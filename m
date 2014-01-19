Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:58350 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752382AbaASQsT (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 19 Jan 2014 11:48:19 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 08/16] backports: backport get_stats in alx driver
Date: Sun, 19 Jan 2014 17:47:29 +0100
Message-Id: <1390150057-11652-9-git-send-email-hauke@hauke-m.de> (sfid-20140119_174821_252537_FA89F596)
In-Reply-To: <1390150057-11652-1-git-send-email-hauke@hauke-m.de>
References: <1390150057-11652-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

alx_get_stats64() was added recently to alx driver, but on kernel <
2.6.30 only get_stats is available, convert the function on such
kernels to use the old api.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../network/64-b44-32bit-stats/alx.patch           |   36 ++++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 patches/collateral-evolutions/network/64-b44-32bit-stats/alx.patch

diff --git a/patches/collateral-evolutions/network/64-b44-32bit-stats/alx.patch b/patches/collateral-evolutions/network/64-b44-32bit-stats/alx.patch
new file mode 100644
index 0000000..9e4e6d9
--- /dev/null
+++ b/patches/collateral-evolutions/network/64-b44-32bit-stats/alx.patch
@@ -0,0 +1,36 @@
+diff --git a/drivers/net/ethernet/atheros/alx/main.c b/drivers/net/ethernet/atheros/alx/main.c
+index e92ffd6..78bf4f4 100644
+--- a/drivers/net/ethernet/atheros/alx/main.c
++++ b/drivers/net/ethernet/atheros/alx/main.c
+@@ -1180,11 +1180,19 @@ static void alx_poll_controller(struct n
+ }
+ #endif
+ 
++
++#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36))
+ static struct rtnl_link_stats64 *alx_get_stats64(struct net_device *dev,
+ 					struct rtnl_link_stats64 *net_stats)
++#else
++static struct net_device_stats *alx_get_stats(struct net_device *dev)
++#endif
+ {
+ 	struct alx_priv *alx = netdev_priv(dev);
+ 	struct alx_hw_stats *hw_stats = &alx->hw.stats;
++#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,36))
++	struct net_device_stats *net_stats = &dev->stats;
++#endif
+ 
+ 	spin_lock(&alx->stats_lock);
+ 
+@@ -1233,7 +1241,11 @@ static const struct net_device_ops alx_n
+ 	.ndo_open               = alx_open,
+ 	.ndo_stop               = alx_stop,
+ 	.ndo_start_xmit         = alx_start_xmit,
++#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36))
+ 	.ndo_get_stats64        = alx_get_stats64,
++#else
++	.ndo_get_stats		= alx_get_stats,
++#endif
+ 	.ndo_set_rx_mode        = alx_set_rx_mode,
+ 	.ndo_validate_addr      = eth_validate_addr,
+ 	.ndo_set_mac_address    = alx_set_mac_address,
-- 
1.7.10.4

