Return-Path: <SRS0=kiHp=QC=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A168C282C8
	for <backports@archiver.kernel.org>; Sat, 26 Jan 2019 22:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 380562184C
	for <backports@archiver.kernel.org>; Sat, 26 Jan 2019 22:00:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbfAZWA6 (ORCPT <rfc822;backports@archiver.kernel.org>);
        Sat, 26 Jan 2019 17:00:58 -0500
Received: from mx2.mailbox.org ([80.241.60.215]:28286 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726392AbfAZWA6 (ORCPT <rfc822;backports@vger.kernel.org>);
        Sat, 26 Jan 2019 17:00:58 -0500
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 67541A12ED;
        Sat, 26 Jan 2019 23:00:57 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter05.heinlein-hosting.de (spamfilter05.heinlein-hosting.de [80.241.56.123]) (amavisd-new, port 10030)
        with ESMTP id JWfOaJc1jp36; Sat, 26 Jan 2019 23:00:56 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 5/7] backports: Add extra parameter to dev_open()
Date:   Sat, 26 Jan 2019 23:00:31 +0100
Message-Id: <20190126220033.27634-6-hauke@hauke-m.de>
In-Reply-To: <20190126220033.27634-1-hauke@hauke-m.de>
References: <20190126220033.27634-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

dev_open() got the extra parameter extack in Linux commit 00f54e68924e
("net: core: dev: Add extack argument to dev_open()"), just ignore it on
older kernel versions. This is used by the hostap driver.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/netdevice.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/backport/backport-include/linux/netdevice.h b/backport/backport-include/linux/netdevice.h
index 44319331..c3e91a0c 100644
--- a/backport/backport-include/linux/netdevice.h
+++ b/backport/backport-include/linux/netdevice.h
@@ -358,4 +358,12 @@ static inline int _bp_netdev_upper_dev_link(struct net_device *dev,
 	macro_dispatcher(netdev_upper_dev_link, __VA_ARGS__)(__VA_ARGS__)
 #endif
 
+#if LINUX_VERSION_IS_LESS(5,0,0)
+static inline int backport_dev_open(struct net_device *dev, struct netlink_ext_ack *extack)
+{
+	return dev_open(dev);
+}
+#define dev_open LINUX_BACKPORT(dev_open)
+#endif
+
 #endif /* __BACKPORT_NETDEVICE_H */
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
