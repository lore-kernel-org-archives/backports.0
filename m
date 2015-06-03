Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48298 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752558AbbFCL0R (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 3 Jun 2015 07:26:17 -0400
From: Stefan Assmann <sassmann@kpanic.de>
To: backports@vger.kernel.org
Cc: mcgrof@do-not-panic.com, hauke@hauke-m.de, sassmann@kpanic.de
Subject: [PATCH 3/4] backports: replace igb xmit_more patch with semantic patch
Date: Wed,  3 Jun 2015 13:25:55 +0200
Message-Id: <1433330756-22733-4-git-send-email-sassmann@kpanic.de> (sfid-20150603_132618_340372_70BC11C2)
In-Reply-To: <1433330756-22733-1-git-send-email-sassmann@kpanic.de>
References: <1433330756-22733-1-git-send-email-sassmann@kpanic.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
---
 .../network/0048-no_ndo_xmit_flush/igb.patch               | 14 --------------
 .../collateral-evolutions/network/0059-skb_xmit_more/INFO  | 10 ++++++++++
 .../network/0059-skb_xmit_more/skb_no_xmit_more.cocci      |  9 +++++++++
 3 files changed, 19 insertions(+), 14 deletions(-)
 delete mode 100644 patches/collateral-evolutions/network/0048-no_ndo_xmit_flush/igb.patch
 create mode 100644 patches/collateral-evolutions/network/0059-skb_xmit_more/INFO
 create mode 100644 patches/collateral-evolutions/network/0059-skb_xmit_more/skb_no_xmit_more.cocci

diff --git a/patches/collateral-evolutions/network/0048-no_ndo_xmit_flush/igb.patch b/patches/collateral-evolutions/network/0048-no_ndo_xmit_flush/igb.patch
deleted file mode 100644
index 54d52a5..0000000
--- a/patches/collateral-evolutions/network/0048-no_ndo_xmit_flush/igb.patch
+++ /dev/null
@@ -1,14 +0,0 @@
---- a/drivers/net/ethernet/intel/igb/igb_main.c
-+++ b/drivers/net/ethernet/intel/igb/igb_main.c
-@@ -4952,7 +4952,10 @@ static void igb_tx_map(struct igb_ring *
- 	/* Make sure there is space in the ring for the next send. */
- 	igb_maybe_stop_tx(tx_ring, DESC_NEEDED);
- 
--	if (netif_xmit_stopped(txring_txq(tx_ring)) || !skb->xmit_more) {
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,18,0)
-+	if (netif_xmit_stopped(txring_txq(tx_ring)) || !skb->xmit_more)
-+#endif
-+	{
- 		writel(i, tx_ring->tail);
- 
- 		/* we need this if more than one processor can write to our tail
diff --git a/patches/collateral-evolutions/network/0059-skb_xmit_more/INFO b/patches/collateral-evolutions/network/0059-skb_xmit_more/INFO
new file mode 100644
index 0000000..b429637
--- /dev/null
+++ b/patches/collateral-evolutions/network/0059-skb_xmit_more/INFO
@@ -0,0 +1,10 @@
+In kernel 3.18 __u8 xmit_more is added to struct sk_buff.
+
+commit 0b725a2ca61bedc33a2a63d0451d528b268cf975
+Author: David S. Miller <davem@davemloft.net>
+Date:   Mon Aug 25 15:51:53 2014 -0700
+
+    net: Remove ndo_xmit_flush netdev operation, use signalling instead.
+
+git describe --contains 0b725a2ca61bedc33a2a63d0451d528b268cf975
+v3.18-rc1~52^2~228
diff --git a/patches/collateral-evolutions/network/0059-skb_xmit_more/skb_no_xmit_more.cocci b/patches/collateral-evolutions/network/0059-skb_xmit_more/skb_no_xmit_more.cocci
new file mode 100644
index 0000000..ab207bd
--- /dev/null
+++ b/patches/collateral-evolutions/network/0059-skb_xmit_more/skb_no_xmit_more.cocci
@@ -0,0 +1,9 @@
+@r1@
+struct sk_buff *skb;
+expression E1;
+@@
+ if (E1
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,18,0)
+ || !skb->xmit_more
++#endif /* if LINUX_VERSION_CODE >= KERNEL_VERSION(3,18,0) */
+ ) {...}
-- 
2.4.2

