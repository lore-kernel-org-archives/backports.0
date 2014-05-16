Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33932 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932321AbaEPLWe (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 16 May 2014 07:22:34 -0400
From: Stefan Assmann <sassmann@kpanic.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, sassmann@kpanic.de
Subject: [PATCH 07/13] backports: handle new get_ts_info pointer in struct ethtool_ops
Date: Fri, 16 May 2014 13:21:18 +0200
Message-Id: <1400239284-2916-8-git-send-email-sassmann@kpanic.de> (sfid-20140516_132237_571671_2AEB89D8)
In-Reply-To: <1400239284-2916-1-git-send-email-sassmann@kpanic.de>
References: <1400239284-2916-1-git-send-email-sassmann@kpanic.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

In kernel 3.5 struct ethtool_ops received a new function pointer
get_ts_info. Address this by putting ifdef around the code.

commit c8f3a8c31069137fe0100e6920558f1a7487ef3c
Author: Richard Cochran <richardcochran@gmail.com>
Date:   Tue Apr 3 22:59:17 2012 +0000

    ethtool: Introduce a method for getting time stamping capabilities.

git describe --contains c8f3a8c31069137fe0100e6920558f1a7487ef3c
v3.5-rc1~109^2~632

Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
---
 .../network/0017-get_ts_info/igb_get_ts_info.patch | 30 ++++++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 patches/collateral-evolutions/network/0017-get_ts_info/igb_get_ts_info.patch

diff --git a/patches/collateral-evolutions/network/0017-get_ts_info/igb_get_ts_info.patch b/patches/collateral-evolutions/network/0017-get_ts_info/igb_get_ts_info.patch
new file mode 100644
index 0000000..1409834
--- /dev/null
+++ b/patches/collateral-evolutions/network/0017-get_ts_info/igb_get_ts_info.patch
@@ -0,0 +1,30 @@
+diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
+index 7c8b9bf..75606be 100644
+--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
++++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
+@@ -2350,6 +2350,7 @@ static void igb_get_strings(struct net_device *netdev, u32 stringset, u8 *data)
+ 	}
+ }
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
+ static int igb_get_ts_info(struct net_device *dev,
+ 			   struct ethtool_ts_info *info)
+ {
+@@ -2405,6 +2406,7 @@ static int igb_get_ts_info(struct net_device *dev,
+ 		return -EOPNOTSUPP;
+ 	}
+ }
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0) */
+ 
+ static int igb_get_rss_hash_opts(struct igb_adapter *adapter,
+ 				 struct ethtool_rxnfc *cmd)
+@@ -3019,7 +3021,9 @@ static const struct ethtool_ops igb_ethtool_ops = {
+ 	.get_ethtool_stats	= igb_get_ethtool_stats,
+ 	.get_coalesce		= igb_get_coalesce,
+ 	.set_coalesce		= igb_set_coalesce,
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
+ 	.get_ts_info		= igb_get_ts_info,
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0) */
+ 	.get_rxnfc		= igb_get_rxnfc,
+ 	.set_rxnfc		= igb_set_rxnfc,
+ #if LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0)
-- 
1.9.0

