Return-Path: <SRS0=xZrn=6D=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E19BC54F70
	for <backports@archiver.kernel.org>; Sun, 19 Apr 2020 17:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DA46206E9
	for <backports@archiver.kernel.org>; Sun, 19 Apr 2020 17:11:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbgDSRLE (ORCPT <rfc822;backports@archiver.kernel.org>);
        Sun, 19 Apr 2020 13:11:04 -0400
Received: from mout-p-103.mailbox.org ([80.241.56.161]:37016 "EHLO
        mout-p-103.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbgDSRLD (ORCPT
        <rfc822;backports@vger.kernel.org>); Sun, 19 Apr 2020 13:11:03 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-103.mailbox.org (Postfix) with ESMTPS id 494xDg6Vt9zKmL5;
        Sun, 19 Apr 2020 19:10:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172]) (amavisd-new, port 10030)
        with ESMTP id wnQZTFSQX8pj; Sun, 19 Apr 2020 19:10:56 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes@sipsolutions.net, Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 3/8] backports: netlink: fix nla_validate_nested()
Date:   Sun, 19 Apr 2020 19:10:34 +0200
Message-Id: <20200419171039.17268-4-hauke@hauke-m.de>
In-Reply-To: <20200419171039.17268-1-hauke@hauke-m.de>
References: <20200419171039.17268-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D77D11761
X-Rspamd-Score: 0.31 / 15.00 / 15.00
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
index b2045e44..082ac4d0 100644
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
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
