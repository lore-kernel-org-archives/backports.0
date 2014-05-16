Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37365 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932321AbaEPLWc (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 16 May 2014 07:22:32 -0400
From: Stefan Assmann <sassmann@kpanic.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, sassmann@kpanic.de
Subject: [PATCH 08/13] backports: handle new get_module_info and get_module_eeprom pointers in struct ethtool_ops
Date: Fri, 16 May 2014 13:21:19 +0200
Message-Id: <1400239284-2916-9-git-send-email-sassmann@kpanic.de> (sfid-20140516_132236_929011_7A5989C3)
In-Reply-To: <1400239284-2916-1-git-send-email-sassmann@kpanic.de>
References: <1400239284-2916-1-git-send-email-sassmann@kpanic.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

In kernel 3.5 struct ethtool_ops received 2 new function pointers
get_module_info and get_module_eeprom. Address this by putting ifdef around
the code.

commit 41c3cb6d20f0252308e9796fa4f3dacb4960de91
Author: Stuart Hodgson <smhodgson@solarflare.com>
Date:   Thu Apr 19 09:44:42 2012 +0100

    ethtool: Extend the ethtool API to obtain plugin module eeprom data

git describe --contains 41c3cb6d20f0252308e9796fa4f3dacb4960de91
v3.5-rc1~109^2~124^2~2

Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
---
 .../network/0037-ethtool_get_module/INFO           | 14 ++++++++++
 .../0037-ethtool_get_module/igb_get_module.patch   | 31 ++++++++++++++++++++++
 2 files changed, 45 insertions(+)
 create mode 100644 patches/collateral-evolutions/network/0037-ethtool_get_module/INFO
 create mode 100644 patches/collateral-evolutions/network/0037-ethtool_get_module/igb_get_module.patch

diff --git a/patches/collateral-evolutions/network/0037-ethtool_get_module/INFO b/patches/collateral-evolutions/network/0037-ethtool_get_module/INFO
new file mode 100644
index 0000000..d2cc4fe
--- /dev/null
+++ b/patches/collateral-evolutions/network/0037-ethtool_get_module/INFO
@@ -0,0 +1,14 @@
+In kernel 3.5 struct ethtool_ops received 2 new function pointers
+get_module_info and get_module_eeprom. Address this by putting ifdef around
+the code.
+
+
+commit 41c3cb6d20f0252308e9796fa4f3dacb4960de91
+Author: Stuart Hodgson <smhodgson@solarflare.com>
+Date:   Thu Apr 19 09:44:42 2012 +0100
+
+    ethtool: Extend the ethtool API to obtain plugin module eeprom data
+
+git describe --contains 41c3cb6d20f0252308e9796fa4f3dacb4960de91
+v3.5-rc1~109^2~124^2~2
+
diff --git a/patches/collateral-evolutions/network/0037-ethtool_get_module/igb_get_module.patch b/patches/collateral-evolutions/network/0037-ethtool_get_module/igb_get_module.patch
new file mode 100644
index 0000000..851fdc8
--- /dev/null
+++ b/patches/collateral-evolutions/network/0037-ethtool_get_module/igb_get_module.patch
@@ -0,0 +1,31 @@
+diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
+index 75606be..6662b3b 100644
+--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
++++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
+@@ -2735,6 +2735,7 @@ static int igb_set_eee(struct net_device *netdev,
+ }
+ #endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0) */
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
+ static int igb_get_module_info(struct net_device *netdev,
+ 			       struct ethtool_modinfo *modinfo)
+ {
+@@ -2815,6 +2816,7 @@ static int igb_get_module_eeprom(struct net_device *netdev,
+ 
+ 	return 0;
+ }
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0) */
+ 
+ static int igb_ethtool_begin(struct net_device *netdev)
+ {
+@@ -3030,8 +3032,10 @@ static const struct ethtool_ops igb_ethtool_ops = {
+ 	.get_eee		= igb_get_eee,
+ 	.set_eee		= igb_set_eee,
+ #endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0) */
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
+ 	.get_module_info	= igb_get_module_info,
+ 	.get_module_eeprom	= igb_get_module_eeprom,
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0) */
+ 	.get_rxfh_indir_size	= igb_get_rxfh_indir_size,
+ 	.get_rxfh_indir		= igb_get_rxfh_indir,
+ 	.set_rxfh_indir		= igb_set_rxfh_indir,
-- 
1.9.0

