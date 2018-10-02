Return-Path: <SRS0=zs2H=MO=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD05C43143
	for <backports@archiver.kernel.org>; Tue,  2 Oct 2018 17:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F79B2089C
	for <backports@archiver.kernel.org>; Tue,  2 Oct 2018 17:51:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F79B2089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=backports-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbeJCAf6 (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 2 Oct 2018 20:35:58 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:47538 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbeJCAf6 (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 2 Oct 2018 20:35:58 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.91)
        (envelope-from <johannes@sipsolutions.net>)
        id 1g7OpO-0003Fx-RV; Tue, 02 Oct 2018 19:51:23 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     backports@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 1/6] backports: rename magic functions for netlink parsing
Date:   Tue,  2 Oct 2018 19:51:02 +0200
Message-Id: <20181002175107.16336-1-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.14.4
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Make all the magic variable argument calls inlines and
rename them so we can override them more easily later.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/net/netlink.h | 100 +++++++++++++++++++++-----------
 1 file changed, 65 insertions(+), 35 deletions(-)

diff --git a/backport/backport-include/net/netlink.h b/backport/backport-include/net/netlink.h
index 37c899b07b1d..7775bc8295c3 100644
--- a/backport/backport-include/net/netlink.h
+++ b/backport/backport-include/net/netlink.h
@@ -7,70 +7,100 @@
 #if LINUX_VERSION_IS_LESS(4,12,0)
 #include <backport/magic.h>
 
-static inline int nla_validate5(const struct nlattr *head,
-				int len, int maxtype,
-				const struct nla_policy *policy,
-				struct netlink_ext_ack *extack)
+static inline int _nla_validate5(const struct nlattr *head,
+				 int len, int maxtype,
+				 const struct nla_policy *policy,
+				 struct netlink_ext_ack *extack)
 {
 	return nla_validate(head, len, maxtype, policy);
 }
-#define nla_validate4 nla_validate
+static inline int _nla_validate4(const struct nlattr *head,
+				 int len, int maxtype,
+				 const struct nla_policy *policy)
+{
+	return nla_validate(head, len, maxtype, policy);
+}
+#undef nla_validate
 #define nla_validate(...) \
-	macro_dispatcher(nla_validate, __VA_ARGS__)(__VA_ARGS__)
+	macro_dispatcher(_nla_validate, __VA_ARGS__)(__VA_ARGS__)
 
-static inline int nla_parse6(struct nlattr **tb, int maxtype,
-			     const struct nlattr *head,
-			     int len, const struct nla_policy *policy,
-			     struct netlink_ext_ack *extack)
+static inline int _nla_parse6(struct nlattr **tb, int maxtype,
+			      const struct nlattr *head,
+			      int len, const struct nla_policy *policy,
+			      struct netlink_ext_ack *extack)
+{
+	return nla_parse(tb, maxtype, head, len, policy);
+}
+static inline int _nla_parse5(struct nlattr **tb, int maxtype,
+			      const struct nlattr *head,
+			      int len, const struct nla_policy *policy)
 {
 	return nla_parse(tb, maxtype, head, len, policy);
 }
-#define nla_parse5(...) nla_parse(__VA_ARGS__)
 #define nla_parse(...) \
-	macro_dispatcher(nla_parse, __VA_ARGS__)(__VA_ARGS__)
+	macro_dispatcher(_nla_parse, __VA_ARGS__)(__VA_ARGS__)
 
-static inline int nlmsg_parse6(const struct nlmsghdr *nlh, int hdrlen,
-			       struct nlattr *tb[], int maxtype,
-			       const struct nla_policy *policy,
-			       struct netlink_ext_ack *extack)
+static inline int _nlmsg_parse6(const struct nlmsghdr *nlh, int hdrlen,
+			        struct nlattr *tb[], int maxtype,
+			        const struct nla_policy *policy,
+			        struct netlink_ext_ack *extack)
+{
+	return nlmsg_parse(nlh, hdrlen, tb, maxtype, policy);
+}
+static inline int _nlmsg_parse5(const struct nlmsghdr *nlh, int hdrlen,
+			        struct nlattr *tb[], int maxtype,
+			        const struct nla_policy *policy)
 {
 	return nlmsg_parse(nlh, hdrlen, tb, maxtype, policy);
 }
-#define nlmsg_parse5 nlmsg_parse
 #define nlmsg_parse(...) \
-	macro_dispatcher(nlmsg_parse, __VA_ARGS__)(__VA_ARGS__)
+	macro_dispatcher(_nlmsg_parse, __VA_ARGS__)(__VA_ARGS__)
 
-static inline int nlmsg_validate5(const struct nlmsghdr *nlh,
-				  int hdrlen, int maxtype,
-				  const struct nla_policy *policy,
-				  struct netlink_ext_ack *extack)
+static inline int _nlmsg_validate5(const struct nlmsghdr *nlh,
+				   int hdrlen, int maxtype,
+				   const struct nla_policy *policy,
+				   struct netlink_ext_ack *extack)
+{
+	return nlmsg_validate(nlh, hdrlen, maxtype, policy);
+}
+static inline int _nlmsg_validate4(const struct nlmsghdr *nlh,
+				   int hdrlen, int maxtype,
+				   const struct nla_policy *policy)
 {
 	return nlmsg_validate(nlh, hdrlen, maxtype, policy);
 }
-#define nlmsg_validate4 nlmsg_validate
 #define nlmsg_validate(...) \
-	macro_dispatcher(nlmsg_validate, __VA_ARGS__)(__VA_ARGS__)
+	macro_dispatcher(_nlmsg_validate, __VA_ARGS__)(__VA_ARGS__)
 
-static inline int nla_parse_nested5(struct nlattr *tb[], int maxtype,
-				    const struct nlattr *nla,
-				    const struct nla_policy *policy,
-				    struct netlink_ext_ack *extack)
+static inline int _nla_parse_nested5(struct nlattr *tb[], int maxtype,
+				     const struct nlattr *nla,
+				     const struct nla_policy *policy,
+				     struct netlink_ext_ack *extack)
+{
+	return nla_parse_nested(tb, maxtype, nla, policy);
+}
+static inline int _nla_parse_nested4(struct nlattr *tb[], int maxtype,
+				     const struct nlattr *nla,
+				     const struct nla_policy *policy)
 {
 	return nla_parse_nested(tb, maxtype, nla, policy);
 }
-#define nla_parse_nested4 nla_parse_nested
 #define nla_parse_nested(...) \
-	macro_dispatcher(nla_parse_nested, __VA_ARGS__)(__VA_ARGS__)
+	macro_dispatcher(_nla_parse_nested, __VA_ARGS__)(__VA_ARGS__)
 
-static inline int nla_validate_nested4(const struct nlattr *start, int maxtype,
-				       const struct nla_policy *policy,
-				       struct netlink_ext_ack *extack)
+static inline int _nla_validate_nested4(const struct nlattr *start, int maxtype,
+					const struct nla_policy *policy,
+					struct netlink_ext_ack *extack)
+{
+	return nla_validate_nested(start, maxtype, policy);
+}
+static inline int _nla_validate_nested3(const struct nlattr *start, int maxtype,
+					const struct nla_policy *policy)
 {
 	return nla_validate_nested(start, maxtype, policy);
 }
-#define nla_validate_nested3 nla_validate_nested
 #define nla_validate_nested(...) \
-	macro_dispatcher(nla_validate_nested, __VA_ARGS__)(__VA_ARGS__)
+	macro_dispatcher(_nla_validate_nested, __VA_ARGS__)(__VA_ARGS__)
 #endif /* LINUX_VERSION_IS_LESS(4,12,0) */
 
 #if LINUX_VERSION_IS_LESS(3,7,0)
-- 
2.14.4

--
To unsubscribe from this list: send the line "unsubscribe backports" in
