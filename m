Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:60858 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755803Ab3HRXif (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 18 Aug 2013 19:38:35 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH v2 09/19] backports: do not access hw_features in wil6210
Date: Mon, 19 Aug 2013 01:37:54 +0200
Message-Id: <1376869084-16513-10-git-send-email-hauke@hauke-m.de> (sfid-20130819_013836_125392_016B2F2B)
In-Reply-To: <1376869084-16513-1-git-send-email-hauke@hauke-m.de>
References: <1376869084-16513-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

wil6210 now uses netdev->hw_features which is not available in all
kernel versions, do not set it then.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../drivers_net_wireless_ath_wil6210_netdev.patch          |   12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_wireless_ath_wil6210_netdev.patch

diff --git a/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_wireless_ath_wil6210_netdev.patch b/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_wireless_ath_wil6210_netdev.patch
new file mode 100644
index 0000000..5f3e636
--- /dev/null
+++ b/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_wireless_ath_wil6210_netdev.patch
@@ -0,0 +1,12 @@
+--- a/drivers/net/wireless/ath/wil6210/netdev.c
++++ b/drivers/net/wireless/ath/wil6210/netdev.c
+@@ -127,7 +127,9 @@ void *wil_if_alloc(struct device *dev, v
+ 
+ 	netdev_attach_ops(ndev, &wil_netdev_ops);
+ 	ndev->ieee80211_ptr = wdev;
++#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,39))
+ 	ndev->hw_features = NETIF_F_HW_CSUM | NETIF_F_RXCSUM;
++#endif
+ 	ndev->features |= NETIF_F_HW_CSUM | NETIF_F_RXCSUM;
+ 	SET_NETDEV_DEV(ndev, wiphy_dev(wdev->wiphy));
+ 	wdev->netdev = ndev;
-- 
1.7.10.4

