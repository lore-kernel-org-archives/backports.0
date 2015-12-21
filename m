Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:51831 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751046AbbLUAGK (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 20 Dec 2015 19:06:10 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 4/6] header: add NETIF_F_SCTP_CRC
Date: Mon, 21 Dec 2015 01:05:59 +0100
Message-Id: <1450656361-21259-5-git-send-email-hauke@hauke-m.de> (sfid-20151221_010621_248583_AE278F32)
In-Reply-To: <1450656361-21259-1-git-send-email-hauke@hauke-m.de>
References: <1450656361-21259-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

NETIF_F_SCTP_CSUM was renamed to NETIF_F_SCTP_CRC in commit 53692b1de
"sctp: Rename NETIF_F_SCTP_CSUM to NETIF_F_SCTP_CRC" make new code
still work with old kernel.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/netdev_features.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/backport/backport-include/linux/netdev_features.h b/backport/backport-include/linux/netdev_features.h
index 350283d..3ca13e2 100644
--- a/backport/backport-include/linux/netdev_features.h
+++ b/backport/backport-include/linux/netdev_features.h
@@ -45,4 +45,9 @@ typedef u32 netdev_features_t;
 #define NETIF_F_RXFCS 0
 #endif
 
+/* this was renamed in commit 53692b1de :  sctp: Rename NETIF_F_SCTP_CSUM to NETIF_F_SCTP_CRC */
+#ifndef NETIF_F_SCTP_CRC
+#define NETIF_F_SCTP_CRC __NETIF_F(SCTP_CSUM)
+#endif
+
 #endif /* __BACKPORT_NETDEV_FEATURES_H */
-- 
2.6.4

--
To unsubscribe from this list: send the line "unsubscribe backports" in
