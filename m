Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38740 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753259AbbBYOWD (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 25 Feb 2015 09:22:03 -0500
From: Stefan Assmann <sassmann@kpanic.de>
To: backports@vger.kernel.org
Cc: mcgrof@do-not-panic.com, hauke@hauke-m.de, sassmann@kpanic.de
Subject: [PATCH 06/10] backports: replace struct ethtool_ops get_rxnfc changes with smpl patch
Date: Wed, 25 Feb 2015 15:20:50 +0100
Message-Id: <1424874054-22956-7-git-send-email-sassmann@kpanic.de> (sfid-20150225_152216_092477_0B46EC3A)
In-Reply-To: <1424874054-22956-1-git-send-email-sassmann@kpanic.de>
References: <1424874054-22956-1-git-send-email-sassmann@kpanic.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
---
 .../network/0039-ethtool_rxnfc/igb_rxnfc.patch     | 16 ----------------
 .../network/0039-ethtool_rxnfc/rxnfc.cocci         | 22 ++++++++++++++++++++++
 2 files changed, 22 insertions(+), 16 deletions(-)
 delete mode 100644 patches/collateral-evolutions/network/0039-ethtool_rxnfc/igb_rxnfc.patch
 create mode 100644 patches/collateral-evolutions/network/0039-ethtool_rxnfc/rxnfc.cocci

diff --git a/patches/collateral-evolutions/network/0039-ethtool_rxnfc/igb_rxnfc.patch b/patches/collateral-evolutions/network/0039-ethtool_rxnfc/igb_rxnfc.patch
deleted file mode 100644
index 86425c6..0000000
--- a/patches/collateral-evolutions/network/0039-ethtool_rxnfc/igb_rxnfc.patch
+++ /dev/null
@@ -1,16 +0,0 @@
---- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
-+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
-@@ -2452,8 +2452,13 @@ static int igb_get_rss_hash_opts(struct
- 	return 0;
- }
- 
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0)
- static int igb_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd,
- 			 u32 *rule_locs)
-+#else
-+static int igb_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd,
-+			 void *rule_locs)
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0) */
- {
- 	struct igb_adapter *adapter = netdev_priv(dev);
- 	int ret = -EOPNOTSUPP;
diff --git a/patches/collateral-evolutions/network/0039-ethtool_rxnfc/rxnfc.cocci b/patches/collateral-evolutions/network/0039-ethtool_rxnfc/rxnfc.cocci
new file mode 100644
index 0000000..e546f4d
--- /dev/null
+++ b/patches/collateral-evolutions/network/0039-ethtool_rxnfc/rxnfc.cocci
@@ -0,0 +1,22 @@
+@r@
+identifier s,func;
+@@
+
+struct ethtool_ops s = {
+.get_rxnfc = func,
+};
+
+@@
+identifier r.func,rule_locs;
+typedef u32;
+@@
+
+// ----------------------------------------------------------------------
+
+func(...
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0)
+,u32 *rule_locs
++#else
++,void *rule_locs
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0) */
+ ) { ... }
-- 
2.1.0

