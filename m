Return-Path: <SRS0=+jjK=6E=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39BB7C55181
	for <backports@archiver.kernel.org>; Mon, 20 Apr 2020 22:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 192472078C
	for <backports@archiver.kernel.org>; Mon, 20 Apr 2020 22:16:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbgDTWQa (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 20 Apr 2020 18:16:30 -0400
Received: from mout-p-103.mailbox.org ([80.241.56.161]:34576 "EHLO
        mout-p-103.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbgDTWQa (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 20 Apr 2020 18:16:30 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-103.mailbox.org (Postfix) with ESMTPS id 495gyj4THdzKmZB;
        Tue, 21 Apr 2020 00:16:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter03.heinlein-hosting.de (spamfilter03.heinlein-hosting.de [80.241.56.117]) (amavisd-new, port 10030)
        with ESMTP id gPcMdLBCTzKt; Tue, 21 Apr 2020 00:16:26 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes@sipsolutions.net, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 3/9] backports: genetlink: Add genlmsg_parse()
Date:   Tue, 21 Apr 2020 00:16:09 +0200
Message-Id: <20200420221615.14734-4-hauke@hauke-m.de>
In-Reply-To: <20200420221615.14734-1-hauke@hauke-m.de>
References: <20200420221615.14734-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D89EE174A
X-Rspamd-Score: -5.67 / 15.00 / 15.00
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

This adds the genlmsg_parse() function to the netlink backport. This was
added in upstream commit 8cb081746c03 ("netlink: make validation more
configurable for future strictness").

This function is used by the mac80211_hwsim driver.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/net/genetlink.h | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/backport/backport-include/net/genetlink.h b/backport/backport-include/net/genetlink.h
index 747b6dac..326b9992 100644
--- a/backport/backport-include/net/genetlink.h
+++ b/backport/backport-include/net/genetlink.h
@@ -249,6 +249,17 @@ static inline struct nlattr **genl_family_attrbuf(struct genl_family *family)
 
 	return family->attrbuf;
 }
-#endif /* LINUX_VERSION_IS_LESS(4,20,0) */
+
+#define genlmsg_parse LINUX_BACKPORT(genlmsg_parse)
+static inline int genlmsg_parse(const struct nlmsghdr *nlh,
+				const struct genl_family *family,
+				struct nlattr *tb[], int maxtype,
+				const struct nla_policy *policy,
+				struct netlink_ext_ack *extack)
+{
+	return __nlmsg_parse(nlh, family->hdrsize + GENL_HDRLEN, tb, maxtype,
+			     policy, NL_VALIDATE_STRICT, extack);
+}
+#endif /* LINUX_VERSION_IS_LESS(5,2,0) */
 
 #endif /* __BACKPORT_NET_GENETLINK_H */
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
