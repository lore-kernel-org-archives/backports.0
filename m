Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:41788 "EHLO sipsolutions.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S971334AbdDUKr2 (ORCPT <rfc822;backports@vger.kernel.org>);
        Fri, 21 Apr 2017 06:47:28 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 2/2] backports: add the necessary backports for netlink extack
Date: Fri, 21 Apr 2017 12:47:22 +0200
Message-Id: <20170421104722.21538-2-johannes@sipsolutions.net> (sfid-20170421_124730_651228_2FBF6B29)
In-Reply-To: <20170421104722.21538-1-johannes@sipsolutions.net>
References: <20170421104722.21538-1-johannes@sipsolutions.net>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/netlink.h | 17 ++++++++
 backport/backport-include/net/genetlink.h | 24 +++++++++++
 backport/backport-include/net/netlink.h   | 69 +++++++++++++++++++++++++++++++
 patches/0078-genl-extack.cocci            |  5 +++
 4 files changed, 115 insertions(+)
 create mode 100644 patches/0078-genl-extack.cocci

diff --git a/backport/backport-include/linux/netlink.h b/backport/backport-include/linux/netlink.h
index a40cc0f7f58f..58fad589039f 100644
--- a/backport/backport-include/linux/netlink.h
+++ b/backport/backport-include/linux/netlink.h
@@ -3,6 +3,23 @@
 #include_next <linux/netlink.h>
 #include <linux/version.h>
 
+#if LINUX_VERSION_IS_LESS(4,12,0)
+#define NETLINK_MAX_COOKIE_LEN  20
+
+struct netlink_ext_ack {
+	const char *_msg;
+	const struct nlattr *bad_attr;
+	u8 cookie[NETLINK_MAX_COOKIE_LEN];
+	u8 cookie_len;
+};
+
+#define NL_SET_ERR_MSG(extack, msg) do {	\
+	static const char _msg[] = (msg);	\
+						\
+	(extack)->_msg = _msg;			\
+} while (0)
+#endif
+
 /* this is for patches we apply */
 #if LINUX_VERSION_IS_LESS(3,7,0)
 #define netlink_notify_portid(__notify) (__notify->pid)
diff --git a/backport/backport-include/net/genetlink.h b/backport/backport-include/net/genetlink.h
index 4b31d73f8072..b655d243621b 100644
--- a/backport/backport-include/net/genetlink.h
+++ b/backport/backport-include/net/genetlink.h
@@ -3,6 +3,30 @@
 #include_next <net/genetlink.h>
 #include <linux/version.h>
 
+#if LINUX_VERSION_IS_LESS(4,12,0)
+#define GENL_SET_ERR_MSG(info, msg) do { } while (0)
+
+static inline int genl_err_attr(struct genl_info *info, int err,
+				struct nlattr *attr)
+{
+#if LINUX_VERSION_IS_GEQ(4,12,0)
+	info->extack->bad_attr = attr;
+#endif
+
+	return err;
+}
+#endif
+
+/* this is for patches we apply */
+static inline struct netlink_ext_ack *genl_info_extack(struct genl_info *info)
+{
+#if LINUX_VERSION_IS_GEQ(4,12,0)
+	return info->extack;
+#else
+	return NULL;
+#endif
+}
+
 /* this is for patches we apply */
 #if LINUX_VERSION_IS_LESS(3,7,0)
 #define genl_info_snd_portid(__genl_info) (__genl_info->snd_pid)
diff --git a/backport/backport-include/net/netlink.h b/backport/backport-include/net/netlink.h
index 9a3def77edb9..37c899b07b1d 100644
--- a/backport/backport-include/net/netlink.h
+++ b/backport/backport-include/net/netlink.h
@@ -4,6 +4,75 @@
 #include <linux/version.h>
 #include <linux/in6.h>
 
+#if LINUX_VERSION_IS_LESS(4,12,0)
+#include <backport/magic.h>
+
+static inline int nla_validate5(const struct nlattr *head,
+				int len, int maxtype,
+				const struct nla_policy *policy,
+				struct netlink_ext_ack *extack)
+{
+	return nla_validate(head, len, maxtype, policy);
+}
+#define nla_validate4 nla_validate
+#define nla_validate(...) \
+	macro_dispatcher(nla_validate, __VA_ARGS__)(__VA_ARGS__)
+
+static inline int nla_parse6(struct nlattr **tb, int maxtype,
+			     const struct nlattr *head,
+			     int len, const struct nla_policy *policy,
+			     struct netlink_ext_ack *extack)
+{
+	return nla_parse(tb, maxtype, head, len, policy);
+}
+#define nla_parse5(...) nla_parse(__VA_ARGS__)
+#define nla_parse(...) \
+	macro_dispatcher(nla_parse, __VA_ARGS__)(__VA_ARGS__)
+
+static inline int nlmsg_parse6(const struct nlmsghdr *nlh, int hdrlen,
+			       struct nlattr *tb[], int maxtype,
+			       const struct nla_policy *policy,
+			       struct netlink_ext_ack *extack)
+{
+	return nlmsg_parse(nlh, hdrlen, tb, maxtype, policy);
+}
+#define nlmsg_parse5 nlmsg_parse
+#define nlmsg_parse(...) \
+	macro_dispatcher(nlmsg_parse, __VA_ARGS__)(__VA_ARGS__)
+
+static inline int nlmsg_validate5(const struct nlmsghdr *nlh,
+				  int hdrlen, int maxtype,
+				  const struct nla_policy *policy,
+				  struct netlink_ext_ack *extack)
+{
+	return nlmsg_validate(nlh, hdrlen, maxtype, policy);
+}
+#define nlmsg_validate4 nlmsg_validate
+#define nlmsg_validate(...) \
+	macro_dispatcher(nlmsg_validate, __VA_ARGS__)(__VA_ARGS__)
+
+static inline int nla_parse_nested5(struct nlattr *tb[], int maxtype,
+				    const struct nlattr *nla,
+				    const struct nla_policy *policy,
+				    struct netlink_ext_ack *extack)
+{
+	return nla_parse_nested(tb, maxtype, nla, policy);
+}
+#define nla_parse_nested4 nla_parse_nested
+#define nla_parse_nested(...) \
+	macro_dispatcher(nla_parse_nested, __VA_ARGS__)(__VA_ARGS__)
+
+static inline int nla_validate_nested4(const struct nlattr *start, int maxtype,
+				       const struct nla_policy *policy,
+				       struct netlink_ext_ack *extack)
+{
+	return nla_validate_nested(start, maxtype, policy);
+}
+#define nla_validate_nested3 nla_validate_nested
+#define nla_validate_nested(...) \
+	macro_dispatcher(nla_validate_nested, __VA_ARGS__)(__VA_ARGS__)
+#endif /* LINUX_VERSION_IS_LESS(4,12,0) */
+
 #if LINUX_VERSION_IS_LESS(3,7,0)
 /**
  * nla_put_s8 - Add a s8 netlink attribute to a socket buffer
diff --git a/patches/0078-genl-extack.cocci b/patches/0078-genl-extack.cocci
new file mode 100644
index 000000000000..b25061743554
--- /dev/null
+++ b/patches/0078-genl-extack.cocci
@@ -0,0 +1,5 @@
+@@
+struct genl_info *info;
+@@
+-info->extack
++genl_info_extack(info)
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
