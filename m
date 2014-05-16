Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47300 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932318AbaEPLWa (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 16 May 2014 07:22:30 -0400
From: Stefan Assmann <sassmann@kpanic.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, sassmann@kpanic.de
Subject: [PATCH 10/13] backports: handle argument type change of get_rxnfc in struct ethtool_ops
Date: Fri, 16 May 2014 13:21:21 +0200
Message-Id: <1400239284-2916-11-git-send-email-sassmann@kpanic.de> (sfid-20140516_132234_330887_B4047D82)
In-Reply-To: <1400239284-2916-1-git-send-email-sassmann@kpanic.de>
References: <1400239284-2916-1-git-send-email-sassmann@kpanic.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

In kernel 3.2 an argument type of function pointer get_rxnfc in
struct ethtool_ops changed from void to u32.
Address this by putting ifdef around the code.

commit 815c7db5c809ea3d5735de3131ecdf758b0e14ff
Author: Ben Hutchings <bhutchings@solarflare.com>
Date:   Tue Sep 6 13:49:12 2011 +0000

    ethtool: Clean up definitions of rule location arrays in RX NFC

git describe --contains 815c7db5c809ea3d5735de3131ecdf758b0e14ff
v3.2-rc1~129^2~272

Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
---
 .../network/0039-ethtool_rxnfc/INFO                    | 14 ++++++++++++++
 .../network/0039-ethtool_rxnfc/igb_rxnfc.patch         | 18 ++++++++++++++++++
 2 files changed, 32 insertions(+)
 create mode 100644 patches/collateral-evolutions/network/0039-ethtool_rxnfc/INFO
 create mode 100644 patches/collateral-evolutions/network/0039-ethtool_rxnfc/igb_rxnfc.patch

diff --git a/patches/collateral-evolutions/network/0039-ethtool_rxnfc/INFO b/patches/collateral-evolutions/network/0039-ethtool_rxnfc/INFO
new file mode 100644
index 0000000..55ad380
--- /dev/null
+++ b/patches/collateral-evolutions/network/0039-ethtool_rxnfc/INFO
@@ -0,0 +1,14 @@
+In kernel 3.2 an argument type of function pointer get_rxnfc in
+struct ethtool_ops changed from void to u32.
+Address this by putting ifdef around the code.
+
+
+commit 815c7db5c809ea3d5735de3131ecdf758b0e14ff
+Author: Ben Hutchings <bhutchings@solarflare.com>
+Date:   Tue Sep 6 13:49:12 2011 +0000
+
+    ethtool: Clean up definitions of rule location arrays in RX NFC
+
+git describe --contains 815c7db5c809ea3d5735de3131ecdf758b0e14ff
+v3.2-rc1~129^2~272
+
diff --git a/patches/collateral-evolutions/network/0039-ethtool_rxnfc/igb_rxnfc.patch b/patches/collateral-evolutions/network/0039-ethtool_rxnfc/igb_rxnfc.patch
new file mode 100644
index 0000000..875b97a
--- /dev/null
+++ b/patches/collateral-evolutions/network/0039-ethtool_rxnfc/igb_rxnfc.patch
@@ -0,0 +1,18 @@
+diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
+index 03fe81a..f561b7b 100644
+--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
++++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
+@@ -2450,8 +2450,13 @@ static int igb_get_rss_hash_opts(struct igb_adapter *adapter,
+ 	return 0;
+ }
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0)
+ static int igb_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd,
+ 			 u32 *rule_locs)
++#else
++static int igb_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd,
++			 void *rule_locs)
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0) */
+ {
+ 	struct igb_adapter *adapter = netdev_priv(dev);
+ 	int ret = -EOPNOTSUPP;
-- 
1.9.0

