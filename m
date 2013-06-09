Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:51289 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753897Ab3FINYS (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 9 Jun 2013 09:24:18 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 3/5] backports: alx driver now uses NETIF_F_HW_VLAN_CTAG_*
Date: Sun,  9 Jun 2013 15:23:51 +0200
Message-Id: <1370784233-18228-3-git-send-email-hauke@hauke-m.de> (sfid-20130609_152420_046687_5C3F1620)
In-Reply-To: <1370784233-18228-1-git-send-email-hauke@hauke-m.de>
References: <1370784233-18228-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This was/will be renamed in the alx driver, this patch makes backports
work with alx again.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 patches/unified-drivers/network/0001-backport-alx/alx.patch |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/patches/unified-drivers/network/0001-backport-alx/alx.patch b/patches/unified-drivers/network/0001-backport-alx/alx.patch
index e550439..a0a9c1f 100644
--- a/patches/unified-drivers/network/0001-backport-alx/alx.patch
+++ b/patches/unified-drivers/network/0001-backport-alx/alx.patch
@@ -84,17 +84,17 @@
 +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,39))
  	netdev->hw_features = NETIF_F_SG	 |
  			      NETIF_F_HW_CSUM	 |
- 			      NETIF_F_HW_VLAN_RX |
+ 			      NETIF_F_HW_VLAN_CTAG_RX |
  			      NETIF_F_TSO        |
  			      NETIF_F_TSO6;
- 	netdev->features = netdev->hw_features | NETIF_F_HW_VLAN_TX;
+ 	netdev->features = netdev->hw_features | NETIF_F_HW_VLAN_CTAG_TX;
 +#else
 +	netdev->features = NETIF_F_SG            |
 +			   NETIF_F_HW_CSUM       |
-+			   NETIF_F_HW_VLAN_RX    |
++			   NETIF_F_HW_VLAN_CTAG_RX    |
 +			   NETIF_F_TSO           |
 +			   NETIF_F_TSO6          |
-+			   NETIF_F_HW_VLAN_TX;
++			   NETIF_F_HW_VLAN_CTAG_TX;
 +#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,39)) */
  
  	/* read permanent mac addr from register or eFuse */
@@ -120,4 +120,4 @@
 +#endif
  };
  
- 
+ module_pci_driver(alx_driver);
-- 
1.7.10.4

