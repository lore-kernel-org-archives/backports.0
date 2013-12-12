Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:23592 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751450Ab3LLJ3e (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 12 Dec 2013 04:29:34 -0500
From: Stefan Assmann <sassmann@kpanic.de>
To: mcgrof@kernel.org
Cc: backports@vger.kernel.org, hauke@hauke-m.de, sassmann@kpanic.de
Subject: [PATCH RFC 08/10] backports: igb fixes for linux-3.3
Date: Thu, 12 Dec 2013 10:28:00 +0100
Message-Id: <1386840482-585-9-git-send-email-sassmann@kpanic.de> (sfid-20131212_102937_050445_34AF39E9)
In-Reply-To: <1386840482-585-1-git-send-email-sassmann@kpanic.de>
References: <1386840482-585-1-git-send-email-sassmann@kpanic.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

- patches/collateral-evolutions/network/82-ethernet/igb_no_fcs.patch

How to handle changes in struct sk_buff? Changes just commented out
for now.

Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
---
 backport/backport-include/linux/if.h                     |  4 ++++
 .../network/82-ethernet/igb_no_fcs.patch                 | 16 ++++++++++++++++
 2 files changed, 20 insertions(+)
 create mode 100644 patches/collateral-evolutions/network/82-ethernet/igb_no_fcs.patch

diff --git a/backport/backport-include/linux/if.h b/backport/backport-include/linux/if.h
index 8f85b83..f23d2b8 100644
--- a/backport/backport-include/linux/if.h
+++ b/backport/backport-include/linux/if.h
@@ -33,4 +33,8 @@
 #define IFF_LIVE_ADDR_CHANGE 0x100000
 #endif
 
+#ifndef IFF_SUPP_NOFCS
+#define IFF_SUPP_NOFCS	0x80000		/* device supports sending custom FCS */
+#endif
+
 #endif	/* _BACKPORT_LINUX_IF_H */
diff --git a/patches/collateral-evolutions/network/82-ethernet/igb_no_fcs.patch b/patches/collateral-evolutions/network/82-ethernet/igb_no_fcs.patch
new file mode 100644
index 0000000..f196f2d
--- /dev/null
+++ b/patches/collateral-evolutions/network/82-ethernet/igb_no_fcs.patch
@@ -0,0 +1,16 @@
+diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
+index fd6a103..a919cfa 100644
+--- a/drivers/net/ethernet/intel/igb/igb_main.c
++++ b/drivers/net/ethernet/intel/igb/igb_main.c
+@@ -4480,9 +4480,10 @@ static u32 igb_tx_cmd_type(struct sk_buff *skb, u32 tx_flags)
+ 	cmd_type |= IGB_SET_FLAG(tx_flags, IGB_TX_FLAGS_TSTAMP,
+ 				 (E1000_ADVTXD_MAC_TSTAMP));
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,4,0)
+ 	/* insert frame checksum */
+ 	cmd_type ^= IGB_SET_FLAG(skb->no_fcs, 1, E1000_ADVTXD_DCMD_IFCS);
+-
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,4,0) */
+ 	return cmd_type;
+ }
+ 
-- 
1.8.3.1

