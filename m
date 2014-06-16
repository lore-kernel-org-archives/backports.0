Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:52142 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932590AbaFPWc0 (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 16 Jun 2014 18:32:26 -0400
Received: from localhost (localhost [127.0.0.1])
	by hauke-m.de (Postfix) with ESMTP id 05D5A7E32
	for <backports@vger.kernel.org>; Tue, 17 Jun 2014 00:32:25 +0200 (CEST)
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 4/5] backports: refresh patches on next-20140616
Date: Tue, 17 Jun 2014 00:31:58 +0200
Message-Id: <1402957919-31374-5-git-send-email-hauke@hauke-m.de> (sfid-20140617_003234_929050_EF404FBC)
In-Reply-To: <1402957919-31374-1-git-send-email-hauke@hauke-m.de>
References: <1402957919-31374-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

== ckmake-report.log ==

1   3.0.101             [  OK  ]
2   3.1.10              [  OK  ]
3   3.2.60              [  OK  ]
4   3.3.8               [  OK  ]
5   3.4.93              [  OK  ]
6   3.5.7               [  OK  ]
7   3.6.11              [  OK  ]
8   3.7.10              [  OK  ]
9   3.8.13              [  OK  ]
10  3.9.11              [  OK  ]
11  3.10.43             [  OK  ]
12  3.11.10             [  OK  ]
13  3.12.22             [  OK  ]
14  3.13.11             [  OK  ]
15  3.14.7              [  OK  ]
16  3.15.0              [  OK  ]
17  3.16-rc1            [  OK  ]

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../network/0017-get_ts_info/igb_get_ts_info.patch             |  6 +++---
 .../0034-ndo_set_vf_spoofchk/igb_ndo_set_vf_spoofchk.patch     |  2 +-
 .../network/0036-ethtool_eee/igb_ethtool_eee.patch             |  6 +++---
 .../network/0037-ethtool_get_module/igb_get_module.patch       |  6 +++---
 .../network/0038-ethtool_rxfh_indir/igb_rxfh_indir.patch       | 10 +++++-----
 .../network/0039-ethtool_rxnfc/igb_rxnfc.patch                 |  2 +-
 .../network/0040-ethtool_cmd_mdix/igb_ethtool_cmd_mdix.patch   | 10 +++++-----
 7 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/patches/collateral-evolutions/network/0017-get_ts_info/igb_get_ts_info.patch b/patches/collateral-evolutions/network/0017-get_ts_info/igb_get_ts_info.patch
index 551d368..89da7ce 100644
--- a/patches/collateral-evolutions/network/0017-get_ts_info/igb_get_ts_info.patch
+++ b/patches/collateral-evolutions/network/0017-get_ts_info/igb_get_ts_info.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
 +++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
-@@ -2350,6 +2350,7 @@ static void igb_get_strings(struct net_d
+@@ -2352,6 +2352,7 @@ static void igb_get_strings(struct net_d
  	}
  }
  
@@ -8,7 +8,7 @@
  static int igb_get_ts_info(struct net_device *dev,
  			   struct ethtool_ts_info *info)
  {
-@@ -2405,6 +2406,7 @@ static int igb_get_ts_info(struct net_de
+@@ -2407,6 +2408,7 @@ static int igb_get_ts_info(struct net_de
  		return -EOPNOTSUPP;
  	}
  }
@@ -16,7 +16,7 @@
  
  static int igb_get_rss_hash_opts(struct igb_adapter *adapter,
  				 struct ethtool_rxnfc *cmd)
-@@ -3018,7 +3020,9 @@ static const struct ethtool_ops igb_etht
+@@ -3020,7 +3022,9 @@ static const struct ethtool_ops igb_etht
  	.get_ethtool_stats	= igb_get_ethtool_stats,
  	.get_coalesce		= igb_get_coalesce,
  	.set_coalesce		= igb_set_coalesce,
diff --git a/patches/collateral-evolutions/network/0034-ndo_set_vf_spoofchk/igb_ndo_set_vf_spoofchk.patch b/patches/collateral-evolutions/network/0034-ndo_set_vf_spoofchk/igb_ndo_set_vf_spoofchk.patch
index 50cbc02..f8b64b6 100644
--- a/patches/collateral-evolutions/network/0034-ndo_set_vf_spoofchk/igb_ndo_set_vf_spoofchk.patch
+++ b/patches/collateral-evolutions/network/0034-ndo_set_vf_spoofchk/igb_ndo_set_vf_spoofchk.patch
@@ -31,7 +31,7 @@
  {
 @@ -7973,6 +7978,7 @@ static int igb_ndo_set_vf_spoofchk(struc
  	adapter->vf_data[vf].spoofchk_enabled = setting;
- 	return E1000_SUCCESS;
+ 	return 0;
  }
 +#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0) */
  
diff --git a/patches/collateral-evolutions/network/0036-ethtool_eee/igb_ethtool_eee.patch b/patches/collateral-evolutions/network/0036-ethtool_eee/igb_ethtool_eee.patch
index bf92176..1986172 100644
--- a/patches/collateral-evolutions/network/0036-ethtool_eee/igb_ethtool_eee.patch
+++ b/patches/collateral-evolutions/network/0036-ethtool_eee/igb_ethtool_eee.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
 +++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
-@@ -2591,6 +2591,7 @@ static int igb_set_rxnfc(struct net_devi
+@@ -2593,6 +2593,7 @@ static int igb_set_rxnfc(struct net_devi
  	return ret;
  }
  
@@ -8,7 +8,7 @@
  static int igb_get_eee(struct net_device *netdev, struct ethtool_eee *edata)
  {
  	struct igb_adapter *adapter = netdev_priv(netdev);
-@@ -2732,6 +2733,7 @@ static int igb_set_eee(struct net_device
+@@ -2734,6 +2735,7 @@ static int igb_set_eee(struct net_device
  
  	return 0;
  }
@@ -16,7 +16,7 @@
  
  static int igb_get_module_info(struct net_device *netdev,
  			       struct ethtool_modinfo *modinfo)
-@@ -3025,8 +3027,10 @@ static const struct ethtool_ops igb_etht
+@@ -3027,8 +3029,10 @@ static const struct ethtool_ops igb_etht
  #endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0) */
  	.get_rxnfc		= igb_get_rxnfc,
  	.set_rxnfc		= igb_set_rxnfc,
diff --git a/patches/collateral-evolutions/network/0037-ethtool_get_module/igb_get_module.patch b/patches/collateral-evolutions/network/0037-ethtool_get_module/igb_get_module.patch
index 147fe8e..3908219 100644
--- a/patches/collateral-evolutions/network/0037-ethtool_get_module/igb_get_module.patch
+++ b/patches/collateral-evolutions/network/0037-ethtool_get_module/igb_get_module.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
 +++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
-@@ -2735,6 +2735,7 @@ static int igb_set_eee(struct net_device
+@@ -2737,6 +2737,7 @@ static int igb_set_eee(struct net_device
  }
  #endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0) */
  
@@ -8,7 +8,7 @@
  static int igb_get_module_info(struct net_device *netdev,
  			       struct ethtool_modinfo *modinfo)
  {
-@@ -2815,6 +2816,7 @@ static int igb_get_module_eeprom(struct
+@@ -2817,6 +2818,7 @@ static int igb_get_module_eeprom(struct
  
  	return 0;
  }
@@ -16,7 +16,7 @@
  
  static int igb_ethtool_begin(struct net_device *netdev)
  {
-@@ -3031,8 +3033,10 @@ static const struct ethtool_ops igb_etht
+@@ -3033,8 +3035,10 @@ static const struct ethtool_ops igb_etht
  	.get_eee		= igb_get_eee,
  	.set_eee		= igb_set_eee,
  #endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0) */
diff --git a/patches/collateral-evolutions/network/0038-ethtool_rxfh_indir/igb_rxfh_indir.patch b/patches/collateral-evolutions/network/0038-ethtool_rxfh_indir/igb_rxfh_indir.patch
index 870f793..8a77425 100644
--- a/patches/collateral-evolutions/network/0038-ethtool_rxfh_indir/igb_rxfh_indir.patch
+++ b/patches/collateral-evolutions/network/0038-ethtool_rxfh_indir/igb_rxfh_indir.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
 +++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
-@@ -2831,12 +2831,17 @@ static void igb_ethtool_complete(struct
+@@ -2833,12 +2833,17 @@ static void igb_ethtool_complete(struct
  	pm_runtime_put(&adapter->pdev->dev);
  }
  
@@ -18,7 +18,7 @@
  {
  	struct igb_adapter *adapter = netdev_priv(netdev);
  	int i;
-@@ -2846,6 +2851,7 @@ static int igb_get_rxfh(struct net_devic
+@@ -2848,6 +2853,7 @@ static int igb_get_rxfh(struct net_devic
  
  	return 0;
  }
@@ -26,7 +26,7 @@
  
  void igb_write_rss_indir_tbl(struct igb_adapter *adapter)
  {
-@@ -2882,8 +2888,13 @@ void igb_write_rss_indir_tbl(struct igb_
+@@ -2884,8 +2890,13 @@ void igb_write_rss_indir_tbl(struct igb_
  	}
  }
  
@@ -40,7 +40,7 @@
  {
  	struct igb_adapter *adapter = netdev_priv(netdev);
  	struct e1000_hw *hw = &adapter->hw;
-@@ -2915,6 +2926,7 @@ static int igb_set_rxfh(struct net_devic
+@@ -2917,6 +2928,7 @@ static int igb_set_rxfh(struct net_devic
  
  	return 0;
  }
@@ -48,7 +48,7 @@
  
  static unsigned int igb_max_channels(struct igb_adapter *adapter)
  {
-@@ -3037,9 +3049,15 @@ static const struct ethtool_ops igb_etht
+@@ -3039,9 +3051,15 @@ static const struct ethtool_ops igb_etht
  	.get_module_info	= igb_get_module_info,
  	.get_module_eeprom	= igb_get_module_eeprom,
  #endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0) */
diff --git a/patches/collateral-evolutions/network/0039-ethtool_rxnfc/igb_rxnfc.patch b/patches/collateral-evolutions/network/0039-ethtool_rxnfc/igb_rxnfc.patch
index ed435d9..86425c6 100644
--- a/patches/collateral-evolutions/network/0039-ethtool_rxnfc/igb_rxnfc.patch
+++ b/patches/collateral-evolutions/network/0039-ethtool_rxnfc/igb_rxnfc.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
 +++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
-@@ -2450,8 +2450,13 @@ static int igb_get_rss_hash_opts(struct
+@@ -2452,8 +2452,13 @@ static int igb_get_rss_hash_opts(struct
  	return 0;
  }
  
diff --git a/patches/collateral-evolutions/network/0040-ethtool_cmd_mdix/igb_ethtool_cmd_mdix.patch b/patches/collateral-evolutions/network/0040-ethtool_cmd_mdix/igb_ethtool_cmd_mdix.patch
index d21f7f9..f48aa3f 100644
--- a/patches/collateral-evolutions/network/0040-ethtool_cmd_mdix/igb_ethtool_cmd_mdix.patch
+++ b/patches/collateral-evolutions/network/0040-ethtool_cmd_mdix/igb_ethtool_cmd_mdix.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
 +++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
-@@ -245,10 +245,12 @@ static int igb_get_settings(struct net_d
+@@ -247,10 +247,12 @@ static int igb_get_settings(struct net_d
  	else
  		ecmd->eth_tp_mdix = ETH_TP_MDI_INVALID;
  
@@ -13,7 +13,7 @@
  
  	return 0;
  }
-@@ -267,6 +269,7 @@ static int igb_set_settings(struct net_d
+@@ -269,6 +271,7 @@ static int igb_set_settings(struct net_d
  		return -EINVAL;
  	}
  
@@ -21,7 +21,7 @@
  	/* MDI setting is only allowed when autoneg enabled because
  	 * some hardware doesn't allow MDI setting when speed or
  	 * duplex is forced.
-@@ -281,6 +284,7 @@ static int igb_set_settings(struct net_d
+@@ -283,6 +286,7 @@ static int igb_set_settings(struct net_d
  			return -EINVAL;
  		}
  	}
@@ -29,7 +29,7 @@
  
  	while (test_and_set_bit(__IGB_RESETTING, &adapter->state))
  		usleep_range(1000, 2000);
-@@ -324,6 +328,7 @@ static int igb_set_settings(struct net_d
+@@ -326,6 +330,7 @@ static int igb_set_settings(struct net_d
  		}
  	}
  
@@ -37,7 +37,7 @@
  	/* MDI-X => 2; MDI => 1; Auto => 3 */
  	if (ecmd->eth_tp_mdix_ctrl) {
  		/* fix up the value for auto (3 => 0) as zero is mapped
-@@ -334,6 +339,7 @@ static int igb_set_settings(struct net_d
+@@ -336,6 +341,7 @@ static int igb_set_settings(struct net_d
  		else
  			hw->phy.mdix = ecmd->eth_tp_mdix_ctrl;
  	}
-- 
1.9.1

