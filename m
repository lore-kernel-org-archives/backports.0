Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:63827 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932318AbaEPLWc (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 16 May 2014 07:22:32 -0400
From: Stefan Assmann <sassmann@kpanic.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, sassmann@kpanic.de
Subject: [PATCH 06/13] backports: handle new get_eee and set_eee pointers in struct ethtool_ops
Date: Fri, 16 May 2014 13:21:17 +0200
Message-Id: <1400239284-2916-7-git-send-email-sassmann@kpanic.de> (sfid-20140516_132234_957798_9888348E)
In-Reply-To: <1400239284-2916-1-git-send-email-sassmann@kpanic.de>
References: <1400239284-2916-1-git-send-email-sassmann@kpanic.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

In kernel 3.6 struct ethtool_ops received 2 new function pointers get_eee
and set_eee. Address this by putting ifdef around the code.

commit 80f12eccce775dc6bb93dba9b52529740f929237
Author: Yuval Mintz <yuvalmin@broadcom.com>
Date:   Wed Jun 6 17:13:06 2012 +0000

    Added kernel support in EEE Ethtool commands

git describe --contains 80f12eccce775dc6bb93dba9b52529740f929237
v3.6-rc1~125^2~587

Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
---
 .../network/0036-ethtool_eee/INFO                  | 12 +++++++++
 .../network/0036-ethtool_eee/igb_ethtool_eee.patch | 31 ++++++++++++++++++++++
 2 files changed, 43 insertions(+)
 create mode 100644 patches/collateral-evolutions/network/0036-ethtool_eee/INFO
 create mode 100644 patches/collateral-evolutions/network/0036-ethtool_eee/igb_ethtool_eee.patch

diff --git a/patches/collateral-evolutions/network/0036-ethtool_eee/INFO b/patches/collateral-evolutions/network/0036-ethtool_eee/INFO
new file mode 100644
index 0000000..32650f7
--- /dev/null
+++ b/patches/collateral-evolutions/network/0036-ethtool_eee/INFO
@@ -0,0 +1,12 @@
+In kernel 3.6 struct ethtool_ops received 2 new function pointers get_eee
+and set_eee. Address this by putting ifdef around the code.
+
+
+commit 80f12eccce775dc6bb93dba9b52529740f929237
+Author: Yuval Mintz <yuvalmin@broadcom.com>
+Date:   Wed Jun 6 17:13:06 2012 +0000
+
+    Added kernel support in EEE Ethtool commands
+
+git describe --contains 80f12eccce775dc6bb93dba9b52529740f929237
+v3.6-rc1~125^2~587
diff --git a/patches/collateral-evolutions/network/0036-ethtool_eee/igb_ethtool_eee.patch b/patches/collateral-evolutions/network/0036-ethtool_eee/igb_ethtool_eee.patch
new file mode 100644
index 0000000..dcc5b2b
--- /dev/null
+++ b/patches/collateral-evolutions/network/0036-ethtool_eee/igb_ethtool_eee.patch
@@ -0,0 +1,31 @@
+diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
+index 333a2b0..7c8b9bf 100644
+--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
++++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
+@@ -2589,6 +2589,7 @@ static int igb_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd)
+ 	return ret;
+ }
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0)
+ static int igb_get_eee(struct net_device *netdev, struct ethtool_eee *edata)
+ {
+ 	struct igb_adapter *adapter = netdev_priv(netdev);
+@@ -2730,6 +2731,7 @@ static int igb_set_eee(struct net_device *netdev,
+ 
+ 	return 0;
+ }
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0) */
+ 
+ static int igb_get_module_info(struct net_device *netdev,
+ 			       struct ethtool_modinfo *modinfo)
+@@ -3020,8 +3022,10 @@ static const struct ethtool_ops igb_ethtool_ops = {
+ 	.get_ts_info		= igb_get_ts_info,
+ 	.get_rxnfc		= igb_get_rxnfc,
+ 	.set_rxnfc		= igb_set_rxnfc,
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0)
+ 	.get_eee		= igb_get_eee,
+ 	.set_eee		= igb_set_eee,
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0) */
+ 	.get_module_info	= igb_get_module_info,
+ 	.get_module_eeprom	= igb_get_module_eeprom,
+ 	.get_rxfh_indir_size	= igb_get_rxfh_indir_size,
-- 
1.9.0

