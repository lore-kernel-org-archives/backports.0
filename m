Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:48147 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751930AbaIFXX6 (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 6 Sep 2014 19:23:58 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 3/4] backports: remove usage of skbuff->xmit_more
Date: Sun,  7 Sep 2014 01:23:36 +0200
Message-Id: <1410045817-4112-4-git-send-email-hauke@hauke-m.de> (sfid-20140907_012403_592266_E9E87452)
In-Reply-To: <1410045817-4112-1-git-send-email-hauke@hauke-m.de>
References: <1410045817-4112-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This is a revet of these two upstream commits:
commit c1ebf46c1f72fe542853fc00f059a7d15259379d
Author: David S. Miller <davem@davemloft.net>
Date:   Fri Aug 22 17:24:49 2014 -0700

    igb: Support netdev_ops->ndo_xmit_flush()

commit 0b725a2ca61bedc33a2a63d0451d528b268cf975
Author: David S. Miller <davem@davemloft.net>
Date:   Mon Aug 25 15:51:53 2014 -0700

    net: Remove ndo_xmit_flush netdev operation, use signalling instead.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../network/0048-no_ndo_xmit_flush/igb.patch               | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 patches/collateral-evolutions/network/0048-no_ndo_xmit_flush/igb.patch

diff --git a/patches/collateral-evolutions/network/0048-no_ndo_xmit_flush/igb.patch b/patches/collateral-evolutions/network/0048-no_ndo_xmit_flush/igb.patch
new file mode 100644
index 0000000..f3ed217
--- /dev/null
+++ b/patches/collateral-evolutions/network/0048-no_ndo_xmit_flush/igb.patch
@@ -0,0 +1,14 @@
+--- a/drivers/net/ethernet/intel/igb/igb_main.c
++++ b/drivers/net/ethernet/intel/igb/igb_main.c
+@@ -4982,7 +4982,10 @@ static void igb_tx_map(struct igb_ring *
+ 	/* Make sure there is space in the ring for the next send. */
+ 	igb_maybe_stop_tx(tx_ring, DESC_NEEDED);
+ 
+-	if (netif_xmit_stopped(txring_txq(tx_ring)) || !skb->xmit_more) {
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,18,0)
++	if (netif_xmit_stopped(txring_txq(tx_ring)) || !skb->xmit_more)
++#endif
++	{
+ 		writel(i, tx_ring->tail);
+ 
+ 		/* we need this if more than one processor can write to our tail
-- 
1.9.1

