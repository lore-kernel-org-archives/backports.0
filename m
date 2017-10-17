Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.63.242]:58932 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752490AbdJQHSW (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 17 Oct 2017 03:18:22 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: ilan.peer@intel.com, Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v3] backports: fully add netlink extack for generic netlink
Date: Tue, 17 Oct 2017 09:18:19 +0200
Message-Id: <20171017071819.14204-1-johannes@sipsolutions.net> (sfid-20171017_091824_390685_01978012)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

The previous backport just made the code compatible, but removed
the extack functionality entirely.

By ignoring the setsockopt() and just assuming that userspace does
in fact support extack (which is true for all of wifi and in fact
all users of libnl), we can support full extack functionality even
on kernels that don't support it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/netlink.h |   3 +
 backport/backport-include/net/genetlink.h |  27 +++-
 backport/compat/Makefile                  |   1 +
 backport/compat/backport-4.12.c           | 243 ++++++++++++++++++++++++++++++
 patches/0078-genl-extack.cocci            |   6 +
 5 files changed, 279 insertions(+), 1 deletion(-)
 create mode 100644 backport/compat/backport-4.12.c

diff --git a/backport/backport-include/linux/netlink.h b/backport/backport-include/linux/netlink.h
index 58fad589039f..443599187920 100644
--- a/backport/backport-include/linux/netlink.h
+++ b/backport/backport-include/linux/netlink.h
@@ -11,6 +11,9 @@ struct netlink_ext_ack {
 	const struct nlattr *bad_attr;
 	u8 cookie[NETLINK_MAX_COOKIE_LEN];
 	u8 cookie_len;
+
+	/* backport only field */
+	const void *__bp_genl_real_ops;
 };
 
 #define NL_SET_ERR_MSG(extack, msg) do {	\
diff --git a/backport/backport-include/net/genetlink.h b/backport/backport-include/net/genetlink.h
index b655d243621b..65a4a4b27548 100644
--- a/backport/backport-include/net/genetlink.h
+++ b/backport/backport-include/net/genetlink.h
@@ -23,10 +23,16 @@ static inline struct netlink_ext_ack *genl_info_extack(struct genl_info *info)
 #if LINUX_VERSION_IS_GEQ(4,12,0)
 	return info->extack;
 #else
-	return NULL;
+	return info->userhdr;
 #endif
 }
 
+/* this gets put in place of info->userhdr, since we use that above */
+static inline void *genl_info_userhdr(struct genl_info *info)
+{
+	return (u8 *)info->genlhdr + GENL_HDRLEN;
+}
+
 /* this is for patches we apply */
 #if LINUX_VERSION_IS_LESS(3,7,0)
 #define genl_info_snd_portid(__genl_info) (__genl_info->snd_pid)
@@ -202,4 +208,23 @@ static inline struct nlattr **genl_family_attrbuf(struct genl_family *family)
 #define __genl_ro_after_init __ro_after_init
 #endif
 
+#if LINUX_VERSION_IS_LESS(4,12,0)
+static inline int
+__real_bp_extack_genl_register_family(struct genl_family *family)
+{
+	return genl_register_family(family);
+}
+static inline int
+__real_bp_extack_genl_unregister_family(struct genl_family *family)
+{
+	return genl_unregister_family(family);
+}
+int bp_extack_genl_register_family(struct genl_family *family);
+int bp_extack_genl_unregister_family(struct genl_family *family);
+#undef genl_register_family
+#define genl_register_family bp_extack_genl_register_family
+#undef genl_unregister_family
+#define genl_unregister_family bp_extack_genl_unregister_family
+#endif
+
 #endif /* __BACKPORT_NET_GENETLINK_H */
diff --git a/backport/compat/Makefile b/backport/compat/Makefile
index 69cfd514da71..5c79b9b849cb 100644
--- a/backport/compat/Makefile
+++ b/backport/compat/Makefile
@@ -36,6 +36,7 @@ compat-$(CPTCFG_KERNEL_4_6) += backport-4.6.o
 compat-$(CPTCFG_KERNEL_4_7) += backport-4.7.o
 compat-$(CPTCFG_KERNEL_4_8) += backport-4.8.o
 compat-$(CPTCFG_KERNEL_4_10) += backport-4.10.o
+compat-$(CPTCFG_KERNEL_4_12) += backport-4.12.o
 
 compat-$(CPTCFG_BPAUTO_CRYPTO_SKCIPHER) += crypto-skcipher.o
 
diff --git a/backport/compat/backport-4.12.c b/backport/compat/backport-4.12.c
new file mode 100644
index 000000000000..73973bca949e
--- /dev/null
+++ b/backport/compat/backport-4.12.c
@@ -0,0 +1,243 @@
+/*
+ * Copyright 2017 Intel Deutschland GmbH
+ */
+#include <net/genetlink.h>
+#include <net/sock.h>
+
+enum nlmsgerr_attrs {
+	NLMSGERR_ATTR_UNUSED,
+	NLMSGERR_ATTR_MSG,
+	NLMSGERR_ATTR_OFFS,
+	NLMSGERR_ATTR_COOKIE,
+	__NLMSGERR_ATTR_MAX,
+	NLMSGERR_ATTR_MAX = __NLMSGERR_ATTR_MAX - 1
+};
+
+#define NLM_F_CAPPED	0x100	/* request was capped */
+#define NLM_F_ACK_TLVS	0x200	/* extended ACK TVLs were included */
+
+struct bp_extack_genl_family {
+	struct genl_family family;
+	struct genl_family *real_family;
+
+	struct genl_ops ops[];
+};
+
+static const struct nla_policy extack_dummy_policy[1] = {};
+
+static struct bp_extack_genl_family *get_copy(const struct genl_ops *op)
+{
+	do {
+		op--;
+	} while (op->policy != extack_dummy_policy);
+
+	return container_of(op, struct bp_extack_genl_family, ops[0]);
+}
+
+static int extack_pre_doit(const struct genl_ops *ops,
+			   struct sk_buff *skb,
+			   struct genl_info *info)
+{
+	struct netlink_ext_ack *extack = kzalloc(sizeof(*extack), GFP_KERNEL);
+	struct bp_extack_genl_family *copy = get_copy(ops);
+	const struct genl_ops *real_ops;
+	int err;
+
+	info->userhdr = extack;
+
+	if (!extack) {
+		info->userhdr = ERR_PTR(-ENOMEM);
+		return -ENOMEM;
+	}
+
+	real_ops = &copy->real_family->ops[ops - &copy->ops[1]];
+	extack->__bp_genl_real_ops = real_ops;
+
+	if (copy->real_family->pre_doit)
+		err = copy->real_family->pre_doit(real_ops, skb, info);
+	else
+		err = 0;
+
+	if (err) {
+		info->userhdr = ERR_PTR(err);
+		kfree(extack);
+	}
+
+	return err;
+}
+
+static void extack_netlink_ack(struct sk_buff *in_skb, struct nlmsghdr *nlh,
+			       int err, const struct netlink_ext_ack *extack)
+{
+	struct sk_buff *skb;
+	struct nlmsghdr *rep;
+	struct nlmsgerr *errmsg;
+	size_t payload = sizeof(*errmsg);
+	size_t tlvlen = 0;
+	unsigned int flags = 0;
+	/* backports assumes everyone supports this - libnl does so it's true */
+	bool nlk_has_extack = true;
+
+	/* Error messages get the original request appened, unless the user
+	 * requests to cap the error message, and get extra error data if
+	 * requested.
+	 * (ignored in backports)
+	 */
+	if (err) {
+		if (1)
+			payload += nlmsg_len(nlh);
+		else
+			flags |= NLM_F_CAPPED;
+		if (nlk_has_extack && extack) {
+			if (extack->_msg)
+				tlvlen += nla_total_size(strlen(extack->_msg) + 1);
+			if (extack->bad_attr)
+				tlvlen += nla_total_size(sizeof(u32));
+		}
+	} else {
+		flags |= NLM_F_CAPPED;
+
+		if (nlk_has_extack && extack && extack->cookie_len)
+			tlvlen += nla_total_size(extack->cookie_len);
+	}
+
+	if (tlvlen)
+		flags |= NLM_F_ACK_TLVS;
+
+	skb = nlmsg_new(payload + tlvlen, GFP_KERNEL);
+	if (!skb) {
+		NETLINK_CB(in_skb).sk->sk_err = ENOBUFS;
+		NETLINK_CB(in_skb).sk->sk_error_report(NETLINK_CB(in_skb).sk);
+		return;
+	}
+
+	rep = __nlmsg_put(skb, NETLINK_CB(in_skb).portid, nlh->nlmsg_seq,
+			  NLMSG_ERROR, payload, flags);
+	errmsg = nlmsg_data(rep);
+	errmsg->error = err;
+	memcpy(&errmsg->msg, nlh, payload > sizeof(*errmsg) ? nlh->nlmsg_len : sizeof(*nlh));
+
+	if (nlk_has_extack && extack) {
+		if (err) {
+			if (extack->_msg)
+				WARN_ON(nla_put_string(skb, NLMSGERR_ATTR_MSG,
+						       extack->_msg));
+			if (extack->bad_attr &&
+			    !WARN_ON((u8 *)extack->bad_attr < in_skb->data ||
+				     (u8 *)extack->bad_attr >= in_skb->data +
+							       in_skb->len))
+				WARN_ON(nla_put_u32(skb, NLMSGERR_ATTR_OFFS,
+						    (u8 *)extack->bad_attr -
+						    in_skb->data));
+		} else {
+			if (extack->cookie_len)
+				WARN_ON(nla_put(skb, NLMSGERR_ATTR_COOKIE,
+						extack->cookie_len,
+						extack->cookie));
+		}
+	}
+
+	nlmsg_end(skb, rep);
+
+	netlink_unicast(in_skb->sk, skb, NETLINK_CB(in_skb).portid, MSG_DONTWAIT);
+}
+
+static int extack_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	const struct genl_ops *real_ops;
+	int err;
+
+	/* older kernels have a bug here */
+	if (IS_ERR(info->userhdr)) {
+		extack_netlink_ack(skb, info->nlhdr,
+				   PTR_ERR(info->userhdr),
+				   genl_info_extack(info));
+		goto out;
+	}
+
+	real_ops = genl_info_extack(info)->__bp_genl_real_ops;
+	err = real_ops->doit(skb, info);
+
+	if (err == -EINTR)
+		return err;
+
+	if (info->nlhdr->nlmsg_flags & NLM_F_ACK || err)
+		extack_netlink_ack(skb, info->nlhdr, err,
+				   genl_info_extack(info));
+
+out:
+	/* suppress sending ACK from normal netlink code */
+	info->nlhdr->nlmsg_flags &= ~NLM_F_ACK;
+	return 0;
+}
+
+static void extack_post_doit(const struct genl_ops *ops,
+			     struct sk_buff *skb,
+			     struct genl_info *info)
+{
+	void (*post_doit)(const struct genl_ops *ops,
+			  struct sk_buff *skb,
+			  struct genl_info *info);
+
+	post_doit = get_copy(ops)->real_family->post_doit;
+
+	if (post_doit)
+		post_doit(ops, skb, info);
+	kfree(info->userhdr);
+}
+
+int bp_extack_genl_register_family(struct genl_family *family)
+{
+	unsigned int size = sizeof(struct bp_extack_genl_family) +
+			    sizeof(family->ops[0]) * (family->n_ops + 1);
+	struct bp_extack_genl_family *copy;
+	int i, err;
+
+	copy = kzalloc(size, GFP_KERNEL);
+	if (!copy)
+		return -ENOMEM;
+
+	copy->family = *family;
+	copy->real_family = family;
+	copy->family.ops = &copy->ops[1];
+
+	for (i = 0; i < family->n_ops; i++) {
+		copy->ops[i + 1] = family->ops[i];
+		if (family->ops[i].doit)
+			copy->ops[i + 1].doit = extack_doit;
+	}
+
+	copy->ops[0].policy = extack_dummy_policy;
+
+	copy->family.pre_doit = extack_pre_doit;
+	copy->family.post_doit = extack_post_doit;
+
+	/*
+	 * store in attrbuf, so that even if we re-register the family
+	 * the data will be overwritten and we don't overwrite data
+	 * that's used again later...
+	 */
+	family->attrbuf = (void *)copy;
+
+	err = __real_bp_extack_genl_register_family(&copy->family);
+	if (err)
+		kfree(copy);
+	return err;
+}
+EXPORT_SYMBOL_GPL(bp_extack_genl_register_family);
+
+int bp_extack_genl_unregister_family(struct genl_family *family)
+{
+	struct bp_extack_genl_family *copy = (void *)family->attrbuf;
+	int err;
+
+	if (!copy)
+		return -ENOENT;
+
+	err = __real_bp_extack_genl_unregister_family(&copy->family);
+	WARN_ON(err);
+	kfree(copy);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(bp_extack_genl_unregister_family);
diff --git a/patches/0078-genl-extack.cocci b/patches/0078-genl-extack.cocci
index b25061743554..5560e09dc0c0 100644
--- a/patches/0078-genl-extack.cocci
+++ b/patches/0078-genl-extack.cocci
@@ -3,3 +3,9 @@ struct genl_info *info;
 @@
 -info->extack
 +genl_info_extack(info)
+
+@@
+struct genl_info *info;
+@@
+-info->userhdr
++genl_info_userhdr(info)
-- 
2.14.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
