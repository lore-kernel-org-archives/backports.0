Return-Path: <SRS0=GVy1=45=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF8FAC1975A
	for <backports@archiver.kernel.org>; Thu, 12 Mar 2020 15:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90F2E206B7
	for <backports@archiver.kernel.org>; Thu, 12 Mar 2020 15:59:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbgCLP7Y (ORCPT <rfc822;backports@archiver.kernel.org>);
        Thu, 12 Mar 2020 11:59:24 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:57516 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727240AbgCLP7Y (ORCPT
        <rfc822;backports@vger.kernel.org>); Thu, 12 Mar 2020 11:59:24 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jCQEz-004nuk-UJ; Thu, 12 Mar 2020 16:59:22 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     backports@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 3/3] backports: netlink: fix nla_validate_nested()
Date:   Thu, 12 Mar 2020 16:59:13 +0100
Message-Id: <20200312165913.14bfeceb4e2e.I026c8a13b9f070ccccbf29547d1289c362782881@changeid>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200312165913.e9a97c70de23.Idb983599e482232ae3cfc3328e837e8a9bf1af7a@changeid>
References: <20200312165913.e9a97c70de23.Idb983599e482232ae3cfc3328e837e8a9bf1af7a@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

I had accidentally named this nl80211_validate_nested(),
and it got renamed in 5.6.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/net/netlink.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/backport/backport-include/net/netlink.h b/backport/backport-include/net/netlink.h
index bc24adfb4d63..675e43fc4e31 100644
--- a/backport/backport-include/net/netlink.h
+++ b/backport/backport-include/net/netlink.h
@@ -266,17 +266,17 @@ nla_validate_nested_deprecated(const struct nlattr *start, int maxtype,
 }
 #endif /* < 5.2 */
 
-#if LINUX_VERSION_IS_LESS(5,3,0)
-#define nl80211_validate_nested LINUX_BACKPORT(nl80211_validate_nested)
+#if LINUX_VERSION_IS_LESS(5,6,0)
+#define nla_validate_nested LINUX_BACKPORT(nla_validate_nested)
 static inline int
-nl80211_validate_nested(const struct nlattr *start, int maxtype,
-			const struct nla_policy *policy,
-			struct netlink_ext_ack *extack)
+nla_validate_nested(const struct nlattr *start, int maxtype,
+		    const struct nla_policy *policy,
+		    struct netlink_ext_ack *extack)
 {
 	return __nla_validate_nested(start, maxtype, policy,
 				     NL_VALIDATE_STRICT, extack);
 }
-#endif /* < 5.3 */
+#endif /* < 5.6 */
 
 #if LINUX_VERSION_IS_LESS(5,1,0)
 #undef NLA_POLICY_NESTED
-- 
2.24.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
