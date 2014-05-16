Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53984 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932075AbaEPLW3 (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 16 May 2014 07:22:29 -0400
From: Stefan Assmann <sassmann@kpanic.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, sassmann@kpanic.de
Subject: [PATCH 09/13] backports: handle new rxfh_ndir pointers in struct ethtool_ops
Date: Fri, 16 May 2014 13:21:20 +0200
Message-Id: <1400239284-2916-10-git-send-email-sassmann@kpanic.de> (sfid-20140516_132231_319827_20631F89)
In-Reply-To: <1400239284-2916-1-git-send-email-sassmann@kpanic.de>
References: <1400239284-2916-1-git-send-email-sassmann@kpanic.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

In kernel 3.3 struct ethtool_ops received 3 new function pointers
get_rxfh_indir_size, get_rxfh_indir, set_rxfh_indir.
Address this by putting ifdef around the code.

commit 7850f63f1620512631445b901ae11cd149e7375c
Author: Ben Hutchings <bhutchings@solarflare.com>
Date:   Thu Dec 15 13:55:01 2011 +0000

    ethtool: Centralise validation of ETHTOOL_{G, S}RXFHINDIR parameters

git describe --contains 7850f63f1620512631445b901ae11cd149e7375c
v3.3-rc1~182^2~192

Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
---
 .../network/0038-ethtool_rxfh_indir/INFO           | 13 ++++++
 .../0038-ethtool_rxfh_indir/igb_rxfh_indir.patch   | 48 ++++++++++++++++++++++
 2 files changed, 61 insertions(+)
 create mode 100644 patches/collateral-evolutions/network/0038-ethtool_rxfh_indir/INFO
 create mode 100644 patches/collateral-evolutions/network/0038-ethtool_rxfh_indir/igb_rxfh_indir.patch

diff --git a/patches/collateral-evolutions/network/0038-ethtool_rxfh_indir/INFO b/patches/collateral-evolutions/network/0038-ethtool_rxfh_indir/INFO
new file mode 100644
index 0000000..0e050aa
--- /dev/null
+++ b/patches/collateral-evolutions/network/0038-ethtool_rxfh_indir/INFO
@@ -0,0 +1,13 @@
+In kernel 3.3 struct ethtool_ops received 3 new function pointers
+get_rxfh_indir_size, get_rxfh_indir, set_rxfh_indir.
+Address this by putting ifdef around the code.
+
+
+commit 7850f63f1620512631445b901ae11cd149e7375c
+Author: Ben Hutchings <bhutchings@solarflare.com>
+Date:   Thu Dec 15 13:55:01 2011 +0000
+
+    ethtool: Centralise validation of ETHTOOL_{G, S}RXFHINDIR parameters
+
+git describe --contains 7850f63f1620512631445b901ae11cd149e7375c
+v3.3-rc1~182^2~192
diff --git a/patches/collateral-evolutions/network/0038-ethtool_rxfh_indir/igb_rxfh_indir.patch b/patches/collateral-evolutions/network/0038-ethtool_rxfh_indir/igb_rxfh_indir.patch
new file mode 100644
index 0000000..93a0396
--- /dev/null
+++ b/patches/collateral-evolutions/network/0038-ethtool_rxfh_indir/igb_rxfh_indir.patch
@@ -0,0 +1,48 @@
+diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
+index 6662b3b..03fe81a 100644
+--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
++++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
+@@ -2831,6 +2831,7 @@ static void igb_ethtool_complete(struct net_device *netdev)
+ 	pm_runtime_put(&adapter->pdev->dev);
+ }
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0)
+ static u32 igb_get_rxfh_indir_size(struct net_device *netdev)
+ {
+ 	return IGB_RETA_SIZE;
+@@ -2846,6 +2847,7 @@ static int igb_get_rxfh_indir(struct net_device *netdev, u32 *indir)
+ 
+ 	return 0;
+ }
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0) */
+ 
+ void igb_write_rss_indir_tbl(struct igb_adapter *adapter)
+ {
+@@ -2882,6 +2884,7 @@ void igb_write_rss_indir_tbl(struct igb_adapter *adapter)
+ 	}
+ }
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0)
+ static int igb_set_rxfh_indir(struct net_device *netdev, const u32 *indir)
+ {
+ 	struct igb_adapter *adapter = netdev_priv(netdev);
+@@ -2914,6 +2917,7 @@ static int igb_set_rxfh_indir(struct net_device *netdev, const u32 *indir)
+ 
+ 	return 0;
+ }
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0) */
+ 
+ static unsigned int igb_max_channels(struct igb_adapter *adapter)
+ {
+@@ -3036,9 +3040,11 @@ static const struct ethtool_ops igb_ethtool_ops = {
+ 	.get_module_info	= igb_get_module_info,
+ 	.get_module_eeprom	= igb_get_module_eeprom,
+ #endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0) */
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0)
+ 	.get_rxfh_indir_size	= igb_get_rxfh_indir_size,
+ 	.get_rxfh_indir		= igb_get_rxfh_indir,
+ 	.set_rxfh_indir		= igb_set_rxfh_indir,
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0) */
+ 	.get_channels		= igb_get_channels,
+ 	.set_channels		= igb_set_channels,
+ 	.begin			= igb_ethtool_begin,
-- 
1.9.0

