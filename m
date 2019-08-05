Return-Path: <SRS0=hnMY=WB=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 887D2C433FF
	for <backports@archiver.kernel.org>; Mon,  5 Aug 2019 12:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CB8F2086D
	for <backports@archiver.kernel.org>; Mon,  5 Aug 2019 12:08:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728144AbfHEMID (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 5 Aug 2019 08:08:03 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:18044 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727259AbfHEMID (ORCPT <rfc822;backports@vger.kernel.org>);
        Mon, 5 Aug 2019 08:08:03 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 5B7C3A1635;
        Mon,  5 Aug 2019 14:08:01 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id YPkm8BP3KMtO; Mon,  5 Aug 2019 14:07:46 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes@sipsolutions.net, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 04/12] header: Add nl80211_validate_nested()
Date:   Mon,  5 Aug 2019 14:06:56 +0200
Message-Id: <20190805120704.13128-5-hauke@hauke-m.de>
In-Reply-To: <20190805120704.13128-1-hauke@hauke-m.de>
References: <20190805120704.13128-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

nl80211_validate_nested() was added in commit 901bb9891855 ("nl80211:
require and validate vendor command policy") in kernel 5.3 and is used
by nl80211.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/net/netlink.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/backport/backport-include/net/netlink.h b/backport/backport-include/net/netlink.h
index 4d73c57f..b2045e44 100644
--- a/backport/backport-include/net/netlink.h
+++ b/backport/backport-include/net/netlink.h
@@ -266,6 +266,18 @@ nla_validate_nested_deprecated(const struct nlattr *start, int maxtype,
 }
 #endif /* < 5.2 */
 
+#if LINUX_VERSION_IS_LESS(5,3,0)
+#define nl80211_validate_nested LINUX_BACKPORT(nl80211_validate_nested)
+static inline int
+nl80211_validate_nested(const struct nlattr *start, int maxtype,
+			const struct nla_policy *policy,
+			struct netlink_ext_ack *extack)
+{
+	return __nla_validate_nested(start, maxtype, policy,
+				     NL_VALIDATE_STRICT, extack);
+}
+#endif /* < 5.3 */
+
 #if LINUX_VERSION_IS_LESS(5,1,0)
 #undef NLA_POLICY_NESTED
 #undef NLA_POLICY_NESTED_ARRAY
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
