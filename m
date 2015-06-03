Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41682 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752558AbbFCL0O (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 3 Jun 2015 07:26:14 -0400
From: Stefan Assmann <sassmann@kpanic.de>
To: backports@vger.kernel.org
Cc: mcgrof@do-not-panic.com, hauke@hauke-m.de, sassmann@kpanic.de
Subject: [PATCH 1/4] backports: replace igb skb->no_fcs patch with semantic patch
Date: Wed,  3 Jun 2015 13:25:53 +0200
Message-Id: <1433330756-22733-2-git-send-email-sassmann@kpanic.de> (sfid-20150603_132617_152833_522C734B)
In-Reply-To: <1433330756-22733-1-git-send-email-sassmann@kpanic.de>
References: <1433330756-22733-1-git-send-email-sassmann@kpanic.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
---
 .../network/0035-skb_no_fcs/igb_skb_no_fcs.patch           | 14 --------------
 .../network/0035-skb_no_fcs/skb_no_fcs.cocci               |  7 +++++++
 2 files changed, 7 insertions(+), 14 deletions(-)
 delete mode 100644 patches/collateral-evolutions/network/0035-skb_no_fcs/igb_skb_no_fcs.patch
 create mode 100644 patches/collateral-evolutions/network/0035-skb_no_fcs/skb_no_fcs.cocci

diff --git a/patches/collateral-evolutions/network/0035-skb_no_fcs/igb_skb_no_fcs.patch b/patches/collateral-evolutions/network/0035-skb_no_fcs/igb_skb_no_fcs.patch
deleted file mode 100644
index f659bfd..0000000
--- a/patches/collateral-evolutions/network/0035-skb_no_fcs/igb_skb_no_fcs.patch
+++ /dev/null
@@ -1,14 +0,0 @@
---- a/drivers/net/ethernet/intel/igb/igb_main.c
-+++ b/drivers/net/ethernet/intel/igb/igb_main.c
-@@ -4782,9 +4782,10 @@ static u32 igb_tx_cmd_type(struct sk_buf
- 	cmd_type |= IGB_SET_FLAG(tx_flags, IGB_TX_FLAGS_TSTAMP,
- 				 (E1000_ADVTXD_MAC_TSTAMP));
- 
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,4,0)
- 	/* insert frame checksum */
- 	cmd_type ^= IGB_SET_FLAG(skb->no_fcs, 1, E1000_ADVTXD_DCMD_IFCS);
--
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,4,0) */
- 	return cmd_type;
- }
- 
diff --git a/patches/collateral-evolutions/network/0035-skb_no_fcs/skb_no_fcs.cocci b/patches/collateral-evolutions/network/0035-skb_no_fcs/skb_no_fcs.cocci
new file mode 100644
index 0000000..703c227
--- /dev/null
+++ b/patches/collateral-evolutions/network/0035-skb_no_fcs/skb_no_fcs.cocci
@@ -0,0 +1,7 @@
+@r1@
+expression E1,E2;
+struct sk_buff *skb;
+@@
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,18,0)
+ E1 ^= E2(..., skb->no_fcs, ...)
++#endif /* if LINUX_VERSION_CODE >= KERNEL_VERSION(3,18,0) */
-- 
2.4.2

