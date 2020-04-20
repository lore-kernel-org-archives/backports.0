Return-Path: <SRS0=+jjK=6E=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B86F9C55186
	for <backports@archiver.kernel.org>; Mon, 20 Apr 2020 22:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94E3620722
	for <backports@archiver.kernel.org>; Mon, 20 Apr 2020 22:16:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbgDTWQe (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 20 Apr 2020 18:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727873AbgDTWQe (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 20 Apr 2020 18:16:34 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050::465:101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D392EC061A0C
        for <backports@vger.kernel.org>; Mon, 20 Apr 2020 15:16:33 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 495gym2c6GzKmhy;
        Tue, 21 Apr 2020 00:16:32 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter03.heinlein-hosting.de (spamfilter03.heinlein-hosting.de [80.241.56.117]) (amavisd-new, port 10030)
        with ESMTP id yRXg_7sCBBL8; Tue, 21 Apr 2020 00:16:29 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes@sipsolutions.net, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 9/9] backports: netdevice: Add netif_is_bridge_port()
Date:   Tue, 21 Apr 2020 00:16:15 +0200
Message-Id: <20200420221615.14734-10-hauke@hauke-m.de>
In-Reply-To: <20200420221615.14734-1-hauke@hauke-m.de>
References: <20200420221615.14734-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9C4821750
X-Rspamd-Score: -5.43 / 15.00 / 15.00
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

netif_is_bridge_port() was added in upstream Linux commit 28f9ee22bcdd
("vlan: Do not put vlan headers back on bridge and macvlan ports").

It is now used by the wireless subsystem.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/netdevice.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/backport/backport-include/linux/netdevice.h b/backport/backport-include/linux/netdevice.h
index a71ed590..edb0aaf3 100644
--- a/backport/backport-include/linux/netdevice.h
+++ b/backport/backport-include/linux/netdevice.h
@@ -380,4 +380,12 @@ static inline int backport_dev_open(struct net_device *dev, struct netlink_ext_a
 #define dev_open LINUX_BACKPORT(dev_open)
 #endif
 
+#if LINUX_VERSION_IS_LESS(4,4,0)
+#define netif_is_bridge_port LINUX_BACKPORT(netif_is_bridge_port)
+static inline bool netif_is_bridge_port(const struct net_device *dev)
+{
+	return dev->priv_flags & IFF_BRIDGE_PORT;
+}
+#endif
+
 #endif /* __BACKPORT_NETDEVICE_H */
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
