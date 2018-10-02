Return-Path: <SRS0=zs2H=MO=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3188CC64EB9
	for <backports@archiver.kernel.org>; Tue,  2 Oct 2018 19:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4044206B2
	for <backports@archiver.kernel.org>; Tue,  2 Oct 2018 19:32:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4044206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=backports-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbeJCCRc (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 2 Oct 2018 22:17:32 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:48356 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726503AbeJCCRb (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 2 Oct 2018 22:17:31 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.91)
        (envelope-from <johannes@sipsolutions.net>)
        id 1g7QPI-0004o0-20; Tue, 02 Oct 2018 21:32:32 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     backports@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 4/6] backports: backport most of improved netlink policy validation
Date:   Tue,  2 Oct 2018 21:32:13 +0200
Message-Id: <20181002193215.399-4-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181002193215.399-1-johannes@sipsolutions.net>
References: <20181002193215.399-1-johannes@sipsolutions.net>
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/netlink.h |  19 ++
 backport/backport-include/net/netlink.h   | 185 ++++++++++++++-
 backport/compat/Makefile                  |   1 +
 backport/compat/backport-4.20.c           | 379 ++++++++++++++++++++++++++++++
 4 files changed, 572 insertions(+), 12 deletions(-)
 create mode 100644 backport/compat/backport-4.20.c

diff --git a/backport/backport-include/linux/netlink.h b/backport/backport-include/linux/netlink.h
index 468a12d15dbe..366c9e27e8c2 100644
--- a/backport/backport-include/linux/netlink.h
+++ b/backport/backport-include/linux/netlink.h
@@ -3,6 +3,13 @@
 #include_next <linux/netlink.h>
 #include <linux/version.h>
 
+#if LINUX_VERSION_IS_LESS(4,14,0)
+struct nla_bitfield32 {
+	__u32 value;
+	__u32 selector;
+};
+#endif
+
 #if LINUX_VERSION_IS_LESS(4,12,0)
 #define NETLINK_MAX_COOKIE_LEN  20
 
@@ -23,6 +30,18 @@ struct netlink_ext_ack {
 } while (0)
 #endif
 
+#ifndef NL_SET_ERR_MSG_ATTR
+#define NL_SET_ERR_MSG_ATTR(extack, attr, msg) do {	\
+	static const char __msg[] = msg;		\
+	struct netlink_ext_ack *__extack = (extack);	\
+							\
+	if (__extack) {					\
+		__extack->_msg = __msg;			\
+		__extack->bad_attr = (attr);		\
+	}						\
+} while (0)
+#endif
+
 /* this is for patches we apply */
 #if LINUX_VERSION_IS_LESS(3,7,0)
 #define netlink_notify_portid(__notify) (__notify->pid)
diff --git a/backport/backport-include/net/netlink.h b/backport/backport-include/net/netlink.h
index 7775bc8295c3..4af73631115e 100644
--- a/backport/backport-include/net/netlink.h
+++ b/backport/backport-include/net/netlink.h
@@ -4,6 +4,162 @@
 #include <linux/version.h>
 #include <linux/in6.h>
 
+#if LINUX_VERSION_IS_LESS(4,20,0)
+/* can't backport using the enum - need to override */
+#define NLA_UNSPEC		0
+#define NLA_U8			1
+#define NLA_U16			2
+#define NLA_U32			3
+#define NLA_U64			4
+#define NLA_STRING		5
+#define NLA_FLAG		6
+#define NLA_MSECS		7
+#define NLA_NESTED		8
+#define NLA_NESTED_ARRAY	9
+#define NLA_NUL_STRING		10
+#define NLA_BINARY		11
+#define NLA_S8			12
+#define NLA_S16			13
+#define NLA_S32			14
+#define NLA_S64			15
+#define NLA_BITFIELD32		16
+#define NLA_REJECT		17
+#define NLA_EXACT_LEN		18
+#define NLA_EXACT_LEN_WARN	19
+#define __NLA_TYPE_MAX		20
+#define NLA_TYPE_MAX		(__NLA_TYPE_MAX - 1)
+
+enum nla_policy_validation {
+	NLA_VALIDATE_NONE,
+	NLA_VALIDATE_RANGE,
+	NLA_VALIDATE_MIN,
+	NLA_VALIDATE_MAX,
+	NLA_VALIDATE_FUNCTION,
+};
+
+struct backport_nla_policy {
+	u8		type;
+	u8		validation_type;
+	u16		len;
+	union {
+		const void *validation_data;
+		struct {
+			s16 min, max;
+		};
+		int (*validate)(const struct nlattr *attr,
+				struct netlink_ext_ack *extack);
+	};
+};
+#define nla_policy backport_nla_policy
+
+#define NLA_POLICY_EXACT_LEN(_len)	{ .type = NLA_EXACT_LEN, .len = _len }
+#define NLA_POLICY_EXACT_LEN_WARN(_len)	{ .type = NLA_EXACT_LEN_WARN, \
+					  .len = _len }
+
+#define NLA_POLICY_ETH_ADDR		NLA_POLICY_EXACT_LEN(ETH_ALEN)
+#define NLA_POLICY_ETH_ADDR_COMPAT	NLA_POLICY_EXACT_LEN_WARN(ETH_ALEN)
+
+#define NLA_POLICY_NESTED(maxattr, policy) \
+	{ .type = NLA_NESTED, .validation_data = policy, .len = maxattr }
+#define NLA_POLICY_NESTED_ARRAY(maxattr, policy) \
+	{ .type = NLA_NESTED_ARRAY, .validation_data = policy, .len = maxattr }
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
+}
+
+#define nla_validate LINUX_BACKPORT(nla_validate)
+int nla_validate(const struct nlattr *head, int len, int maxtype,
+		 const struct nla_policy *policy,
+		 struct netlink_ext_ack *extack);
+#define nla_parse LINUX_BACKPORT(nla_parse)
+int nla_parse(struct nlattr **tb, int maxtype, const struct nlattr *head,
+	      int len, const struct nla_policy *policy,
+	      struct netlink_ext_ack *extack);
+#define nla_policy_len LINUX_BACKPORT(nla_policy_len)
+int nla_policy_len(const struct nla_policy *, int);
+
+#define nlmsg_parse LINUX_BACKPORT(nlmsg_parse)
+static inline int nlmsg_parse(const struct nlmsghdr *nlh, int hdrlen,
+			      struct nlattr *tb[], int maxtype,
+			      const struct nla_policy *policy,
+			      struct netlink_ext_ack *extack)
+{
+	if (nlh->nlmsg_len < nlmsg_msg_size(hdrlen))
+		return -EINVAL;
+
+	return nla_parse(tb, maxtype, nlmsg_attrdata(nlh, hdrlen),
+			 nlmsg_attrlen(nlh, hdrlen), policy, extack);
+}
+
+#define nlmsg_validate LINUX_BACKPORT(nlmsg_validate)
+static inline int nlmsg_validate(const struct nlmsghdr *nlh,
+				 int hdrlen, int maxtype,
+				 const struct nla_policy *policy,
+				 struct netlink_ext_ack *extack)
+{
+	if (nlh->nlmsg_len < nlmsg_msg_size(hdrlen))
+		return -EINVAL;
+
+	return nla_validate(nlmsg_attrdata(nlh, hdrlen),
+			    nlmsg_attrlen(nlh, hdrlen), maxtype, policy,
+			    extack);
+}
+
+#define nla_parse_nested LINUX_BACKPORT(nla_parse_nested)
+static inline int nla_parse_nested(struct nlattr *tb[], int maxtype,
+				   const struct nlattr *nla,
+				   const struct nla_policy *policy,
+				   struct netlink_ext_ack *extack)
+{
+	return nla_parse(tb, maxtype, nla_data(nla), nla_len(nla), policy,
+			 extack);
+}
+
+#define nla_validate_nested LINUX_BACKPORT(nla_validate_nested)
+static inline int nla_validate_nested(const struct nlattr *start, int maxtype,
+				      const struct nla_policy *policy,
+				      struct netlink_ext_ack *extack)
+{
+	return nla_validate(nla_data(start), nla_len(start), maxtype, policy,
+			    extack);
+}
+#endif /* < 4.20 */
+
 #if LINUX_VERSION_IS_LESS(4,12,0)
 #include <backport/magic.h>
 
@@ -12,13 +168,13 @@ static inline int _nla_validate5(const struct nlattr *head,
 				 const struct nla_policy *policy,
 				 struct netlink_ext_ack *extack)
 {
-	return nla_validate(head, len, maxtype, policy);
+	return nla_validate(head, len, maxtype, policy, extack);
 }
 static inline int _nla_validate4(const struct nlattr *head,
 				 int len, int maxtype,
 				 const struct nla_policy *policy)
 {
-	return nla_validate(head, len, maxtype, policy);
+	return nla_validate(head, len, maxtype, policy, NULL);
 }
 #undef nla_validate
 #define nla_validate(...) \
@@ -29,14 +185,15 @@ static inline int _nla_parse6(struct nlattr **tb, int maxtype,
 			      int len, const struct nla_policy *policy,
 			      struct netlink_ext_ack *extack)
 {
-	return nla_parse(tb, maxtype, head, len, policy);
+	return nla_parse(tb, maxtype, head, len, policy, extack);
 }
 static inline int _nla_parse5(struct nlattr **tb, int maxtype,
 			      const struct nlattr *head,
 			      int len, const struct nla_policy *policy)
 {
-	return nla_parse(tb, maxtype, head, len, policy);
+	return nla_parse(tb, maxtype, head, len, policy, NULL);
 }
+#undef nla_parse
 #define nla_parse(...) \
 	macro_dispatcher(_nla_parse, __VA_ARGS__)(__VA_ARGS__)
 
@@ -45,14 +202,15 @@ static inline int _nlmsg_parse6(const struct nlmsghdr *nlh, int hdrlen,
 			        const struct nla_policy *policy,
 			        struct netlink_ext_ack *extack)
 {
-	return nlmsg_parse(nlh, hdrlen, tb, maxtype, policy);
+	return nlmsg_parse(nlh, hdrlen, tb, maxtype, policy, extack);
 }
 static inline int _nlmsg_parse5(const struct nlmsghdr *nlh, int hdrlen,
 			        struct nlattr *tb[], int maxtype,
 			        const struct nla_policy *policy)
 {
-	return nlmsg_parse(nlh, hdrlen, tb, maxtype, policy);
+	return nlmsg_parse(nlh, hdrlen, tb, maxtype, policy, NULL);
 }
+#undef nlmsg_parse
 #define nlmsg_parse(...) \
 	macro_dispatcher(_nlmsg_parse, __VA_ARGS__)(__VA_ARGS__)
 
@@ -61,14 +219,15 @@ static inline int _nlmsg_validate5(const struct nlmsghdr *nlh,
 				   const struct nla_policy *policy,
 				   struct netlink_ext_ack *extack)
 {
-	return nlmsg_validate(nlh, hdrlen, maxtype, policy);
+	return nlmsg_validate(nlh, hdrlen, maxtype, policy, extack);
 }
 static inline int _nlmsg_validate4(const struct nlmsghdr *nlh,
 				   int hdrlen, int maxtype,
 				   const struct nla_policy *policy)
 {
-	return nlmsg_validate(nlh, hdrlen, maxtype, policy);
+	return nlmsg_validate(nlh, hdrlen, maxtype, policy, NULL);
 }
+#undef nlmsg_validate
 #define nlmsg_validate(...) \
 	macro_dispatcher(_nlmsg_validate, __VA_ARGS__)(__VA_ARGS__)
 
@@ -77,14 +236,15 @@ static inline int _nla_parse_nested5(struct nlattr *tb[], int maxtype,
 				     const struct nla_policy *policy,
 				     struct netlink_ext_ack *extack)
 {
-	return nla_parse_nested(tb, maxtype, nla, policy);
+	return nla_parse_nested(tb, maxtype, nla, policy, extack);
 }
 static inline int _nla_parse_nested4(struct nlattr *tb[], int maxtype,
 				     const struct nlattr *nla,
 				     const struct nla_policy *policy)
 {
-	return nla_parse_nested(tb, maxtype, nla, policy);
+	return nla_parse_nested(tb, maxtype, nla, policy, NULL);
 }
+#undef nla_parse_nested
 #define nla_parse_nested(...) \
 	macro_dispatcher(_nla_parse_nested, __VA_ARGS__)(__VA_ARGS__)
 
@@ -92,13 +252,14 @@ static inline int _nla_validate_nested4(const struct nlattr *start, int maxtype,
 					const struct nla_policy *policy,
 					struct netlink_ext_ack *extack)
 {
-	return nla_validate_nested(start, maxtype, policy);
+	return nla_validate_nested(start, maxtype, policy, extack);
 }
 static inline int _nla_validate_nested3(const struct nlattr *start, int maxtype,
 					const struct nla_policy *policy)
 {
-	return nla_validate_nested(start, maxtype, policy);
+	return nla_validate_nested(start, maxtype, policy, NULL);
 }
+#undef nla_validate_nested
 #define nla_validate_nested(...) \
 	macro_dispatcher(_nla_validate_nested, __VA_ARGS__)(__VA_ARGS__)
 #endif /* LINUX_VERSION_IS_LESS(4,12,0) */
diff --git a/backport/compat/Makefile b/backport/compat/Makefile
index f5b1886e2d8e..ff6c7e658380 100644
--- a/backport/compat/Makefile
+++ b/backport/compat/Makefile
@@ -38,6 +38,7 @@ compat-$(CPTCFG_KERNEL_4_8) += backport-4.8.o
 compat-$(CPTCFG_KERNEL_4_10) += backport-4.10.o
 compat-$(CPTCFG_KERNEL_4_12) += backport-4.12.o
 compat-$(CPTCFG_KERNEL_4_18) += backport-4.18.o
+compat-$(CPTCFG_KERNEL_4_20) += backport-4.20.o
 
 compat-$(CPTCFG_BPAUTO_CRYPTO_SKCIPHER) += crypto-skcipher.o
 
diff --git a/backport/compat/backport-4.20.c b/backport/compat/backport-4.20.c
new file mode 100644
index 000000000000..e26f3b52fbbe
--- /dev/null
+++ b/backport/compat/backport-4.20.c
@@ -0,0 +1,379 @@
+/*
+ * Copyright (C) 2018 Intel Corporation
+ *
+ * Backport functionality introduced in Linux 4.20.
+ * This is basically upstream lib/nlattr.c.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/kernel.h>
+#include <linux/export.h>
+#include <linux/errno.h>
+#include <linux/types.h>
+#include <net/netlink.h>
+
+static const u8 nla_attr_len[NLA_TYPE_MAX+1] = {
+	[NLA_U8]	= sizeof(u8),
+	[NLA_U16]	= sizeof(u16),
+	[NLA_U32]	= sizeof(u32),
+	[NLA_U64]	= sizeof(u64),
+	[NLA_S8]	= sizeof(s8),
+	[NLA_S16]	= sizeof(s16),
+	[NLA_S32]	= sizeof(s32),
+	[NLA_S64]	= sizeof(s64),
+};
+
+static const u8 nla_attr_minlen[NLA_TYPE_MAX+1] = {
+	[NLA_U8]	= sizeof(u8),
+	[NLA_U16]	= sizeof(u16),
+	[NLA_U32]	= sizeof(u32),
+	[NLA_U64]	= sizeof(u64),
+	[NLA_MSECS]	= sizeof(u64),
+	[NLA_NESTED]	= NLA_HDRLEN,
+	[NLA_S8]	= sizeof(s8),
+	[NLA_S16]	= sizeof(s16),
+	[NLA_S32]	= sizeof(s32),
+	[NLA_S64]	= sizeof(s64),
+};
+
+static int validate_nla_bitfield32(const struct nlattr *nla,
+				   const u32 *valid_flags_mask)
+{
+	const struct nla_bitfield32 *bf = nla_data(nla);
+
+	if (!valid_flags_mask)
+		return -EINVAL;
+
+	/*disallow invalid bit selector */
+	if (bf->selector & ~*valid_flags_mask)
+		return -EINVAL;
+
+	/*disallow invalid bit values */
+	if (bf->value & ~*valid_flags_mask)
+		return -EINVAL;
+
+	/*disallow valid bit values that are not selected*/
+	if (bf->value & ~bf->selector)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int nla_validate_array(const struct nlattr *head, int len, int maxtype,
+			      const struct nla_policy *policy,
+			      struct netlink_ext_ack *extack)
+{
+	const struct nlattr *entry;
+	int rem;
+
+	nla_for_each_attr(entry, head, len, rem) {
+		int ret;
+
+		if (nla_len(entry) == 0)
+			continue;
+
+		if (nla_len(entry) < NLA_HDRLEN) {
+			NL_SET_ERR_MSG_ATTR(extack, entry,
+					    "Array element too short");
+			return -ERANGE;
+		}
+
+		ret = nla_validate(nla_data(entry), nla_len(entry),
+				   maxtype, policy, extack);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int nla_validate_int_range(const struct nla_policy *pt,
+				  const struct nlattr *nla,
+				  struct netlink_ext_ack *extack)
+{
+	bool validate_min, validate_max;
+	s64 value;
+
+	validate_min = pt->validation_type == NLA_VALIDATE_RANGE ||
+		       pt->validation_type == NLA_VALIDATE_MIN;
+	validate_max = pt->validation_type == NLA_VALIDATE_RANGE ||
+		       pt->validation_type == NLA_VALIDATE_MAX;
+
+	switch (pt->type) {
+	case NLA_U8:
+		value = nla_get_u8(nla);
+		break;
+	case NLA_U16:
+		value = nla_get_u16(nla);
+		break;
+	case NLA_U32:
+		value = nla_get_u32(nla);
+		break;
+	case NLA_S8:
+		value = nla_get_s8(nla);
+		break;
+	case NLA_S16:
+		value = nla_get_s16(nla);
+		break;
+	case NLA_S32:
+		value = nla_get_s32(nla);
+		break;
+	case NLA_S64:
+		value = nla_get_s64(nla);
+		break;
+	case NLA_U64:
+		/* treat this one specially, since it may not fit into s64 */
+		if ((validate_min && nla_get_u64(nla) < pt->min) ||
+		    (validate_max && nla_get_u64(nla) > pt->max)) {
+			NL_SET_ERR_MSG_ATTR(extack, nla,
+					    "integer out of range");
+			return -ERANGE;
+		}
+		return 0;
+	default:
+		WARN_ON(1);
+		return -EINVAL;
+	}
+
+	if ((validate_min && value < pt->min) ||
+	    (validate_max && value > pt->max)) {
+		NL_SET_ERR_MSG_ATTR(extack, nla,
+				    "integer out of range");
+		return -ERANGE;
+	}
+
+	return 0;
+}
+
+static int validate_nla(const struct nlattr *nla, int maxtype,
+			const struct nla_policy *policy,
+			struct netlink_ext_ack *extack)
+{
+	const struct nla_policy *pt;
+	int minlen = 0, attrlen = nla_len(nla), type = nla_type(nla);
+	int err = -ERANGE;
+
+	if (type <= 0 || type > maxtype)
+		return 0;
+
+	pt = &policy[type];
+
+	BUG_ON(pt->type > NLA_TYPE_MAX);
+
+	if ((nla_attr_len[pt->type] && attrlen != nla_attr_len[pt->type]) ||
+	    (pt->type == NLA_EXACT_LEN_WARN && attrlen != pt->len)) {
+		pr_warn_ratelimited("netlink: '%s': attribute type %d has an invalid length.\n",
+				    current->comm, type);
+	}
+
+	switch (pt->type) {
+	case NLA_EXACT_LEN:
+		if (attrlen != pt->len)
+			goto out_err;
+		break;
+
+	case NLA_REJECT:
+		if (extack && pt->validation_data) {
+			NL_SET_BAD_ATTR(extack, nla);
+			extack->_msg = pt->validation_data;
+			return -EINVAL;
+		}
+		err = -EINVAL;
+		goto out_err;
+
+	case NLA_FLAG:
+		if (attrlen > 0)
+			goto out_err;
+		break;
+
+	case NLA_BITFIELD32:
+		if (attrlen != sizeof(struct nla_bitfield32))
+			goto out_err;
+
+		err = validate_nla_bitfield32(nla, pt->validation_data);
+		if (err)
+			goto out_err;
+		break;
+
+	case NLA_NUL_STRING:
+		if (pt->len)
+			minlen = min_t(int, attrlen, pt->len + 1);
+		else
+			minlen = attrlen;
+
+		if (!minlen || memchr(nla_data(nla), '\0', minlen) == NULL) {
+			err = -EINVAL;
+			goto out_err;
+		}
+		/* fall through */
+
+	case NLA_STRING:
+		if (attrlen < 1)
+			goto out_err;
+
+		if (pt->len) {
+			char *buf = nla_data(nla);
+
+			if (buf[attrlen - 1] == '\0')
+				attrlen--;
+
+			if (attrlen > pt->len)
+				goto out_err;
+		}
+		break;
+
+	case NLA_BINARY:
+		if (pt->len && attrlen > pt->len)
+			goto out_err;
+		break;
+
+	case NLA_NESTED:
+		/* a nested attributes is allowed to be empty; if its not,
+		 * it must have a size of at least NLA_HDRLEN.
+		 */
+		if (attrlen == 0)
+			break;
+		if (attrlen < NLA_HDRLEN)
+			goto out_err;
+		if (pt->validation_data) {
+			err = nla_validate(nla_data(nla), nla_len(nla), pt->len,
+					   pt->validation_data, extack);
+			if (err < 0) {
+				/*
+				 * return directly to preserve the inner
+				 * error message/attribute pointer
+				 */
+				return err;
+			}
+		}
+		break;
+	case NLA_NESTED_ARRAY:
+		/* a nested array attribute is allowed to be empty; if its not,
+		 * it must have a size of at least NLA_HDRLEN.
+		 */
+		if (attrlen == 0)
+			break;
+		if (attrlen < NLA_HDRLEN)
+			goto out_err;
+		if (pt->validation_data) {
+			int err;
+
+			err = nla_validate_array(nla_data(nla), nla_len(nla),
+						 pt->len, pt->validation_data,
+						 extack);
+			if (err < 0) {
+				/*
+				 * return directly to preserve the inner
+				 * error message/attribute pointer
+				 */
+				return err;
+			}
+		}
+		break;
+	default:
+		if (pt->len)
+			minlen = pt->len;
+		else if (pt->type != NLA_UNSPEC)
+			minlen = nla_attr_minlen[pt->type];
+
+		if (attrlen < minlen)
+			goto out_err;
+	}
+
+	/* further validation */
+	switch (pt->validation_type) {
+	case NLA_VALIDATE_NONE:
+		/* nothing to do */
+		break;
+	case NLA_VALIDATE_RANGE:
+	case NLA_VALIDATE_MIN:
+	case NLA_VALIDATE_MAX:
+		err = nla_validate_int_range(pt, nla, extack);
+		if (err)
+			return err;
+		break;
+	case NLA_VALIDATE_FUNCTION:
+		if (pt->validate) {
+			err = pt->validate(nla, extack);
+			if (err)
+				return err;
+		}
+		break;
+	}
+
+	return 0;
+out_err:
+	NL_SET_ERR_MSG_ATTR(extack, nla, "Attribute failed policy validation");
+	return err;
+}
+
+int backport_nla_validate(const struct nlattr *head, int len, int maxtype,
+			  const struct nla_policy *policy,
+			  struct netlink_ext_ack *extack)
+{
+	const struct nlattr *nla;
+	int rem;
+
+	nla_for_each_attr(nla, head, len, rem) {
+		int err = validate_nla(nla, maxtype, policy, extack);
+
+		if (err < 0)
+			return err;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(backport_nla_validate);
+
+int backport_nla_policy_len(const struct nla_policy *p, int n)
+{
+	int i, len = 0;
+
+	for (i = 0; i < n; i++, p++) {
+		if (p->len)
+			len += nla_total_size(p->len);
+		else if (nla_attr_len[p->type])
+			len += nla_total_size(nla_attr_len[p->type]);
+		else if (nla_attr_minlen[p->type])
+			len += nla_total_size(nla_attr_minlen[p->type]);
+	}
+
+	return len;
+}
+EXPORT_SYMBOL_GPL(backport_nla_policy_len);
+
+int backport_nla_parse(struct nlattr **tb, int maxtype,
+		       const struct nlattr *head,
+		       int len, const struct nla_policy *policy,
+		       struct netlink_ext_ack *extack)
+{
+	const struct nlattr *nla;
+	int rem;
+
+	memset(tb, 0, sizeof(struct nlattr *) * (maxtype + 1));
+
+	nla_for_each_attr(nla, head, len, rem) {
+		u16 type = nla_type(nla);
+
+		if (type > 0 && type <= maxtype) {
+			if (policy) {
+				int err = validate_nla(nla, maxtype, policy,
+						       extack);
+
+				if (err < 0)
+					return err;
+			}
+
+			tb[type] = (struct nlattr *)nla;
+		}
+	}
+
+	if (unlikely(rem > 0))
+		pr_warn_ratelimited("netlink: %d bytes leftover after parsing attributes in process `%s'.\n",
+				    rem, current->comm);
+
+	return 0;
+}
+EXPORT_SYMBOL(backport_nla_parse);
-- 
2.14.4

--
To unsubscribe from this list: send the line "unsubscribe backports" in
