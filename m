Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:60073 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751296AbaBHNpC (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 8 Feb 2014 08:45:02 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 6/6] backports: refresh patches on next-20140207
Date: Sat,  8 Feb 2014 14:44:30 +0100
Message-Id: <1391867070-20031-7-git-send-email-hauke@hauke-m.de> (sfid-20140208_144505_900373_10A303E6)
In-Reply-To: <1391867070-20031-1-git-send-email-hauke@hauke-m.de>
References: <1391867070-20031-1-git-send-email-hauke@hauke-m.de>
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
20  3.4.79              [  OK  ]
21  3.5.7               [  OK  ]
22  3.6.11              [  OK  ]
23  3.7.10              [  OK  ]
24  3.8.13              [  OK  ]
25  3.9.11              [  OK  ]
26  3.10.29             [  OK  ]
27  3.11.10             [  OK  ]
28  3.12.10             [  OK  ]
29  3.13.2              [  OK  ]
30  3.14-rc1            [  OK  ]

Manual changes were needed in
patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_hidp_core.patch

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 patches/backport-adjustments/dma-buf.patch         |    2 +-
 .../mac80211.patch                                 |    4 +--
 .../0006-disable-dump-adjust-on-old-kernels.patch  |    2 +-
 .../net_wireless_core.patch                        |    2 +-
 .../net_wireless_core.patch                        |    2 +-
 .../16-bluetooth/net_bluetooth_hidp_core.patch     |   22 +++++++++++------
 .../17-netdev-queue/net_mac80211_iface.patch       |    4 +--
 .../24-pcmcia/drivers_bluetooth_bluecard_cs.patch  |   26 ++++++++++----------
 .../24-pcmcia/drivers_bluetooth_bt3c_cs.patch      |   18 +++++++-------
 .../24-pcmcia/drivers_bluetooth_btuart_cs.patch    |   22 ++++++++---------
 .../24-pcmcia/drivers_bluetooth_dtl1_cs.patch      |   22 ++++++++---------
 .../drivers_net_wireless_rtl818x_rtl8180_dev.patch |    2 +-
 .../net_mac80211_iface.patch                       |    4 +--
 .../30-bridge-port/net_wireless_nl80211.patch      |    2 +-
 .../42-netlink_seq/net_wireless_nl80211.patch      |    2 +-
 .../69-wowlan-no-socket/net_wireless_nl80211.patch |    2 +-
 .../network/81-genl-const/nl80211.patch            |    6 ++---
 .../network/83-select_queue/mac80211.patch         |    4 +--
 .../regulator/0001-bt8xx-rename-dst-ops.patch      |   12 ++++-----
 19 files changed, 83 insertions(+), 77 deletions(-)

diff --git a/patches/backport-adjustments/dma-buf.patch b/patches/backport-adjustments/dma-buf.patch
index 4afae5f..cfd78be 100644
--- a/patches/backport-adjustments/dma-buf.patch
+++ b/patches/backport-adjustments/dma-buf.patch
@@ -51,7 +51,7 @@
  
  	fd_install(fd, dmabuf->file);
  
-@@ -724,17 +750,15 @@ static inline void dma_buf_uninit_debugf
+@@ -726,17 +752,15 @@ static inline void dma_buf_uninit_debugf
  }
  #endif
  
diff --git a/patches/collateral-evolutions/network/0003-netdev-needed_headroom_tailroom/mac80211.patch b/patches/collateral-evolutions/network/0003-netdev-needed_headroom_tailroom/mac80211.patch
index e7995a6..2e764c2 100644
--- a/patches/collateral-evolutions/network/0003-netdev-needed_headroom_tailroom/mac80211.patch
+++ b/patches/collateral-evolutions/network/0003-netdev-needed_headroom_tailroom/mac80211.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -1598,6 +1598,7 @@ int ieee80211_if_add(struct ieee80211_lo
+@@ -1609,6 +1609,7 @@ int ieee80211_if_add(struct ieee80211_lo
  			return -ENOMEM;
  		dev_net_set(ndev, wiphy_net(local->hw.wiphy));
  
@@ -8,7 +8,7 @@
  		ndev->needed_headroom = local->tx_headroom +
  					4*6 /* four MAC addresses */
  					+ 2 + 2 + 2 + 2 /* ctl, dur, seq, qos */
-@@ -1606,6 +1607,7 @@ int ieee80211_if_add(struct ieee80211_lo
+@@ -1617,6 +1618,7 @@ int ieee80211_if_add(struct ieee80211_lo
  					- ETH_HLEN /* ethernet hard_header_len */
  					+ IEEE80211_ENCRYPT_HEADROOM;
  		ndev->needed_tailroom = IEEE80211_ENCRYPT_TAILROOM;
diff --git a/patches/collateral-evolutions/network/0006-disable-dump-adjust-on-old-kernels.patch b/patches/collateral-evolutions/network/0006-disable-dump-adjust-on-old-kernels.patch
index 55a086b..a440aee 100644
--- a/patches/collateral-evolutions/network/0006-disable-dump-adjust-on-old-kernels.patch
+++ b/patches/collateral-evolutions/network/0006-disable-dump-adjust-on-old-kernels.patch
@@ -36,7 +36,7 @@ Date:   Fri Mar 1 14:03:49 2013 +0100
  				/*
  				 * If sending the wiphy data didn't fit (ENOBUFS
  				 * or EMSGSIZE returned), this SKB is still
-@@ -1725,6 +1726,7 @@ static int nl80211_dump_wiphy(struct sk_
+@@ -1726,6 +1727,7 @@ static int nl80211_dump_wiphy(struct sk_
  					rtnl_unlock();
  					return 1;
  				}
diff --git a/patches/collateral-evolutions/network/09-cfg80211-wext-padding/net_wireless_core.patch b/patches/collateral-evolutions/network/09-cfg80211-wext-padding/net_wireless_core.patch
index 516ed36..5cd257b 100644
--- a/patches/collateral-evolutions/network/09-cfg80211-wext-padding/net_wireless_core.patch
+++ b/patches/collateral-evolutions/network/09-cfg80211-wext-padding/net_wireless_core.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/core.c
 +++ b/net/wireless/core.c
-@@ -266,6 +266,17 @@ struct wiphy *wiphy_new(const struct cfg
+@@ -269,6 +269,17 @@ struct wiphy *wiphy_new(const struct cfg
  	struct cfg80211_registered_device *rdev;
  	int alloc_size;
  
diff --git a/patches/collateral-evolutions/network/10-add-wext-handlers-to-netdev/net_wireless_core.patch b/patches/collateral-evolutions/network/10-add-wext-handlers-to-netdev/net_wireless_core.patch
index 9c6b7ae..a743052 100644
--- a/patches/collateral-evolutions/network/10-add-wext-handlers-to-netdev/net_wireless_core.patch
+++ b/patches/collateral-evolutions/network/10-add-wext-handlers-to-netdev/net_wireless_core.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/core.c
 +++ b/net/wireless/core.c
-@@ -318,10 +318,6 @@ struct wiphy *wiphy_new(const struct cfg
+@@ -321,10 +321,6 @@ struct wiphy *wiphy_new(const struct cfg
  	INIT_WORK(&rdev->sched_scan_results_wk, __cfg80211_sched_scan_results);
  	INIT_DELAYED_WORK(&rdev->dfs_update_channels_wk,
  			  cfg80211_dfs_channels_update_work);
diff --git a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_hidp_core.patch b/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_hidp_core.patch
index 29dca32..068243f 100644
--- a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_hidp_core.patch
+++ b/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_hidp_core.patch
@@ -8,17 +8,23 @@
  static int hidp_get_raw_report(struct hid_device *hid,
  		unsigned char report_number,
  		unsigned char *data, size_t count,
-@@ -352,7 +353,9 @@ err:
+@@ -352,6 +353,7 @@ err:
  	mutex_unlock(&session->report_mutex);
  	return ret;
  }
 +#endif /* (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,38)) */
  
+ static int hidp_set_raw_report(struct hid_device *hid, unsigned char reportnum,
+ 			       unsigned char *data, size_t count,
+@@ -418,6 +420,7 @@ err:
+ 	return ret;
+ }
+ 
 +#if defined(CPTCFG_BACKPORT_OPTION_BT_SOCK_CREATE_NEEDS_KERN)
  static int hidp_output_raw_report(struct hid_device *hid, unsigned char *data, size_t count,
  		unsigned char report_type)
  {
-@@ -410,6 +413,16 @@ err:
+@@ -475,6 +478,16 @@ err:
  	mutex_unlock(&session->report_mutex);
  	return ret;
  }
@@ -33,9 +39,9 @@
 +}
 +#endif
  
- static void hidp_idle_timeout(unsigned long arg)
- {
-@@ -698,6 +711,87 @@ static void hidp_close(struct hid_device
+ static int hidp_raw_request(struct hid_device *hid, unsigned char reportnum,
+ 			    __u8 *buf, size_t len, unsigned char rtype,
+@@ -786,6 +799,87 @@ static void hidp_close(struct hid_device
  {
  }
  
@@ -123,7 +129,7 @@
  static int hidp_parse(struct hid_device *hid)
  {
  	struct hidp_session *session = hid->driver_data;
-@@ -775,7 +869,9 @@ static int hidp_setup_hid(struct hidp_se
+@@ -865,7 +959,9 @@ static int hidp_setup_hid(struct hidp_se
  	hid->dev.parent = &session->conn->hcon->dev;
  	hid->ll_driver = &hidp_hid_driver;
  
@@ -133,7 +139,7 @@
  	hid->hid_output_raw_report = hidp_output_raw_report;
  
  	/* True if device is blacklisted in drivers/hid/hid-core.c */
-@@ -793,6 +889,7 @@ fault:
+@@ -883,6 +979,7 @@ fault:
  
  	return err;
  }
@@ -141,7 +147,7 @@
  
  /* initialize session devices */
  static int hidp_session_dev_init(struct hidp_session *session,
-@@ -855,10 +952,17 @@ static int hidp_session_dev_add(struct h
+@@ -945,10 +1042,17 @@ static int hidp_session_dev_add(struct h
  /* remove HID/input devices from their bus systems */
  static void hidp_session_dev_del(struct hidp_session *session)
  {
diff --git a/patches/collateral-evolutions/network/17-netdev-queue/net_mac80211_iface.patch b/patches/collateral-evolutions/network/17-netdev-queue/net_mac80211_iface.patch
index 06b23fb..47f75f0 100644
--- a/patches/collateral-evolutions/network/17-netdev-queue/net_mac80211_iface.patch
+++ b/patches/collateral-evolutions/network/17-netdev-queue/net_mac80211_iface.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -1722,6 +1722,7 @@ void ieee80211_sdata_stop(struct ieee802
+@@ -1733,6 +1733,7 @@ void ieee80211_sdata_stop(struct ieee802
   * Remove all interfaces, may only be called at hardware unregistration
   * time because it doesn't do RCU-safe list removals.
   */
@@ -8,7 +8,7 @@
  void ieee80211_remove_interfaces(struct ieee80211_local *local)
  {
  	struct ieee80211_sub_if_data *sdata, *tmp;
-@@ -1758,6 +1759,22 @@ void ieee80211_remove_interfaces(struct
+@@ -1769,6 +1770,22 @@ void ieee80211_remove_interfaces(struct
  		kfree(sdata);
  	}
  }
diff --git a/patches/collateral-evolutions/network/24-pcmcia/drivers_bluetooth_bluecard_cs.patch b/patches/collateral-evolutions/network/24-pcmcia/drivers_bluetooth_bluecard_cs.patch
index 71375e7..c21f22e 100644
--- a/patches/collateral-evolutions/network/24-pcmcia/drivers_bluetooth_bluecard_cs.patch
+++ b/patches/collateral-evolutions/network/24-pcmcia/drivers_bluetooth_bluecard_cs.patch
@@ -1,6 +1,6 @@
 --- a/drivers/bluetooth/bluecard_cs.c
 +++ b/drivers/bluetooth/bluecard_cs.c
-@@ -157,7 +157,12 @@ static void bluecard_detach(struct pcmci
+@@ -158,7 +158,12 @@ static void bluecard_detach(struct pcmci
  static void bluecard_activity_led_timeout(u_long arg)
  {
  	bluecard_info_t *info = (bluecard_info_t *)arg;
@@ -13,7 +13,7 @@
  
  	if (!test_bit(CARD_HAS_PCCARD_ID, &(info->hw_state)))
  		return;
-@@ -174,7 +179,11 @@ static void bluecard_activity_led_timeou
+@@ -175,7 +180,11 @@ static void bluecard_activity_led_timeou
  
  static void bluecard_enable_activity_led(bluecard_info_t *info)
  {
@@ -25,7 +25,7 @@
  
  	if (!test_bit(CARD_HAS_PCCARD_ID, &(info->hw_state)))
  		return;
-@@ -230,7 +239,11 @@ static void bluecard_write_wakeup(blueca
+@@ -231,7 +240,11 @@ static void bluecard_write_wakeup(blueca
  	}
  
  	do {
@@ -37,7 +37,7 @@
  		unsigned int offset;
  		unsigned char command;
  		unsigned long ready_bit;
-@@ -377,7 +390,11 @@ static void bluecard_receive(bluecard_in
+@@ -378,7 +391,11 @@ static void bluecard_receive(bluecard_in
  		return;
  	}
  
@@ -49,7 +49,7 @@
  
  	if (test_bit(XMIT_SENDING_READY, &(info->tx_state)))
  		bluecard_enable_activity_led(info);
-@@ -505,7 +522,11 @@ static irqreturn_t bluecard_interrupt(in
+@@ -506,7 +523,11 @@ static irqreturn_t bluecard_interrupt(in
  	if (!test_bit(CARD_READY, &(info->hw_state)))
  		return IRQ_HANDLED;
  
@@ -61,7 +61,7 @@
  
  	spin_lock(&(info->lock));
  
-@@ -627,7 +648,11 @@ static int bluecard_hci_open(struct hci_
+@@ -628,7 +649,11 @@ static int bluecard_hci_open(struct hci_
  		return 0;
  
  	if (test_bit(CARD_HAS_PCCARD_ID, &(info->hw_state))) {
@@ -73,7 +73,7 @@
  
  		/* Enable LED */
  		outb(0x08 | 0x20, iobase + 0x30);
-@@ -647,7 +672,11 @@ static int bluecard_hci_close(struct hci
+@@ -648,7 +673,11 @@ static int bluecard_hci_close(struct hci
  	bluecard_hci_flush(hdev);
  
  	if (test_bit(CARD_HAS_PCCARD_ID, &(info->hw_state))) {
@@ -85,7 +85,7 @@
  
  		/* Disable LED */
  		outb(0x00, iobase + 0x30);
-@@ -689,7 +718,11 @@ static int bluecard_hci_send_frame(struc
+@@ -690,7 +719,11 @@ static int bluecard_hci_send_frame(struc
  
  static int bluecard_open(bluecard_info_t *info)
  {
@@ -97,7 +97,7 @@
  	struct hci_dev *hdev;
  	unsigned char id;
  
-@@ -804,7 +837,11 @@ static int bluecard_open(bluecard_info_t
+@@ -805,7 +838,11 @@ static int bluecard_open(bluecard_info_t
  
  static int bluecard_close(bluecard_info_t *info)
  {
@@ -109,7 +109,7 @@
  	struct hci_dev *hdev = info->hdev;
  
  	if (!hdev)
-@@ -839,7 +876,18 @@ static int bluecard_probe(struct pcmcia_
+@@ -840,7 +877,18 @@ static int bluecard_probe(struct pcmcia_
  	info->p_dev = link;
  	link->priv = info;
  
@@ -128,7 +128,7 @@
  
  	return bluecard_config(link);
  }
-@@ -856,15 +904,30 @@ static int bluecard_config(struct pcmcia
+@@ -857,15 +905,30 @@ static int bluecard_config(struct pcmcia
  	bluecard_info_t *info = link->priv;
  	int i, n;
  
@@ -159,7 +159,7 @@
  		if (i == 0)
  			break;
  	}
-@@ -872,9 +935,15 @@ static int bluecard_config(struct pcmcia
+@@ -873,9 +936,15 @@ static int bluecard_config(struct pcmcia
  	if (i != 0)
  		goto failed;
  
@@ -175,7 +175,7 @@
  
  	i = pcmcia_enable_device(link);
  	if (i != 0)
-@@ -912,7 +981,13 @@ MODULE_DEVICE_TABLE(pcmcia, bluecard_ids
+@@ -913,7 +982,13 @@ MODULE_DEVICE_TABLE(pcmcia, bluecard_ids
  
  static struct pcmcia_driver bluecard_driver = {
  	.owner		= THIS_MODULE,
diff --git a/patches/collateral-evolutions/network/24-pcmcia/drivers_bluetooth_bt3c_cs.patch b/patches/collateral-evolutions/network/24-pcmcia/drivers_bluetooth_bt3c_cs.patch
index 7f7d693..d2b3221 100644
--- a/patches/collateral-evolutions/network/24-pcmcia/drivers_bluetooth_bt3c_cs.patch
+++ b/patches/collateral-evolutions/network/24-pcmcia/drivers_bluetooth_bt3c_cs.patch
@@ -1,6 +1,6 @@
 --- a/drivers/bluetooth/bt3c_cs.c
 +++ b/drivers/bluetooth/bt3c_cs.c
-@@ -185,7 +185,11 @@ static void bt3c_write_wakeup(bt3c_info_
+@@ -186,7 +186,11 @@ static void bt3c_write_wakeup(bt3c_info_
  		return;
  
  	do {
@@ -12,7 +12,7 @@
  		register struct sk_buff *skb;
  		int len;
  
-@@ -223,7 +227,11 @@ static void bt3c_receive(bt3c_info_t *in
+@@ -224,7 +228,11 @@ static void bt3c_receive(bt3c_info_t *in
  		return;
  	}
  
@@ -24,7 +24,7 @@
  
  	avail = bt3c_read(iobase, 0x7006);
  	//printk("bt3c_cs: receiving %d bytes\n", avail);
-@@ -343,7 +351,11 @@ static irqreturn_t bt3c_interrupt(int ir
+@@ -344,7 +352,11 @@ static irqreturn_t bt3c_interrupt(int ir
  		/* our irq handler is shared */
  		return IRQ_NONE;
  
@@ -36,7 +36,7 @@
  
  	spin_lock(&(info->lock));
  
-@@ -457,7 +469,11 @@ static int bt3c_load_firmware(bt3c_info_
+@@ -458,7 +470,11 @@ static int bt3c_load_firmware(bt3c_info_
  	unsigned int iobase, size, addr, fcs, tmp;
  	int i, err = 0;
  
@@ -48,7 +48,7 @@
  
  	/* Reset */
  	bt3c_io_write(iobase, 0x8040, 0x0404);
-@@ -628,8 +644,27 @@ static int bt3c_probe(struct pcmcia_devi
+@@ -629,8 +645,27 @@ static int bt3c_probe(struct pcmcia_devi
  	info->p_dev = link;
  	link->priv = info;
  
@@ -76,7 +76,7 @@
  
  	return bt3c_config(link);
  }
-@@ -640,6 +675,7 @@ static void bt3c_detach(struct pcmcia_de
+@@ -641,6 +676,7 @@ static void bt3c_detach(struct pcmcia_de
  	bt3c_release(link);
  }
  
@@ -84,7 +84,7 @@
  static int bt3c_check_config(struct pcmcia_device *p_dev, void *priv_data)
  {
  	int *try = priv_data;
-@@ -678,6 +714,63 @@ static int bt3c_check_config_notpicky(st
+@@ -679,6 +715,63 @@ static int bt3c_check_config_notpicky(st
  	}
  	return -ENODEV;
  }
@@ -148,7 +148,7 @@
  
  static int bt3c_config(struct pcmcia_device *link)
  {
-@@ -701,9 +794,15 @@ static int bt3c_config(struct pcmcia_dev
+@@ -702,9 +795,15 @@ static int bt3c_config(struct pcmcia_dev
  	goto failed;
  
  found_port:
@@ -164,7 +164,7 @@
  
  	i = pcmcia_enable_device(link);
  	if (i != 0)
-@@ -738,7 +837,13 @@ MODULE_DEVICE_TABLE(pcmcia, bt3c_ids);
+@@ -739,7 +838,13 @@ MODULE_DEVICE_TABLE(pcmcia, bt3c_ids);
  
  static struct pcmcia_driver bt3c_driver = {
  	.owner		= THIS_MODULE,
diff --git a/patches/collateral-evolutions/network/24-pcmcia/drivers_bluetooth_btuart_cs.patch b/patches/collateral-evolutions/network/24-pcmcia/drivers_bluetooth_btuart_cs.patch
index 101014a..be1a160 100644
--- a/patches/collateral-evolutions/network/24-pcmcia/drivers_bluetooth_btuart_cs.patch
+++ b/patches/collateral-evolutions/network/24-pcmcia/drivers_bluetooth_btuart_cs.patch
@@ -1,6 +1,6 @@
 --- a/drivers/bluetooth/btuart_cs.c
 +++ b/drivers/bluetooth/btuart_cs.c
-@@ -139,7 +139,11 @@ static void btuart_write_wakeup(btuart_i
+@@ -140,7 +140,11 @@ static void btuart_write_wakeup(btuart_i
  	}
  
  	do {
@@ -12,7 +12,7 @@
  		register struct sk_buff *skb;
  		int len;
  
-@@ -180,7 +184,11 @@ static void btuart_receive(btuart_info_t
+@@ -181,7 +185,11 @@ static void btuart_receive(btuart_info_t
  		return;
  	}
  
@@ -24,7 +24,7 @@
  
  	do {
  		info->hdev->stat.byte_rx++;
-@@ -293,7 +301,11 @@ static irqreturn_t btuart_interrupt(int
+@@ -294,7 +302,11 @@ static irqreturn_t btuart_interrupt(int
  		/* our irq handler is shared */
  		return IRQ_NONE;
  
@@ -36,7 +36,7 @@
  
  	spin_lock(&(info->lock));
  
-@@ -350,7 +362,11 @@ static void btuart_change_speed(btuart_i
+@@ -351,7 +363,11 @@ static void btuart_change_speed(btuart_i
  		return;
  	}
  
@@ -48,7 +48,7 @@
  
  	spin_lock_irqsave(&(info->lock), flags);
  
-@@ -455,7 +471,11 @@ static int btuart_hci_send_frame(struct
+@@ -456,7 +472,11 @@ static int btuart_hci_send_frame(struct
  static int btuart_open(btuart_info_t *info)
  {
  	unsigned long flags;
@@ -60,7 +60,7 @@
  	struct hci_dev *hdev;
  
  	spin_lock_init(&(info->lock));
-@@ -521,7 +541,11 @@ static int btuart_open(btuart_info_t *in
+@@ -522,7 +542,11 @@ static int btuart_open(btuart_info_t *in
  static int btuart_close(btuart_info_t *info)
  {
  	unsigned long flags;
@@ -72,7 +72,7 @@
  	struct hci_dev *hdev = info->hdev;
  
  	if (!hdev)
-@@ -557,8 +581,27 @@ static int btuart_probe(struct pcmcia_de
+@@ -558,8 +582,27 @@ static int btuart_probe(struct pcmcia_de
  	info->p_dev = link;
  	link->priv = info;
  
@@ -100,7 +100,7 @@
  
  	return btuart_config(link);
  }
-@@ -569,6 +612,7 @@ static void btuart_detach(struct pcmcia_
+@@ -570,6 +613,7 @@ static void btuart_detach(struct pcmcia_
  	btuart_release(link);
  }
  
@@ -108,7 +108,7 @@
  static int btuart_check_config(struct pcmcia_device *p_dev, void *priv_data)
  {
  	int *try = priv_data;
-@@ -607,6 +651,63 @@ static int btuart_check_config_notpicky(
+@@ -608,6 +652,63 @@ static int btuart_check_config_notpicky(
  	}
  	return -ENODEV;
  }
@@ -172,7 +172,7 @@
  
  static int btuart_config(struct pcmcia_device *link)
  {
-@@ -630,9 +731,15 @@ static int btuart_config(struct pcmcia_d
+@@ -631,9 +732,15 @@ static int btuart_config(struct pcmcia_d
  	goto failed;
  
  found_port:
@@ -188,7 +188,7 @@
  
  	i = pcmcia_enable_device(link);
  	if (i != 0)
-@@ -666,7 +773,13 @@ MODULE_DEVICE_TABLE(pcmcia, btuart_ids);
+@@ -667,7 +774,13 @@ MODULE_DEVICE_TABLE(pcmcia, btuart_ids);
  
  static struct pcmcia_driver btuart_driver = {
  	.owner		= THIS_MODULE,
diff --git a/patches/collateral-evolutions/network/24-pcmcia/drivers_bluetooth_dtl1_cs.patch b/patches/collateral-evolutions/network/24-pcmcia/drivers_bluetooth_dtl1_cs.patch
index 9738e2d..4fccab6 100644
--- a/patches/collateral-evolutions/network/24-pcmcia/drivers_bluetooth_dtl1_cs.patch
+++ b/patches/collateral-evolutions/network/24-pcmcia/drivers_bluetooth_dtl1_cs.patch
@@ -1,6 +1,6 @@
 --- a/drivers/bluetooth/dtl1_cs.c
 +++ b/drivers/bluetooth/dtl1_cs.c
-@@ -143,7 +143,11 @@ static void dtl1_write_wakeup(dtl1_info_
+@@ -144,7 +144,11 @@ static void dtl1_write_wakeup(dtl1_info_
  	}
  
  	do {
@@ -12,7 +12,7 @@
  		register struct sk_buff *skb;
  		int len;
  
-@@ -208,7 +212,11 @@ static void dtl1_receive(dtl1_info_t *in
+@@ -209,7 +213,11 @@ static void dtl1_receive(dtl1_info_t *in
  		return;
  	}
  
@@ -24,7 +24,7 @@
  
  	do {
  		info->hdev->stat.byte_rx++;
-@@ -294,7 +302,11 @@ static irqreturn_t dtl1_interrupt(int ir
+@@ -295,7 +303,11 @@ static irqreturn_t dtl1_interrupt(int ir
  		/* our irq handler is shared */
  		return IRQ_NONE;
  
@@ -36,7 +36,7 @@
  
  	spin_lock(&(info->lock));
  
-@@ -435,7 +447,11 @@ static int dtl1_hci_send_frame(struct hc
+@@ -436,7 +448,11 @@ static int dtl1_hci_send_frame(struct hc
  static int dtl1_open(dtl1_info_t *info)
  {
  	unsigned long flags;
@@ -48,7 +48,7 @@
  	struct hci_dev *hdev;
  
  	spin_lock_init(&(info->lock));
-@@ -478,8 +494,13 @@ static int dtl1_open(dtl1_info_t *info)
+@@ -479,8 +495,13 @@ static int dtl1_open(dtl1_info_t *info)
  	outb(UART_LCR_WLEN8, iobase + UART_LCR);	/* Reset DLAB */
  	outb((UART_MCR_DTR | UART_MCR_RTS | UART_MCR_OUT2), iobase + UART_MCR);
  
@@ -62,7 +62,7 @@
  
  	/* Turn on interrupts */
  	outb(UART_IER_RLSI | UART_IER_RDI | UART_IER_THRI, iobase + UART_IER);
-@@ -504,7 +525,11 @@ static int dtl1_open(dtl1_info_t *info)
+@@ -505,7 +526,11 @@ static int dtl1_open(dtl1_info_t *info)
  static int dtl1_close(dtl1_info_t *info)
  {
  	unsigned long flags;
@@ -74,7 +74,7 @@
  	struct hci_dev *hdev = info->hdev;
  
  	if (!hdev)
-@@ -540,7 +565,24 @@ static int dtl1_probe(struct pcmcia_devi
+@@ -541,7 +566,24 @@ static int dtl1_probe(struct pcmcia_devi
  	info->p_dev = link;
  	link->priv = info;
  
@@ -99,7 +99,7 @@
  
  	return dtl1_config(link);
  }
-@@ -554,6 +596,7 @@ static void dtl1_detach(struct pcmcia_de
+@@ -555,6 +597,7 @@ static void dtl1_detach(struct pcmcia_de
  	pcmcia_disable_device(link);
  }
  
@@ -107,7 +107,7 @@
  static int dtl1_confcheck(struct pcmcia_device *p_dev, void *priv_data)
  {
  	if ((p_dev->resource[1]->end) || (p_dev->resource[1]->end < 8))
-@@ -564,6 +607,29 @@ static int dtl1_confcheck(struct pcmcia_
+@@ -565,6 +608,29 @@ static int dtl1_confcheck(struct pcmcia_
  
  	return pcmcia_request_io(p_dev);
  }
@@ -137,7 +137,7 @@
  
  static int dtl1_config(struct pcmcia_device *link)
  {
-@@ -571,14 +637,24 @@ static int dtl1_config(struct pcmcia_dev
+@@ -572,14 +638,24 @@ static int dtl1_config(struct pcmcia_dev
  	int ret;
  
  	/* Look for a generic full-sized window */
@@ -162,7 +162,7 @@
  
  	ret = pcmcia_enable_device(link);
  	if (ret)
-@@ -606,7 +682,13 @@ MODULE_DEVICE_TABLE(pcmcia, dtl1_ids);
+@@ -607,7 +683,13 @@ MODULE_DEVICE_TABLE(pcmcia, dtl1_ids);
  
  static struct pcmcia_driver dtl1_driver = {
  	.owner		= THIS_MODULE,
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_rtl818x_rtl8180_dev.patch b/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_rtl818x_rtl8180_dev.patch
index e2fb10b..5c19308 100644
--- a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_rtl818x_rtl8180_dev.patch
+++ b/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_rtl818x_rtl8180_dev.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/rtl818x/rtl8180/dev.c
 +++ b/drivers/net/wireless/rtl818x/rtl8180/dev.c
-@@ -817,10 +817,19 @@ static void rtl8180_bss_info_changed(str
+@@ -834,10 +834,19 @@ static void rtl8180_bss_info_changed(str
  	}
  }
  
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_iface.patch b/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_iface.patch
index fc267ef..4dbd96c 100644
--- a/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_iface.patch
+++ b/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_iface.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -812,8 +812,13 @@ static void ieee80211_do_stop(struct iee
+@@ -823,8 +823,13 @@ static void ieee80211_do_stop(struct iee
  	if (sdata->dev) {
  		netif_addr_lock_bh(sdata->dev);
  		spin_lock_bh(&local->filter_lock);
@@ -14,7 +14,7 @@
  		spin_unlock_bh(&local->filter_lock);
  		netif_addr_unlock_bh(sdata->dev);
  	}
-@@ -1013,7 +1018,12 @@ static void ieee80211_set_multicast_list
+@@ -1024,7 +1029,12 @@ static void ieee80211_set_multicast_list
  		sdata->flags ^= IEEE80211_SDATA_PROMISC;
  	}
  	spin_lock_bh(&local->filter_lock);
diff --git a/patches/collateral-evolutions/network/30-bridge-port/net_wireless_nl80211.patch b/patches/collateral-evolutions/network/30-bridge-port/net_wireless_nl80211.patch
index 65a4ddd..307354e 100644
--- a/patches/collateral-evolutions/network/30-bridge-port/net_wireless_nl80211.patch
+++ b/patches/collateral-evolutions/network/30-bridge-port/net_wireless_nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -2379,7 +2379,7 @@ static int nl80211_valid_4addr(struct cf
+@@ -2380,7 +2380,7 @@ static int nl80211_valid_4addr(struct cf
  			       enum nl80211_iftype iftype)
  {
  	if (!use_4addr) {
diff --git a/patches/collateral-evolutions/network/42-netlink_seq/net_wireless_nl80211.patch b/patches/collateral-evolutions/network/42-netlink_seq/net_wireless_nl80211.patch
index cad8792..da19d69 100644
--- a/patches/collateral-evolutions/network/42-netlink_seq/net_wireless_nl80211.patch
+++ b/patches/collateral-evolutions/network/42-netlink_seq/net_wireless_nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -5977,7 +5977,9 @@ static int nl80211_dump_scan(struct sk_b
+@@ -5978,7 +5978,9 @@ static int nl80211_dump_scan(struct sk_b
  	spin_lock_bh(&rdev->bss_lock);
  	cfg80211_bss_expire(rdev);
  
diff --git a/patches/collateral-evolutions/network/69-wowlan-no-socket/net_wireless_nl80211.patch b/patches/collateral-evolutions/network/69-wowlan-no-socket/net_wireless_nl80211.patch
index ab511cf..0a3f6c5 100644
--- a/patches/collateral-evolutions/network/69-wowlan-no-socket/net_wireless_nl80211.patch
+++ b/patches/collateral-evolutions/network/69-wowlan-no-socket/net_wireless_nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -8202,7 +8202,7 @@ static int nl80211_parse_wowlan_tcp(stru
+@@ -8203,7 +8203,7 @@ static int nl80211_parse_wowlan_tcp(stru
  		port = nla_get_u16(tb[NL80211_WOWLAN_TCP_SRC_PORT]);
  	else
  		port = 0;
diff --git a/patches/collateral-evolutions/network/81-genl-const/nl80211.patch b/patches/collateral-evolutions/network/81-genl-const/nl80211.patch
index 3695e74..5f78eff 100644
--- a/patches/collateral-evolutions/network/81-genl-const/nl80211.patch
+++ b/patches/collateral-evolutions/network/81-genl-const/nl80211.patch
@@ -21,7 +21,7 @@
  	[NL80211_MCGRP_CONFIG] = { .name = "config", },
  	[NL80211_MCGRP_SCAN] = { .name = "scan", },
  	[NL80211_MCGRP_REGULATORY] = { .name = "regulatory", },
-@@ -9153,7 +9153,7 @@ static int nl80211_set_qos_map(struct sk
+@@ -9154,7 +9154,7 @@ static int nl80211_set_qos_map(struct sk
  #define NL80211_FLAG_NEED_WDEV_UP	(NL80211_FLAG_NEED_WDEV |\
  					 NL80211_FLAG_CHECK_NETDEV_UP)
  
@@ -30,7 +30,7 @@
  			    struct genl_info *info)
  {
  	struct cfg80211_registered_device *rdev;
-@@ -9222,7 +9222,7 @@ static int nl80211_pre_doit(const struct
+@@ -9223,7 +9223,7 @@ static int nl80211_pre_doit(const struct
  	return 0;
  }
  
@@ -39,7 +39,7 @@
  			      struct genl_info *info)
  {
  	if (info->user_ptr[1]) {
-@@ -9239,7 +9239,7 @@ static void nl80211_post_doit(const stru
+@@ -9240,7 +9240,7 @@ static void nl80211_post_doit(const stru
  		rtnl_unlock();
  }
  
diff --git a/patches/collateral-evolutions/network/83-select_queue/mac80211.patch b/patches/collateral-evolutions/network/83-select_queue/mac80211.patch
index 0e61876..eb90b42 100644
--- a/patches/collateral-evolutions/network/83-select_queue/mac80211.patch
+++ b/patches/collateral-evolutions/network/83-select_queue/mac80211.patch
@@ -2,7 +2,7 @@ diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
 index 3dfd20a..0696aec 100644
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -1054,9 +1054,14 @@ static void ieee80211_uninit(struct net_
+@@ -1065,9 +1065,14 @@ static void ieee80211_uninit(struct net_
  	ieee80211_teardown_sdata(IEEE80211_DEV_TO_SUB_IF(dev));
  }
  
@@ -17,7 +17,7 @@ index 3dfd20a..0696aec 100644
  {
  	return ieee80211_select_queue(IEEE80211_DEV_TO_SUB_IF(dev), skb);
  }
-@@ -1072,9 +1077,14 @@ static const struct net_device_ops ieee8
+@@ -1083,9 +1088,14 @@ static const struct net_device_ops ieee8
  	.ndo_select_queue	= ieee80211_netdev_select_queue,
  };
  
diff --git a/patches/collateral-evolutions/regulator/0001-bt8xx-rename-dst-ops.patch b/patches/collateral-evolutions/regulator/0001-bt8xx-rename-dst-ops.patch
index 6472dc0..2e8e1b3 100644
--- a/patches/collateral-evolutions/regulator/0001-bt8xx-rename-dst-ops.patch
+++ b/patches/collateral-evolutions/regulator/0001-bt8xx-rename-dst-ops.patch
@@ -3,7 +3,7 @@ names and another symbol from older kernels.
 
 --- a/drivers/media/pci/bt8xx/dst.c
 +++ b/drivers/media/pci/bt8xx/dst.c
-@@ -1543,7 +1543,7 @@ static int dst_send_burst(struct dvb_fro
+@@ -1544,7 +1544,7 @@ static int dst_send_burst(struct dvb_fro
  }
  
  
@@ -12,7 +12,7 @@ names and another symbol from older kernels.
  {
  	struct dst_state *state = fe->demodulator_priv;
  
-@@ -1706,7 +1706,7 @@ static int dst_get_frontend(struct dvb_f
+@@ -1707,7 +1707,7 @@ static int dst_get_frontend(struct dvb_f
  	return 0;
  }
  
@@ -21,7 +21,7 @@ names and another symbol from older kernels.
  {
  	struct dst_state *state = fe->demodulator_priv;
  	if (state->dst_ca) {
-@@ -1775,8 +1775,8 @@ static struct dvb_frontend_ops dst_dvbt_
+@@ -1776,8 +1776,8 @@ static struct dvb_frontend_ops dst_dvbt_
  			FE_CAN_GUARD_INTERVAL_AUTO
  	},
  
@@ -32,7 +32,7 @@ names and another symbol from older kernels.
  	.tune = dst_tune_frontend,
  	.set_frontend = dst_set_frontend,
  	.get_frontend = dst_get_frontend,
-@@ -1800,8 +1800,8 @@ static struct dvb_frontend_ops dst_dvbs_
+@@ -1801,8 +1801,8 @@ static struct dvb_frontend_ops dst_dvbs_
  		.caps = FE_CAN_FEC_AUTO | FE_CAN_QPSK
  	},
  
@@ -43,7 +43,7 @@ names and another symbol from older kernels.
  	.tune = dst_tune_frontend,
  	.set_frontend = dst_set_frontend,
  	.get_frontend = dst_get_frontend,
-@@ -1833,8 +1833,8 @@ static struct dvb_frontend_ops dst_dvbc_
+@@ -1834,8 +1834,8 @@ static struct dvb_frontend_ops dst_dvbc_
  			FE_CAN_QAM_256
  	},
  
@@ -54,7 +54,7 @@ names and another symbol from older kernels.
  	.tune = dst_tune_frontend,
  	.set_frontend = dst_set_frontend,
  	.get_frontend = dst_get_frontend,
-@@ -1856,8 +1856,8 @@ static struct dvb_frontend_ops dst_atsc_
+@@ -1857,8 +1857,8 @@ static struct dvb_frontend_ops dst_atsc_
  		.caps = FE_CAN_FEC_AUTO | FE_CAN_QAM_AUTO | FE_CAN_QAM_64 | FE_CAN_QAM_256 | FE_CAN_8VSB
  	},
  
-- 
1.7.10.4

