Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:54686 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751347AbaARUIv (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 18 Jan 2014 15:08:51 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 5/5] backports: refresh on next-20140106
Date: Sat, 18 Jan 2014 21:05:24 +0100
Message-Id: <1390075524-6924-6-git-send-email-hauke@hauke-m.de> (sfid-20140118_210854_081302_7C37E3F0)
In-Reply-To: <1390075524-6924-1-git-send-email-hauke@hauke-m.de>
References: <1390075524-6924-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

1   2.6.25              [  OK  ]
2   2.6.26              [  OK  ]
3   2.6.27              [  OK  ]
4   2.6.28              [  OK  ]
5   2.6.29              [  OK  ]
6   2.6.30              [  OK  ]
7   2.6.31              [  OK  ]
8   2.6.32              [  OK  ]
9   2.6.33              [  OK  ]
10  2.6.34              [  OK  ]
11  2.6.35              [  OK  ]
12  2.6.36              [  OK  ]
13  2.6.37              [  OK  ]
14  2.6.38              [  OK  ]
15  2.6.39              [  OK  ]
16  3.0.101             [  OK  ]
17  3.1.10              [  OK  ]
18  3.2.54              [  OK  ]
19  3.3.8               [  OK  ]
20  3.4.77              [  OK  ]
21  3.5.7               [  OK  ]
22  3.6.11              [  OK  ]
23  3.7.10              [  OK  ]
24  3.8.13              [  OK  ]
25  3.9.11              [  OK  ]
26  3.10.27             [  OK  ]
27  3.11.10             [  OK  ]
28  3.12.8              [  OK  ]
29  3.13-rc8            [  OK  ]

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../mac80211.patch                                   |    4 ++--
 .../0006-disable-dump-adjust-on-old-kernels.patch    |    4 ++--
 .../network/05-usb/p54usb.patch                      |    2 +-
 .../include_net_cfg80211.patch                       |    2 +-
 .../drivers_net_wireless_iwlegacy_common.patch       |    2 +-
 .../network/17-netdev-queue/net_mac80211_iface.patch |    4 ++--
 .../drivers_net_wireless_orinoco_orinoco_cs.patch    |   18 +++++++++---------
 .../drivers_net_wireless_orinoco_spectrum_cs.patch   |   16 ++++++++--------
 .../drivers_net_wireless_adm8211.patch               |    2 +-
 .../drivers_net_wireless_ath_carl9170_main.patch     |    2 +-
 .../drivers_net_wireless_cw1200_sta.patch            |    6 +++---
 .../drivers_net_wireless_mwl8k.patch                 |   10 +++++-----
 .../drivers_net_wireless_p54_main.patch              |    4 ++--
 .../drivers_net_wireless_rtl818x_rtl8180_dev.patch   |    2 +-
 .../drivers_net_wireless_rtl818x_rtl8187_dev.patch   |    2 +-
 .../drivers_net_wireless_zd1211rw_zd_mac.patch       |    2 +-
 .../net_mac80211_ieee80211_i.patch                   |    2 +-
 .../25-multicast-list_head/net_mac80211_iface.patch  |    4 ++--
 .../drivers_net_wireless_orinoco_hermes.patch        |    2 +-
 .../drivers_net_wireless_orinoco_orinoco_usb.patch   |    2 +-
 .../30-bridge-port/net_wireless_nl80211.patch        |    2 +-
 .../network/30-bridge-port/net_wireless_util.patch   |    2 +-
 .../drivers_net_wireless_iwlegacy_common.patch       |    2 +-
 .../drivers_net_wireless_iwlwifi_dvm_led.patch       |    2 +-
 .../drivers_net_ethernet_atheros_atlx_atl1.patch     |    4 ++--
 .../42-netlink_seq/net_wireless_nl80211.patch        |    2 +-
 .../69-wowlan-no-socket/net_wireless_nl80211.patch   |    2 +-
 .../network/76-sysfs-api/drivers_bcma.patch          |    2 +-
 .../network/77-led-blink-api/mac80211.patch          |    2 +-
 .../network/81-genl-const/nl80211.patch              |    8 ++++----
 30 files changed, 60 insertions(+), 60 deletions(-)

diff --git a/patches/collateral-evolutions/network/0003-netdev-needed_headroom_tailroom/mac80211.patch b/patches/collateral-evolutions/network/0003-netdev-needed_headroom_tailroom/mac80211.patch
index ed89650..2b3ae36 100644
--- a/patches/collateral-evolutions/network/0003-netdev-needed_headroom_tailroom/mac80211.patch
+++ b/patches/collateral-evolutions/network/0003-netdev-needed_headroom_tailroom/mac80211.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -1593,6 +1593,7 @@ int ieee80211_if_add(struct ieee80211_lo
+@@ -1596,6 +1596,7 @@ int ieee80211_if_add(struct ieee80211_lo
  			return -ENOMEM;
  		dev_net_set(ndev, wiphy_net(local->hw.wiphy));
  
@@ -8,7 +8,7 @@
  		ndev->needed_headroom = local->tx_headroom +
  					4*6 /* four MAC addresses */
  					+ 2 + 2 + 2 + 2 /* ctl, dur, seq, qos */
-@@ -1601,6 +1602,7 @@ int ieee80211_if_add(struct ieee80211_lo
+@@ -1604,6 +1605,7 @@ int ieee80211_if_add(struct ieee80211_lo
  					- ETH_HLEN /* ethernet hard_header_len */
  					+ IEEE80211_ENCRYPT_HEADROOM;
  		ndev->needed_tailroom = IEEE80211_ENCRYPT_TAILROOM;
diff --git a/patches/collateral-evolutions/network/0006-disable-dump-adjust-on-old-kernels.patch b/patches/collateral-evolutions/network/0006-disable-dump-adjust-on-old-kernels.patch
index 739448e..46728b2 100644
--- a/patches/collateral-evolutions/network/0006-disable-dump-adjust-on-old-kernels.patch
+++ b/patches/collateral-evolutions/network/0006-disable-dump-adjust-on-old-kernels.patch
@@ -28,7 +28,7 @@ Date:   Fri Mar 1 14:03:49 2013 +0100
 
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -1682,6 +1682,7 @@ static int nl80211_dump_wiphy(struct sk_
+@@ -1708,6 +1708,7 @@ static int nl80211_dump_wiphy(struct sk_
  						 cb->nlh->nlmsg_seq,
  						 NLM_F_MULTI, state);
  			if (ret < 0) {
@@ -36,7 +36,7 @@ Date:   Fri Mar 1 14:03:49 2013 +0100
  				/*
  				 * If sending the wiphy data didn't fit (ENOBUFS
  				 * or EMSGSIZE returned), this SKB is still
-@@ -1702,6 +1703,7 @@ static int nl80211_dump_wiphy(struct sk_
+@@ -1728,6 +1729,7 @@ static int nl80211_dump_wiphy(struct sk_
  					rtnl_unlock();
  					return 1;
  				}
diff --git a/patches/collateral-evolutions/network/05-usb/p54usb.patch b/patches/collateral-evolutions/network/05-usb/p54usb.patch
index 8ea02ed..2e0fc28 100644
--- a/patches/collateral-evolutions/network/05-usb/p54usb.patch
+++ b/patches/collateral-evolutions/network/05-usb/p54usb.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/p54/p54usb.c
 +++ b/drivers/net/wireless/p54/p54usb.c
-@@ -1139,7 +1139,9 @@ static struct usb_driver p54u_driver = {
+@@ -1138,7 +1138,9 @@ static struct usb_driver p54u_driver = {
  	.resume = p54u_resume,
  	.reset_resume = p54u_resume,
  #endif /* CONFIG_PM */
diff --git a/patches/collateral-evolutions/network/09-cfg80211-wext-padding/include_net_cfg80211.patch b/patches/collateral-evolutions/network/09-cfg80211-wext-padding/include_net_cfg80211.patch
index bc49087..8af7fa6 100644
--- a/patches/collateral-evolutions/network/09-cfg80211-wext-padding/include_net_cfg80211.patch
+++ b/patches/collateral-evolutions/network/09-cfg80211-wext-padding/include_net_cfg80211.patch
@@ -1,6 +1,6 @@
 --- a/include/net/cfg80211.h
 +++ b/include/net/cfg80211.h
-@@ -2828,6 +2828,9 @@ struct wiphy_vendor_command {
+@@ -2879,6 +2879,9 @@ struct wiphy_vendor_command {
  struct wiphy {
  	/* assign these fields before you register the wiphy */
  
diff --git a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlegacy_common.patch b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlegacy_common.patch
index 54bce74..0e2fcaf 100644
--- a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlegacy_common.patch
+++ b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlegacy_common.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/iwlegacy/common.c
 +++ b/drivers/net/wireless/iwlegacy/common.c
-@@ -4936,8 +4936,15 @@ il_pci_resume(struct device *device)
+@@ -4935,8 +4935,15 @@ il_pci_resume(struct device *device)
  	return 0;
  }
  
diff --git a/patches/collateral-evolutions/network/17-netdev-queue/net_mac80211_iface.patch b/patches/collateral-evolutions/network/17-netdev-queue/net_mac80211_iface.patch
index 7142517..fbca21c 100644
--- a/patches/collateral-evolutions/network/17-netdev-queue/net_mac80211_iface.patch
+++ b/patches/collateral-evolutions/network/17-netdev-queue/net_mac80211_iface.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -1717,6 +1717,7 @@ void ieee80211_sdata_stop(struct ieee802
+@@ -1720,6 +1720,7 @@ void ieee80211_sdata_stop(struct ieee802
   * Remove all interfaces, may only be called at hardware unregistration
   * time because it doesn't do RCU-safe list removals.
   */
@@ -8,7 +8,7 @@
  void ieee80211_remove_interfaces(struct ieee80211_local *local)
  {
  	struct ieee80211_sub_if_data *sdata, *tmp;
-@@ -1753,6 +1754,22 @@ void ieee80211_remove_interfaces(struct
+@@ -1756,6 +1757,22 @@ void ieee80211_remove_interfaces(struct
  		kfree(sdata);
  	}
  }
diff --git a/patches/collateral-evolutions/network/24-pcmcia/drivers_net_wireless_orinoco_orinoco_cs.patch b/patches/collateral-evolutions/network/24-pcmcia/drivers_net_wireless_orinoco_orinoco_cs.patch
index fcd179a..41b8712 100644
--- a/patches/collateral-evolutions/network/24-pcmcia/drivers_net_wireless_orinoco_orinoco_cs.patch
+++ b/patches/collateral-evolutions/network/24-pcmcia/drivers_net_wireless_orinoco_orinoco_cs.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/orinoco/orinoco_cs.c
 +++ b/drivers/net/wireless/orinoco/orinoco_cs.c
-@@ -78,7 +78,11 @@ orinoco_cs_hard_reset(struct orinoco_pri
+@@ -77,7 +77,11 @@ orinoco_cs_hard_reset(struct orinoco_pri
  	/* We need atomic ops here, because we're not holding the lock */
  	set_bit(0, &card->hard_reset_in_progress);
  
@@ -12,7 +12,7 @@
  	if (err)
  		return err;
  
-@@ -108,6 +112,16 @@ orinoco_cs_probe(struct pcmcia_device *l
+@@ -107,6 +111,16 @@ orinoco_cs_probe(struct pcmcia_device *l
  	card->p_dev = link;
  	link->priv = priv;
  
@@ -29,7 +29,7 @@
  	return orinoco_cs_config(link);
  }				/* orinoco_cs_attach */
  
-@@ -122,6 +136,7 @@ static void orinoco_cs_detach(struct pcm
+@@ -121,6 +135,7 @@ static void orinoco_cs_detach(struct pcm
  	free_orinocodev(priv);
  }				/* orinoco_cs_detach */
  
@@ -37,7 +37,7 @@
  static int orinoco_cs_config_check(struct pcmcia_device *p_dev, void *priv_data)
  {
  	if (p_dev->config_index == 0)
-@@ -129,6 +144,98 @@ static int orinoco_cs_config_check(struc
+@@ -128,6 +143,98 @@ static int orinoco_cs_config_check(struc
  
  	return pcmcia_request_io(p_dev);
  };
@@ -136,7 +136,7 @@
  
  static int
  orinoco_cs_config(struct pcmcia_device *link)
-@@ -138,10 +245,12 @@ orinoco_cs_config(struct pcmcia_device *
+@@ -137,10 +244,12 @@ orinoco_cs_config(struct pcmcia_device *
  	int ret;
  	void __iomem *mem;
  
@@ -149,7 +149,7 @@
  	ret = pcmcia_loop_config(link, orinoco_cs_config_check, NULL);
  	if (ret) {
  		if (!ignore_cis_vcc)
-@@ -151,8 +260,12 @@ orinoco_cs_config(struct pcmcia_device *
+@@ -150,8 +259,12 @@ orinoco_cs_config(struct pcmcia_device *
  		goto failed;
  	}
  
@@ -162,7 +162,7 @@
  	if (!mem)
  		goto failed;
  
-@@ -161,7 +274,11 @@ orinoco_cs_config(struct pcmcia_device *
+@@ -160,7 +273,11 @@ orinoco_cs_config(struct pcmcia_device *
  	 * called. */
  	hermes_struct_init(hw, mem, HERMES_16BIT_REGSPACING);
  
@@ -174,7 +174,7 @@
  	if (ret)
  		goto failed;
  
-@@ -176,8 +293,16 @@ orinoco_cs_config(struct pcmcia_device *
+@@ -175,8 +292,16 @@ orinoco_cs_config(struct pcmcia_device *
  	}
  
  	/* Register an interface with the stack */
@@ -191,7 +191,7 @@
  		printk(KERN_ERR PFX "orinoco_if_add() failed\n");
  		goto failed;
  	}
-@@ -331,7 +456,13 @@ MODULE_DEVICE_TABLE(pcmcia, orinoco_cs_i
+@@ -330,7 +455,13 @@ MODULE_DEVICE_TABLE(pcmcia, orinoco_cs_i
  
  static struct pcmcia_driver orinoco_driver = {
  	.owner		= THIS_MODULE,
diff --git a/patches/collateral-evolutions/network/24-pcmcia/drivers_net_wireless_orinoco_spectrum_cs.patch b/patches/collateral-evolutions/network/24-pcmcia/drivers_net_wireless_orinoco_spectrum_cs.patch
index 2941af9..0cdaec3 100644
--- a/patches/collateral-evolutions/network/24-pcmcia/drivers_net_wireless_orinoco_spectrum_cs.patch
+++ b/patches/collateral-evolutions/network/24-pcmcia/drivers_net_wireless_orinoco_spectrum_cs.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/orinoco/spectrum_cs.c
 +++ b/drivers/net/wireless/orinoco/spectrum_cs.c
-@@ -170,6 +170,16 @@ spectrum_cs_probe(struct pcmcia_device *
+@@ -169,6 +169,16 @@ spectrum_cs_probe(struct pcmcia_device *
  	card->p_dev = link;
  	link->priv = priv;
  
@@ -17,7 +17,7 @@
  	return spectrum_cs_config(link);
  }				/* spectrum_cs_attach */
  
-@@ -184,6 +194,7 @@ static void spectrum_cs_detach(struct pc
+@@ -183,6 +193,7 @@ static void spectrum_cs_detach(struct pc
  	free_orinocodev(priv);
  }				/* spectrum_cs_detach */
  
@@ -25,7 +25,7 @@
  static int spectrum_cs_config_check(struct pcmcia_device *p_dev,
  				    void *priv_data)
  {
-@@ -192,6 +203,98 @@ static int spectrum_cs_config_check(stru
+@@ -191,6 +202,98 @@ static int spectrum_cs_config_check(stru
  
  	return pcmcia_request_io(p_dev);
  };
@@ -124,7 +124,7 @@
  
  static int
  spectrum_cs_config(struct pcmcia_device *link)
-@@ -201,10 +304,12 @@ spectrum_cs_config(struct pcmcia_device
+@@ -200,10 +303,12 @@ spectrum_cs_config(struct pcmcia_device
  	int ret;
  	void __iomem *mem;
  
@@ -137,7 +137,7 @@
  	ret = pcmcia_loop_config(link, spectrum_cs_config_check, NULL);
  	if (ret) {
  		if (!ignore_cis_vcc)
-@@ -214,8 +319,12 @@ spectrum_cs_config(struct pcmcia_device
+@@ -213,8 +318,12 @@ spectrum_cs_config(struct pcmcia_device
  		goto failed;
  	}
  
@@ -150,7 +150,7 @@
  	if (!mem)
  		goto failed;
  
-@@ -225,7 +334,11 @@ spectrum_cs_config(struct pcmcia_device
+@@ -224,7 +333,11 @@ spectrum_cs_config(struct pcmcia_device
  	hermes_struct_init(hw, mem, HERMES_16BIT_REGSPACING);
  	hw->eeprom_pda = true;
  
@@ -162,7 +162,7 @@
  	if (ret)
  		goto failed;
  
-@@ -244,8 +357,16 @@ spectrum_cs_config(struct pcmcia_device
+@@ -243,8 +356,16 @@ spectrum_cs_config(struct pcmcia_device
  	}
  
  	/* Register an interface with the stack */
@@ -179,7 +179,7 @@
  		printk(KERN_ERR PFX "orinoco_if_add() failed\n");
  		goto failed;
  	}
-@@ -311,7 +432,13 @@ MODULE_DEVICE_TABLE(pcmcia, spectrum_cs_
+@@ -310,7 +431,13 @@ MODULE_DEVICE_TABLE(pcmcia, spectrum_cs_
  
  static struct pcmcia_driver orinoco_driver = {
  	.owner		= THIS_MODULE,
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_adm8211.patch b/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_adm8211.patch
index 7793f2c..049512c 100644
--- a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_adm8211.patch
+++ b/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_adm8211.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/adm8211.c
 +++ b/drivers/net/wireless/adm8211.c
-@@ -1321,19 +1321,37 @@ static void adm8211_bss_info_changed(str
+@@ -1320,19 +1320,37 @@ static void adm8211_bss_info_changed(str
  }
  
  static u64 adm8211_prepare_multicast(struct ieee80211_hw *hw,
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_ath_carl9170_main.patch b/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_ath_carl9170_main.patch
index 5b7e439..844dff5 100644
--- a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_ath_carl9170_main.patch
+++ b/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_ath_carl9170_main.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/ath/carl9170/main.c
 +++ b/drivers/net/wireless/ath/carl9170/main.c
-@@ -970,17 +970,35 @@ out:
+@@ -969,17 +969,35 @@ out:
  	return err;
  }
  
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_cw1200_sta.patch b/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_cw1200_sta.patch
index 166de17..3974eb3 100644
--- a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_cw1200_sta.patch
+++ b/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_cw1200_sta.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/cw1200/sta.c
 +++ b/drivers/net/wireless/cw1200/sta.c
-@@ -530,8 +530,13 @@ void cw1200_set_beacon_wakeup_period_wor
+@@ -531,8 +531,13 @@ void cw1200_set_beacon_wakeup_period_wor
  				     priv->join_dtim_period, 0);
  }
  
@@ -14,7 +14,7 @@
  {
  	static u8 broadcast_ipv6[ETH_ALEN] = {
  		0x33, 0x33, 0x00, 0x00, 0x00, 0x01
-@@ -540,13 +545,16 @@ u64 cw1200_prepare_multicast(struct ieee
+@@ -541,13 +546,16 @@ u64 cw1200_prepare_multicast(struct ieee
  		0x01, 0x00, 0x5e, 0x00, 0x00, 0x01
  	};
  	struct cw1200_common *priv = hw->priv;
@@ -31,7 +31,7 @@
  	if (netdev_hw_addr_list_count(mc_list) > WSM_MAX_GRP_ADDRTABLE_ENTRIES)
  		return 0;
  
-@@ -560,13 +568,26 @@ u64 cw1200_prepare_multicast(struct ieee
+@@ -561,13 +569,26 @@ u64 cw1200_prepare_multicast(struct ieee
  			priv->has_multicast_subscription = true;
  		count++;
  	}
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_mwl8k.patch b/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_mwl8k.patch
index e18755a..a5e07e0 100644
--- a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_mwl8k.patch
+++ b/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_mwl8k.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/mwl8k.c
 +++ b/drivers/net/wireless/mwl8k.c
-@@ -2661,15 +2661,21 @@ struct mwl8k_cmd_mac_multicast_adr {
+@@ -2660,15 +2660,21 @@ struct mwl8k_cmd_mac_multicast_adr {
  
  static struct mwl8k_cmd_pkt *
  __mwl8k_cmd_mac_multicast_adr(struct ieee80211_hw *hw, int allmulti,
@@ -22,7 +22,7 @@
  
  	if (allmulti || mc_count > priv->num_mcaddrs) {
  		allmulti = 1;
-@@ -2690,13 +2696,27 @@ __mwl8k_cmd_mac_multicast_adr(struct iee
+@@ -2689,13 +2695,27 @@ __mwl8k_cmd_mac_multicast_adr(struct iee
  	if (allmulti) {
  		cmd->action |= cpu_to_le16(MWL8K_ENABLE_RX_ALL_MULTICAST);
  	} else if (mc_count) {
@@ -50,7 +50,7 @@
  		}
  	}
  
-@@ -5031,7 +5051,11 @@ mwl8k_bss_info_changed(struct ieee80211_
+@@ -5030,7 +5050,11 @@ mwl8k_bss_info_changed(struct ieee80211_
  }
  
  static u64 mwl8k_prepare_multicast(struct ieee80211_hw *hw,
@@ -62,7 +62,7 @@
  {
  	struct mwl8k_cmd_pkt *cmd;
  
-@@ -5042,7 +5066,11 @@ static u64 mwl8k_prepare_multicast(struc
+@@ -5041,7 +5065,11 @@ static u64 mwl8k_prepare_multicast(struc
  	 * we'll end up throwing this packet away and creating a new
  	 * one in mwl8k_configure_filter().
  	 */
@@ -74,7 +74,7 @@
  
  	return (unsigned long)cmd;
  }
-@@ -5164,7 +5192,11 @@ static void mwl8k_configure_filter(struc
+@@ -5163,7 +5191,11 @@ static void mwl8k_configure_filter(struc
  	 */
  	if (*total_flags & FIF_ALLMULTI) {
  		kfree(cmd);
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_p54_main.patch b/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_p54_main.patch
index e2883c5..635a19b 100644
--- a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_p54_main.patch
+++ b/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_p54_main.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/p54/main.c
 +++ b/drivers/net/wireless/p54/main.c
-@@ -364,11 +364,18 @@ out:
+@@ -363,11 +363,18 @@ out:
  	return ret;
  }
  
@@ -19,7 +19,7 @@
  	int i;
  
  	BUILD_BUG_ON(ARRAY_SIZE(priv->mc_maclist) !=
-@@ -378,12 +385,23 @@ static u64 p54_prepare_multicast(struct
+@@ -377,12 +384,23 @@ static u64 p54_prepare_multicast(struct
  	 * Otherwise the firmware will drop it and ARP will no longer work.
  	 */
  	i = 1;
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_rtl818x_rtl8180_dev.patch b/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_rtl818x_rtl8180_dev.patch
index f25881f..e2fb10b 100644
--- a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_rtl818x_rtl8180_dev.patch
+++ b/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_rtl818x_rtl8180_dev.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/rtl818x/rtl8180/dev.c
 +++ b/drivers/net/wireless/rtl818x/rtl8180/dev.c
-@@ -818,10 +818,19 @@ static void rtl8180_bss_info_changed(str
+@@ -817,10 +817,19 @@ static void rtl8180_bss_info_changed(str
  	}
  }
  
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_rtl818x_rtl8187_dev.patch b/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_rtl818x_rtl8187_dev.patch
index 291255b..014e47f 100644
--- a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_rtl818x_rtl8187_dev.patch
+++ b/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_rtl818x_rtl8187_dev.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/rtl818x/rtl8187/dev.c
 +++ b/drivers/net/wireless/rtl818x/rtl8187/dev.c
-@@ -1295,9 +1295,17 @@ static void rtl8187_bss_info_changed(str
+@@ -1294,9 +1294,17 @@ static void rtl8187_bss_info_changed(str
  }
  
  static u64 rtl8187_prepare_multicast(struct ieee80211_hw *dev,
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_zd1211rw_zd_mac.patch b/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_zd1211rw_zd_mac.patch
index ba9845c..d7aa319 100644
--- a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_zd1211rw_zd_mac.patch
+++ b/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_zd1211rw_zd_mac.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/zd1211rw/zd_mac.c
 +++ b/drivers/net/wireless/zd1211rw/zd_mac.c
-@@ -1214,17 +1214,34 @@ static void zd_process_intr(struct work_
+@@ -1213,17 +1213,34 @@ static void zd_process_intr(struct work_
  
  
  static u64 zd_op_prepare_multicast(struct ieee80211_hw *hw,
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_ieee80211_i.patch b/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_ieee80211_i.patch
index 5b264d2..290b720 100644
--- a/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_ieee80211_i.patch
+++ b/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_ieee80211_i.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/ieee80211_i.h
 +++ b/net/mac80211/ieee80211_i.h
-@@ -1006,7 +1006,12 @@ struct ieee80211_local {
+@@ -1013,7 +1013,12 @@ struct ieee80211_local {
  	struct work_struct reconfig_filter;
  
  	/* aggregated multicast list */
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_iface.patch b/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_iface.patch
index 361687c..fc267ef 100644
--- a/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_iface.patch
+++ b/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_iface.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -808,8 +808,13 @@ static void ieee80211_do_stop(struct iee
+@@ -812,8 +812,13 @@ static void ieee80211_do_stop(struct iee
  	if (sdata->dev) {
  		netif_addr_lock_bh(sdata->dev);
  		spin_lock_bh(&local->filter_lock);
@@ -14,7 +14,7 @@
  		spin_unlock_bh(&local->filter_lock);
  		netif_addr_unlock_bh(sdata->dev);
  	}
-@@ -1009,7 +1014,12 @@ static void ieee80211_set_multicast_list
+@@ -1013,7 +1018,12 @@ static void ieee80211_set_multicast_list
  		sdata->flags ^= IEEE80211_SDATA_PROMISC;
  	}
  	spin_lock_bh(&local->filter_lock);
diff --git a/patches/collateral-evolutions/network/27-hermes-read-pda-conflict/drivers_net_wireless_orinoco_hermes.patch b/patches/collateral-evolutions/network/27-hermes-read-pda-conflict/drivers_net_wireless_orinoco_hermes.patch
index 70e108a..70bca92 100644
--- a/patches/collateral-evolutions/network/27-hermes-read-pda-conflict/drivers_net_wireless_orinoco_hermes.patch
+++ b/patches/collateral-evolutions/network/27-hermes-read-pda-conflict/drivers_net_wireless_orinoco_hermes.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/orinoco/hermes.c
 +++ b/drivers/net/wireless/orinoco/hermes.c
-@@ -767,7 +767,7 @@ static const struct hermes_ops hermes_op
+@@ -766,7 +766,7 @@ static const struct hermes_ops hermes_op
  	.write_ltv = hermes_write_ltv,
  	.bap_pread = hermes_bap_pread,
  	.bap_pwrite = hermes_bap_pwrite,
diff --git a/patches/collateral-evolutions/network/27-hermes-read-pda-conflict/drivers_net_wireless_orinoco_orinoco_usb.patch b/patches/collateral-evolutions/network/27-hermes-read-pda-conflict/drivers_net_wireless_orinoco_orinoco_usb.patch
index fa11d01..aa08ba8 100644
--- a/patches/collateral-evolutions/network/27-hermes-read-pda-conflict/drivers_net_wireless_orinoco_orinoco_usb.patch
+++ b/patches/collateral-evolutions/network/27-hermes-read-pda-conflict/drivers_net_wireless_orinoco_orinoco_usb.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/orinoco/orinoco_usb.c
 +++ b/drivers/net/wireless/orinoco/orinoco_usb.c
-@@ -1554,7 +1554,7 @@ static const struct hermes_ops ezusb_ops
+@@ -1553,7 +1553,7 @@ static const struct hermes_ops ezusb_ops
  	.read_ltv = ezusb_read_ltv,
  	.write_ltv = ezusb_write_ltv,
  	.bap_pread = ezusb_bap_pread,
diff --git a/patches/collateral-evolutions/network/30-bridge-port/net_wireless_nl80211.patch b/patches/collateral-evolutions/network/30-bridge-port/net_wireless_nl80211.patch
index 6940eb0..a4151b8 100644
--- a/patches/collateral-evolutions/network/30-bridge-port/net_wireless_nl80211.patch
+++ b/patches/collateral-evolutions/network/30-bridge-port/net_wireless_nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -2381,7 +2381,7 @@ static int nl80211_valid_4addr(struct cf
+@@ -2407,7 +2407,7 @@ static int nl80211_valid_4addr(struct cf
  			       enum nl80211_iftype iftype)
  {
  	if (!use_4addr) {
diff --git a/patches/collateral-evolutions/network/30-bridge-port/net_wireless_util.patch b/patches/collateral-evolutions/network/30-bridge-port/net_wireless_util.patch
index 4bac3e2..aac67dd 100644
--- a/patches/collateral-evolutions/network/30-bridge-port/net_wireless_util.patch
+++ b/patches/collateral-evolutions/network/30-bridge-port/net_wireless_util.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/util.c
 +++ b/net/wireless/util.c
-@@ -849,7 +849,7 @@ int cfg80211_change_iface(struct cfg8021
+@@ -865,7 +865,7 @@ int cfg80211_change_iface(struct cfg8021
  		return -EOPNOTSUPP;
  
  	/* if it's part of a bridge, reject changing type to station/ibss */
diff --git a/patches/collateral-evolutions/network/38-led-max-brightness/drivers_net_wireless_iwlegacy_common.patch b/patches/collateral-evolutions/network/38-led-max-brightness/drivers_net_wireless_iwlegacy_common.patch
index d5632b7..6e4a76c 100644
--- a/patches/collateral-evolutions/network/38-led-max-brightness/drivers_net_wireless_iwlegacy_common.patch
+++ b/patches/collateral-evolutions/network/38-led-max-brightness/drivers_net_wireless_iwlegacy_common.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/iwlegacy/common.c
 +++ b/drivers/net/wireless/iwlegacy/common.c
-@@ -562,7 +562,9 @@ il_leds_init(struct il_priv *il)
+@@ -561,7 +561,9 @@ il_leds_init(struct il_priv *il)
  	    kasprintf(GFP_KERNEL, "%s-led", wiphy_name(il->hw->wiphy));
  	il->led.brightness_set = il_led_brightness_set;
  	il->led.blink_set = il_led_blink_set;
diff --git a/patches/collateral-evolutions/network/38-led-max-brightness/drivers_net_wireless_iwlwifi_dvm_led.patch b/patches/collateral-evolutions/network/38-led-max-brightness/drivers_net_wireless_iwlwifi_dvm_led.patch
index 4f579b5..05461b7 100644
--- a/patches/collateral-evolutions/network/38-led-max-brightness/drivers_net_wireless_iwlwifi_dvm_led.patch
+++ b/patches/collateral-evolutions/network/38-led-max-brightness/drivers_net_wireless_iwlwifi_dvm_led.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/iwlwifi/dvm/led.c
 +++ b/drivers/net/wireless/iwlwifi/dvm/led.c
-@@ -187,7 +187,9 @@ void iwl_leds_init(struct iwl_priv *priv
+@@ -186,7 +186,9 @@ void iwl_leds_init(struct iwl_priv *priv
  				   wiphy_name(priv->hw->wiphy));
  	priv->led.brightness_set = iwl_led_brightness_set;
  	priv->led.blink_set = iwl_led_blink_set;
diff --git a/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atlx_atl1.patch b/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atlx_atl1.patch
index f7f943b..9d3a16b 100644
--- a/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atlx_atl1.patch
+++ b/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atlx_atl1.patch
@@ -25,7 +25,7 @@
  
  	/*
  	 * patch for some L1 of old version,
-@@ -3607,6 +3611,14 @@ static int atl1_set_pauseparam(struct ne
+@@ -3608,6 +3612,14 @@ static int atl1_set_pauseparam(struct ne
  	return 0;
  }
  
@@ -40,7 +40,7 @@
  static void atl1_get_strings(struct net_device *netdev, u32 stringset,
  	u8 *data)
  {
-@@ -3679,6 +3691,12 @@ static const struct ethtool_ops atl1_eth
+@@ -3680,6 +3692,12 @@ static const struct ethtool_ops atl1_eth
  	.nway_reset		= atl1_nway_reset,
  	.get_ethtool_stats	= atl1_get_ethtool_stats,
  	.get_sset_count		= atl1_get_sset_count,
diff --git a/patches/collateral-evolutions/network/42-netlink_seq/net_wireless_nl80211.patch b/patches/collateral-evolutions/network/42-netlink_seq/net_wireless_nl80211.patch
index d8155f8..3edda0e 100644
--- a/patches/collateral-evolutions/network/42-netlink_seq/net_wireless_nl80211.patch
+++ b/patches/collateral-evolutions/network/42-netlink_seq/net_wireless_nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -5988,7 +5988,9 @@ static int nl80211_dump_scan(struct sk_b
+@@ -6014,7 +6014,9 @@ static int nl80211_dump_scan(struct sk_b
  	spin_lock_bh(&rdev->bss_lock);
  	cfg80211_bss_expire(rdev);
  
diff --git a/patches/collateral-evolutions/network/69-wowlan-no-socket/net_wireless_nl80211.patch b/patches/collateral-evolutions/network/69-wowlan-no-socket/net_wireless_nl80211.patch
index 88d716c..2fd9569 100644
--- a/patches/collateral-evolutions/network/69-wowlan-no-socket/net_wireless_nl80211.patch
+++ b/patches/collateral-evolutions/network/69-wowlan-no-socket/net_wireless_nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -8176,7 +8176,7 @@ static int nl80211_parse_wowlan_tcp(stru
+@@ -8239,7 +8239,7 @@ static int nl80211_parse_wowlan_tcp(stru
  		port = nla_get_u16(tb[NL80211_WOWLAN_TCP_SRC_PORT]);
  	else
  		port = 0;
diff --git a/patches/collateral-evolutions/network/76-sysfs-api/drivers_bcma.patch b/patches/collateral-evolutions/network/76-sysfs-api/drivers_bcma.patch
index e5dcaaf..cc3da6f 100644
--- a/patches/collateral-evolutions/network/76-sysfs-api/drivers_bcma.patch
+++ b/patches/collateral-evolutions/network/76-sysfs-api/drivers_bcma.patch
@@ -25,7 +25,7 @@
  };
  
  static u16 bcma_cc_core_id(struct bcma_bus *bus)
-@@ -493,6 +502,7 @@ static int __init bcma_modinit(void)
+@@ -482,6 +491,7 @@ static int __init bcma_modinit(void)
  {
  	int err;
  
diff --git a/patches/collateral-evolutions/network/77-led-blink-api/mac80211.patch b/patches/collateral-evolutions/network/77-led-blink-api/mac80211.patch
index d5f8878..c8dcc3e 100644
--- a/patches/collateral-evolutions/network/77-led-blink-api/mac80211.patch
+++ b/patches/collateral-evolutions/network/77-led-blink-api/mac80211.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/ieee80211_i.h
 +++ b/net/mac80211/ieee80211_i.h
-@@ -1154,6 +1154,9 @@ struct ieee80211_local {
+@@ -1161,6 +1161,9 @@ struct ieee80211_local {
  	u32 dot11TransmittedFrameCount;
  
  #ifdef CONFIG_MAC80211_LEDS
diff --git a/patches/collateral-evolutions/network/81-genl-const/nl80211.patch b/patches/collateral-evolutions/network/81-genl-const/nl80211.patch
index e4a5858..2d9895c 100644
--- a/patches/collateral-evolutions/network/81-genl-const/nl80211.patch
+++ b/patches/collateral-evolutions/network/81-genl-const/nl80211.patch
@@ -12,7 +12,7 @@
  			      struct genl_info *info);
  
  /* the netlink family */
-@@ -56,7 +56,7 @@ enum nl80211_multicast_groups {
+@@ -57,7 +57,7 @@ enum nl80211_multicast_groups {
  	NL80211_MCGRP_TESTMODE /* keep last - ifdef! */
  };
  
@@ -21,7 +21,7 @@
  	[NL80211_MCGRP_CONFIG] = { .name = "config", },
  	[NL80211_MCGRP_SCAN] = { .name = "scan", },
  	[NL80211_MCGRP_REGULATORY] = { .name = "regulatory", },
-@@ -9076,7 +9076,7 @@ EXPORT_SYMBOL_GPL(cfg80211_vendor_cmd_re
+@@ -9190,7 +9190,7 @@ static int nl80211_set_qos_map(struct sk
  #define NL80211_FLAG_NEED_WDEV_UP	(NL80211_FLAG_NEED_WDEV |\
  					 NL80211_FLAG_CHECK_NETDEV_UP)
  
@@ -30,7 +30,7 @@
  			    struct genl_info *info)
  {
  	struct cfg80211_registered_device *rdev;
-@@ -9145,7 +9145,7 @@ static int nl80211_pre_doit(const struct
+@@ -9259,7 +9259,7 @@ static int nl80211_pre_doit(const struct
  	return 0;
  }
  
@@ -39,7 +39,7 @@
  			      struct genl_info *info)
  {
  	if (info->user_ptr[1]) {
-@@ -9162,7 +9162,7 @@ static void nl80211_post_doit(const stru
+@@ -9276,7 +9276,7 @@ static void nl80211_post_doit(const stru
  		rtnl_unlock();
  }
  
-- 
1.7.10.4

