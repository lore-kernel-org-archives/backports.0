Return-path: <backports-owner@vger.kernel.org>
Received: from mx2.mailbox.org ([80.241.60.215]:42917 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753869AbdHUW2l (ORCPT <rfc822;backports@vger.kernel.org>);
        Mon, 21 Aug 2017 18:28:41 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 01/21] copy: do not copy files removed in kernel 4.13
Date: Tue, 22 Aug 2017 00:27:57 +0200
Message-Id: <20170821222817.17376-2-hauke@hauke-m.de> (sfid-20170822_002844_703571_4D92CE1B)
In-Reply-To: <20170821222817.17376-1-hauke@hauke-m.de>
References: <20170821222817.17376-1-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

These files were removed in kernel 4.13 and should not be copied any
more.

The wil6210_uapi.h file was removed in a520b49ec155767 ("wil6210: remove
ioctl interface") and the st-nci.h file in commit 61a04101c8a486d ("NFC:
st-nci: Get rid of platform data")

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 copy-list | 2 --
 1 file changed, 2 deletions(-)

diff --git a/copy-list b/copy-list
index 3b1fa2ac..17afcb4c 100644
--- a/copy-list
+++ b/copy-list
@@ -31,7 +31,6 @@ include/linux/pci_ids.h
 include/uapi/linux/pci_regs.h
 include/linux/mmc/sdio_ids.h
 include/linux/ath9k_platform.h
-include/uapi/linux/wil6210_uapi.h
 include/linux/wl12xx.h
 include/linux/rndis.h
 include/linux/bcm47xx_wdt.h
@@ -113,7 +112,6 @@ include/uapi/linux/nfc.h
 drivers/nfc/
 include/linux/platform_data/nfcmrvl.h
 include/linux/platform_data/nxp-nci.h
-include/linux/platform_data/st-nci.h
 
 # MPLS labels, checked on skb->protocol on the
 # respective 802 family, only ethernet seems to use
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
