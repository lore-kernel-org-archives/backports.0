Return-Path: <SRS0=zs2H=MO=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4368CC64EB8
	for <backports@archiver.kernel.org>; Tue,  2 Oct 2018 19:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1631206B2
	for <backports@archiver.kernel.org>; Tue,  2 Oct 2018 19:32:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1631206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=backports-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbeJCCRf (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 2 Oct 2018 22:17:35 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:48364 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726274AbeJCCRe (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 2 Oct 2018 22:17:34 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.91)
        (envelope-from <johannes@sipsolutions.net>)
        id 1g7QPI-0004o0-VC; Tue, 02 Oct 2018 21:32:33 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     backports@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 6/6] backports: genetlink: update completely
Date:   Tue,  2 Oct 2018 21:32:15 +0200
Message-Id: <20181002193215.399-6-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181002193215.399-1-johannes@sipsolutions.net>
References: <20181002193215.399-1-johannes@sipsolutions.net>
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Replace all the different nested versions of generic netlink
backport with a single one, covering from < 3.13 all the way
to the upcoming netlink policy improvements in 4.20.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/netlink.h |   2 +-
 backport/backport-include/net/genetlink.h | 238 ++++++-----------
 backport/compat/Makefile                  |   3 +-
 backport/compat/backport-3.13.c           |  66 -----
 backport/compat/backport-4.12.c           | 274 -------------------
 backport/compat/backport-genetlink.c      | 429 ++++++++++++++++++++++++++++++
 backport/compat/compat-3.3.c              |  13 -
 7 files changed, 513 insertions(+), 512 deletions(-)
 delete mode 100644 backport/compat/backport-4.12.c
 create mode 100644 backport/compat/backport-genetlink.c

diff --git a/backport/backport-include/linux/netlink.h b/backport/backport-include/linux/netlink.h
index 366c9e27e8c2..f956a76966f3 100644
--- a/backport/backport-include/linux/netlink.h
+++ b/backport/backport-include/linux/netlink.h
@@ -20,7 +20,7 @@ struct netlink_ext_ack {
 	u8 cookie_len;
 
 	/* backport only field */
-	void *__bp_genl_real_ops;
+	void *__bp_doit;
 };
 
 #define NL_SET_ERR_MSG(extack, msg) do {	\
diff --git a/backport/backport-include/net/genetlink.h b/backport/backport-include/net/genetlink.h
index d80d979ac423..84011e72644e 100644
--- a/backport/backport-include/net/genetlink.h
+++ b/backport/backport-include/net/genetlink.h
@@ -15,18 +15,14 @@ static inline void *__bp_genl_info_userhdr(struct genl_info *info)
 }
 
 #if LINUX_VERSION_IS_LESS(4,12,0)
-#define GENL_SET_ERR_MSG(info, msg) do { } while (0)
+#define GENL_SET_ERR_MSG(info, msg) NL_SET_ERR_MSG(genl_info_extack(info), msg)
 
 static inline int genl_err_attr(struct genl_info *info, int err,
 				struct nlattr *attr)
 {
-#if LINUX_VERSION_IS_GEQ(4,12,0)
-	info->extack->bad_attr = attr;
-#endif
-
 	return err;
 }
-#endif
+#endif /* < 4.12 */
 
 /* this is for patches we apply */
 static inline struct netlink_ext_ack *genl_info_extack(struct genl_info *info)
@@ -51,12 +47,24 @@ static inline void *genl_info_userhdr(struct genl_info *info)
 #define genl_info_snd_portid(__genl_info) (__genl_info->snd_portid)
 #endif
 
+#if LINUX_VERSION_IS_LESS(3,13,0)
+#define __genl_const
+#else /* < 3.13 */
+#define __genl_const const
+#endif /* < 3.13 */
+
 #ifndef GENLMSG_DEFAULT_SIZE
 #define GENLMSG_DEFAULT_SIZE (NLMSG_DEFAULT_SIZE - GENL_HDRLEN)
 #endif
 
 #if LINUX_VERSION_IS_LESS(3,1,0)
-#define genl_dump_check_consistent(cb, user_hdr)
+#define genl_dump_check_consistent(cb, user_hdr) do { } while (0)
+#endif
+
+#if LINUX_VERSION_IS_LESS(4,10,0)
+#define __genl_ro_after_init
+#else
+#define __genl_ro_after_init __ro_after_init
 #endif
 
 #if LINUX_VERSION_IS_LESS(4,15,0)
@@ -83,148 +91,87 @@ void backport_genl_dump_check_consistent(struct netlink_callback *cb,
 #endif
 #endif /* LINUX_VERSION_IS_LESS(4,15,0) */
 
-#if LINUX_VERSION_IS_LESS(3,13,0) && RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,0)
-static inline int __real_genl_register_family(struct genl_family *family)
+#if LINUX_VERSION_IS_LESS(4,20,0)
+static inline int
+__real_backport_genl_register_family(struct genl_family *family)
 {
 	return genl_register_family(family);
 }
-
-/* Needed for the mcgrps pointer */
-struct backport_genl_family {
-	struct genl_family family;
-
-	unsigned int id, hdrsize, version, maxattr;
-	char name[GENL_NAMSIZ];
-	bool netnsok;
-	bool parallel_ops;
-
-	struct nlattr **attrbuf;
-
-	int (*pre_doit)(struct genl_ops *ops, struct sk_buff *skb,
-			struct genl_info *info);
-
-	void (*post_doit)(struct genl_ops *ops, struct sk_buff *skb,
-			  struct genl_info *info);
-
-	struct genl_multicast_group *mcgrps;
-	struct genl_ops *ops;
-	unsigned int n_mcgrps, n_ops;
-
-	struct module *module;
-};
-#define genl_family LINUX_BACKPORT(genl_family)
-
-int __backport_genl_register_family(struct genl_family *family);
-
-#define genl_register_family LINUX_BACKPORT(genl_register_family)
 static inline int
-genl_register_family(struct genl_family *family)
+__real_backport_genl_unregister_family(struct genl_family *family)
 {
-	family->module = THIS_MODULE;
-	return __backport_genl_register_family(family);
+	return genl_unregister_family(family);
 }
 
-#define _genl_register_family_with_ops_grps \
-	_backport_genl_register_family_with_ops_grps
-static inline int
-_genl_register_family_with_ops_grps(struct genl_family *family,
-				    struct genl_ops *ops, size_t n_ops,
-				    struct genl_multicast_group *mcgrps,
-				    size_t n_mcgrps)
-{
-	family->ops = ops;
-	family->n_ops = n_ops;
-	family->mcgrps = mcgrps;
-	family->n_mcgrps = n_mcgrps;
-	return genl_register_family(family);
-}
+struct backport_genl_family {
+	struct genl_family	family;
+	const struct genl_ops *	copy_ops;
+
+	/* copied */
+	int			id;		/* private */
+	unsigned int		hdrsize;
+	char			name[GENL_NAMSIZ];
+	unsigned int		version;
+	unsigned int		maxattr;
+	bool			netnsok;
+	bool			parallel_ops;
+	int			(*pre_doit)(__genl_const struct genl_ops *ops,
+					    struct sk_buff *skb,
+					    struct genl_info *info);
+	void			(*post_doit)(__genl_const struct genl_ops *ops,
+					     struct sk_buff *skb,
+					     struct genl_info *info);
+/*
+ * unsupported!
+	int			(*mcast_bind)(struct net *net, int group);
+	void			(*mcast_unbind)(struct net *net, int group);
+ */
+	struct nlattr **	attrbuf;	/* private */
+	__genl_const struct genl_ops *	ops;
+	__genl_const struct genl_multicast_group *mcgrps;
+	unsigned int		n_ops;
+	unsigned int		n_mcgrps;
+	struct module		*module;
+};
+#undef genl_family
+#define genl_family backport_genl_family
 
-#define genl_register_family_with_ops(family, ops)			\
-	_genl_register_family_with_ops_grps((family),			\
-					    (ops), ARRAY_SIZE(ops),	\
-					    NULL, 0)
-#define genl_register_family_with_ops_groups(family, ops, grps)		\
-	_genl_register_family_with_ops_grps((family),			\
-					    (ops), ARRAY_SIZE(ops),	\
-					    (grps), ARRAY_SIZE(grps))
+#define genl_register_family backport_genl_register_family
+int genl_register_family(struct genl_family *family);
 
 #define genl_unregister_family backport_genl_unregister_family
-int genl_unregister_family(struct genl_family *family);
+int backport_genl_unregister_family(struct genl_family *family);
 
-#if LINUX_VERSION_IS_LESS(3,3,0)
-extern void genl_notify(struct sk_buff *skb, struct net *net, u32 pid,
-			u32 group, struct nlmsghdr *nlh, gfp_t flags);
-#endif
-#define genl_notify(_fam, _skb, _info, _group, _flags)			\
-	genl_notify(_skb, genl_info_net(_info),				\
-		    genl_info_snd_portid(_info),			\
-		    (_fam)->mcgrps[_group].id, _info->nlhdr, _flags)
-#define genlmsg_put(_skb, _pid, _seq, _fam, _flags, _cmd)		\
-	genlmsg_put(_skb, _pid, _seq, &(_fam)->family, _flags, _cmd)
+#define genl_notify LINUX_BACKPORT(genl_notify)
+void genl_notify(const struct genl_family *family, struct sk_buff *skb,
+		 struct genl_info *info, u32 group, gfp_t flags);
+
+#define genlmsg_put LINUX_BACKPORT(genlmsg_put)
+void *genlmsg_put(struct sk_buff *skb, u32 portid, u32 seq,
+		  const struct genl_family *family, int flags, u8 cmd);
+
+#define genlmsg_put_reply LINUX_BACKPORT(genlmsg_put_reply)
+void *genlmsg_put_reply(struct sk_buff *skb,
+			struct genl_info *info,
+			const struct genl_family *family,
+			int flags, u8 cmd);
 
-#ifndef genlmsg_put_reply /* might already be there from _info override above */
-#define genlmsg_put_reply(_skb, _info, _fam, _flags, _cmd)		\
-	genlmsg_put_reply(_skb, _info, &(_fam)->family, _flags, _cmd)
-#endif
 #define genlmsg_multicast_netns LINUX_BACKPORT(genlmsg_multicast_netns)
-static inline int genlmsg_multicast_netns(struct genl_family *family,
-					  struct net *net, struct sk_buff *skb,
-					  u32 portid, unsigned int group,
-					  gfp_t flags)
-{
-	if (WARN_ON_ONCE(group >= family->n_mcgrps))
-		return -EINVAL;
-	group = family->mcgrps[group].id;
-	return nlmsg_multicast(
-		net->genl_sock,
-		skb, portid, group, flags);
-}
+int genlmsg_multicast_netns(const struct genl_family *family,
+			    struct net *net, struct sk_buff *skb,
+			    u32 portid, unsigned int group,
+			    gfp_t flags);
+
 #define genlmsg_multicast LINUX_BACKPORT(genlmsg_multicast)
-static inline int genlmsg_multicast(struct genl_family *family,
-				    struct sk_buff *skb, u32 portid,
-				    unsigned int group, gfp_t flags)
-{
-	if (WARN_ON_ONCE(group >= family->n_mcgrps))
-		return -EINVAL;
-	group = family->mcgrps[group].id;
-	return nlmsg_multicast(
-		init_net.genl_sock,
-		skb, portid, group, flags);
-}
-static inline int
-backport_genlmsg_multicast_allns(struct genl_family *family,
-				 struct sk_buff *skb, u32 portid,
-				 unsigned int group, gfp_t flags)
-{
-	if (WARN_ON_ONCE(group >= family->n_mcgrps))
-		return -EINVAL;
-	group = family->mcgrps[group].id;
-	return genlmsg_multicast_allns(skb, portid, group, flags);
-}
-#define genlmsg_multicast_allns LINUX_BACKPORT(genlmsg_multicast_allns)
+int genlmsg_multicast(const struct genl_family *family,
+		      struct sk_buff *skb, u32 portid,
+		      unsigned int group, gfp_t flags);
 
-#define __genl_const
-#else /* < 3.13 */
-#define __genl_const const
-#if LINUX_VERSION_IS_LESS(4,4,0)
-#define genl_notify(_fam, _skb, _info, _group, _flags)			\
-	genl_notify(_fam, _skb, genl_info_net(_info),			\
-		    genl_info_snd_portid(_info),			\
-		    _group, _info->nlhdr, _flags)
-#endif /* < 4.4 */
-#endif /* < 3.13 */
+#define genlmsg_multicast_allns LINUX_BACKPORT(genlmsg_multicast_allns)
+int backport_genlmsg_multicast_allns(const struct genl_family *family,
+				     struct sk_buff *skb, u32 portid,
+				     unsigned int group, gfp_t flags);
 
-#if LINUX_VERSION_IS_LESS(4,10,0)
-/**
- * genl_family_attrbuf - return family's attrbuf
- * @family: the family
- *
- * Return the family's attrbuf, while validating that it's
- * actually valid to access it.
- *
- * You cannot use this function with a family that has parallel_ops
- * and you can only use it within (pre/post) doit/dumpit callbacks.
- */
 #define genl_family_attrbuf LINUX_BACKPORT(genl_family_attrbuf)
 static inline struct nlattr **genl_family_attrbuf(struct genl_family *family)
 {
@@ -232,29 +179,6 @@ static inline struct nlattr **genl_family_attrbuf(struct genl_family *family)
 
 	return family->attrbuf;
 }
-
-#define __genl_ro_after_init
-#else
-#define __genl_ro_after_init __ro_after_init
-#endif
-
-#if LINUX_VERSION_IS_LESS(4,12,0)
-static inline int
-__real_bp_extack_genl_register_family(struct genl_family *family)
-{
-	return genl_register_family(family);
-}
-static inline int
-__real_bp_extack_genl_unregister_family(struct genl_family *family)
-{
-	return genl_unregister_family(family);
-}
-int bp_extack_genl_register_family(struct genl_family *family);
-int bp_extack_genl_unregister_family(struct genl_family *family);
-#undef genl_register_family
-#define genl_register_family bp_extack_genl_register_family
-#undef genl_unregister_family
-#define genl_unregister_family bp_extack_genl_unregister_family
-#endif
+#endif /* LINUX_VERSION_IS_LESS(4,20,0) */
 
 #endif /* __BACKPORT_NET_GENETLINK_H */
diff --git a/backport/compat/Makefile b/backport/compat/Makefile
index ff6c7e658380..fdc68c8b4600 100644
--- a/backport/compat/Makefile
+++ b/backport/compat/Makefile
@@ -36,10 +36,11 @@ compat-$(CPTCFG_KERNEL_4_6) += backport-4.6.o
 compat-$(CPTCFG_KERNEL_4_7) += backport-4.7.o
 compat-$(CPTCFG_KERNEL_4_8) += backport-4.8.o
 compat-$(CPTCFG_KERNEL_4_10) += backport-4.10.o
-compat-$(CPTCFG_KERNEL_4_12) += backport-4.12.o
 compat-$(CPTCFG_KERNEL_4_18) += backport-4.18.o
 compat-$(CPTCFG_KERNEL_4_20) += backport-4.20.o
 
+compat-$(CPTCFG_KERNEL_4_20) += backport-genetlink.o
+
 compat-$(CPTCFG_BPAUTO_CRYPTO_SKCIPHER) += crypto-skcipher.o
 
 compat-$(CPTCFG_BPAUTO_BUILD_SYSTEM_DATA_VERIFICATION) += verification/verify.o
diff --git a/backport/compat/backport-3.13.c b/backport/compat/backport-3.13.c
index c33a04432ddc..2b61711d233d 100644
--- a/backport/compat/backport-3.13.c
+++ b/backport/compat/backport-3.13.c
@@ -11,78 +11,12 @@
  */
 #include <linux/version.h>
 #include <linux/kernel.h>
-#include <net/genetlink.h>
 #include <linux/delay.h>
 #include <linux/pci.h>
 #include <linux/device.h>
 #include <linux/hwmon.h>
 #include <linux/net.h>
 
-/************* generic netlink backport *****************/
-#if RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,0)
-
-#undef genl_register_family
-#undef genl_unregister_family
-
-int __backport_genl_register_family(struct genl_family *family)
-{
-	int i, ret;
-
-#define __copy(_field) family->family._field = family->_field
-	__copy(id);
-	__copy(hdrsize);
-	__copy(version);
-	__copy(maxattr);
-	strncpy(family->family.name, family->name, sizeof(family->family.name));
-	__copy(netnsok);
-	__copy(pre_doit);
-	__copy(post_doit);
-#if LINUX_VERSION_IS_GEQ(3,10,0)
-	__copy(parallel_ops);
-#endif
-#if LINUX_VERSION_IS_GEQ(3,11,0)
-	__copy(module);
-#endif
-#undef __copy
-
-	ret = genl_register_family(&family->family);
-	if (ret < 0)
-		return ret;
-
-	family->attrbuf = family->family.attrbuf;
-	family->id = family->family.id;
-
-	for (i = 0; i < family->n_ops; i++) {
-		ret = genl_register_ops(&family->family, &family->ops[i]);
-		if (ret < 0)
-			goto error;
-	}
-
-	for (i = 0; i < family->n_mcgrps; i++) {
-		ret = genl_register_mc_group(&family->family,
-					     &family->mcgrps[i]);
-		if (ret)
-			goto error;
-	}
-
-	return 0;
-
- error:
-	backport_genl_unregister_family(family);
-	return ret;
-}
-EXPORT_SYMBOL_GPL(__backport_genl_register_family);
-
-int backport_genl_unregister_family(struct genl_family *family)
-{
-	int err;
-	err = genl_unregister_family(&family->family);
-	return err;
-}
-EXPORT_SYMBOL_GPL(backport_genl_unregister_family);
-
-#endif /* RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,0) */
-
 #ifdef __BACKPORT_NET_GET_RANDOM_ONCE
 struct __net_random_once_work {
 	struct work_struct work;
diff --git a/backport/compat/backport-4.12.c b/backport/compat/backport-4.12.c
deleted file mode 100644
index 5fc8c10cb8d8..000000000000
--- a/backport/compat/backport-4.12.c
+++ /dev/null
@@ -1,274 +0,0 @@
-/*
- * Copyright 2017 Intel Deutschland GmbH
- */
-#include <net/genetlink.h>
-#include <net/sock.h>
-
-enum nlmsgerr_attrs {
-	NLMSGERR_ATTR_UNUSED,
-	NLMSGERR_ATTR_MSG,
-	NLMSGERR_ATTR_OFFS,
-	NLMSGERR_ATTR_COOKIE,
-	__NLMSGERR_ATTR_MAX,
-	NLMSGERR_ATTR_MAX = __NLMSGERR_ATTR_MAX - 1
-};
-
-#define NLM_F_CAPPED	0x100	/* request was capped */
-#define NLM_F_ACK_TLVS	0x200	/* extended ACK TVLs were included */
-
-struct bp_extack_genl_family {
-	struct genl_family family;
-	struct genl_family *real_family;
-	struct list_head list;
-
-	struct genl_ops ops[];
-};
-
-static LIST_HEAD(copies_list);
-static DEFINE_MUTEX(copies_mutex);
-
-static const struct nla_policy extack_dummy_policy[1] = {};
-
-static struct bp_extack_genl_family *get_copy(__genl_const struct genl_ops *op)
-{
-	do {
-		op--;
-	} while (op->policy != extack_dummy_policy);
-
-	return container_of(op, struct bp_extack_genl_family, ops[0]);
-}
-
-static int extack_pre_doit(__genl_const struct genl_ops *ops,
-			   struct sk_buff *skb,
-			   struct genl_info *info)
-{
-	struct netlink_ext_ack *extack = kzalloc(sizeof(*extack), GFP_KERNEL);
-	struct bp_extack_genl_family *copy = get_copy(ops);
-	struct genl_ops *real_ops;
-	int err;
-
-	__bp_genl_info_userhdr_set(info, extack);
-
-	if (!extack) {
-		__bp_genl_info_userhdr_set(info, ERR_PTR(-ENOMEM));
-		return -ENOMEM;
-	}
-
-	real_ops = (void *)&copy->real_family->ops[ops - &copy->ops[1]];
-	extack->__bp_genl_real_ops = real_ops;
-
-	if (copy->real_family->pre_doit)
-		err = copy->real_family->pre_doit(real_ops, skb, info);
-	else
-		err = 0;
-
-	if (err) {
-		__bp_genl_info_userhdr_set(info, ERR_PTR(err));
-		kfree(extack);
-	}
-
-	return err;
-}
-
-static void extack_netlink_ack(struct sk_buff *in_skb, struct nlmsghdr *nlh,
-			       int err, const struct netlink_ext_ack *extack)
-{
-	struct sk_buff *skb;
-	struct nlmsghdr *rep;
-	struct nlmsgerr *errmsg;
-	size_t payload = sizeof(*errmsg);
-	size_t tlvlen = 0;
-	unsigned int flags = 0;
-	/* backports assumes everyone supports this - libnl does so it's true */
-	bool nlk_has_extack = true;
-
-	/* Error messages get the original request appened, unless the user
-	 * requests to cap the error message, and get extra error data if
-	 * requested.
-	 * (ignored in backports)
-	 */
-	if (nlk_has_extack && extack && extack->_msg)
-		tlvlen += nla_total_size(strlen(extack->_msg) + 1);
-
-	if (err) {
-		if (1)
-			payload += nlmsg_len(nlh);
-		else
-			flags |= NLM_F_CAPPED;
-		if (nlk_has_extack && extack && extack->bad_attr)
-			tlvlen += nla_total_size(sizeof(u32));
-	} else {
-		flags |= NLM_F_CAPPED;
-
-		if (nlk_has_extack && extack && extack->cookie_len)
-			tlvlen += nla_total_size(extack->cookie_len);
-	}
-
-	if (tlvlen)
-		flags |= NLM_F_ACK_TLVS;
-
-	skb = nlmsg_new(payload + tlvlen, GFP_KERNEL);
-	if (!skb) {
-		NETLINK_CB(in_skb).sk->sk_err = ENOBUFS;
-		NETLINK_CB(in_skb).sk->sk_error_report(NETLINK_CB(in_skb).sk);
-		return;
-	}
-
-	rep = __nlmsg_put(skb, NETLINK_CB(in_skb).portid, nlh->nlmsg_seq,
-			  NLMSG_ERROR, payload, flags);
-	errmsg = nlmsg_data(rep);
-	errmsg->error = err;
-	memcpy(&errmsg->msg, nlh, payload > sizeof(*errmsg) ? nlh->nlmsg_len : sizeof(*nlh));
-
-	if (nlk_has_extack && extack) {
-		if (extack->_msg) {
-			WARN_ON(nla_put_string(skb, NLMSGERR_ATTR_MSG,
-					       extack->_msg));
-		}
-		if (err) {
-			if (extack->bad_attr &&
-			    !WARN_ON((u8 *)extack->bad_attr < in_skb->data ||
-				     (u8 *)extack->bad_attr >= in_skb->data +
-							       in_skb->len))
-				WARN_ON(nla_put_u32(skb, NLMSGERR_ATTR_OFFS,
-						    (u8 *)extack->bad_attr -
-						    in_skb->data));
-		} else {
-			if (extack->cookie_len)
-				WARN_ON(nla_put(skb, NLMSGERR_ATTR_COOKIE,
-						extack->cookie_len,
-						extack->cookie));
-		}
-	}
-
-	nlmsg_end(skb, rep);
-
-	netlink_unicast(in_skb->sk, skb, NETLINK_CB(in_skb).portid, MSG_DONTWAIT);
-}
-
-static int extack_doit(struct sk_buff *skb, struct genl_info *info)
-{
-	struct genl_ops *real_ops;
-	int err;
-
-	/* older kernels have a bug here */
-	if (IS_ERR(__bp_genl_info_userhdr(info))) {
-		extack_netlink_ack(skb, info->nlhdr,
-				   PTR_ERR(__bp_genl_info_userhdr(info)),
-				   genl_info_extack(info));
-		goto out;
-	}
-
-	real_ops = genl_info_extack(info)->__bp_genl_real_ops;
-	err = real_ops->doit(skb, info);
-
-	if (err == -EINTR)
-		return err;
-
-	if (info->nlhdr->nlmsg_flags & NLM_F_ACK || err)
-		extack_netlink_ack(skb, info->nlhdr, err,
-				   genl_info_extack(info));
-
-out:
-	/* suppress sending ACK from normal netlink code */
-	info->nlhdr->nlmsg_flags &= ~NLM_F_ACK;
-	return 0;
-}
-
-static void extack_post_doit(__genl_const struct genl_ops *ops,
-			     struct sk_buff *skb,
-			     struct genl_info *info)
-{
-	void (*post_doit)(__genl_const struct genl_ops *ops,
-			  struct sk_buff *skb,
-			  struct genl_info *info);
-
-	post_doit = get_copy(ops)->real_family->post_doit;
-
-	if (post_doit)
-		post_doit(ops, skb, info);
-	kfree(__bp_genl_info_userhdr(info));
-}
-
-int bp_extack_genl_register_family(struct genl_family *family)
-{
-	unsigned int size = sizeof(struct bp_extack_genl_family) +
-			    sizeof(family->ops[0]) * (family->n_ops + 1);
-	struct bp_extack_genl_family *copy;
-	int i, err;
-
-	copy = kzalloc(size, GFP_KERNEL);
-	if (!copy)
-		return -ENOMEM;
-
-	copy->family = *family;
-	copy->real_family = family;
-	copy->family.ops = &copy->ops[1];
-
-	for (i = 0; i < family->n_ops; i++) {
-		copy->ops[i + 1] = family->ops[i];
-		if (family->ops[i].doit)
-			copy->ops[i + 1].doit = extack_doit;
-	}
-
-	copy->ops[0].policy = extack_dummy_policy;
-
-	copy->family.pre_doit = extack_pre_doit;
-	copy->family.post_doit = extack_post_doit;
-
-	err = __real_bp_extack_genl_register_family(&copy->family);
-	if (err) {
-		kfree(copy);
-		return err;
-	}
-
-	/* copy this since the family might access it directly */
-	family->id = copy->family.id;
-	family->attrbuf = copy->family.attrbuf;
-
-#if LINUX_VERSION_IS_LESS(3,13,0) && RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,0)
-	/* family ID from the original family struct will be used when building
-	 * genl messages (sent as nlmsg_type), so the new id should be updated
-	 * in the original (older kernel format) family struct too
-	 */
-	family->family.id = copy->family.id;
-#endif
-
-#if LINUX_VERSION_IS_GEQ(3,13,0)
-	family->mcgrp_offset = copy->family.mcgrp_offset;
-#endif
-
-	mutex_lock(&copies_mutex);
-	list_add_tail(&copy->list, &copies_list);
-	mutex_unlock(&copies_mutex);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(bp_extack_genl_register_family);
-
-int bp_extack_genl_unregister_family(struct genl_family *family)
-{
-	struct bp_extack_genl_family *tmp, *copy = NULL;
-	int err;
-
-	mutex_lock(&copies_mutex);
-	list_for_each_entry(tmp, &copies_list, list) {
-		if (tmp->real_family == family) {
-			copy = tmp;
-			break;
-		}
-	}
-	if (copy)
-		list_del(&copy->list);
-	mutex_unlock(&copies_mutex);
-
-	if (!copy)
-		return -ENOENT;
-
-	err = __real_bp_extack_genl_unregister_family(&copy->family);
-	WARN_ON(err);
-	kfree(copy);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(bp_extack_genl_unregister_family);
diff --git a/backport/compat/backport-genetlink.c b/backport/compat/backport-genetlink.c
new file mode 100644
index 000000000000..cc70cd73d0c0
--- /dev/null
+++ b/backport/compat/backport-genetlink.c
@@ -0,0 +1,429 @@
+/*
+ * Copyright 2017 Intel Deutschland GmbH
+ * Copyright (C) 2018 Intel Corporation
+ *
+ * Backport functionality introduced in Linux 4.20.
+ * Much of this is based on upstream lib/nlattr.c.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/kernel.h>
+#include <linux/export.h>
+#include <linux/errno.h>
+#include <linux/types.h>
+#include <net/genetlink.h>
+#include <net/netlink.h>
+#include <net/sock.h>
+
+static const struct genl_family *find_family_real_ops(__genl_const struct genl_ops **ops)
+{
+	const struct genl_family *family;
+	const struct genl_ops *tmp_ops = *ops;
+
+	/* find the family ... */
+	while (tmp_ops->doit || tmp_ops->dumpit)
+		tmp_ops++;
+	family = (void *)tmp_ops->done;
+
+	/* cast to suppress const warning */
+	*ops = (void *)(family->ops + (*ops - family->copy_ops));
+
+	return family;
+}
+
+#if LINUX_VERSION_IS_LESS(4,12,0)
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
+	if (nlk_has_extack && extack && extack->_msg)
+		tlvlen += nla_total_size(strlen(extack->_msg) + 1);
+
+	if (err) {
+		if (1)
+			payload += nlmsg_len(nlh);
+		else
+			flags |= NLM_F_CAPPED;
+		if (nlk_has_extack && extack && extack->bad_attr)
+			tlvlen += nla_total_size(sizeof(u32));
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
+		if (extack->_msg) {
+			WARN_ON(nla_put_string(skb, NLMSGERR_ATTR_MSG,
+					       extack->_msg));
+		}
+		if (err) {
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
+	int (*doit)(struct sk_buff *, struct genl_info *);
+	int err;
+
+	doit = genl_info_extack(info)->__bp_doit;
+
+	/* signal from our pre_doit to not do anything */
+	if (!doit)
+		return 0;
+
+	err = doit(skb, info);
+
+	if (err == -EINTR)
+		return err;
+
+	if (info->nlhdr->nlmsg_flags & NLM_F_ACK || err)
+		extack_netlink_ack(skb, info->nlhdr, err,
+				   genl_info_extack(info));
+
+	/* suppress sending ACK from normal netlink code */
+	info->nlhdr->nlmsg_flags &= ~NLM_F_ACK;
+	return 0;
+}
+#endif /* LINUX_VERSION_IS_LESS(4,12,0) */
+
+static int backport_pre_doit(__genl_const struct genl_ops *ops,
+			     struct sk_buff *skb,
+			     struct genl_info *info)
+{
+	const struct genl_family *family = find_family_real_ops(&ops);
+	int err;
+#if LINUX_VERSION_IS_LESS(4,12,0)
+	struct netlink_ext_ack *extack = kzalloc(sizeof(*extack), GFP_KERNEL);
+
+	__bp_genl_info_userhdr_set(info, extack);
+
+	if (!extack) {
+		err = -ENOMEM;
+		goto err;
+	}
+
+	extack->__bp_doit = ops->doit;
+#else
+	struct netlink_ext_ack *extack = info->extack;
+#endif
+
+	err = nlmsg_validate(info->nlhdr, GENL_HDRLEN + family->hdrsize,
+			     family->maxattr, ops->policy, extack);
+	if (!err)
+		err = family->pre_doit(ops, skb, info);
+
+#if LINUX_VERSION_IS_LESS(4,12,0)
+err:
+	if (err) {
+		/* signal to do nothing */
+		extack->__bp_doit = NULL;
+
+		extack_netlink_ack(skb, info->nlhdr, err, extack);
+
+		/* suppress sending ACK from normal netlink code */
+		info->nlhdr->nlmsg_flags &= ~NLM_F_ACK;
+
+		/* extack will be freed in post_doit as usual */
+
+		return 0;
+	}
+#endif
+
+	return err;
+}
+
+static void backport_post_doit(__genl_const struct genl_ops *ops,
+			       struct sk_buff *skb,
+			       struct genl_info *info)
+{
+	const struct genl_family *family = find_family_real_ops(&ops);
+
+#if LINUX_VERSION_IS_LESS(4,12,0)
+	if (genl_info_extack(info)->__bp_doit)
+#else
+	if (1)
+#endif
+		family->post_doit(ops, skb, info);
+
+#if LINUX_VERSION_IS_LESS(4,12,0)
+	kfree(__bp_genl_info_userhdr(info));
+#endif
+}
+
+int backport_genl_register_family(struct genl_family *family)
+{
+	struct genl_ops *ops;
+	int err, i;
+
+#define COPY(memb)	family->family.memb = family->memb
+#define BACK(memb)	family->memb = family->family.memb
+
+	/* we append one entry to the ops to find our family pointer ... */
+	ops = kzalloc(sizeof(*ops) * (family->n_ops + 1), GFP_KERNEL);
+	memcpy(ops, family->ops, sizeof(*ops) * family->n_ops);
+	/*
+	 * Remove policy to skip validation as the struct nla_policy
+	 * memory layout isn't compatible with the old version
+	 */
+	for (i = 0; i < family->n_ops; i++) {
+		ops[i].policy = NULL;
+#if LINUX_VERSION_IS_LESS(4,12,0)
+		if (ops[i].doit)
+			ops[i].doit = extack_doit;
+#endif
+	}
+	/* keep doit/dumpit NULL - that's invalid */
+	ops[family->n_ops].done = (void *)family;
+
+	COPY(id);
+	memcpy(family->family.name, family->name, sizeof(family->name));
+	COPY(hdrsize);
+	COPY(version);
+	COPY(maxattr);
+	COPY(netnsok);
+#if LINUX_VERSION_IS_GEQ(3,10,0)
+	COPY(parallel_ops);
+#endif
+	family->family.pre_doit = backport_pre_doit;
+	family->family.post_doit = backport_post_doit;
+	/* attrbuf is output only */
+	family->copy_ops = ops;
+#if LINUX_VERSION_IS_GEQ(3,13,0)
+	family->family.ops = ops;
+	COPY(mcgrps);
+	COPY(n_ops);
+	COPY(n_mcgrps);
+#endif
+#if LINUX_VERSION_IS_GEQ(3,11,0)
+	COPY(module);
+#endif
+
+	err = __real_backport_genl_register_family(&family->family);
+
+	BACK(id);
+	BACK(attrbuf);
+
+	if (err)
+		return err;
+
+#if LINUX_VERSION_IS_GEQ(3,13,0) || RHEL_RELEASE_CODE >= RHEL_RELEASE_VERSION(7,0)
+	return 0;
+#else
+	for (i = 0; i < family->n_ops; i++) {
+		err = genl_register_ops(&family->family, ops + i);
+		if (err < 0)
+			goto error;
+	}
+
+	for (i = 0; i < family->n_mcgrps; i++) {
+		err = genl_register_mc_group(&family->family,
+					     &family->mcgrps[i]);
+		if (err)
+			goto error;
+	}
+
+	return 0;
+ error:
+	genl_unregister_family(family);
+	return err;
+#endif /* LINUX_VERSION_IS_GEQ(3,13,0) || RHEL_RELEASE_CODE >= RHEL_RELEASE_VERSION(7,0) */
+}
+EXPORT_SYMBOL_GPL(backport_genl_register_family);
+
+int backport_genl_unregister_family(struct genl_family *family)
+{
+	return __real_backport_genl_unregister_family(&family->family);
+}
+EXPORT_SYMBOL_GPL(backport_genl_unregister_family);
+
+#define INVALID_GROUP	0xffffffff
+
+static u32 __backport_genl_group(const struct genl_family *family,
+				 u32 group)
+{
+	if (WARN_ON_ONCE(group >= family->n_mcgrps))
+		return INVALID_GROUP;
+#if LINUX_VERSION_IS_LESS(3,13,0)
+	return family->mcgrps[group].id;
+#else
+	return family->family.mcgrp_offset + group;
+#endif
+}
+
+void genl_notify(const struct genl_family *family, struct sk_buff *skb,
+		 struct genl_info *info, u32 group, gfp_t flags)
+{
+	struct net *net = genl_info_net(info);
+	struct sock *sk = net->genl_sock;
+	int report = 0;
+
+	if (info->nlhdr)
+		report = nlmsg_report(info->nlhdr);
+
+	group = __backport_genl_group(family, group);
+	if (group == INVALID_GROUP)
+		return;
+	nlmsg_notify(sk, skb, info->snd_portid, group, report, flags);
+}
+EXPORT_SYMBOL_GPL(genl_notify);
+
+void *genlmsg_put(struct sk_buff *skb, u32 portid, u32 seq,
+		  const struct genl_family *family, int flags, u8 cmd)
+{
+	struct nlmsghdr *nlh;
+	struct genlmsghdr *hdr;
+
+	nlh = nlmsg_put(skb, portid, seq, family->id, GENL_HDRLEN +
+			family->hdrsize, flags);
+	if (nlh == NULL)
+		return NULL;
+
+	hdr = nlmsg_data(nlh);
+	hdr->cmd = cmd;
+	hdr->version = family->version;
+	hdr->reserved = 0;
+
+	return (char *) hdr + GENL_HDRLEN;
+}
+EXPORT_SYMBOL_GPL(genlmsg_put);
+
+void *genlmsg_put_reply(struct sk_buff *skb,
+			struct genl_info *info,
+			const struct genl_family *family,
+			int flags, u8 cmd)
+{
+	return genlmsg_put(skb, info->snd_portid, info->snd_seq, family,
+			   flags, cmd);
+}
+EXPORT_SYMBOL_GPL(genlmsg_put_reply);
+
+int genlmsg_multicast_netns(const struct genl_family *family,
+			    struct net *net, struct sk_buff *skb,
+			    u32 portid, unsigned int group,
+			    gfp_t flags)
+{
+	group = __backport_genl_group(family, group);
+	if (group == INVALID_GROUP)
+		return -EINVAL;
+	return nlmsg_multicast(net->genl_sock, skb, portid, group, flags);
+}
+EXPORT_SYMBOL_GPL(genlmsg_multicast_netns);
+
+int genlmsg_multicast(const struct genl_family *family,
+		      struct sk_buff *skb, u32 portid,
+		      unsigned int group, gfp_t flags)
+{
+	return genlmsg_multicast_netns(family, &init_net, skb,
+				       portid, group, flags);
+}
+EXPORT_SYMBOL_GPL(genlmsg_multicast);
+
+static int genlmsg_mcast(struct sk_buff *skb, u32 portid, unsigned long group,
+			 gfp_t flags)
+{
+	struct sk_buff *tmp;
+	struct net *net, *prev = NULL;
+	bool delivered = false;
+	int err;
+
+	for_each_net_rcu(net) {
+		if (prev) {
+			tmp = skb_clone(skb, flags);
+			if (!tmp) {
+				err = -ENOMEM;
+				goto error;
+			}
+			err = nlmsg_multicast(prev->genl_sock, tmp,
+					      portid, group, flags);
+			if (!err)
+				delivered = true;
+			else if (err != -ESRCH)
+				goto error;
+		}
+
+		prev = net;
+	}
+
+	err = nlmsg_multicast(prev->genl_sock, skb, portid, group, flags);
+	if (!err)
+		delivered = true;
+	else if (err != -ESRCH)
+		return err;
+	return delivered ? 0 : -ESRCH;
+ error:
+	kfree_skb(skb);
+	return err;
+}
+
+int backport_genlmsg_multicast_allns(const struct genl_family *family,
+				     struct sk_buff *skb, u32 portid,
+				     unsigned int group, gfp_t flags)
+{
+	group = __backport_genl_group(family, group);
+	if (group == INVALID_GROUP)
+		return -EINVAL;
+	return genlmsg_mcast(skb, portid, group, flags);
+}
+EXPORT_SYMBOL_GPL(backport_genlmsg_multicast_allns);
diff --git a/backport/compat/compat-3.3.c b/backport/compat/compat-3.3.c
index c064f09d9abe..1185a5d2d4e0 100644
--- a/backport/compat/compat-3.3.c
+++ b/backport/compat/compat-3.3.c
@@ -224,16 +224,3 @@ void backport_destroy_workqueue(struct workqueue_struct *wq)
 	spin_unlock(&wq_name_lock);
 }
 EXPORT_SYMBOL_GPL(backport_destroy_workqueue);
-
-void genl_notify(struct sk_buff *skb, struct net *net, u32 pid, u32 group,
-		 struct nlmsghdr *nlh, gfp_t flags)
-{
-	struct sock *sk = net->genl_sock;
-	int report = 0;
-
-	if (nlh)
-		report = nlmsg_report(nlh);
-
-	nlmsg_notify(sk, skb, pid, group, report, flags);
-}
-EXPORT_SYMBOL_GPL(genl_notify);
-- 
2.14.4

--
To unsubscribe from this list: send the line "unsubscribe backports" in
