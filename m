Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:51947 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757062AbbIUWHd (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 21 Sep 2015 18:07:33 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 10/10] patches: refresh patches on next-20150903
Date: Tue, 22 Sep 2015 00:07:23 +0200
Message-Id: <1442873243-15490-11-git-send-email-hauke@hauke-m.de> (sfid-20150922_001657_509869_7217819C)
In-Reply-To: <1442873243-15490-1-git-send-email-hauke@hauke-m.de>
References: <1442873243-15490-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

1   3.0.101             [  OK  ]
2   3.1.10              [  OK  ]
3   3.2.71              [  OK  ]
4   3.3.8               [  OK  ]
5   3.4.108             [  OK  ]
6   3.5.7               [  OK  ]
7   3.6.11              [  OK  ]
8   3.7.10              [  OK  ]
9   3.8.13              [  OK  ]
10  3.9.11              [  OK  ]
11  3.10.88             [  OK  ]
12  3.11.10             [  OK  ]
13  3.12.47             [  OK  ]
14  3.13.11             [  OK  ]
15  3.14.52             [  OK  ]
16  3.15.10             [  OK  ]
17  3.16.7              [  OK  ]
18  3.17.8              [  OK  ]
19  3.18.21             [  OK  ]
20  3.19.8              [  OK  ]
21  4.0.9               [  OK  ]
22  4.1.7               [  OK  ]
23  4.2.0               [  OK  ]

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../media/0002-no_dmabuf/v4l2.patch                    |  8 ++++----
 .../network/0021-umode_t-api-change/ath10k.patch       |  2 +-
 .../network/0025-usb-sg/usbnet.patch                   | 12 ++++++------
 .../0032-sriov_configure/igb_sriov_configure.patch     |  4 ++--
 .../0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch     |  8 ++++----
 .../0038-ethtool_rxfh_indir/igb_rxfh_indir.patch       |  2 +-
 .../network/0043-ndo_set_vf_rate/igb_set_vf_rate.patch |  4 ++--
 .../network/0052-deactivate-ptp-pin/igb.patch          | 14 +++++++-------
 .../0053-remove_wait_on_bit_timeout/btusb.patch        | 12 ++++++------
 .../network/0062-acpi-gpio-remove/hci_bcm.patch        | 18 +++++++++---------
 10 files changed, 42 insertions(+), 42 deletions(-)

diff --git a/patches/collateral-evolutions/media/0002-no_dmabuf/v4l2.patch b/patches/collateral-evolutions/media/0002-no_dmabuf/v4l2.patch
index 89eb464..8a90f65 100644
--- a/patches/collateral-evolutions/media/0002-no_dmabuf/v4l2.patch
+++ b/patches/collateral-evolutions/media/0002-no_dmabuf/v4l2.patch
@@ -247,7 +247,7 @@
  static void vb2_vmalloc_put(void *buf_priv);
 --- a/include/media/v4l2-mem2mem.h
 +++ b/include/media/v4l2-mem2mem.h
-@@ -121,8 +121,10 @@ int v4l2_m2m_prepare_buf(struct file *fi
+@@ -125,8 +125,10 @@ int v4l2_m2m_prepare_buf(struct file *fi
  int v4l2_m2m_create_bufs(struct file *file, struct v4l2_m2m_ctx *m2m_ctx,
  			 struct v4l2_create_buffers *create);
  
@@ -258,7 +258,7 @@
  
  int v4l2_m2m_streamon(struct file *file, struct v4l2_m2m_ctx *m2m_ctx,
  		      enum v4l2_buf_type type);
-@@ -244,8 +246,10 @@ int v4l2_m2m_ioctl_create_bufs(struct fi
+@@ -264,8 +266,10 @@ int v4l2_m2m_ioctl_create_bufs(struct fi
  				struct v4l2_create_buffers *create);
  int v4l2_m2m_ioctl_querybuf(struct file *file, void *fh,
  				struct v4l2_buffer *buf);
@@ -296,7 +296,7 @@
  
  	void		*(*vaddr)(void *buf_priv);
  	void		*(*cookie)(void *buf_priv);
-@@ -465,7 +469,9 @@ void vb2_queue_release(struct vb2_queue
+@@ -467,7 +471,9 @@ void vb2_queue_release(struct vb2_queue
  void vb2_queue_error(struct vb2_queue *q);
  
  int vb2_qbuf(struct vb2_queue *q, struct v4l2_buffer *b);
@@ -306,7 +306,7 @@
  int vb2_dqbuf(struct vb2_queue *q, struct v4l2_buffer *b, bool nonblocking);
  
  int vb2_streamon(struct vb2_queue *q, enum v4l2_buf_type type);
-@@ -639,8 +645,10 @@ int vb2_ioctl_qbuf(struct file *file, vo
+@@ -641,8 +647,10 @@ int vb2_ioctl_qbuf(struct file *file, vo
  int vb2_ioctl_dqbuf(struct file *file, void *priv, struct v4l2_buffer *p);
  int vb2_ioctl_streamon(struct file *file, void *priv, enum v4l2_buf_type i);
  int vb2_ioctl_streamoff(struct file *file, void *priv, enum v4l2_buf_type i);
diff --git a/patches/collateral-evolutions/network/0021-umode_t-api-change/ath10k.patch b/patches/collateral-evolutions/network/0021-umode_t-api-change/ath10k.patch
index bdcf6d2..0d02657 100644
--- a/patches/collateral-evolutions/network/0021-umode_t-api-change/ath10k.patch
+++ b/patches/collateral-evolutions/network/0021-umode_t-api-change/ath10k.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/ath/ath10k/spectral.c
 +++ b/drivers/net/wireless/ath/ath10k/spectral.c
-@@ -469,7 +469,11 @@ static const struct file_operations fops
+@@ -477,7 +477,11 @@ static const struct file_operations fops
  
  static struct dentry *create_buf_file_handler(const char *filename,
  					      struct dentry *parent,
diff --git a/patches/collateral-evolutions/network/0025-usb-sg/usbnet.patch b/patches/collateral-evolutions/network/0025-usb-sg/usbnet.patch
index 2265ff1..3618f9c 100644
--- a/patches/collateral-evolutions/network/0025-usb-sg/usbnet.patch
+++ b/patches/collateral-evolutions/network/0025-usb-sg/usbnet.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/usb/usbnet.c
 +++ b/drivers/net/usb/usbnet.c
-@@ -1248,6 +1248,7 @@ EXPORT_SYMBOL_GPL(usbnet_tx_timeout);
+@@ -1249,6 +1249,7 @@ EXPORT_SYMBOL_GPL(usbnet_tx_timeout);
  
  /*-------------------------------------------------------------------------*/
  
@@ -8,7 +8,7 @@
  static int build_dma_sg(const struct sk_buff *skb, struct urb *urb)
  {
  	unsigned num_sgs, total_len = 0;
-@@ -1280,6 +1281,12 @@ static int build_dma_sg(const struct sk_
+@@ -1281,6 +1282,12 @@ static int build_dma_sg(const struct sk_
  
  	return 1;
  }
@@ -21,7 +21,7 @@
  
  netdev_tx_t usbnet_start_xmit (struct sk_buff *skb,
  				     struct net_device *net)
-@@ -1336,12 +1343,19 @@ netdev_tx_t usbnet_start_xmit (struct sk
+@@ -1337,12 +1344,19 @@ netdev_tx_t usbnet_start_xmit (struct sk
  		if (!(info->flags & FLAG_SEND_ZLP)) {
  			if (!(info->flags & FLAG_MULTI_PACKET)) {
  				length++;
@@ -41,7 +41,7 @@
  			}
  		} else
  			urb->transfer_flags |= URB_ZERO_PACKET;
-@@ -1408,7 +1422,9 @@ not_drop:
+@@ -1409,7 +1423,9 @@ not_drop:
  		if (skb)
  			dev_kfree_skb_any (skb);
  		if (urb) {
@@ -51,7 +51,7 @@
  			usb_free_urb(urb);
  		}
  	} else
-@@ -1461,7 +1477,9 @@ static void usbnet_bh (unsigned long par
+@@ -1462,7 +1478,9 @@ static void usbnet_bh (unsigned long par
  			rx_process (dev, skb);
  			continue;
  		case tx_done:
@@ -61,7 +61,7 @@
  		case rx_cleanup:
  			usb_free_urb (entry->urb);
  			dev_kfree_skb (skb);
-@@ -1817,7 +1835,9 @@ int usbnet_resume (struct usb_interface
+@@ -1818,7 +1836,9 @@ int usbnet_resume (struct usb_interface
  			retval = usb_submit_urb(res, GFP_ATOMIC);
  			if (retval < 0) {
  				dev_kfree_skb_any(skb);
diff --git a/patches/collateral-evolutions/network/0032-sriov_configure/igb_sriov_configure.patch b/patches/collateral-evolutions/network/0032-sriov_configure/igb_sriov_configure.patch
index 8376697..f29b66e 100644
--- a/patches/collateral-evolutions/network/0032-sriov_configure/igb_sriov_configure.patch
+++ b/patches/collateral-evolutions/network/0032-sriov_configure/igb_sriov_configure.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/ethernet/intel/igb/igb_main.c
 +++ b/drivers/net/ethernet/intel/igb/igb_main.c
-@@ -7506,6 +7506,7 @@ static int igb_sriov_reinit(struct pci_d
+@@ -7526,6 +7526,7 @@ static int igb_sriov_reinit(struct pci_d
  	return 0;
  }
  
@@ -8,7 +8,7 @@
  static int igb_pci_disable_sriov(struct pci_dev *dev)
  {
  	int err = igb_disable_sriov(dev);
-@@ -7515,6 +7516,7 @@ static int igb_pci_disable_sriov(struct
+@@ -7535,6 +7536,7 @@ static int igb_pci_disable_sriov(struct
  
  	return err;
  }
diff --git a/patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch b/patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch
index 78baa28..0bca051 100644
--- a/patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch
+++ b/patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch
@@ -17,7 +17,7 @@
  static void igb_restore_vlan(struct igb_adapter *);
  static void igb_rar_set_qsel(struct igb_adapter *, u8 *, u32 , u8);
  static void igb_ping_all_vfs(struct igb_adapter *);
-@@ -7170,8 +7178,14 @@ static void igb_vlan_mode(struct net_dev
+@@ -7188,8 +7196,14 @@ static void igb_vlan_mode(struct net_dev
  	igb_rlpml_set(adapter);
  }
  
@@ -32,7 +32,7 @@
  {
  	struct igb_adapter *adapter = netdev_priv(netdev);
  	struct e1000_hw *hw = &adapter->hw;
-@@ -7185,11 +7199,19 @@ static int igb_vlan_rx_add_vid(struct ne
+@@ -7203,11 +7217,19 @@ static int igb_vlan_rx_add_vid(struct ne
  
  	set_bit(vid, adapter->active_vlans);
  
@@ -52,7 +52,7 @@
  {
  	struct igb_adapter *adapter = netdev_priv(netdev);
  	struct e1000_hw *hw = &adapter->hw;
-@@ -7205,7 +7227,9 @@ static int igb_vlan_rx_kill_vid(struct n
+@@ -7223,7 +7245,9 @@ static int igb_vlan_rx_kill_vid(struct n
  
  	clear_bit(vid, adapter->active_vlans);
  
@@ -62,7 +62,7 @@
  }
  
  static void igb_restore_vlan(struct igb_adapter *adapter)
-@@ -7215,7 +7239,11 @@ static void igb_restore_vlan(struct igb_
+@@ -7233,7 +7257,11 @@ static void igb_restore_vlan(struct igb_
  	igb_vlan_mode(adapter->netdev, adapter->netdev->features);
  
  	for_each_set_bit(vid, adapter->active_vlans, VLAN_N_VID)
diff --git a/patches/collateral-evolutions/network/0038-ethtool_rxfh_indir/igb_rxfh_indir.patch b/patches/collateral-evolutions/network/0038-ethtool_rxfh_indir/igb_rxfh_indir.patch
index 6b36a9c..781ab6f 100644
--- a/patches/collateral-evolutions/network/0038-ethtool_rxfh_indir/igb_rxfh_indir.patch
+++ b/patches/collateral-evolutions/network/0038-ethtool_rxfh_indir/igb_rxfh_indir.patch
@@ -74,7 +74,7 @@
  
  static unsigned int igb_max_channels(struct igb_adapter *adapter)
  {
-@@ -3066,9 +3087,15 @@ static const struct ethtool_ops igb_etht
+@@ -3069,9 +3090,15 @@ static const struct ethtool_ops igb_etht
  	.set_eee		= igb_set_eee,
  	.get_module_info	= igb_get_module_info,
  	.get_module_eeprom	= igb_get_module_eeprom,
diff --git a/patches/collateral-evolutions/network/0043-ndo_set_vf_rate/igb_set_vf_rate.patch b/patches/collateral-evolutions/network/0043-ndo_set_vf_rate/igb_set_vf_rate.patch
index 32559f6..3af7b32 100644
--- a/patches/collateral-evolutions/network/0043-ndo_set_vf_rate/igb_set_vf_rate.patch
+++ b/patches/collateral-evolutions/network/0043-ndo_set_vf_rate/igb_set_vf_rate.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/ethernet/intel/igb/igb_main.c
 +++ b/drivers/net/ethernet/intel/igb/igb_main.c
-@@ -7834,6 +7834,7 @@ static int igb_ndo_set_vf_bw(struct net_
+@@ -7854,6 +7854,7 @@ static int igb_ndo_set_vf_bw(struct net_
  	if (hw->mac.type != e1000_82576)
  		return -EOPNOTSUPP;
  
@@ -8,7 +8,7 @@
  	if (min_tx_rate)
  		return -EINVAL;
  
-@@ -7847,7 +7848,17 @@ static int igb_ndo_set_vf_bw(struct net_
+@@ -7867,7 +7868,17 @@ static int igb_ndo_set_vf_bw(struct net_
  	adapter->vf_rate_link_speed = actual_link_speed;
  	adapter->vf_data[vf].tx_rate = (u16)max_tx_rate;
  	igb_set_vf_rate_limit(hw, vf, max_tx_rate, actual_link_speed);
diff --git a/patches/collateral-evolutions/network/0052-deactivate-ptp-pin/igb.patch b/patches/collateral-evolutions/network/0052-deactivate-ptp-pin/igb.patch
index 896136e..ed41932 100644
--- a/patches/collateral-evolutions/network/0052-deactivate-ptp-pin/igb.patch
+++ b/patches/collateral-evolutions/network/0052-deactivate-ptp-pin/igb.patch
@@ -68,7 +68,7 @@
  static int igb_ptp_settime_i210(struct ptp_clock_info *ptp,
  				const struct timespec64 *ts)
  {
-@@ -565,6 +572,7 @@ static int igb_ptp_feature_enable_i210(s
+@@ -597,6 +604,7 @@ static int igb_ptp_feature_enable_i210(s
  
  	return -EOPNOTSUPP;
  }
@@ -76,7 +76,7 @@
  
  static int igb_ptp_feature_enable(struct ptp_clock_info *ptp,
  				  struct ptp_clock_request *rq, int on)
-@@ -572,6 +580,7 @@ static int igb_ptp_feature_enable(struct
+@@ -604,6 +612,7 @@ static int igb_ptp_feature_enable(struct
  	return -EOPNOTSUPP;
  }
  
@@ -84,7 +84,7 @@
  static int igb_ptp_verify_pin(struct ptp_clock_info *ptp, unsigned int pin,
  			      enum ptp_pin_function func, unsigned int chan)
  {
-@@ -585,6 +594,7 @@ static int igb_ptp_verify_pin(struct ptp
+@@ -617,6 +626,7 @@ static int igb_ptp_verify_pin(struct ptp
  	}
  	return 0;
  }
@@ -92,7 +92,7 @@
  
  /**
   * igb_ptp_tx_work
-@@ -977,7 +987,9 @@ void igb_ptp_init(struct igb_adapter *ad
+@@ -1009,7 +1019,9 @@ void igb_ptp_init(struct igb_adapter *ad
  {
  	struct e1000_hw *hw = &adapter->hw;
  	struct net_device *netdev = adapter->netdev;
@@ -102,7 +102,7 @@
  
  	switch (hw->mac.type) {
  	case e1000_82576:
-@@ -1018,6 +1030,7 @@ void igb_ptp_init(struct igb_adapter *ad
+@@ -1050,6 +1062,7 @@ void igb_ptp_init(struct igb_adapter *ad
  		/* Enable the timer functions by clearing bit 31. */
  		wr32(E1000_TSAUXC, 0x0);
  		break;
@@ -110,7 +110,7 @@
  	case e1000_i210:
  	case e1000_i211:
  		for (i = 0; i < IGB_N_SDP; i++) {
-@@ -1044,6 +1057,7 @@ void igb_ptp_init(struct igb_adapter *ad
+@@ -1076,6 +1089,7 @@ void igb_ptp_init(struct igb_adapter *ad
  		/* Enable the timer functions by clearing bit 31. */
  		wr32(E1000_TSAUXC, 0x0);
  		break;
@@ -118,7 +118,7 @@
  	default:
  		adapter->ptp_clock = NULL;
  		return;
-@@ -1055,11 +1069,14 @@ void igb_ptp_init(struct igb_adapter *ad
+@@ -1087,11 +1101,14 @@ void igb_ptp_init(struct igb_adapter *ad
  	INIT_WORK(&adapter->ptp_tx_work, igb_ptp_tx_work);
  
  	/* Initialize the clock and overflow work for devices that need it. */
diff --git a/patches/collateral-evolutions/network/0053-remove_wait_on_bit_timeout/btusb.patch b/patches/collateral-evolutions/network/0053-remove_wait_on_bit_timeout/btusb.patch
index 10b3da6..59a8694 100644
--- a/patches/collateral-evolutions/network/0053-remove_wait_on_bit_timeout/btusb.patch
+++ b/patches/collateral-evolutions/network/0053-remove_wait_on_bit_timeout/btusb.patch
@@ -1,6 +1,6 @@
 --- a/drivers/bluetooth/btusb.c
 +++ b/drivers/bluetooth/btusb.c
-@@ -1762,8 +1762,12 @@ static void btusb_intel_bootup(struct bt
+@@ -1764,8 +1764,12 @@ static void btusb_intel_bootup(struct bt
  		return;
  
  	if (test_and_clear_bit(BTUSB_BOOTING, &data->flags)) {
@@ -13,7 +13,7 @@
  	}
  }
  
-@@ -1780,8 +1784,12 @@ static void btusb_intel_secure_send_resu
+@@ -1782,8 +1786,12 @@ static void btusb_intel_secure_send_resu
  
  	if (test_and_clear_bit(BTUSB_DOWNLOADING, &data->flags) &&
  	    test_bit(BTUSB_FIRMWARE_LOADED, &data->flags)) {
@@ -26,7 +26,7 @@
  	}
  }
  
-@@ -2136,6 +2144,7 @@ static int btusb_setup_intel_new(struct
+@@ -2138,6 +2146,7 @@ static int btusb_setup_intel_new(struct
  	 * and thus just timeout if that happens and fail the setup
  	 * of this device.
  	 */
@@ -34,7 +34,7 @@
  	err = wait_on_bit_timeout(&data->flags, BTUSB_DOWNLOADING,
  				  TASK_INTERRUPTIBLE,
  				  msecs_to_jiffies(5000));
-@@ -2150,6 +2159,31 @@ static int btusb_setup_intel_new(struct
+@@ -2152,6 +2161,31 @@ static int btusb_setup_intel_new(struct
  		err = -ETIMEDOUT;
  		goto done;
  	}
@@ -66,7 +66,7 @@
  
  	if (test_bit(BTUSB_FIRMWARE_FAILED, &data->flags)) {
  		BT_ERR("%s: Firmware loading failed", hdev->name);
-@@ -2189,6 +2223,7 @@ done:
+@@ -2191,6 +2225,7 @@ done:
  	 */
  	BT_INFO("%s: Waiting for device to boot", hdev->name);
  
@@ -74,7 +74,7 @@
  	err = wait_on_bit_timeout(&data->flags, BTUSB_BOOTING,
  				  TASK_INTERRUPTIBLE,
  				  msecs_to_jiffies(1000));
-@@ -2202,6 +2237,33 @@ done:
+@@ -2204,6 +2239,33 @@ done:
  		BT_ERR("%s: Device boot timeout", hdev->name);
  		return -ETIMEDOUT;
  	}
diff --git a/patches/collateral-evolutions/network/0062-acpi-gpio-remove/hci_bcm.patch b/patches/collateral-evolutions/network/0062-acpi-gpio-remove/hci_bcm.patch
index df1b165..76e90f0 100644
--- a/patches/collateral-evolutions/network/0062-acpi-gpio-remove/hci_bcm.patch
+++ b/patches/collateral-evolutions/network/0062-acpi-gpio-remove/hci_bcm.patch
@@ -21,27 +21,27 @@
  
  	if (!powered && !IS_ERR(dev->clk) && dev->clk_enabled)
  		clk_disable(dev->clk);
-@@ -347,7 +351,9 @@ static int bcm_suspend(struct device *de
+@@ -352,7 +356,9 @@ static int bcm_suspend(struct device *de
  
  	/* Suspend the device */
  	if (bdev->device_wakeup) {
 +#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,13,0)
  		gpiod_set_value(bdev->device_wakeup, false);
 +#endif
- 		BT_DBG("suspend, delaying 15 ms");
+ 		bt_dev_dbg(bdev, "suspend, delaying 15 ms");
  		mdelay(15);
  	}
-@@ -363,7 +369,9 @@ static int bcm_resume(struct device *dev
- 	BT_DBG("resume (%p): is_suspended %d", bdev, bdev->is_suspended);
+@@ -376,7 +382,9 @@ static int bcm_resume(struct device *dev
+ 		goto unlock;
  
  	if (bdev->device_wakeup) {
 +#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,13,0)
  		gpiod_set_value(bdev->device_wakeup, true);
 +#endif
- 		BT_DBG("resume, delaying 15 ms");
+ 		bt_dev_dbg(bdev, "resume, delaying 15 ms");
  		mdelay(15);
  	}
-@@ -379,6 +387,7 @@ static int bcm_resume(struct device *dev
+@@ -395,6 +403,7 @@ unlock:
  }
  #endif
  
@@ -49,7 +49,7 @@
  static const struct acpi_gpio_params device_wakeup_gpios = { 0, 0, false };
  static const struct acpi_gpio_params shutdown_gpios = { 1, 0, false };
  
-@@ -388,7 +397,6 @@ static const struct acpi_gpio_mapping ac
+@@ -404,7 +413,6 @@ static const struct acpi_gpio_mapping ac
  	{ },
  };
  
@@ -57,7 +57,7 @@
  static int bcm_resource(struct acpi_resource *ares, void *data)
  {
  	struct bcm_device *dev = data;
-@@ -527,7 +535,7 @@ static const struct hci_uart_proto bcm_p
+@@ -543,7 +551,7 @@ static const struct hci_uart_proto bcm_p
  	.dequeue	= bcm_dequeue,
  };
  
@@ -66,7 +66,7 @@
  static const struct acpi_device_id bcm_acpi_match[] = {
  	{ "BCM2E39", 0 },
  	{ "BCM2E67", 0 },
-@@ -544,7 +552,9 @@ static struct platform_driver bcm_driver
+@@ -560,7 +568,9 @@ static struct platform_driver bcm_driver
  	.remove = bcm_remove,
  	.driver = {
  		.name = "hci_bcm",
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe backports" in
