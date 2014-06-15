Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:44902 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752309AbaFOVWj (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 15 Jun 2014 17:22:39 -0400
Received: from localhost (localhost [127.0.0.1])
	by hauke-m.de (Postfix) with ESMTP id 376FC7E62
	for <backports@vger.kernel.org>; Sun, 15 Jun 2014 23:22:38 +0200 (CEST)
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 18/19] backports: remove useless git patch header
Date: Sun, 15 Jun 2014 23:21:46 +0200
Message-Id: <1402867307-31337-19-git-send-email-hauke@hauke-m.de> (sfid-20140615_233457_001987_8082B158)
In-Reply-To: <1402867307-31337-1-git-send-email-hauke@hauke-m.de>
References: <1402867307-31337-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

When exporting a patch from git it adds a header to it, but this header
is not needed by backports, remove it from the patches.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../network/0017-get_ts_info/igb_get_ts_info.patch                      | 2 --
 patches/collateral-evolutions/network/0028-select_queue/mac80211.patch  | 2 --
 patches/collateral-evolutions/network/0028-select_queue/mwifiex.patch   | 2 --
 .../network/0032-sriov_configure/igb_sriov_configure.patch              | 2 --
 .../collateral-evolutions/network/0033-ndo_vlan_rx_vid/cdc_mbim.patch   | 2 --
 .../network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch              | 2 --
 .../network/0034-ndo_set_vf_spoofchk/igb_ndo_set_vf_spoofchk.patch      | 2 --
 .../collateral-evolutions/network/0035-skb_no_fcs/igb_skb_no_fcs.patch  | 2 --
 .../network/0036-ethtool_eee/igb_ethtool_eee.patch                      | 2 --
 .../network/0037-ethtool_get_module/igb_get_module.patch                | 2 --
 .../network/0038-ethtool_rxfh_indir/igb_rxfh_indir.patch                | 2 --
 .../collateral-evolutions/network/0039-ethtool_rxnfc/igb_rxnfc.patch    | 2 --
 .../network/0040-ethtool_cmd_mdix/igb_ethtool_cmd_mdix.patch            | 2 --
 .../igb-devm_hwmon_device_register_with_groups.patch                    | 2 --
 .../network/0042-pci_error_handlers/igb_pci_error_handlers.patch        | 2 --
 15 files changed, 30 deletions(-)

diff --git a/patches/collateral-evolutions/network/0017-get_ts_info/igb_get_ts_info.patch b/patches/collateral-evolutions/network/0017-get_ts_info/igb_get_ts_info.patch
index 38f11f5..0b978c9 100644
--- a/patches/collateral-evolutions/network/0017-get_ts_info/igb_get_ts_info.patch
+++ b/patches/collateral-evolutions/network/0017-get_ts_info/igb_get_ts_info.patch
@@ -1,5 +1,3 @@
-diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
-index 7c8b9bf..75606be 100644
 --- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
 +++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
 @@ -2350,6 +2350,7 @@ static void igb_get_strings(struct net_d
diff --git a/patches/collateral-evolutions/network/0028-select_queue/mac80211.patch b/patches/collateral-evolutions/network/0028-select_queue/mac80211.patch
index 77d3e2f..2290203 100644
--- a/patches/collateral-evolutions/network/0028-select_queue/mac80211.patch
+++ b/patches/collateral-evolutions/network/0028-select_queue/mac80211.patch
@@ -1,5 +1,3 @@
-diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
-index 088111a..dcf149a 100644
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
 @@ -1063,10 +1063,19 @@ static void ieee80211_uninit(struct net_
diff --git a/patches/collateral-evolutions/network/0028-select_queue/mwifiex.patch b/patches/collateral-evolutions/network/0028-select_queue/mwifiex.patch
index 7391bdd..f722292 100644
--- a/patches/collateral-evolutions/network/0028-select_queue/mwifiex.patch
+++ b/patches/collateral-evolutions/network/0028-select_queue/mwifiex.patch
@@ -1,5 +1,3 @@
-diff --git a/drivers/net/wireless/mwifiex/main.c b/drivers/net/wireless/mwifiex/main.c
-index 9d3d275..f8b16f4 100644
 --- a/drivers/net/wireless/mwifiex/main.c
 +++ b/drivers/net/wireless/mwifiex/main.c
 @@ -745,9 +745,18 @@ static struct net_device_stats *mwifiex_
diff --git a/patches/collateral-evolutions/network/0032-sriov_configure/igb_sriov_configure.patch b/patches/collateral-evolutions/network/0032-sriov_configure/igb_sriov_configure.patch
index 3453e74..5b81354 100644
--- a/patches/collateral-evolutions/network/0032-sriov_configure/igb_sriov_configure.patch
+++ b/patches/collateral-evolutions/network/0032-sriov_configure/igb_sriov_configure.patch
@@ -1,5 +1,3 @@
-diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
-index 0270da9..09564d0 100644
 --- a/drivers/net/ethernet/intel/igb/igb_main.c
 +++ b/drivers/net/ethernet/intel/igb/igb_main.c
 @@ -198,7 +198,9 @@ static const struct dev_pm_ops igb_pm_op
diff --git a/patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/cdc_mbim.patch b/patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/cdc_mbim.patch
index de3ad1d..362b544 100644
--- a/patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/cdc_mbim.patch
+++ b/patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/cdc_mbim.patch
@@ -1,5 +1,3 @@
-diff --git a/drivers/net/usb/cdc_mbim.c b/drivers/net/usb/cdc_mbim.c
-index bc23273..459730d 100644
 --- a/drivers/net/usb/cdc_mbim.c
 +++ b/drivers/net/usb/cdc_mbim.c
 @@ -70,7 +70,13 @@ static int cdc_mbim_wdm_manage_power(str
diff --git a/patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch b/patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch
index adb2d97..fe31809 100644
--- a/patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch
+++ b/patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch
@@ -1,5 +1,3 @@
-diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
-index 09564d0..325f244 100644
 --- a/drivers/net/ethernet/intel/igb/igb_main.c
 +++ b/drivers/net/ethernet/intel/igb/igb_main.c
 @@ -157,8 +157,16 @@ static void igb_tx_timeout(struct net_de
diff --git a/patches/collateral-evolutions/network/0034-ndo_set_vf_spoofchk/igb_ndo_set_vf_spoofchk.patch b/patches/collateral-evolutions/network/0034-ndo_set_vf_spoofchk/igb_ndo_set_vf_spoofchk.patch
index 1e6eda5..9b83f5f 100644
--- a/patches/collateral-evolutions/network/0034-ndo_set_vf_spoofchk/igb_ndo_set_vf_spoofchk.patch
+++ b/patches/collateral-evolutions/network/0034-ndo_set_vf_spoofchk/igb_ndo_set_vf_spoofchk.patch
@@ -1,5 +1,3 @@
-diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
-index 325f244..ccd8f36 100644
 --- a/drivers/net/ethernet/intel/igb/igb_main.c
 +++ b/drivers/net/ethernet/intel/igb/igb_main.c
 @@ -178,8 +178,10 @@ static int igb_ndo_set_vf_mac(struct net
diff --git a/patches/collateral-evolutions/network/0035-skb_no_fcs/igb_skb_no_fcs.patch b/patches/collateral-evolutions/network/0035-skb_no_fcs/igb_skb_no_fcs.patch
index e0c54ce..691c1bc 100644
--- a/patches/collateral-evolutions/network/0035-skb_no_fcs/igb_skb_no_fcs.patch
+++ b/patches/collateral-evolutions/network/0035-skb_no_fcs/igb_skb_no_fcs.patch
@@ -1,5 +1,3 @@
-diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
-index ccd8f36..132cef8 100644
 --- a/drivers/net/ethernet/intel/igb/igb_main.c
 +++ b/drivers/net/ethernet/intel/igb/igb_main.c
 @@ -4768,9 +4768,10 @@ static u32 igb_tx_cmd_type(struct sk_buf
diff --git a/patches/collateral-evolutions/network/0036-ethtool_eee/igb_ethtool_eee.patch b/patches/collateral-evolutions/network/0036-ethtool_eee/igb_ethtool_eee.patch
index 8663c39..c737c98 100644
--- a/patches/collateral-evolutions/network/0036-ethtool_eee/igb_ethtool_eee.patch
+++ b/patches/collateral-evolutions/network/0036-ethtool_eee/igb_ethtool_eee.patch
@@ -1,5 +1,3 @@
-diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
-index 333a2b0..7c8b9bf 100644
 --- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
 +++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
 @@ -2591,6 +2591,7 @@ static int igb_set_rxnfc(struct net_devi
diff --git a/patches/collateral-evolutions/network/0037-ethtool_get_module/igb_get_module.patch b/patches/collateral-evolutions/network/0037-ethtool_get_module/igb_get_module.patch
index 4c2f181..a703f62 100644
--- a/patches/collateral-evolutions/network/0037-ethtool_get_module/igb_get_module.patch
+++ b/patches/collateral-evolutions/network/0037-ethtool_get_module/igb_get_module.patch
@@ -1,5 +1,3 @@
-diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
-index 75606be..6662b3b 100644
 --- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
 +++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
 @@ -2735,6 +2735,7 @@ static int igb_set_eee(struct net_device
diff --git a/patches/collateral-evolutions/network/0038-ethtool_rxfh_indir/igb_rxfh_indir.patch b/patches/collateral-evolutions/network/0038-ethtool_rxfh_indir/igb_rxfh_indir.patch
index 9568482..75b9e61 100644
--- a/patches/collateral-evolutions/network/0038-ethtool_rxfh_indir/igb_rxfh_indir.patch
+++ b/patches/collateral-evolutions/network/0038-ethtool_rxfh_indir/igb_rxfh_indir.patch
@@ -1,5 +1,3 @@
-diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
-index 6662b3b..03fe81a 100644
 --- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
 +++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
 @@ -2831,6 +2831,7 @@ static void igb_ethtool_complete(struct
diff --git a/patches/collateral-evolutions/network/0039-ethtool_rxnfc/igb_rxnfc.patch b/patches/collateral-evolutions/network/0039-ethtool_rxnfc/igb_rxnfc.patch
index daec82c..ed435d9 100644
--- a/patches/collateral-evolutions/network/0039-ethtool_rxnfc/igb_rxnfc.patch
+++ b/patches/collateral-evolutions/network/0039-ethtool_rxnfc/igb_rxnfc.patch
@@ -1,5 +1,3 @@
-diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
-index 03fe81a..f561b7b 100644
 --- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
 +++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
 @@ -2450,8 +2450,13 @@ static int igb_get_rss_hash_opts(struct
diff --git a/patches/collateral-evolutions/network/0040-ethtool_cmd_mdix/igb_ethtool_cmd_mdix.patch b/patches/collateral-evolutions/network/0040-ethtool_cmd_mdix/igb_ethtool_cmd_mdix.patch
index 5b4713d..d21f7f9 100644
--- a/patches/collateral-evolutions/network/0040-ethtool_cmd_mdix/igb_ethtool_cmd_mdix.patch
+++ b/patches/collateral-evolutions/network/0040-ethtool_cmd_mdix/igb_ethtool_cmd_mdix.patch
@@ -1,5 +1,3 @@
-diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
-index f561b7b..b611f5b 100644
 --- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
 +++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
 @@ -245,10 +245,12 @@ static int igb_get_settings(struct net_d
diff --git a/patches/collateral-evolutions/network/0041-devm_hwmon_device_register_with_groups/igb-devm_hwmon_device_register_with_groups.patch b/patches/collateral-evolutions/network/0041-devm_hwmon_device_register_with_groups/igb-devm_hwmon_device_register_with_groups.patch
index 057dc28..cd83953 100644
--- a/patches/collateral-evolutions/network/0041-devm_hwmon_device_register_with_groups/igb-devm_hwmon_device_register_with_groups.patch
+++ b/patches/collateral-evolutions/network/0041-devm_hwmon_device_register_with_groups/igb-devm_hwmon_device_register_with_groups.patch
@@ -1,5 +1,3 @@
-diff --git a/drivers/net/ethernet/intel/igb/igb_hwmon.c b/drivers/net/ethernet/intel/igb/igb_hwmon.c
-index 2eee9bb..ad08b1f 100644
 --- a/drivers/net/ethernet/intel/igb/igb_hwmon.c
 +++ b/drivers/net/ethernet/intel/igb/igb_hwmon.c
 @@ -173,7 +173,9 @@ int igb_sysfs_init(struct igb_adapter *a
diff --git a/patches/collateral-evolutions/network/0042-pci_error_handlers/igb_pci_error_handlers.patch b/patches/collateral-evolutions/network/0042-pci_error_handlers/igb_pci_error_handlers.patch
index 06af19b..4f99a2b 100644
--- a/patches/collateral-evolutions/network/0042-pci_error_handlers/igb_pci_error_handlers.patch
+++ b/patches/collateral-evolutions/network/0042-pci_error_handlers/igb_pci_error_handlers.patch
@@ -1,5 +1,3 @@
-diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
-index 132cef8..0e616a7 100644
 --- a/drivers/net/ethernet/intel/igb/igb_main.c
 +++ b/drivers/net/ethernet/intel/igb/igb_main.c
 @@ -234,7 +234,11 @@ static pci_ers_result_t igb_io_error_det
-- 
1.9.1

