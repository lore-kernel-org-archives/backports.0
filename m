Return-Path: <SRS0=giDq=U6=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B67B9C06513
	for <backports@archiver.kernel.org>; Mon,  1 Jul 2019 21:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B0F72173E
	for <backports@archiver.kernel.org>; Mon,  1 Jul 2019 21:50:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbfGAVuF (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 1 Jul 2019 17:50:05 -0400
Received: from mx1.mailbox.org ([80.241.60.212]:40582 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726979AbfGAVuE (ORCPT <rfc822;backports@vger.kernel.org>);
        Mon, 1 Jul 2019 17:50:04 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id 63F1C4EB6E;
        Mon,  1 Jul 2019 23:50:01 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter05.heinlein-hosting.de (spamfilter05.heinlein-hosting.de [80.241.56.123]) (amavisd-new, port 10030)
        with ESMTP id Wox8szp4jY1U; Mon,  1 Jul 2019 23:49:53 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 06/18] backport: Extend netlink parsing with strict validation
Date:   Mon,  1 Jul 2019 23:49:01 +0200
Message-Id: <20190701214914.8066-7-hauke@hauke-m.de>
In-Reply-To: <20190701214914.8066-1-hauke@hauke-m.de>
References: <20190701214914.8066-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

This extends the backported netlink handling with strict parsing. the
struct gen_ops now supports the validate member and does the validation
inside the backport layer.

This is needed to use backports with kernel 5.2.

[Hauke: Remove nla_validate_nested()]
[Hauke: Support struct genl_ops on older kernel versions]
Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/net/genetlink.h     |  62 +++-
 backport/backport-include/net/netlink.h       | 341 +++++++++++++-----
 backport/compat/Kconfig                       |   5 +
 backport/compat/Makefile                      |   4 +-
 .../{backport-4.20.c => backport-5.2.c}       | 216 ++++++++---
 backport/compat/backport-genetlink.c          |  26 +-
 6 files changed, 491 insertions(+), 163 deletions(-)
 rename backport/compat/{backport-4.20.c => backport-5.2.c} (58%)

diff --git a/backport/backport-include/net/genetlink.h b/backport/backport-include/net/genetlink.h
index 84011e72..772f10f0 100644
--- a/backport/backport-include/net/genetlink.h
+++ b/backport/backport-include/net/genetlink.h
@@ -91,12 +91,71 @@ void backport_genl_dump_check_consistent(struct netlink_callback *cb,
 #endif
 #endif /* LINUX_VERSION_IS_LESS(4,15,0) */
 
-#if LINUX_VERSION_IS_LESS(4,20,0)
+#if LINUX_VERSION_IS_LESS(5,2,0)
+enum genl_validate_flags {
+	GENL_DONT_VALIDATE_STRICT		= BIT(0),
+	GENL_DONT_VALIDATE_DUMP			= BIT(1),
+	GENL_DONT_VALIDATE_DUMP_STRICT		= BIT(2),
+};
+
+#if LINUX_VERSION_IS_GEQ(3,13,0)
+struct backport_genl_ops {
+	void			*__dummy_was_policy_must_be_null;
+	int		       (*doit)(struct sk_buff *skb,
+				       struct genl_info *info);
+#if LINUX_VERSION_IS_GEQ(4,5,0) || \
+    LINUX_VERSION_IN_RANGE(4,4,104, 4,5,0) || \
+    LINUX_VERSION_IN_RANGE(4,1,48, 4,2,0) || \
+    LINUX_VERSION_IN_RANGE(3,18,86, 3,19,0)
+	int		       (*start)(struct netlink_callback *cb);
+#endif
+	int		       (*dumpit)(struct sk_buff *skb,
+					 struct netlink_callback *cb);
+	int		       (*done)(struct netlink_callback *cb);
+	u8			cmd;
+	u8			internal_flags;
+	u8			flags;
+	u8			validate;
+};
+#else
+struct backport_genl_ops {
+	u8			cmd;
+	u8			internal_flags;
+	unsigned int		flags;
+	void			*__dummy_was_policy_must_be_null;
+	int		       (*doit)(struct sk_buff *skb,
+				       struct genl_info *info);
+	int		       (*dumpit)(struct sk_buff *skb,
+					 struct netlink_callback *cb);
+	int		       (*done)(struct netlink_callback *cb);
+	struct list_head	ops_list;
+	u8			validate;
+};
+#endif
+
 static inline int
 __real_backport_genl_register_family(struct genl_family *family)
 {
+#define OPS_VALIDATE(f) \
+	BUILD_BUG_ON(offsetof(struct genl_ops, f) != \
+		     offsetof(struct backport_genl_ops, f))
+	OPS_VALIDATE(doit);
+#if LINUX_VERSION_IS_GEQ(4,5,0) || \
+    LINUX_VERSION_IN_RANGE(4,4,104, 4,5,0) || \
+    LINUX_VERSION_IN_RANGE(4,1,48, 4,2,0) || \
+    LINUX_VERSION_IN_RANGE(3,18,86, 3,19,0)
+	OPS_VALIDATE(start);
+#endif
+	OPS_VALIDATE(dumpit);
+	OPS_VALIDATE(done);
+	OPS_VALIDATE(cmd);
+	OPS_VALIDATE(internal_flags);
+	OPS_VALIDATE(flags);
+
 	return genl_register_family(family);
 }
+#define genl_ops backport_genl_ops
+
 static inline int
 __real_backport_genl_unregister_family(struct genl_family *family)
 {
@@ -115,6 +174,7 @@ struct backport_genl_family {
 	unsigned int		maxattr;
 	bool			netnsok;
 	bool			parallel_ops;
+	const struct nla_policy *policy;
 	int			(*pre_doit)(__genl_const struct genl_ops *ops,
 					    struct sk_buff *skb,
 					    struct genl_info *info);
diff --git a/backport/backport-include/net/netlink.h b/backport/backport-include/net/netlink.h
index d8237f10..4d73c57f 100644
--- a/backport/backport-include/net/netlink.h
+++ b/backport/backport-include/net/netlink.h
@@ -4,20 +4,7 @@
 #include <linux/version.h>
 #include <linux/in6.h>
 
-#if LINUX_VERSION_IS_LESS(5,1,0)
-#undef NLA_POLICY_NESTED
-#undef NLA_POLICY_NESTED_ARRAY
-#define _NLA_POLICY_NESTED(maxattr, policy) \
-	{ .type = NLA_NESTED, .validation_data = policy, .len = maxattr }
-#define _NLA_POLICY_NESTED_ARRAY(maxattr, policy) \
-	{ .type = NLA_NESTED_ARRAY, .validation_data = policy, .len = maxattr }
-#define NLA_POLICY_NESTED(policy) \
-	_NLA_POLICY_NESTED(ARRAY_SIZE(policy) - 1, policy)
-#define NLA_POLICY_NESTED_ARRAY(policy) \
-	_NLA_POLICY_NESTED_ARRAY(ARRAY_SIZE(policy) - 1, policy)
-#endif /* < 5.1 */
-
-#if LINUX_VERSION_IS_LESS(4,20,0)
+#if LINUX_VERSION_IS_LESS(5,2,0)
 /* can't backport using the enum - need to override */
 #define NLA_UNSPEC		0
 #define NLA_U8			1
@@ -39,17 +26,10 @@
 #define NLA_REJECT		17
 #define NLA_EXACT_LEN		18
 #define NLA_EXACT_LEN_WARN	19
-#define __NLA_TYPE_MAX		20
+#define NLA_MIN_LEN		20
+#define __NLA_TYPE_MAX		21
 #define NLA_TYPE_MAX		(__NLA_TYPE_MAX - 1)
 
-enum nla_policy_validation {
-	NLA_VALIDATE_NONE,
-	NLA_VALIDATE_RANGE,
-	NLA_VALIDATE_MIN,
-	NLA_VALIDATE_MAX,
-	NLA_VALIDATE_FUNCTION,
-};
-
 struct backport_nla_policy {
 	u8		type;
 	u8		validation_type;
@@ -61,77 +41,169 @@ struct backport_nla_policy {
 		};
 		int (*validate)(const struct nlattr *attr,
 				struct netlink_ext_ack *extack);
+		u16 strict_start_type;
 	};
 };
 #define nla_policy backport_nla_policy
 
-#define NLA_POLICY_EXACT_LEN(_len)	{ .type = NLA_EXACT_LEN, .len = _len }
-#define NLA_POLICY_EXACT_LEN_WARN(_len)	{ .type = NLA_EXACT_LEN_WARN, \
-					  .len = _len }
+#define nla_nest_start_noflag LINUX_BACKPORT(nla_nest_start_noflag)
+static inline struct nlattr *nla_nest_start_noflag(struct sk_buff *skb,
+						   int attrtype)
+{
+	struct nlattr *start = (struct nlattr *)skb_tail_pointer(skb);
 
-#define NLA_POLICY_ETH_ADDR		NLA_POLICY_EXACT_LEN(ETH_ALEN)
-#define NLA_POLICY_ETH_ADDR_COMPAT	NLA_POLICY_EXACT_LEN_WARN(ETH_ALEN)
+	if (nla_put(skb, attrtype, 0, NULL) < 0)
+		return NULL;
 
-#define __NLA_ENSURE(condition) (sizeof(char[1 - 2*!(condition)]) - 1)
-#define NLA_ENSURE_INT_TYPE(tp)				\
-	(__NLA_ENSURE(tp == NLA_S8 || tp == NLA_U8 ||	\
-		      tp == NLA_S16 || tp == NLA_U16 ||	\
-		      tp == NLA_S32 || tp == NLA_U32 ||	\
-		      tp == NLA_S64 || tp == NLA_U64) + tp)
-#define NLA_ENSURE_NO_VALIDATION_PTR(tp)		\
-	(__NLA_ENSURE(tp != NLA_BITFIELD32 &&		\
-		      tp != NLA_REJECT &&		\
-		      tp != NLA_NESTED &&		\
-		      tp != NLA_NESTED_ARRAY) + tp)
+	return start;
+}
 
-#define NLA_POLICY_RANGE(tp, _min, _max) {		\
-	.type = NLA_ENSURE_INT_TYPE(tp),		\
-	.validation_type = NLA_VALIDATE_RANGE,		\
-	.min = _min,					\
-	.max = _max					\
+#define nla_nest_start LINUX_BACKPORT(nla_nest_start)
+static inline struct nlattr *nla_nest_start(struct sk_buff *skb, int attrtype)
+{
+	return nla_nest_start_noflag(skb, attrtype | NLA_F_NESTED);
 }
 
-#define NLA_POLICY_MIN(tp, _min) {			\
-	.type = NLA_ENSURE_INT_TYPE(tp),		\
-	.validation_type = NLA_VALIDATE_MIN,		\
-	.min = _min,					\
+enum netlink_validation {
+	NL_VALIDATE_LIBERAL = 0,
+	NL_VALIDATE_TRAILING = BIT(0),
+	NL_VALIDATE_MAXTYPE = BIT(1),
+	NL_VALIDATE_UNSPEC = BIT(2),
+	NL_VALIDATE_STRICT_ATTRS = BIT(3),
+	NL_VALIDATE_NESTED = BIT(4),
+};
+
+#define NL_VALIDATE_DEPRECATED_STRICT (NL_VALIDATE_TRAILING |\
+				       NL_VALIDATE_MAXTYPE)
+#define NL_VALIDATE_STRICT (NL_VALIDATE_TRAILING |\
+			    NL_VALIDATE_MAXTYPE |\
+			    NL_VALIDATE_UNSPEC |\
+			    NL_VALIDATE_STRICT_ATTRS |\
+			    NL_VALIDATE_NESTED)
+
+#define __nla_validate LINUX_BACKPORT(__nla_validate)
+int __nla_validate(const struct nlattr *head, int len, int maxtype,
+		   const struct nla_policy *policy, unsigned int validate,
+		   struct netlink_ext_ack *extack);
+#define __nla_parse LINUX_BACKPORT(__nla_parse)
+int __nla_parse(struct nlattr **tb, int maxtype, const struct nlattr *head,
+		int len, const struct nla_policy *policy, unsigned int validate,
+		struct netlink_ext_ack *extack);
+
+#define nla_policy_len LINUX_BACKPORT(nla_policy_len)
+int nla_policy_len(const struct nla_policy *, int);
+
+#define nla_parse LINUX_BACKPORT(nla_parse)
+static inline int nla_parse(struct nlattr **tb, int maxtype,
+			    const struct nlattr *head, int len,
+			    const struct nla_policy *policy,
+			    struct netlink_ext_ack *extack)
+{
+	return __nla_parse(tb, maxtype, head, len, policy,
+			   NL_VALIDATE_STRICT, extack);
 }
 
-#define NLA_POLICY_MAX(tp, _max) {			\
-	.type = NLA_ENSURE_INT_TYPE(tp),		\
-	.validation_type = NLA_VALIDATE_MAX,		\
-	.max = _max,					\
+#define nla_parse_deprecated LINUX_BACKPORT(nla_parse_deprecated)
+static inline int nla_parse_deprecated(struct nlattr **tb, int maxtype,
+				       const struct nlattr *head, int len,
+				       const struct nla_policy *policy,
+				       struct netlink_ext_ack *extack)
+{
+	return __nla_parse(tb, maxtype, head, len, policy,
+			   NL_VALIDATE_LIBERAL, extack);
 }
 
-#define NLA_POLICY_VALIDATE_FN(tp, fn, ...) {		\
-	.type = NLA_ENSURE_NO_VALIDATION_PTR(tp),	\
-	.validation_type = NLA_VALIDATE_FUNCTION,	\
-	.validate = fn,					\
-	.len = __VA_ARGS__ + 0,				\
+#define nla_parse_deprecated_strict LINUX_BACKPORT(nla_parse_deprecated_strict)
+static inline int nla_parse_deprecated_strict(struct nlattr **tb, int maxtype,
+					      const struct nlattr *head,
+					      int len,
+					      const struct nla_policy *policy,
+					      struct netlink_ext_ack *extack)
+{
+	return __nla_parse(tb, maxtype, head, len, policy,
+			   NL_VALIDATE_DEPRECATED_STRICT, extack);
 }
 
-#define nla_validate LINUX_BACKPORT(nla_validate)
-int nla_validate(const struct nlattr *head, int len, int maxtype,
-		 const struct nla_policy *policy,
-		 struct netlink_ext_ack *extack);
-#define nla_parse LINUX_BACKPORT(nla_parse)
-int nla_parse(struct nlattr **tb, int maxtype, const struct nlattr *head,
-	      int len, const struct nla_policy *policy,
-	      struct netlink_ext_ack *extack);
-#define nla_policy_len LINUX_BACKPORT(nla_policy_len)
-int nla_policy_len(const struct nla_policy *, int);
+#define __nlmsg_parse LINUX_BACKPORT(__nlmsg_parse)
+static inline int __nlmsg_parse(const struct nlmsghdr *nlh, int hdrlen,
+				struct nlattr *tb[], int maxtype,
+				const struct nla_policy *policy,
+				unsigned int validate,
+				struct netlink_ext_ack *extack)
+{
+	if (nlh->nlmsg_len < nlmsg_msg_size(hdrlen)) {
+		NL_SET_ERR_MSG(extack, "Invalid header length");
+		return -EINVAL;
+	}
+
+	return __nla_parse(tb, maxtype, nlmsg_attrdata(nlh, hdrlen),
+			   nlmsg_attrlen(nlh, hdrlen), policy, validate,
+			   extack);
+}
 
 #define nlmsg_parse LINUX_BACKPORT(nlmsg_parse)
 static inline int nlmsg_parse(const struct nlmsghdr *nlh, int hdrlen,
 			      struct nlattr *tb[], int maxtype,
 			      const struct nla_policy *policy,
 			      struct netlink_ext_ack *extack)
+{
+	return __nla_parse(tb, maxtype, nlmsg_attrdata(nlh, hdrlen),
+			   nlmsg_attrlen(nlh, hdrlen), policy,
+			   NL_VALIDATE_STRICT, extack);
+}
+
+#define nlmsg_parse_deprecated LINUX_BACKPORT(nlmsg_parse_deprecated)
+static inline int nlmsg_parse_deprecated(const struct nlmsghdr *nlh, int hdrlen,
+					 struct nlattr *tb[], int maxtype,
+					 const struct nla_policy *policy,
+					 struct netlink_ext_ack *extack)
+{
+	return __nlmsg_parse(nlh, hdrlen, tb, maxtype, policy,
+			     NL_VALIDATE_LIBERAL, extack);
+}
+
+#define nlmsg_parse_deprecated_strict LINUX_BACKPORT(nlmsg_parse_deprecated_strict)
+static inline int
+nlmsg_parse_deprecated_strict(const struct nlmsghdr *nlh, int hdrlen,
+			      struct nlattr *tb[], int maxtype,
+			      const struct nla_policy *policy,
+			      struct netlink_ext_ack *extack)
+{
+	return __nlmsg_parse(nlh, hdrlen, tb, maxtype, policy,
+			     NL_VALIDATE_DEPRECATED_STRICT, extack);
+}
+
+#define nla_validate_deprecated LINUX_BACKPORT(nla_validate_deprecated)
+static inline int nla_validate_deprecated(const struct nlattr *head, int len,
+					  int maxtype,
+					  const struct nla_policy *policy,
+					  struct netlink_ext_ack *extack)
+{
+	return __nla_validate(head, len, maxtype, policy, NL_VALIDATE_LIBERAL,
+			      extack);
+}
+
+#define nla_validate LINUX_BACKPORT(nla_validate)
+static inline int nla_validate(const struct nlattr *head, int len, int maxtype,
+			       const struct nla_policy *policy,
+			       struct netlink_ext_ack *extack)
+{
+	return __nla_validate(head, len, maxtype, policy, NL_VALIDATE_STRICT,
+			      extack);
+}
+
+#define nlmsg_validate_deprecated LINUX_BACKPORT(nlmsg_validate_deprecated)
+static inline int nlmsg_validate_deprecated(const struct nlmsghdr *nlh,
+					    int hdrlen, int maxtype,
+					    const struct nla_policy *policy,
+					    struct netlink_ext_ack *extack)
 {
 	if (nlh->nlmsg_len < nlmsg_msg_size(hdrlen))
 		return -EINVAL;
 
-	return nla_parse(tb, maxtype, nlmsg_attrdata(nlh, hdrlen),
-			 nlmsg_attrlen(nlh, hdrlen), policy, extack);
+	return __nla_validate(nlmsg_attrdata(nlh, hdrlen),
+			      nlmsg_attrlen(nlh, hdrlen), maxtype,
+			      policy, NL_VALIDATE_LIBERAL, extack);
 }
 
 #define nlmsg_validate LINUX_BACKPORT(nlmsg_validate)
@@ -143,9 +215,9 @@ static inline int nlmsg_validate(const struct nlmsghdr *nlh,
 	if (nlh->nlmsg_len < nlmsg_msg_size(hdrlen))
 		return -EINVAL;
 
-	return nla_validate(nlmsg_attrdata(nlh, hdrlen),
-			    nlmsg_attrlen(nlh, hdrlen), maxtype, policy,
-			    extack);
+	return __nla_validate(nlmsg_attrdata(nlh, hdrlen),
+			      nlmsg_attrlen(nlh, hdrlen), maxtype,
+			      policy, NL_VALIDATE_STRICT, extack);
 }
 
 #define nla_parse_nested LINUX_BACKPORT(nla_parse_nested)
@@ -154,17 +226,111 @@ static inline int nla_parse_nested(struct nlattr *tb[], int maxtype,
 				   const struct nla_policy *policy,
 				   struct netlink_ext_ack *extack)
 {
-	return nla_parse(tb, maxtype, nla_data(nla), nla_len(nla), policy,
-			 extack);
+	if (!(nla->nla_type & NLA_F_NESTED)) {
+		NL_SET_ERR_MSG_ATTR(extack, nla, "NLA_F_NESTED is missing");
+		return -EINVAL;
+	}
+
+	return __nla_parse(tb, maxtype, nla_data(nla), nla_len(nla), policy,
+			   NL_VALIDATE_STRICT, extack);
 }
 
-#define nla_validate_nested LINUX_BACKPORT(nla_validate_nested)
-static inline int nla_validate_nested(const struct nlattr *start, int maxtype,
-				      const struct nla_policy *policy,
-				      struct netlink_ext_ack *extack)
+#define nla_parse_nested_deprecated LINUX_BACKPORT(nla_parse_nested_deprecated)
+static inline int nla_parse_nested_deprecated(struct nlattr *tb[], int maxtype,
+					      const struct nlattr *nla,
+					      const struct nla_policy *policy,
+					      struct netlink_ext_ack *extack)
 {
-	return nla_validate(nla_data(start), nla_len(start), maxtype, policy,
-			    extack);
+	return __nla_parse(tb, maxtype, nla_data(nla), nla_len(nla), policy,
+			   NL_VALIDATE_LIBERAL, extack);
+}
+
+#define __nla_validate_nested LINUX_BACKPORT(__nla_validate_nested)
+static inline int __nla_validate_nested(const struct nlattr *start, int maxtype,
+					const struct nla_policy *policy,
+					unsigned int validate,
+					struct netlink_ext_ack *extack)
+{
+	return __nla_validate(nla_data(start), nla_len(start), maxtype, policy,
+			      validate, extack);
+}
+
+#define nla_validate_nested_deprecated LINUX_BACKPORT(nla_validate_nested_deprecated)
+static inline int
+nla_validate_nested_deprecated(const struct nlattr *start, int maxtype,
+			       const struct nla_policy *policy,
+			       struct netlink_ext_ack *extack)
+{
+	return __nla_validate_nested(start, maxtype, policy,
+				     NL_VALIDATE_LIBERAL, extack);
+}
+#endif /* < 5.2 */
+
+#if LINUX_VERSION_IS_LESS(5,1,0)
+#undef NLA_POLICY_NESTED
+#undef NLA_POLICY_NESTED_ARRAY
+#define _NLA_POLICY_NESTED(maxattr, policy) \
+	{ .type = NLA_NESTED, .validation_data = policy, .len = maxattr }
+#define _NLA_POLICY_NESTED_ARRAY(maxattr, policy) \
+	{ .type = NLA_NESTED_ARRAY, .validation_data = policy, .len = maxattr }
+#define NLA_POLICY_NESTED(policy) \
+	_NLA_POLICY_NESTED(ARRAY_SIZE(policy) - 1, policy)
+#define NLA_POLICY_NESTED_ARRAY(policy) \
+	_NLA_POLICY_NESTED_ARRAY(ARRAY_SIZE(policy) - 1, policy)
+#endif /* < 5.1 */
+
+#if LINUX_VERSION_IS_LESS(4,20,0)
+enum nla_policy_validation {
+	NLA_VALIDATE_NONE,
+	NLA_VALIDATE_RANGE,
+	NLA_VALIDATE_MIN,
+	NLA_VALIDATE_MAX,
+	NLA_VALIDATE_FUNCTION,
+};
+
+#define NLA_POLICY_EXACT_LEN(_len)	{ .type = NLA_EXACT_LEN, .len = _len }
+#define NLA_POLICY_EXACT_LEN_WARN(_len)	{ .type = NLA_EXACT_LEN_WARN, \
+					  .len = _len }
+
+#define NLA_POLICY_ETH_ADDR		NLA_POLICY_EXACT_LEN(ETH_ALEN)
+#define NLA_POLICY_ETH_ADDR_COMPAT	NLA_POLICY_EXACT_LEN_WARN(ETH_ALEN)
+
+#define __NLA_ENSURE(condition) (sizeof(char[1 - 2*!(condition)]) - 1)
+#define NLA_ENSURE_INT_TYPE(tp)				\
+	(__NLA_ENSURE(tp == NLA_S8 || tp == NLA_U8 ||	\
+		      tp == NLA_S16 || tp == NLA_U16 ||	\
+		      tp == NLA_S32 || tp == NLA_U32 ||	\
+		      tp == NLA_S64 || tp == NLA_U64) + tp)
+#define NLA_ENSURE_NO_VALIDATION_PTR(tp)		\
+	(__NLA_ENSURE(tp != NLA_BITFIELD32 &&		\
+		      tp != NLA_REJECT &&		\
+		      tp != NLA_NESTED &&		\
+		      tp != NLA_NESTED_ARRAY) + tp)
+
+#define NLA_POLICY_RANGE(tp, _min, _max) {		\
+	.type = NLA_ENSURE_INT_TYPE(tp),		\
+	.validation_type = NLA_VALIDATE_RANGE,		\
+	.min = _min,					\
+	.max = _max					\
+}
+
+#define NLA_POLICY_MIN(tp, _min) {			\
+	.type = NLA_ENSURE_INT_TYPE(tp),		\
+	.validation_type = NLA_VALIDATE_MIN,		\
+	.min = _min,					\
+}
+
+#define NLA_POLICY_MAX(tp, _max) {			\
+	.type = NLA_ENSURE_INT_TYPE(tp),		\
+	.validation_type = NLA_VALIDATE_MAX,		\
+	.max = _max,					\
+}
+
+#define NLA_POLICY_VALIDATE_FN(tp, fn, ...) {		\
+	.type = NLA_ENSURE_NO_VALIDATION_PTR(tp),	\
+	.validation_type = NLA_VALIDATE_FUNCTION,	\
+	.validate = fn,					\
+	.len = __VA_ARGS__ + 0,				\
 }
 #endif /* < 4.20 */
 
@@ -255,21 +421,6 @@ static inline int _nla_parse_nested4(struct nlattr *tb[], int maxtype,
 #undef nla_parse_nested
 #define nla_parse_nested(...) \
 	macro_dispatcher(_nla_parse_nested, __VA_ARGS__)(__VA_ARGS__)
-
-static inline int _nla_validate_nested4(const struct nlattr *start, int maxtype,
-					const struct nla_policy *policy,
-					struct netlink_ext_ack *extack)
-{
-	return nla_validate_nested(start, maxtype, policy, extack);
-}
-static inline int _nla_validate_nested3(const struct nlattr *start, int maxtype,
-					const struct nla_policy *policy)
-{
-	return nla_validate_nested(start, maxtype, policy, NULL);
-}
-#undef nla_validate_nested
-#define nla_validate_nested(...) \
-	macro_dispatcher(_nla_validate_nested, __VA_ARGS__)(__VA_ARGS__)
 #endif /* LINUX_VERSION_IS_LESS(4,12,0) */
 
 #if LINUX_VERSION_IS_LESS(3,7,0)
diff --git a/backport/compat/Kconfig b/backport/compat/Kconfig
index 20f34f1a..1d85a5da 100644
--- a/backport/compat/Kconfig
+++ b/backport/compat/Kconfig
@@ -62,6 +62,11 @@ config BP_MODULES
 	This symbol is necessary for the newer kconf tool, it looks
 	for the "option modules" to control the 'm' state.
 
+config BPAUTO_BUILD_NLATTR
+	def_bool y
+	depends on KERNEL_5_2
+	#c-file lib/nlattr.c
+
 config BPAUTO_BUILD_CORDIC
 	tristate
 	depends on !CORDIC
diff --git a/backport/compat/Makefile b/backport/compat/Makefile
index 99b52faa..e92e3120 100644
--- a/backport/compat/Makefile
+++ b/backport/compat/Makefile
@@ -37,9 +37,7 @@ compat-$(CPTCFG_KERNEL_4_7) += backport-4.7.o
 compat-$(CPTCFG_KERNEL_4_8) += backport-4.8.o
 compat-$(CPTCFG_KERNEL_4_10) += backport-4.10.o
 compat-$(CPTCFG_KERNEL_4_18) += backport-4.18.o
-compat-$(CPTCFG_KERNEL_4_20) += backport-4.20.o
-
-compat-$(CPTCFG_KERNEL_4_20) += backport-genetlink.o
+compat-$(CPTCFG_KERNEL_5_2) += backport-5.2.o backport-genetlink.o
 
 compat-$(CPTCFG_BPAUTO_BUILD_SYSTEM_DATA_VERIFICATION) += verification/verify.o
 compat-$(CPTCFG_BPAUTO_BUILD_SYSTEM_DATA_VERIFICATION) += verification/pkcs7.asn1.o
diff --git a/backport/compat/backport-4.20.c b/backport/compat/backport-5.2.c
similarity index 58%
rename from backport/compat/backport-4.20.c
rename to backport/compat/backport-5.2.c
index e26f3b52..5624d5fa 100644
--- a/backport/compat/backport-4.20.c
+++ b/backport/compat/backport-5.2.c
@@ -1,19 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright (C) 2018 Intel Corporation
+ * NETLINK      Netlink attributes
  *
- * Backport functionality introduced in Linux 4.20.
- * This is basically upstream lib/nlattr.c.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
+ * 		Authors:	Thomas Graf <tgraf@suug.ch>
+ * 				Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
  */
-#include <linux/kernel.h>
+
 #include <linux/export.h>
+#include <linux/kernel.h>
 #include <linux/errno.h>
+#include <linux/jiffies.h>
+#include <linux/skbuff.h>
+#include <linux/string.h>
 #include <linux/types.h>
 #include <net/netlink.h>
 
+/* For these data types, attribute length should be exactly the given
+ * size. However, to maintain compatibility with broken commands, if the
+ * attribute length does not match the expected size a warning is emitted
+ * to the user that the command is sending invalid data and needs to be fixed.
+ */
 static const u8 nla_attr_len[NLA_TYPE_MAX+1] = {
 	[NLA_U8]	= sizeof(u8),
 	[NLA_U16]	= sizeof(u16),
@@ -63,7 +69,8 @@ static int validate_nla_bitfield32(const struct nlattr *nla,
 
 static int nla_validate_array(const struct nlattr *head, int len, int maxtype,
 			      const struct nla_policy *policy,
-			      struct netlink_ext_ack *extack)
+			      struct netlink_ext_ack *extack,
+			      unsigned int validate)
 {
 	const struct nlattr *entry;
 	int rem;
@@ -80,8 +87,8 @@ static int nla_validate_array(const struct nlattr *head, int len, int maxtype,
 			return -ERANGE;
 		}
 
-		ret = nla_validate(nla_data(entry), nla_len(entry),
-				   maxtype, policy, extack);
+		ret = __nla_validate(nla_data(entry), nla_len(entry),
+				     maxtype, policy, validate, extack);
 		if (ret < 0)
 			return ret;
 	}
@@ -148,13 +155,17 @@ static int nla_validate_int_range(const struct nla_policy *pt,
 }
 
 static int validate_nla(const struct nlattr *nla, int maxtype,
-			const struct nla_policy *policy,
+			const struct nla_policy *policy, unsigned int validate,
 			struct netlink_ext_ack *extack)
 {
+	u16 strict_start_type = policy[0].strict_start_type;
 	const struct nla_policy *pt;
 	int minlen = 0, attrlen = nla_len(nla), type = nla_type(nla);
 	int err = -ERANGE;
 
+	if (strict_start_type && type >= strict_start_type)
+		validate |= NL_VALIDATE_STRICT;
+
 	if (type <= 0 || type > maxtype)
 		return 0;
 
@@ -166,6 +177,26 @@ static int validate_nla(const struct nlattr *nla, int maxtype,
 	    (pt->type == NLA_EXACT_LEN_WARN && attrlen != pt->len)) {
 		pr_warn_ratelimited("netlink: '%s': attribute type %d has an invalid length.\n",
 				    current->comm, type);
+		if (validate & NL_VALIDATE_STRICT_ATTRS) {
+			NL_SET_ERR_MSG_ATTR(extack, nla,
+					    "invalid attribute length");
+			return -EINVAL;
+		}
+	}
+
+	if (validate & NL_VALIDATE_NESTED) {
+		if ((pt->type == NLA_NESTED || pt->type == NLA_NESTED_ARRAY) &&
+		    !(nla->nla_type & NLA_F_NESTED)) {
+			NL_SET_ERR_MSG_ATTR(extack, nla,
+					    "NLA_F_NESTED is missing");
+			return -EINVAL;
+		}
+		if (pt->type != NLA_NESTED && pt->type != NLA_NESTED_ARRAY &&
+		    pt->type != NLA_UNSPEC && (nla->nla_type & NLA_F_NESTED)) {
+			NL_SET_ERR_MSG_ATTR(extack, nla,
+					    "NLA_F_NESTED not expected");
+			return -EINVAL;
+		}
 	}
 
 	switch (pt->type) {
@@ -238,8 +269,9 @@ static int validate_nla(const struct nlattr *nla, int maxtype,
 		if (attrlen < NLA_HDRLEN)
 			goto out_err;
 		if (pt->validation_data) {
-			err = nla_validate(nla_data(nla), nla_len(nla), pt->len,
-					   pt->validation_data, extack);
+			err = __nla_validate(nla_data(nla), nla_len(nla), pt->len,
+					     pt->validation_data, validate,
+					     extack);
 			if (err < 0) {
 				/*
 				 * return directly to preserve the inner
@@ -262,7 +294,7 @@ static int validate_nla(const struct nlattr *nla, int maxtype,
 
 			err = nla_validate_array(nla_data(nla), nla_len(nla),
 						 pt->len, pt->validation_data,
-						 extack);
+						 extack, validate);
 			if (err < 0) {
 				/*
 				 * return directly to preserve the inner
@@ -272,10 +304,23 @@ static int validate_nla(const struct nlattr *nla, int maxtype,
 			}
 		}
 		break;
+
+	case NLA_UNSPEC:
+		if (validate & NL_VALIDATE_UNSPEC) {
+			NL_SET_ERR_MSG_ATTR(extack, nla,
+					    "Unsupported attribute");
+			return -EINVAL;
+		}
+		/* fall through */
+	case NLA_MIN_LEN:
+		if (attrlen < pt->len)
+			goto out_err;
+		break;
+
 	default:
 		if (pt->len)
 			minlen = pt->len;
-		else if (pt->type != NLA_UNSPEC)
+		else
 			minlen = nla_attr_minlen[pt->type];
 
 		if (attrlen < minlen)
@@ -309,25 +354,90 @@ out_err:
 	return err;
 }
 
-int backport_nla_validate(const struct nlattr *head, int len, int maxtype,
-			  const struct nla_policy *policy,
-			  struct netlink_ext_ack *extack)
+static int __nla_validate_parse(const struct nlattr *head, int len, int maxtype,
+				const struct nla_policy *policy,
+				unsigned int validate,
+				struct netlink_ext_ack *extack,
+				struct nlattr **tb)
 {
 	const struct nlattr *nla;
 	int rem;
 
+	if (tb)
+		memset(tb, 0, sizeof(struct nlattr *) * (maxtype + 1));
+
 	nla_for_each_attr(nla, head, len, rem) {
-		int err = validate_nla(nla, maxtype, policy, extack);
+		u16 type = nla_type(nla);
 
-		if (err < 0)
-			return err;
+		if (type == 0 || type > maxtype) {
+			if (validate & NL_VALIDATE_MAXTYPE) {
+				NL_SET_ERR_MSG_ATTR(extack, nla,
+						    "Unknown attribute type");
+				return -EINVAL;
+			}
+			continue;
+		}
+		if (policy) {
+			int err = validate_nla(nla, maxtype, policy,
+					       validate, extack);
+
+			if (err < 0)
+				return err;
+		}
+
+		if (tb)
+			tb[type] = (struct nlattr *)nla;
+	}
+
+	if (unlikely(rem > 0)) {
+		pr_warn_ratelimited("netlink: %d bytes leftover after parsing attributes in process `%s'.\n",
+				    rem, current->comm);
+		NL_SET_ERR_MSG(extack, "bytes leftover after parsing attributes");
+		if (validate & NL_VALIDATE_TRAILING)
+			return -EINVAL;
 	}
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(backport_nla_validate);
 
-int backport_nla_policy_len(const struct nla_policy *p, int n)
+/**
+ * __nla_validate - Validate a stream of attributes
+ * @head: head of attribute stream
+ * @len: length of attribute stream
+ * @maxtype: maximum attribute type to be expected
+ * @policy: validation policy
+ * @validate: validation strictness
+ * @extack: extended ACK report struct
+ *
+ * Validates all attributes in the specified attribute stream against the
+ * specified policy. Validation depends on the validate flags passed, see
+ * &enum netlink_validation for more details on that.
+ * See documenation of struct nla_policy for more details.
+ *
+ * Returns 0 on success or a negative error code.
+ */
+int __nla_validate(const struct nlattr *head, int len, int maxtype,
+		   const struct nla_policy *policy, unsigned int validate,
+		   struct netlink_ext_ack *extack)
+{
+	return __nla_validate_parse(head, len, maxtype, policy, validate,
+				    extack, NULL);
+}
+EXPORT_SYMBOL(__nla_validate);
+
+/**
+ * nla_policy_len - Determin the max. length of a policy
+ * @policy: policy to use
+ * @n: number of policies
+ *
+ * Determines the max. length of the policy.  It is currently used
+ * to allocated Netlink buffers roughly the size of the actual
+ * message.
+ *
+ * Returns 0 on success or a negative error code.
+ */
+int
+nla_policy_len(const struct nla_policy *p, int n)
 {
 	int i, len = 0;
 
@@ -342,38 +452,30 @@ int backport_nla_policy_len(const struct nla_policy *p, int n)
 
 	return len;
 }
-EXPORT_SYMBOL_GPL(backport_nla_policy_len);
-
-int backport_nla_parse(struct nlattr **tb, int maxtype,
-		       const struct nlattr *head,
-		       int len, const struct nla_policy *policy,
-		       struct netlink_ext_ack *extack)
+EXPORT_SYMBOL(nla_policy_len);
+
+/**
+ * __nla_parse - Parse a stream of attributes into a tb buffer
+ * @tb: destination array with maxtype+1 elements
+ * @maxtype: maximum attribute type to be expected
+ * @head: head of attribute stream
+ * @len: length of attribute stream
+ * @policy: validation policy
+ * @validate: validation strictness
+ * @extack: extended ACK pointer
+ *
+ * Parses a stream of attributes and stores a pointer to each attribute in
+ * the tb array accessible via the attribute type.
+ * Validation is controlled by the @validate parameter.
+ *
+ * Returns 0 on success or a negative error code.
+ */
+int __nla_parse(struct nlattr **tb, int maxtype,
+		const struct nlattr *head, int len,
+		const struct nla_policy *policy, unsigned int validate,
+		struct netlink_ext_ack *extack)
 {
-	const struct nlattr *nla;
-	int rem;
-
-	memset(tb, 0, sizeof(struct nlattr *) * (maxtype + 1));
-
-	nla_for_each_attr(nla, head, len, rem) {
-		u16 type = nla_type(nla);
-
-		if (type > 0 && type <= maxtype) {
-			if (policy) {
-				int err = validate_nla(nla, maxtype, policy,
-						       extack);
-
-				if (err < 0)
-					return err;
-			}
-
-			tb[type] = (struct nlattr *)nla;
-		}
-	}
-
-	if (unlikely(rem > 0))
-		pr_warn_ratelimited("netlink: %d bytes leftover after parsing attributes in process `%s'.\n",
-				    rem, current->comm);
-
-	return 0;
+	return __nla_validate_parse(head, len, maxtype, policy, validate,
+				    extack, tb);
 }
-EXPORT_SYMBOL(backport_nla_parse);
+EXPORT_SYMBOL(__nla_parse);
diff --git a/backport/compat/backport-genetlink.c b/backport/compat/backport-genetlink.c
index 16971ec3..47078589 100644
--- a/backport/compat/backport-genetlink.c
+++ b/backport/compat/backport-genetlink.c
@@ -167,8 +167,15 @@ static int backport_pre_doit(__genl_const struct genl_ops *ops,
 	struct netlink_ext_ack *extack = info->extack;
 #endif
 
-	err = nlmsg_validate(info->nlhdr, GENL_HDRLEN + family->hdrsize,
-			     family->maxattr, ops->policy, extack);
+	if (ops->validate & GENL_DONT_VALIDATE_STRICT)
+		err = nlmsg_validate_deprecated(info->nlhdr,
+						GENL_HDRLEN + family->hdrsize,
+						family->maxattr, family->policy,
+						extack);
+	else
+		err = nlmsg_validate(info->nlhdr, GENL_HDRLEN + family->hdrsize,
+				     family->maxattr, family->policy, extack);
+
 	if (!err && family->pre_doit)
 		err = family->pre_doit(ops, skb, info);
 
@@ -230,11 +237,15 @@ int backport_genl_register_family(struct genl_family *family)
 	 * memory layout isn't compatible with the old version
 	 */
 	for (i = 0; i < family->n_ops; i++) {
-		ops[i].policy = NULL;
 #if LINUX_VERSION_IS_LESS(4,12,0)
 		if (ops[i].doit)
 			ops[i].doit = extack_doit;
 #endif
+/*
+ * TODO: add dumpit redirect (like extack_doit) that will
+ *       make this code honor !GENL_DONT_VALIDATE_DUMP and
+ *       actually validate in this case ...
+ */
 	}
 	/* keep doit/dumpit NULL - that's invalid */
 	ops[family->n_ops].done = (void *)family;
@@ -248,12 +259,13 @@ int backport_genl_register_family(struct genl_family *family)
 #if LINUX_VERSION_IS_GEQ(3,10,0)
 	COPY(parallel_ops);
 #endif
-	family->family.pre_doit = backport_pre_doit;
-	family->family.post_doit = backport_post_doit;
+	/* The casts are OK - we checked everything is the same offset in genl_ops */
+	family->family.pre_doit = (void *)backport_pre_doit;
+	family->family.post_doit = (void *)backport_post_doit;
 	/* attrbuf is output only */
-	family->copy_ops = ops;
+	family->copy_ops = (void *)ops;
 #if LINUX_VERSION_IS_GEQ(3,13,0)
-	family->family.ops = ops;
+	family->family.ops = (void *)ops;
 	COPY(mcgrps);
 	COPY(n_ops);
 	COPY(n_mcgrps);
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
