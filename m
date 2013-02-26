Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH for 3.8 2/8] compat-drivers: deactivate loopback testing for older kernels
Date: Tue, 26 Feb 2013 21:42:29 +0100
Message-Id: <1361911355-29256-3-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1361911355-29256-1-git-send-email-hauke@hauke-m.de>
References: <1361911355-29256-1-git-send-email-hauke@hauke-m.de>
List-ID: <backports@vger.kernel.org>

Upstream commit 2e05b625a813f79ff4a255d120883ea8aa539972

ETH_TEST_FL_EXTERNAL_LB and ETH_TEST_FL_EXTERNAL_LB_DONE are not
available in kernel version < 3.1.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../0004-alx-deactivate-loopback-test.patch        |   25 ++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 patches/unified-drivers/network/0004-alx-deactivate-loopback-test.patch

diff --git a/patches/unified-drivers/network/0004-alx-deactivate-loopback-test.patch b/patches/unified-drivers/network/0004-alx-deactivate-loopback-test.patch
new file mode 100644
index 0000000..3ed96a4
--- /dev/null
+++ b/patches/unified-drivers/network/0004-alx-deactivate-loopback-test.patch
@@ -0,0 +1,25 @@
+--- a/drivers/net/ethernet/atheros/alx/alx_ethtool.c
++++ b/drivers/net/ethernet/atheros/alx/alx_ethtool.c
+@@ -1687,7 +1687,9 @@ static void alx_self_test(struct net_dev
+ {
+ 	struct alx_adapter *adpt = netdev_priv(netdev);
+ 	bool if_running = netif_running(netdev);
++#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,1,0))
+ 	bool phy_lpback = etest->flags & ETH_TEST_FL_EXTERNAL_LB;
++#endif
+ 
+ 	ALX_FLAG_SET(adpt, TESTING);
+ 	memset(data, 0, sizeof(u64) * ALX_TEST_LEN);
+@@ -1707,10 +1709,12 @@ static void alx_self_test(struct net_dev
+ 		if (alx_diag_interrupt(adpt, &data[2]))
+ 			etest->flags |= ETH_TEST_FL_FAILED;
+ 
++#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,1,0))
+ 		if (phy_lpback)
+ 			etest->flags |= ETH_TEST_FL_EXTERNAL_LB_DONE;
+ 		if (alx_diag_loopback(adpt, &data[3], phy_lpback))
+ 			etest->flags |= ETH_TEST_FL_FAILED;
++#endif
+ 
+ 	} else {
+ 		netif_info(adpt, hw, adpt->netdev,  "online test start...\n");
-- 
1.7.10.4
