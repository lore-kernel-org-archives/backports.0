Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:50182 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752535Ab3J0TKJ (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 27 Oct 2013 15:10:09 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 4/4] backports: refresh on next-20131025
Date: Sun, 27 Oct 2013 20:09:40 +0100
Message-Id: <1382900980-26610-5-git-send-email-hauke@hauke-m.de> (sfid-20131027_201012_777224_74B2BC24)
In-Reply-To: <1382900980-26610-1-git-send-email-hauke@hauke-m.de>
References: <1382900980-26610-1-git-send-email-hauke@hauke-m.de>
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
16  3.0.98              [  OK  ]
17  3.1.10              [  OK  ]
18  3.10.14             [  OK  ]
19  3.11.3              [  OK  ]
20  3.12-rc3            [  OK  ]
21  3.2.51              [  OK  ]
22  3.3.8               [  OK  ]
23  3.4.64              [  OK  ]
24  3.5.7               [  OK  ]
25  3.6.11              [  OK  ]
26  3.7.10              [  OK  ]
27  3.8.13              [  OK  ]
28  3.9.11              [  OK  ]

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../drivers_net_wireless_iwlwifi_pcie_trans.patch    |    4 ++--
 .../drivers_net_wireless_libertas_if_spi.patch       |    6 +++---
 .../16-bluetooth/net_bluetooth_af_bluetooth.patch    |    6 +++---
 .../16-bluetooth/net_bluetooth_hci_sysfs.patch       |    4 ++--
 .../16-bluetooth/net_bluetooth_l2cap_sock.patch      |    6 +++---
 .../drivers_net_wireless_libertas_if_cs.patch        |   18 +++++++++---------
 .../net_mac80211_ieee80211_i.patch                   |    2 +-
 .../drivers_net_wireless_libertas_if_sdio.patch      |    4 ++--
 ...et_wireless_brcm80211_brcmfmac_bcmsdh_sdmmc.patch |    8 ++++----
 .../drivers_net_wireless_libertas_if_sdio.patch      |    4 ++--
 .../drivers_net_wireless_libertas_if_usb.patch       |    4 ++--
 .../drivers_net_wireless_libertas_if_usb.patch       |    2 +-
 .../drivers_net_wireless_rt2x00_rt2800usb.patch      |    2 +-
 .../drivers_net_wireless_iwlwifi_mvm_d3.patch        |    2 +-
 .../drivers_net_wireless_ath_ath9k_debug.patch       |    2 +-
 .../network/77-led-blink-api/mac80211.patch          |    2 +-
 .../nfc/01-netlink-portid/net_nfc_netlink.patch      |   16 ++++++++--------
 17 files changed, 46 insertions(+), 46 deletions(-)

diff --git a/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_iwlwifi_pcie_trans.patch b/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_iwlwifi_pcie_trans.patch
index d7f2911..9679bdf 100644
--- a/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_iwlwifi_pcie_trans.patch
+++ b/patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_iwlwifi_pcie_trans.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/iwlwifi/pcie/trans.c
 +++ b/drivers/net/wireless/iwlwifi/pcie/trans.c
-@@ -793,12 +793,21 @@ void iwl_trans_pcie_free(struct iwl_tran
+@@ -912,12 +912,21 @@ void iwl_trans_pcie_free(struct iwl_tran
  {
  	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
  
@@ -22,7 +22,7 @@
  	iwl_pcie_free_ict(trans);
  
  	pci_disable_msi(trans_pcie->pci_dev);
-@@ -1493,9 +1502,16 @@ struct iwl_trans *iwl_trans_pcie_alloc(s
+@@ -1612,9 +1621,16 @@ struct iwl_trans *iwl_trans_pcie_alloc(s
  	if (iwl_pcie_alloc_ict(trans))
  		goto out_free_cmd_pool;
  
diff --git a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_libertas_if_spi.patch b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_libertas_if_spi.patch
index 3512436..07149e2 100644
--- a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_libertas_if_spi.patch
+++ b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_libertas_if_spi.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/libertas/if_spi.c
 +++ b/drivers/net/wireless/libertas/if_spi.c
-@@ -1249,6 +1249,7 @@ static int libertas_spi_remove(struct sp
+@@ -1245,6 +1245,7 @@ static int libertas_spi_remove(struct sp
  	return 0;
  }
  
@@ -8,7 +8,7 @@
  static int if_spi_suspend(struct device *dev)
  {
  	struct spi_device *spi = to_spi_device(dev);
-@@ -1282,6 +1283,7 @@ static const struct dev_pm_ops if_spi_pm
+@@ -1278,6 +1279,7 @@ static const struct dev_pm_ops if_spi_pm
  	.suspend	= if_spi_suspend,
  	.resume		= if_spi_resume,
  };
@@ -16,7 +16,7 @@
  
  static struct spi_driver libertas_spi_driver = {
  	.probe	= if_spi_probe,
-@@ -1289,7 +1291,9 @@ static struct spi_driver libertas_spi_dr
+@@ -1285,7 +1287,9 @@ static struct spi_driver libertas_spi_dr
  	.driver = {
  		.name	= "libertas_spi",
  		.owner	= THIS_MODULE,
diff --git a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_af_bluetooth.patch b/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_af_bluetooth.patch
index 04a1276..708ce3b 100644
--- a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_af_bluetooth.patch
+++ b/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_af_bluetooth.patch
@@ -1,6 +1,6 @@
 --- a/net/bluetooth/af_bluetooth.c
 +++ b/net/bluetooth/af_bluetooth.c
-@@ -103,8 +103,12 @@ void bt_sock_unregister(int proto)
+@@ -104,8 +104,12 @@ void bt_sock_unregister(int proto)
  }
  EXPORT_SYMBOL(bt_sock_unregister);
  
@@ -13,7 +13,7 @@
  {
  	int err;
  
-@@ -122,7 +126,11 @@ static int bt_sock_create(struct net *ne
+@@ -123,7 +127,11 @@ static int bt_sock_create(struct net *ne
  	read_lock(&bt_proto_lock);
  
  	if (bt_proto[proto] && try_module_get(bt_proto[proto]->owner)) {
@@ -25,7 +25,7 @@
  		if (!err)
  			bt_sock_reclassify_lock(sock->sk, proto);
  		module_put(bt_proto[proto]->owner);
-@@ -463,7 +471,11 @@ int bt_sock_ioctl(struct socket *sock, u
+@@ -464,7 +472,11 @@ int bt_sock_ioctl(struct socket *sock, u
  		if (sk->sk_state == BT_LISTEN)
  			return -EINVAL;
  
diff --git a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_hci_sysfs.patch b/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_hci_sysfs.patch
index e78767e..404f588 100644
--- a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_hci_sysfs.patch
+++ b/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_hci_sysfs.patch
@@ -1,6 +1,6 @@
 --- a/net/bluetooth/hci_sysfs.c
 +++ b/net/bluetooth/hci_sysfs.c
-@@ -72,7 +72,11 @@ static struct attribute_group bt_link_gr
+@@ -53,7 +53,11 @@ static struct attribute_group bt_link_gr
  	.attrs = bt_link_attrs,
  };
  
@@ -12,7 +12,7 @@
  	&bt_link_group,
  	NULL
  };
-@@ -378,7 +382,11 @@ static struct attribute_group bt_host_gr
+@@ -186,7 +190,11 @@ static struct attribute_group bt_host_gr
  	.attrs = bt_host_attrs,
  };
  
diff --git a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_l2cap_sock.patch b/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_l2cap_sock.patch
index 3e87fac..5a9823a 100644
--- a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_l2cap_sock.patch
+++ b/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_l2cap_sock.patch
@@ -1,6 +1,6 @@
 --- a/net/bluetooth/l2cap_sock.c
 +++ b/net/bluetooth/l2cap_sock.c
-@@ -616,8 +616,13 @@ static int l2cap_sock_setsockopt_old(str
+@@ -639,8 +639,13 @@ static int l2cap_sock_setsockopt_old(str
  	return err;
  }
  
@@ -14,7 +14,7 @@
  {
  	struct sock *sk = sock->sk;
  	struct l2cap_chan *chan = l2cap_pi(sk)->chan;
-@@ -1347,8 +1352,12 @@ static struct sock *l2cap_sock_alloc(str
+@@ -1379,8 +1384,12 @@ static struct sock *l2cap_sock_alloc(str
  	return sk;
  }
  
@@ -27,7 +27,7 @@
  {
  	struct sock *sk;
  
-@@ -1360,7 +1369,11 @@ static int l2cap_sock_create(struct net
+@@ -1392,7 +1401,11 @@ static int l2cap_sock_create(struct net
  	    sock->type != SOCK_DGRAM && sock->type != SOCK_RAW)
  		return -ESOCKTNOSUPPORT;
  
diff --git a/patches/collateral-evolutions/network/24-pcmcia/drivers_net_wireless_libertas_if_cs.patch b/patches/collateral-evolutions/network/24-pcmcia/drivers_net_wireless_libertas_if_cs.patch
index f800280..79f18d6 100644
--- a/patches/collateral-evolutions/network/24-pcmcia/drivers_net_wireless_libertas_if_cs.patch
+++ b/patches/collateral-evolutions/network/24-pcmcia/drivers_net_wireless_libertas_if_cs.patch
@@ -1,7 +1,7 @@
 --- a/drivers/net/wireless/libertas/if_cs.c
 +++ b/drivers/net/wireless/libertas/if_cs.c
 @@ -757,7 +757,11 @@ static void if_cs_prog_firmware(struct l
- 		goto out;
+ 		return;
  
  	/* Now actually get the IRQ */
 +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
@@ -22,9 +22,9 @@
 +		free_irq(card->p_dev->irq.AssignedIRQ, card);
 +#endif
  	}
+ }
  
- out:
-@@ -824,7 +832,11 @@ static void if_cs_release(struct pcmcia_
+@@ -820,7 +828,11 @@ static void if_cs_release(struct pcmcia_
  
  	lbs_deb_enter(LBS_DEB_CS);
  
@@ -36,7 +36,7 @@
  	pcmcia_disable_device(p_dev);
  	if (card->iobase)
  		ioport_unmap(card->iobase);
-@@ -832,7 +844,7 @@ static void if_cs_release(struct pcmcia_
+@@ -828,7 +840,7 @@ static void if_cs_release(struct pcmcia_
  	lbs_deb_leave(LBS_DEB_CS);
  }
  
@@ -45,7 +45,7 @@
  static int if_cs_ioprobe(struct pcmcia_device *p_dev, void *priv_data)
  {
  	p_dev->resource[0]->flags &= ~IO_DATA_PATH_WIDTH;
-@@ -842,9 +854,39 @@ static int if_cs_ioprobe(struct pcmcia_d
+@@ -838,9 +850,39 @@ static int if_cs_ioprobe(struct pcmcia_d
  		pr_err("wrong CIS (check number of IO windows)\n");
  		return -ENODEV;
  	}
@@ -85,7 +85,7 @@
  }
  
  static int if_cs_probe(struct pcmcia_device *p_dev)
-@@ -863,7 +905,16 @@ static int if_cs_probe(struct pcmcia_dev
+@@ -859,7 +901,16 @@ static int if_cs_probe(struct pcmcia_dev
  	card->p_dev = p_dev;
  	p_dev->priv = card;
  
@@ -102,7 +102,7 @@
  
  	if (pcmcia_loop_config(p_dev, if_cs_ioprobe, NULL)) {
  		pr_err("error in pcmcia_loop_config\n");
-@@ -875,12 +926,26 @@ static int if_cs_probe(struct pcmcia_dev
+@@ -871,12 +922,26 @@ static int if_cs_probe(struct pcmcia_dev
  	 * a handler to the interrupt, unless the 'Handler' member of
  	 * the irq structure is initialized.
  	 */
@@ -129,7 +129,7 @@
  	if (!card->iobase) {
  		pr_err("error in ioport_map\n");
  		ret = -EIO;
-@@ -894,7 +959,17 @@ static int if_cs_probe(struct pcmcia_dev
+@@ -890,7 +955,17 @@ static int if_cs_probe(struct pcmcia_dev
  	}
  
  	/* Finally, report what we've done */
@@ -147,7 +147,7 @@
  
  	/*
  	 * Most of the libertas cards can do unaligned register access, but some
-@@ -1001,7 +1076,13 @@ MODULE_DEVICE_TABLE(pcmcia, if_cs_ids);
+@@ -997,7 +1072,13 @@ MODULE_DEVICE_TABLE(pcmcia, if_cs_ids);
  
  static struct pcmcia_driver lbs_driver = {
  	.owner		= THIS_MODULE,
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_ieee80211_i.patch b/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_ieee80211_i.patch
index 3e32c54..0f1fc1f 100644
--- a/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_ieee80211_i.patch
+++ b/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_ieee80211_i.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/ieee80211_i.h
 +++ b/net/mac80211/ieee80211_i.h
-@@ -964,7 +964,12 @@ struct ieee80211_local {
+@@ -965,7 +965,12 @@ struct ieee80211_local {
  	struct work_struct reconfig_filter;
  
  	/* aggregated multicast list */
diff --git a/patches/collateral-evolutions/network/26-sdio-quirks/drivers_net_wireless_libertas_if_sdio.patch b/patches/collateral-evolutions/network/26-sdio-quirks/drivers_net_wireless_libertas_if_sdio.patch
index ada7689..412f36e 100644
--- a/patches/collateral-evolutions/network/26-sdio-quirks/drivers_net_wireless_libertas_if_sdio.patch
+++ b/patches/collateral-evolutions/network/26-sdio-quirks/drivers_net_wireless_libertas_if_sdio.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/libertas/if_sdio.c
 +++ b/drivers/net/wireless/libertas/if_sdio.c
-@@ -877,6 +877,7 @@ static int if_sdio_power_on(struct if_sd
+@@ -873,6 +873,7 @@ static int if_sdio_power_on(struct if_sd
  	if (ret)
  		goto release;
  
@@ -8,7 +8,7 @@
  	/* For 1-bit transfers to the 8686 model, we need to enable the
  	 * interrupt flag in the CCCR register. Set the MMC_QUIRK_LENIENT_FN0
  	 * bit to allow access to non-vendor registers. */
-@@ -895,6 +896,7 @@ static int if_sdio_power_on(struct if_sd
+@@ -891,6 +892,7 @@ static int if_sdio_power_on(struct if_sd
  		if (ret)
  			goto disable;
  	}
diff --git a/patches/collateral-evolutions/network/29-sdio_no_suspend/drivers_net_wireless_brcm80211_brcmfmac_bcmsdh_sdmmc.patch b/patches/collateral-evolutions/network/29-sdio_no_suspend/drivers_net_wireless_brcm80211_brcmfmac_bcmsdh_sdmmc.patch
index ee3fb0e..ee1eb72 100644
--- a/patches/collateral-evolutions/network/29-sdio_no_suspend/drivers_net_wireless_brcm80211_brcmfmac_bcmsdh_sdmmc.patch
+++ b/patches/collateral-evolutions/network/29-sdio_no_suspend/drivers_net_wireless_brcm80211_brcmfmac_bcmsdh_sdmmc.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/brcm80211/brcmfmac/bcmsdh_sdmmc.c
 +++ b/drivers/net/wireless/brcm80211/brcmfmac/bcmsdh_sdmmc.c
-@@ -65,7 +65,7 @@ bool
+@@ -66,7 +66,7 @@ bool
  brcmf_pm_resume_error(struct brcmf_sdio_dev *sdiodev)
  {
  	bool is_err = false;
@@ -9,7 +9,7 @@
  	is_err = atomic_read(&sdiodev->suspend);
  #endif
  	return is_err;
-@@ -74,7 +74,7 @@ brcmf_pm_resume_error(struct brcmf_sdio_
+@@ -75,7 +75,7 @@ brcmf_pm_resume_error(struct brcmf_sdio_
  void
  brcmf_pm_resume_wait(struct brcmf_sdio_dev *sdiodev, wait_queue_head_t *wq)
  {
@@ -18,7 +18,7 @@
  	int retry = 0;
  	while (atomic_read(&sdiodev->suspend) && retry++ != 30)
  		wait_event_timeout(*wq, false, HZ/100);
-@@ -400,7 +400,7 @@ static void brcmf_ops_sdio_remove(struct
+@@ -417,7 +417,7 @@ static void brcmf_ops_sdio_remove(struct
  	brcmf_dbg(SDIO, "Exit\n");
  }
  
@@ -27,7 +27,7 @@
  static int brcmf_sdio_suspend(struct device *dev)
  {
  	mmc_pm_flag_t sdio_flags;
-@@ -450,7 +450,7 @@ static struct sdio_driver brcmf_sdmmc_dr
+@@ -467,7 +467,7 @@ static struct sdio_driver brcmf_sdmmc_dr
  	.remove = brcmf_ops_sdio_remove,
  	.name = BRCMFMAC_SDIO_PDATA_NAME,
  	.id_table = brcmf_sdmmc_ids,
diff --git a/patches/collateral-evolutions/network/29-sdio_no_suspend/drivers_net_wireless_libertas_if_sdio.patch b/patches/collateral-evolutions/network/29-sdio_no_suspend/drivers_net_wireless_libertas_if_sdio.patch
index e5d4faf..30d18b3 100644
--- a/patches/collateral-evolutions/network/29-sdio_no_suspend/drivers_net_wireless_libertas_if_sdio.patch
+++ b/patches/collateral-evolutions/network/29-sdio_no_suspend/drivers_net_wireless_libertas_if_sdio.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/libertas/if_sdio.c
 +++ b/drivers/net/wireless/libertas/if_sdio.c
-@@ -1345,6 +1345,7 @@ static void if_sdio_remove(struct sdio_f
+@@ -1341,6 +1341,7 @@ static void if_sdio_remove(struct sdio_f
  	lbs_deb_leave(LBS_DEB_SDIO);
  }
  
@@ -8,7 +8,7 @@
  static int if_sdio_suspend(struct device *dev)
  {
  	struct sdio_func *func = dev_to_sdio_func(dev);
-@@ -1403,15 +1404,18 @@ static const struct dev_pm_ops if_sdio_p
+@@ -1399,15 +1400,18 @@ static const struct dev_pm_ops if_sdio_p
  	.suspend	= if_sdio_suspend,
  	.resume		= if_sdio_resume,
  };
diff --git a/patches/collateral-evolutions/network/50-libertas-olpc-ec-wakeup/drivers_net_wireless_libertas_if_usb.patch b/patches/collateral-evolutions/network/50-libertas-olpc-ec-wakeup/drivers_net_wireless_libertas_if_usb.patch
index a65f196..229c5f7 100644
--- a/patches/collateral-evolutions/network/50-libertas-olpc-ec-wakeup/drivers_net_wireless_libertas_if_usb.patch
+++ b/patches/collateral-evolutions/network/50-libertas-olpc-ec-wakeup/drivers_net_wireless_libertas_if_usb.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/libertas/if_usb.c
 +++ b/drivers/net/wireless/libertas/if_usb.c
-@@ -962,6 +962,7 @@ static int if_usb_suspend(struct usb_int
+@@ -959,6 +959,7 @@ static int if_usb_suspend(struct usb_int
  		goto out;
  	}
  
@@ -8,7 +8,7 @@
  #ifdef CONFIG_OLPC
  	if (machine_is_olpc()) {
  		if (priv->wol_criteria == EHS_REMOVE_WAKEUP)
-@@ -970,6 +971,7 @@ static int if_usb_suspend(struct usb_int
+@@ -967,6 +968,7 @@ static int if_usb_suspend(struct usb_int
  			olpc_ec_wakeup_set(EC_SCI_SRC_WLAN);
  	}
  #endif
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_libertas_if_usb.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_libertas_if_usb.patch
index dcac2af..b930c58 100644
--- a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_libertas_if_usb.patch
+++ b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_libertas_if_usb.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/libertas/if_usb.c
 +++ b/drivers/net/wireless/libertas/if_usb.c
-@@ -1013,7 +1013,9 @@ static struct usb_driver if_usb_driver =
+@@ -1010,7 +1010,9 @@ static struct usb_driver if_usb_driver =
  	.suspend = if_usb_suspend,
  	.resume = if_usb_resume,
  	.reset_resume = if_usb_resume,
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_rt2x00_rt2800usb.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_rt2x00_rt2800usb.patch
index e46c63a..328aa57 100644
--- a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_rt2x00_rt2800usb.patch
+++ b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_wireless_rt2x00_rt2800usb.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/rt2x00/rt2800usb.c
 +++ b/drivers/net/wireless/rt2x00/rt2800usb.c
-@@ -1394,7 +1394,9 @@ static struct usb_driver rt2800usb_drive
+@@ -1398,7 +1398,9 @@ static struct usb_driver rt2800usb_drive
  	.suspend	= rt2x00usb_suspend,
  	.resume		= rt2x00usb_resume,
  	.reset_resume	= rt2x00usb_resume,
diff --git a/patches/collateral-evolutions/network/67-ipv6-dev-list/drivers_net_wireless_iwlwifi_mvm_d3.patch b/patches/collateral-evolutions/network/67-ipv6-dev-list/drivers_net_wireless_iwlwifi_mvm_d3.patch
index 11c2ed8..d4bbf7b 100644
--- a/patches/collateral-evolutions/network/67-ipv6-dev-list/drivers_net_wireless_iwlwifi_mvm_d3.patch
+++ b/patches/collateral-evolutions/network/67-ipv6-dev-list/drivers_net_wireless_iwlwifi_mvm_d3.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/iwlwifi/mvm/d3.c
 +++ b/drivers/net/wireless/iwlwifi/mvm/d3.c
-@@ -102,7 +102,11 @@ void iwl_mvm_ipv6_addr_change(struct iee
+@@ -103,7 +103,11 @@ void iwl_mvm_ipv6_addr_change(struct iee
  	int idx = 0;
  
  	read_lock_bh(&idev->lock);
diff --git a/patches/collateral-evolutions/network/70-umode_t-api-change/drivers_net_wireless_ath_ath9k_debug.patch b/patches/collateral-evolutions/network/70-umode_t-api-change/drivers_net_wireless_ath_ath9k_debug.patch
index 9bd5804..bf041df 100644
--- a/patches/collateral-evolutions/network/70-umode_t-api-change/drivers_net_wireless_ath_ath9k_debug.patch
+++ b/patches/collateral-evolutions/network/70-umode_t-api-change/drivers_net_wireless_ath_ath9k_debug.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/ath/ath9k/debug.c
 +++ b/drivers/net/wireless/ath/ath9k/debug.c
-@@ -1263,7 +1263,11 @@ static const struct file_operations fops
+@@ -1266,7 +1266,11 @@ static const struct file_operations fops
  
  static struct dentry *create_buf_file_handler(const char *filename,
  					      struct dentry *parent,
diff --git a/patches/collateral-evolutions/network/77-led-blink-api/mac80211.patch b/patches/collateral-evolutions/network/77-led-blink-api/mac80211.patch
index c06ba67..e87ab17 100644
--- a/patches/collateral-evolutions/network/77-led-blink-api/mac80211.patch
+++ b/patches/collateral-evolutions/network/77-led-blink-api/mac80211.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/ieee80211_i.h
 +++ b/net/mac80211/ieee80211_i.h
-@@ -1106,6 +1106,9 @@ struct ieee80211_local {
+@@ -1107,6 +1107,9 @@ struct ieee80211_local {
  	u32 dot11TransmittedFrameCount;
  
  #ifdef CONFIG_MAC80211_LEDS
diff --git a/patches/collateral-evolutions/nfc/01-netlink-portid/net_nfc_netlink.patch b/patches/collateral-evolutions/nfc/01-netlink-portid/net_nfc_netlink.patch
index f73352c..e87ae9e 100644
--- a/patches/collateral-evolutions/nfc/01-netlink-portid/net_nfc_netlink.patch
+++ b/patches/collateral-evolutions/nfc/01-netlink-portid/net_nfc_netlink.patch
@@ -1,6 +1,6 @@
 --- a/net/nfc/netlink.c
 +++ b/net/nfc/netlink.c
-@@ -70,7 +70,7 @@ static int nfc_genl_send_target(struct s
+@@ -71,7 +71,7 @@ static int nfc_genl_send_target(struct s
  {
  	void *hdr;
  
@@ -9,7 +9,7 @@
  			  &nfc_genl_family, flags, NFC_CMD_GET_TARGET);
  	if (!hdr)
  		return -EMSGSIZE;
-@@ -545,7 +545,7 @@ static int nfc_genl_dump_devices(struct
+@@ -546,7 +546,7 @@ static int nfc_genl_dump_devices(struct
  	while (dev) {
  		int rc;
  
@@ -18,7 +18,7 @@
  					  cb->nlh->nlmsg_seq, cb, NLM_F_MULTI);
  		if (rc < 0)
  			break;
-@@ -664,7 +664,7 @@ static int nfc_genl_get_device(struct sk
+@@ -665,7 +665,7 @@ static int nfc_genl_get_device(struct sk
  		goto out_putdev;
  	}
  
@@ -27,7 +27,7 @@
  				  NULL, 0);
  	if (rc < 0)
  		goto out_free;
-@@ -755,7 +755,7 @@ static int nfc_genl_start_poll(struct sk
+@@ -756,7 +756,7 @@ static int nfc_genl_start_poll(struct sk
  
  	rc = nfc_start_poll(dev, im_protocols, tm_protocols);
  	if (!rc)
@@ -36,7 +36,7 @@
  
  	mutex_unlock(&dev->genl_data.genl_data_mutex);
  
-@@ -789,7 +789,7 @@ static int nfc_genl_stop_poll(struct sk_
+@@ -790,7 +790,7 @@ static int nfc_genl_stop_poll(struct sk_
  
  	mutex_lock(&dev->genl_data.genl_data_mutex);
  
@@ -45,7 +45,7 @@
  		rc = -EBUSY;
  		goto out;
  	}
-@@ -915,7 +915,7 @@ static int nfc_genl_llc_get_params(struc
+@@ -916,7 +916,7 @@ static int nfc_genl_llc_get_params(struc
  		goto exit;
  	}
  
@@ -54,7 +54,7 @@
  
  exit:
  	device_unlock(&dev->dev);
-@@ -1253,7 +1253,7 @@ static int nfc_genl_dump_ses(struct sk_b
+@@ -1254,7 +1254,7 @@ static int nfc_genl_dump_ses(struct sk_b
  	while (dev) {
  		int rc;
  
@@ -63,7 +63,7 @@
  					  cb->nlh->nlmsg_seq, cb, NLM_F_MULTI);
  		if (rc < 0)
  			break;
-@@ -1408,12 +1408,12 @@ static int nfc_genl_rcv_nl_event(struct
+@@ -1499,12 +1499,12 @@ static int nfc_genl_rcv_nl_event(struct
  	if (event != NETLINK_URELEASE || n->protocol != NETLINK_GENERIC)
  		goto out;
  
-- 
1.7.10.4

