Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:52915 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753962AbbKGQzY (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 7 Nov 2015 11:55:24 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 10/10] patches: refresh on next-20151013
Date: Sat,  7 Nov 2015 17:55:10 +0100
Message-Id: <1446915310-8278-11-git-send-email-hauke@hauke-m.de> (sfid-20151107_181408_906012_4A62D816)
In-Reply-To: <1446915310-8278-1-git-send-email-hauke@hauke-m.de>
References: <1446915310-8278-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

1   3.0.101             [  OK  ]
2   3.1.10              [  OK  ]
3   3.2.72              [  OK  ]
4   3.3.8               [  OK  ]
5   3.4.110             [  OK  ]
6   3.5.7               [  OK  ]
7   3.6.11              [  OK  ]
8   3.7.10              [  OK  ]
9   3.8.13              [  OK  ]
10  3.9.11              [  OK  ]
11  3.10.92             [  OK  ]
12  3.11.10             [  OK  ]
13  3.12.49             [  OK  ]
14  3.13.11             [  OK  ]
15  3.14.56             [  OK  ]
16  3.15.10             [  OK  ]
17  3.16.7              [  OK  ]
18  3.17.8              [  OK  ]
19  3.18.23             [  OK  ]
20  3.19.8              [  OK  ]
21  4.0.9               [  OK  ]
22  4.1.12              [  OK  ]
23  4.2.5               [  OK  ]
24  4.3-rc7             [  OK  ]

manual changes done to the following patches:
 * patches/collateral-evolutions/network/0059-uuid-in-mei/nfc.patch
 * patches/collateral-evolutions/network/0013-fix-makefile-includes/brcmfmac.patch
 * patches/collateral-evolutions/network/0062-acpi-gpio-remove/hci_bcm.patch

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../0002-disable-dump-adjust-on-old-kernels.patch  |  4 ++--
 .../include_net_cfg80211.patch                     |  2 +-
 .../net_wireless_core.patch                        |  2 +-
 .../0013-fix-makefile-includes/brcmfmac.patch      | 10 ---------
 .../0014-netlink_seq/net_wireless_nl80211.patch    |  2 +-
 .../0020-tty-termios/net_bluetooth_hci_ldisc.patch | 10 ++++-----
 .../network/0024-led-blink-api/mac80211.patch      |  2 +-
 .../network/0025-usb-sg/usbnet.patch               |  2 +-
 .../network/0028-select_queue/mwifiex.patch        |  2 +-
 .../network/0030-qdisc_tx_busylock/bluetooth.patch |  4 ++--
 .../0032-sriov_configure/igb_sriov_configure.patch |  4 ++--
 .../0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch |  8 ++++----
 .../0043-ndo_set_vf_rate/igb_set_vf_rate.patch     |  4 ++--
 .../network/0047-write_iter/bluetooth.patch        | 10 ++++-----
 .../network/0050-iov_iter/bluetooth.patch          |  8 ++++----
 .../network/0052-deactivate-ptp-pin/igb.patch      |  4 ++--
 .../network/0053-possible_net_t.patch              |  2 +-
 .../0053-remove_wait_on_bit_timeout/btusb.patch    | 12 +++++------
 .../hci_intel.patch                                | 10 ++++-----
 .../network/0055-name_assign_type/brcmfmac.patch   |  2 +-
 .../network/0059-uuid-in-mei/nfc.patch             | 16 +++++++++------
 .../network/0062-acpi-gpio-remove/hci_bcm.patch    | 24 +++++++++++-----------
 .../network/0062-acpi-gpio-remove/hci_intel.patch  | 10 ++++-----
 23 files changed, 74 insertions(+), 80 deletions(-)
 delete mode 100644 patches/collateral-evolutions/network/0013-fix-makefile-includes/brcmfmac.patch

diff --git a/patches/collateral-evolutions/network/0002-disable-dump-adjust-on-old-kernels.patch b/patches/collateral-evolutions/network/0002-disable-dump-adjust-on-old-kernels.patch
index 933f847..7c901a1 100644
--- a/patches/collateral-evolutions/network/0002-disable-dump-adjust-on-old-kernels.patch
+++ b/patches/collateral-evolutions/network/0002-disable-dump-adjust-on-old-kernels.patch
@@ -28,7 +28,7 @@ Date:   Fri Mar 1 14:03:49 2013 +0100
 
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -1803,6 +1803,7 @@ static int nl80211_dump_wiphy(struct sk_
+@@ -1804,6 +1804,7 @@ static int nl80211_dump_wiphy(struct sk_
  						 cb->nlh->nlmsg_seq,
  						 NLM_F_MULTI, state);
  			if (ret < 0) {
@@ -36,7 +36,7 @@ Date:   Fri Mar 1 14:03:49 2013 +0100
  				/*
  				 * If sending the wiphy data didn't fit (ENOBUFS
  				 * or EMSGSIZE returned), this SKB is still
-@@ -1824,6 +1825,7 @@ static int nl80211_dump_wiphy(struct sk_
+@@ -1825,6 +1826,7 @@ static int nl80211_dump_wiphy(struct sk_
  					rtnl_unlock();
  					return 1;
  				}
diff --git a/patches/collateral-evolutions/network/0003-cfg80211-wext-padding/include_net_cfg80211.patch b/patches/collateral-evolutions/network/0003-cfg80211-wext-padding/include_net_cfg80211.patch
index edc4dc4..66d2fae 100644
--- a/patches/collateral-evolutions/network/0003-cfg80211-wext-padding/include_net_cfg80211.patch
+++ b/patches/collateral-evolutions/network/0003-cfg80211-wext-padding/include_net_cfg80211.patch
@@ -1,6 +1,6 @@
 --- a/include/net/cfg80211.h
 +++ b/include/net/cfg80211.h
-@@ -3119,6 +3119,9 @@ struct wiphy_vendor_command {
+@@ -3131,6 +3131,9 @@ struct wiphy_vendor_command {
  struct wiphy {
  	/* assign these fields before you register the wiphy */
  
diff --git a/patches/collateral-evolutions/network/0010-add-wext-handlers-to-netdev/net_wireless_core.patch b/patches/collateral-evolutions/network/0010-add-wext-handlers-to-netdev/net_wireless_core.patch
index 733d16b..e40ff18 100644
--- a/patches/collateral-evolutions/network/0010-add-wext-handlers-to-netdev/net_wireless_core.patch
+++ b/patches/collateral-evolutions/network/0010-add-wext-handlers-to-netdev/net_wireless_core.patch
@@ -11,7 +11,7 @@
  	device_initialize(&rdev->wiphy.dev);
  	rdev->wiphy.dev.class = &ieee80211_class;
  	rdev->wiphy.dev.platform_data = rdev;
-@@ -1022,6 +1018,15 @@ static int cfg80211_netdev_notifier_call
+@@ -1023,6 +1019,15 @@ static int cfg80211_netdev_notifier_call
  		}
  		wdev->netdev = dev;
  #ifdef CONFIG_CFG80211_WEXT
diff --git a/patches/collateral-evolutions/network/0013-fix-makefile-includes/brcmfmac.patch b/patches/collateral-evolutions/network/0013-fix-makefile-includes/brcmfmac.patch
deleted file mode 100644
index 0e0a96c..0000000
--- a/patches/collateral-evolutions/network/0013-fix-makefile-includes/brcmfmac.patch
+++ /dev/null
@@ -1,10 +0,0 @@
---- a/drivers/net/wireless/brcm80211/brcmfmac/sdio.c
-+++ b/drivers/net/wireless/brcm80211/brcmfmac/sdio.c
-@@ -15,6 +15,7 @@
-  */
- 
- #include <linux/types.h>
-+#include <linux/atomic.h>
- #include <linux/kernel.h>
- #include <linux/kthread.h>
- #include <linux/printk.h>
diff --git a/patches/collateral-evolutions/network/0014-netlink_seq/net_wireless_nl80211.patch b/patches/collateral-evolutions/network/0014-netlink_seq/net_wireless_nl80211.patch
index 88a0553..e06d0bf 100644
--- a/patches/collateral-evolutions/network/0014-netlink_seq/net_wireless_nl80211.patch
+++ b/patches/collateral-evolutions/network/0014-netlink_seq/net_wireless_nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -6652,7 +6652,9 @@ static int nl80211_dump_scan(struct sk_b
+@@ -6666,7 +6666,9 @@ static int nl80211_dump_scan(struct sk_b
  	spin_lock_bh(&rdev->bss_lock);
  	cfg80211_bss_expire(rdev);
  
diff --git a/patches/collateral-evolutions/network/0020-tty-termios/net_bluetooth_hci_ldisc.patch b/patches/collateral-evolutions/network/0020-tty-termios/net_bluetooth_hci_ldisc.patch
index eea918a..5434531 100644
--- a/patches/collateral-evolutions/network/0020-tty-termios/net_bluetooth_hci_ldisc.patch
+++ b/patches/collateral-evolutions/network/0020-tty-termios/net_bluetooth_hci_ldisc.patch
@@ -8,7 +8,7 @@
  
  #include <linux/kernel.h>
  #include <linux/init.h>
-@@ -277,7 +278,11 @@ void hci_uart_set_flow_control(struct hc
+@@ -268,7 +269,11 @@ void hci_uart_set_flow_control(struct hc
  
  	if (enable) {
  		/* Disable hardware flow control */
@@ -20,7 +20,7 @@
  		ktermios.c_cflag &= ~CRTSCTS;
  		status = tty_set_termios(tty, &ktermios);
  		BT_DBG("Disabling hardware flow control: %s",
-@@ -311,7 +316,11 @@ void hci_uart_set_flow_control(struct hc
+@@ -302,7 +307,11 @@ void hci_uart_set_flow_control(struct hc
  		BT_DBG("Setting RTS: %s", status ? "failed" : "success");
  
  		/* Re-enable hardware flow control */
@@ -32,7 +32,7 @@
  		ktermios.c_cflag |= CRTSCTS;
  		status = tty_set_termios(tty, &ktermios);
  		BT_DBG("Enabling hardware flow control: %s",
-@@ -332,7 +341,11 @@ void hci_uart_init_tty(struct hci_uart *
+@@ -323,7 +332,11 @@ void hci_uart_init_tty(struct hci_uart *
  	struct ktermios ktermios;
  
  	/* Bring the UART into a known 8 bits no parity hw fc state */
@@ -44,7 +44,7 @@
  	ktermios.c_iflag &= ~(IGNBRK | BRKINT | PARMRK | ISTRIP |
  			      INLCR | IGNCR | ICRNL | IXON);
  	ktermios.c_oflag &= ~OPOST;
-@@ -350,7 +363,11 @@ void hci_uart_set_baudrate(struct hci_ua
+@@ -341,7 +354,11 @@ void hci_uart_set_baudrate(struct hci_ua
  	struct tty_struct *tty = hu->tty;
  	struct ktermios ktermios;
  
@@ -56,7 +56,7 @@
  	ktermios.c_cflag &= ~CBAUD;
  	tty_termios_encode_baud_rate(&ktermios, speed, speed);
  
-@@ -358,7 +375,7 @@ void hci_uart_set_baudrate(struct hci_ua
+@@ -349,7 +366,7 @@ void hci_uart_set_baudrate(struct hci_ua
  	tty_set_termios(tty, &ktermios);
  
  	BT_DBG("%s: New tty speeds: %d/%d", hu->hdev->name,
diff --git a/patches/collateral-evolutions/network/0024-led-blink-api/mac80211.patch b/patches/collateral-evolutions/network/0024-led-blink-api/mac80211.patch
index ea1c1f7..ee28845 100644
--- a/patches/collateral-evolutions/network/0024-led-blink-api/mac80211.patch
+++ b/patches/collateral-evolutions/network/0024-led-blink-api/mac80211.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/ieee80211_i.h
 +++ b/net/mac80211/ieee80211_i.h
-@@ -1256,6 +1256,7 @@ struct ieee80211_local {
+@@ -1250,6 +1250,7 @@ struct ieee80211_local {
  	struct mutex chanctx_mtx;
  
  #ifdef CONFIG_MAC80211_LEDS
diff --git a/patches/collateral-evolutions/network/0025-usb-sg/usbnet.patch b/patches/collateral-evolutions/network/0025-usb-sg/usbnet.patch
index 13e09ea..4e5864b 100644
--- a/patches/collateral-evolutions/network/0025-usb-sg/usbnet.patch
+++ b/patches/collateral-evolutions/network/0025-usb-sg/usbnet.patch
@@ -61,7 +61,7 @@
  		case rx_cleanup:
  			usb_free_urb (entry->urb);
  			dev_kfree_skb (skb);
-@@ -1836,7 +1854,9 @@ int usbnet_resume (struct usb_interface
+@@ -1830,7 +1848,9 @@ int usbnet_resume (struct usb_interface
  			retval = usb_submit_urb(res, GFP_ATOMIC);
  			if (retval < 0) {
  				dev_kfree_skb_any(skb);
diff --git a/patches/collateral-evolutions/network/0028-select_queue/mwifiex.patch b/patches/collateral-evolutions/network/0028-select_queue/mwifiex.patch
index 36a42c6..084771a 100644
--- a/patches/collateral-evolutions/network/0028-select_queue/mwifiex.patch
+++ b/patches/collateral-evolutions/network/0028-select_queue/mwifiex.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/mwifiex/main.c
 +++ b/drivers/net/wireless/mwifiex/main.c
-@@ -1137,9 +1137,19 @@ static struct net_device_stats *mwifiex_
+@@ -1185,9 +1185,19 @@ static struct net_device_stats *mwifiex_
  	return &priv->stats;
  }
  
diff --git a/patches/collateral-evolutions/network/0030-qdisc_tx_busylock/bluetooth.patch b/patches/collateral-evolutions/network/0030-qdisc_tx_busylock/bluetooth.patch
index 5f07dd0..c19d92c 100644
--- a/patches/collateral-evolutions/network/0030-qdisc_tx_busylock/bluetooth.patch
+++ b/patches/collateral-evolutions/network/0030-qdisc_tx_busylock/bluetooth.patch
@@ -1,6 +1,6 @@
 --- a/net/bluetooth/6lowpan.c
 +++ b/net/bluetooth/6lowpan.c
-@@ -646,7 +646,9 @@ static netdev_tx_t bt_xmit(struct sk_buf
+@@ -645,7 +645,9 @@ static netdev_tx_t bt_xmit(struct sk_buf
  	return err < 0 ? NET_XMIT_DROP : err;
  }
  
@@ -10,7 +10,7 @@
  static struct lock_class_key bt_netdev_xmit_lock_key;
  
  static void bt_set_lockdep_class_one(struct net_device *dev,
-@@ -659,7 +661,9 @@ static void bt_set_lockdep_class_one(str
+@@ -658,7 +660,9 @@ static void bt_set_lockdep_class_one(str
  static int bt_dev_init(struct net_device *dev)
  {
  	netdev_for_each_tx_queue(dev, bt_set_lockdep_class_one, NULL);
diff --git a/patches/collateral-evolutions/network/0032-sriov_configure/igb_sriov_configure.patch b/patches/collateral-evolutions/network/0032-sriov_configure/igb_sriov_configure.patch
index f29b66e..457b38c 100644
--- a/patches/collateral-evolutions/network/0032-sriov_configure/igb_sriov_configure.patch
+++ b/patches/collateral-evolutions/network/0032-sriov_configure/igb_sriov_configure.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/ethernet/intel/igb/igb_main.c
 +++ b/drivers/net/ethernet/intel/igb/igb_main.c
-@@ -7526,6 +7526,7 @@ static int igb_sriov_reinit(struct pci_d
+@@ -7530,6 +7530,7 @@ static int igb_sriov_reinit(struct pci_d
  	return 0;
  }
  
@@ -8,7 +8,7 @@
  static int igb_pci_disable_sriov(struct pci_dev *dev)
  {
  	int err = igb_disable_sriov(dev);
-@@ -7535,6 +7536,7 @@ static int igb_pci_disable_sriov(struct
+@@ -7539,6 +7540,7 @@ static int igb_pci_disable_sriov(struct
  
  	return err;
  }
diff --git a/patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch b/patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch
index 0bca051..886c9cb 100644
--- a/patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch
+++ b/patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch
@@ -17,7 +17,7 @@
  static void igb_restore_vlan(struct igb_adapter *);
  static void igb_rar_set_qsel(struct igb_adapter *, u8 *, u32 , u8);
  static void igb_ping_all_vfs(struct igb_adapter *);
-@@ -7188,8 +7196,14 @@ static void igb_vlan_mode(struct net_dev
+@@ -7192,8 +7200,14 @@ static void igb_vlan_mode(struct net_dev
  	igb_rlpml_set(adapter);
  }
  
@@ -32,7 +32,7 @@
  {
  	struct igb_adapter *adapter = netdev_priv(netdev);
  	struct e1000_hw *hw = &adapter->hw;
-@@ -7203,11 +7217,19 @@ static int igb_vlan_rx_add_vid(struct ne
+@@ -7207,11 +7221,19 @@ static int igb_vlan_rx_add_vid(struct ne
  
  	set_bit(vid, adapter->active_vlans);
  
@@ -52,7 +52,7 @@
  {
  	struct igb_adapter *adapter = netdev_priv(netdev);
  	struct e1000_hw *hw = &adapter->hw;
-@@ -7223,7 +7245,9 @@ static int igb_vlan_rx_kill_vid(struct n
+@@ -7227,7 +7249,9 @@ static int igb_vlan_rx_kill_vid(struct n
  
  	clear_bit(vid, adapter->active_vlans);
  
@@ -62,7 +62,7 @@
  }
  
  static void igb_restore_vlan(struct igb_adapter *adapter)
-@@ -7233,7 +7257,11 @@ static void igb_restore_vlan(struct igb_
+@@ -7237,7 +7261,11 @@ static void igb_restore_vlan(struct igb_
  	igb_vlan_mode(adapter->netdev, adapter->netdev->features);
  
  	for_each_set_bit(vid, adapter->active_vlans, VLAN_N_VID)
diff --git a/patches/collateral-evolutions/network/0043-ndo_set_vf_rate/igb_set_vf_rate.patch b/patches/collateral-evolutions/network/0043-ndo_set_vf_rate/igb_set_vf_rate.patch
index 3af7b32..205d094 100644
--- a/patches/collateral-evolutions/network/0043-ndo_set_vf_rate/igb_set_vf_rate.patch
+++ b/patches/collateral-evolutions/network/0043-ndo_set_vf_rate/igb_set_vf_rate.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/ethernet/intel/igb/igb_main.c
 +++ b/drivers/net/ethernet/intel/igb/igb_main.c
-@@ -7854,6 +7854,7 @@ static int igb_ndo_set_vf_bw(struct net_
+@@ -7858,6 +7858,7 @@ static int igb_ndo_set_vf_bw(struct net_
  	if (hw->mac.type != e1000_82576)
  		return -EOPNOTSUPP;
  
@@ -8,7 +8,7 @@
  	if (min_tx_rate)
  		return -EINVAL;
  
-@@ -7867,7 +7868,17 @@ static int igb_ndo_set_vf_bw(struct net_
+@@ -7871,7 +7872,17 @@ static int igb_ndo_set_vf_bw(struct net_
  	adapter->vf_rate_link_speed = actual_link_speed;
  	adapter->vf_data[vf].tx_rate = (u16)max_tx_rate;
  	igb_set_vf_rate_limit(hw, vf, max_tx_rate, actual_link_speed);
diff --git a/patches/collateral-evolutions/network/0047-write_iter/bluetooth.patch b/patches/collateral-evolutions/network/0047-write_iter/bluetooth.patch
index 692b777..aa888d7 100644
--- a/patches/collateral-evolutions/network/0047-write_iter/bluetooth.patch
+++ b/patches/collateral-evolutions/network/0047-write_iter/bluetooth.patch
@@ -1,6 +1,6 @@
 --- a/drivers/bluetooth/hci_vhci.c
 +++ b/drivers/bluetooth/hci_vhci.c
-@@ -159,6 +159,7 @@ static int vhci_create_device(struct vhc
+@@ -151,6 +151,7 @@ static int vhci_create_device(struct vhc
  	return 0;
  }
  
@@ -8,7 +8,7 @@
  static inline ssize_t vhci_get_user(struct vhci_data *data,
  				    struct iov_iter *from)
  {
-@@ -166,6 +167,17 @@ static inline ssize_t vhci_get_user(stru
+@@ -158,6 +159,17 @@ static inline ssize_t vhci_get_user(stru
  	struct sk_buff *skb;
  	__u8 pkt_type, opcode;
  	int ret;
@@ -26,7 +26,7 @@
  
  	if (len < 2 || len > HCI_MAX_FRAME_SIZE)
  		return -EINVAL;
-@@ -174,10 +186,20 @@ static inline ssize_t vhci_get_user(stru
+@@ -166,10 +178,20 @@ static inline ssize_t vhci_get_user(stru
  	if (!skb)
  		return -ENOMEM;
  
@@ -47,7 +47,7 @@
  
  	pkt_type = *((__u8 *) skb->data);
  	skb_pull(skb, 1);
-@@ -289,12 +311,21 @@ static ssize_t vhci_read(struct file *fi
+@@ -281,12 +303,21 @@ static ssize_t vhci_read(struct file *fi
  	return ret;
  }
  
@@ -69,7 +69,7 @@
  }
  
  static unsigned int vhci_poll(struct file *file, poll_table *wait)
-@@ -359,7 +390,11 @@ static int vhci_release(struct inode *in
+@@ -351,7 +382,11 @@ static int vhci_release(struct inode *in
  static const struct file_operations vhci_fops = {
  	.owner		= THIS_MODULE,
  	.read		= vhci_read,
diff --git a/patches/collateral-evolutions/network/0050-iov_iter/bluetooth.patch b/patches/collateral-evolutions/network/0050-iov_iter/bluetooth.patch
index 0a60b78..d17c489 100644
--- a/patches/collateral-evolutions/network/0050-iov_iter/bluetooth.patch
+++ b/patches/collateral-evolutions/network/0050-iov_iter/bluetooth.patch
@@ -49,7 +49,7 @@
  int l2cap_init_sockets(void);
 --- a/net/bluetooth/6lowpan.c
 +++ b/net/bluetooth/6lowpan.c
-@@ -533,11 +533,18 @@ static int send_pkt(struct l2cap_chan *c
+@@ -532,11 +532,18 @@ static int send_pkt(struct l2cap_chan *c
  	 */
  	chan->data = skb;
  
@@ -68,7 +68,7 @@
  
  	err = l2cap_chan_send(chan, &msg, skb->len);
  	if (err > 0) {
-@@ -1056,6 +1063,9 @@ static const struct l2cap_ops bt_6lowpan
+@@ -1036,6 +1043,9 @@ static const struct l2cap_ops bt_6lowpan
  	.suspend		= chan_suspend_cb,
  	.get_sndtimeo		= chan_get_sndtimeo_cb,
  	.alloc_skb		= chan_alloc_skb_cb,
@@ -175,7 +175,7 @@
  
  	l2cap_chan_send(chan, &msg, 1 + len);
  
-@@ -3058,6 +3063,9 @@ static const struct l2cap_ops smp_chan_o
+@@ -3059,6 +3064,9 @@ static const struct l2cap_ops smp_chan_o
  	.suspend		= l2cap_chan_no_suspend,
  	.set_shutdown		= l2cap_chan_no_set_shutdown,
  	.get_sndtimeo		= l2cap_chan_no_get_sndtimeo,
@@ -185,7 +185,7 @@
  };
  
  static inline struct l2cap_chan *smp_new_conn_cb(struct l2cap_chan *pchan)
-@@ -3106,6 +3114,9 @@ static const struct l2cap_ops smp_root_c
+@@ -3107,6 +3115,9 @@ static const struct l2cap_ops smp_root_c
  	.resume			= l2cap_chan_no_resume,
  	.set_shutdown		= l2cap_chan_no_set_shutdown,
  	.get_sndtimeo		= l2cap_chan_no_get_sndtimeo,
diff --git a/patches/collateral-evolutions/network/0052-deactivate-ptp-pin/igb.patch b/patches/collateral-evolutions/network/0052-deactivate-ptp-pin/igb.patch
index ed41932..3596d6c 100644
--- a/patches/collateral-evolutions/network/0052-deactivate-ptp-pin/igb.patch
+++ b/patches/collateral-evolutions/network/0052-deactivate-ptp-pin/igb.patch
@@ -8,8 +8,8 @@
  	struct ptp_pin_desc sdp_config[IGB_N_SDP];
 +#endif
  	struct {
- 		struct timespec start;
- 		struct timespec period;
+ 		struct timespec64 start;
+ 		struct timespec64 period;
 --- a/drivers/net/ethernet/intel/igb/igb_ptp.c
 +++ b/drivers/net/ethernet/intel/igb/igb_ptp.c
 @@ -115,6 +115,7 @@ static cycle_t igb_ptp_read_82580(const
diff --git a/patches/collateral-evolutions/network/0053-possible_net_t.patch b/patches/collateral-evolutions/network/0053-possible_net_t.patch
index aa470f9..a68a172 100644
--- a/patches/collateral-evolutions/network/0053-possible_net_t.patch
+++ b/patches/collateral-evolutions/network/0053-possible_net_t.patch
@@ -2,7 +2,7 @@ diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
 index 04e5785..a251da1 100644
 --- a/include/net/cfg80211.h
 +++ b/include/net/cfg80211.h
-@@ -3242,12 +3242,12 @@ struct wiphy {
+@@ -3254,12 +3254,12 @@ struct wiphy {
  
  static inline struct net *wiphy_net(struct wiphy *wiphy)
  {
diff --git a/patches/collateral-evolutions/network/0053-remove_wait_on_bit_timeout/btusb.patch b/patches/collateral-evolutions/network/0053-remove_wait_on_bit_timeout/btusb.patch
index 7c65bcc..0b297c9 100644
--- a/patches/collateral-evolutions/network/0053-remove_wait_on_bit_timeout/btusb.patch
+++ b/patches/collateral-evolutions/network/0053-remove_wait_on_bit_timeout/btusb.patch
@@ -1,6 +1,6 @@
 --- a/drivers/bluetooth/btusb.c
 +++ b/drivers/bluetooth/btusb.c
-@@ -1778,8 +1778,12 @@ static void btusb_intel_bootup(struct bt
+@@ -1866,8 +1866,12 @@ static void btusb_intel_bootup(struct bt
  		return;
  
  	if (test_and_clear_bit(BTUSB_BOOTING, &data->flags)) {
@@ -13,7 +13,7 @@
  	}
  }
  
-@@ -1796,8 +1800,12 @@ static void btusb_intel_secure_send_resu
+@@ -1884,8 +1888,12 @@ static void btusb_intel_secure_send_resu
  
  	if (test_and_clear_bit(BTUSB_DOWNLOADING, &data->flags) &&
  	    test_bit(BTUSB_FIRMWARE_LOADED, &data->flags)) {
@@ -26,7 +26,7 @@
  	}
  }
  
-@@ -2152,6 +2160,7 @@ static int btusb_setup_intel_new(struct
+@@ -2237,6 +2245,7 @@ static int btusb_setup_intel_new(struct
  	 * and thus just timeout if that happens and fail the setup
  	 * of this device.
  	 */
@@ -34,7 +34,7 @@
  	err = wait_on_bit_timeout(&data->flags, BTUSB_DOWNLOADING,
  				  TASK_INTERRUPTIBLE,
  				  msecs_to_jiffies(5000));
-@@ -2166,6 +2175,31 @@ static int btusb_setup_intel_new(struct
+@@ -2251,6 +2260,31 @@ static int btusb_setup_intel_new(struct
  		err = -ETIMEDOUT;
  		goto done;
  	}
@@ -66,7 +66,7 @@
  
  	if (test_bit(BTUSB_FIRMWARE_FAILED, &data->flags)) {
  		BT_ERR("%s: Firmware loading failed", hdev->name);
-@@ -2205,6 +2239,7 @@ done:
+@@ -2290,6 +2324,7 @@ done:
  	 */
  	BT_INFO("%s: Waiting for device to boot", hdev->name);
  
@@ -74,7 +74,7 @@
  	err = wait_on_bit_timeout(&data->flags, BTUSB_BOOTING,
  				  TASK_INTERRUPTIBLE,
  				  msecs_to_jiffies(1000));
-@@ -2218,6 +2253,33 @@ done:
+@@ -2303,6 +2338,33 @@ done:
  		BT_ERR("%s: Device boot timeout", hdev->name);
  		return -ETIMEDOUT;
  	}
diff --git a/patches/collateral-evolutions/network/0053-remove_wait_on_bit_timeout/hci_intel.patch b/patches/collateral-evolutions/network/0053-remove_wait_on_bit_timeout/hci_intel.patch
index 1faf5ab..1e9a573 100644
--- a/patches/collateral-evolutions/network/0053-remove_wait_on_bit_timeout/hci_intel.patch
+++ b/patches/collateral-evolutions/network/0053-remove_wait_on_bit_timeout/hci_intel.patch
@@ -86,7 +86,7 @@
  
  	return err;
  }
-@@ -835,6 +887,7 @@ static int intel_setup(struct hci_uart *
+@@ -836,6 +888,7 @@ static int intel_setup(struct hci_uart *
  	 * and thus just timeout if that happens and fail the setup
  	 * of this device.
  	 */
@@ -94,7 +94,7 @@
  	err = wait_on_bit_timeout(&intel->flags, STATE_DOWNLOADING,
  				  TASK_INTERRUPTIBLE,
  				  msecs_to_jiffies(5000));
-@@ -849,6 +902,33 @@ static int intel_setup(struct hci_uart *
+@@ -850,6 +903,33 @@ static int intel_setup(struct hci_uart *
  		err = -ETIMEDOUT;
  		goto done;
  	}
@@ -128,7 +128,7 @@
  
  	if (test_bit(STATE_FIRMWARE_FAILED, &intel->flags)) {
  		bt_dev_err(hdev, "Firmware loading failed");
-@@ -980,8 +1060,12 @@ static int intel_recv_event(struct hci_d
+@@ -981,8 +1061,12 @@ static int intel_recv_event(struct hci_d
  
  		if (test_and_clear_bit(STATE_DOWNLOADING, &intel->flags) &&
  		    test_bit(STATE_FIRMWARE_LOADED, &intel->flags)) {
@@ -141,7 +141,7 @@
  		}
  
  	/* When switching to the operational firmware the device
-@@ -991,8 +1075,12 @@ static int intel_recv_event(struct hci_d
+@@ -992,8 +1076,12 @@ static int intel_recv_event(struct hci_d
  	} else if (skb->len == 9 && hdr->evt == 0xff && hdr->plen == 0x07 &&
  		   skb->data[2] == 0x02) {
  		if (test_and_clear_bit(STATE_BOOTING, &intel->flags)) {
@@ -154,7 +154,7 @@
  		}
  	}
  recv:
-@@ -1031,15 +1119,23 @@ static int intel_recv_lpm(struct hci_dev
+@@ -1032,15 +1120,23 @@ static int intel_recv_lpm(struct hci_dev
  	case LPM_OP_SUSPEND_ACK:
  		set_bit(STATE_SUSPENDED, &intel->flags);
  		if (test_and_clear_bit(STATE_LPM_TRANSACTION, &intel->flags)) {
diff --git a/patches/collateral-evolutions/network/0055-name_assign_type/brcmfmac.patch b/patches/collateral-evolutions/network/0055-name_assign_type/brcmfmac.patch
index 276ba1b..c68e9d0 100644
--- a/patches/collateral-evolutions/network/0055-name_assign_type/brcmfmac.patch
+++ b/patches/collateral-evolutions/network/0055-name_assign_type/brcmfmac.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/brcm80211/brcmfmac/p2p.c
 +++ b/drivers/net/wireless/brcm80211/brcmfmac/p2p.c
-@@ -2215,7 +2215,9 @@ struct wireless_dev *brcmf_p2p_add_vif(s
+@@ -2204,7 +2204,9 @@ struct wireless_dev *brcmf_p2p_add_vif(s
  	}
  
  	strncpy(ifp->ndev->name, name, sizeof(ifp->ndev->name) - 1);
diff --git a/patches/collateral-evolutions/network/0059-uuid-in-mei/nfc.patch b/patches/collateral-evolutions/network/0059-uuid-in-mei/nfc.patch
index 69e20e2..903cac3 100644
--- a/patches/collateral-evolutions/network/0059-uuid-in-mei/nfc.patch
+++ b/patches/collateral-evolutions/network/0059-uuid-in-mei/nfc.patch
@@ -1,11 +1,13 @@
 --- a/drivers/nfc/microread/mei.c
 +++ b/drivers/nfc/microread/mei.c
-@@ -67,7 +67,11 @@ static int microread_mei_remove(struct m
+@@ -67,7 +67,13 @@ static int microread_mei_remove(struct m
  }
  
  static struct mei_cl_device_id microread_mei_tbl[] = {
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,2,0)
- 	{ MICROREAD_DRIVER_NAME, MEI_NFC_UUID},
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,4,0)
+ 	{ MICROREAD_DRIVER_NAME, MEI_NFC_UUID, MEI_CL_VERSION_ANY},
++#elif LINUX_VERSION_CODE >= KERNEL_VERSION(4,2,0)
++	{ MICROREAD_DRIVER_NAME, MEI_NFC_UUID},
 +#else
 +	{ MICROREAD_DRIVER_NAME},
 +#endif
@@ -14,12 +16,14 @@
  	{ }
 --- a/drivers/nfc/pn544/mei.c
 +++ b/drivers/nfc/pn544/mei.c
-@@ -67,7 +67,11 @@ static int pn544_mei_remove(struct mei_c
+@@ -67,7 +67,13 @@ static int pn544_mei_remove(struct mei_c
  }
  
  static struct mei_cl_device_id pn544_mei_tbl[] = {
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,2,0)
- 	{ PN544_DRIVER_NAME, MEI_NFC_UUID},
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,4,0)
+ 	{ PN544_DRIVER_NAME, MEI_NFC_UUID, MEI_CL_VERSION_ANY},
++#elif LINUX_VERSION_CODE >= KERNEL_VERSION(4,2,0)
++	{ PN544_DRIVER_NAME, MEI_NFC_UUID},
 +#else
 +	{ PN544_DRIVER_NAME},
 +#endif
diff --git a/patches/collateral-evolutions/network/0062-acpi-gpio-remove/hci_bcm.patch b/patches/collateral-evolutions/network/0062-acpi-gpio-remove/hci_bcm.patch
index 9e77bb0..1738b9f 100644
--- a/patches/collateral-evolutions/network/0062-acpi-gpio-remove/hci_bcm.patch
+++ b/patches/collateral-evolutions/network/0062-acpi-gpio-remove/hci_bcm.patch
@@ -9,8 +9,8 @@
 +#endif
  #include <linux/tty.h>
  #include <linux/interrupt.h>
- 
-@@ -141,8 +143,10 @@ static int bcm_gpio_set_power(struct bcm
+ #include <linux/dmi.h>
+@@ -148,8 +150,10 @@ static int bcm_gpio_set_power(struct bcm
  	if (powered && !IS_ERR(dev->clk) && !dev->clk_enabled)
  		clk_enable(dev->clk);
  
@@ -21,7 +21,7 @@
  
  	if (!powered && !IS_ERR(dev->clk) && dev->clk_enabled)
  		clk_disable(dev->clk);
-@@ -447,7 +451,9 @@ static int bcm_suspend(struct device *de
+@@ -520,7 +524,9 @@ static int bcm_suspend_device(struct dev
  
  	/* Suspend the device */
  	if (bdev->device_wakeup) {
@@ -31,8 +31,8 @@
  		bt_dev_dbg(bdev, "suspend, delaying 15 ms");
  		mdelay(15);
  	}
-@@ -482,7 +488,9 @@ static int bcm_resume(struct device *dev
- 	}
+@@ -535,7 +541,9 @@ static int bcm_resume_device(struct devi
+ 	bt_dev_dbg(bdev, "");
  
  	if (bdev->device_wakeup) {
 +#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,13,0)
@@ -41,7 +41,7 @@
  		bt_dev_dbg(bdev, "resume, delaying 15 ms");
  		mdelay(15);
  	}
-@@ -501,6 +509,7 @@ unlock:
+@@ -618,6 +626,7 @@ unlock:
  }
  #endif
  
@@ -49,15 +49,15 @@
  static const struct acpi_gpio_params device_wakeup_gpios = { 0, 0, false };
  static const struct acpi_gpio_params shutdown_gpios = { 1, 0, false };
  static const struct acpi_gpio_params host_wakeup_gpios = { 2, 0, false };
-@@ -512,7 +521,6 @@ static const struct acpi_gpio_mapping ac
+@@ -629,7 +638,6 @@ static const struct acpi_gpio_mapping ac
  	{ },
  };
  
 -#ifdef CONFIG_ACPI
- static int bcm_resource(struct acpi_resource *ares, void *data)
- {
- 	struct bcm_device *dev = data;
-@@ -683,7 +691,7 @@ static const struct hci_uart_proto bcm_p
+ static u8 acpi_active_low = ACPI_ACTIVE_LOW;
+ 
+ /* IRQ polarity of some chipsets are not defined correctly in ACPI table. */
+@@ -811,7 +819,7 @@ static const struct hci_uart_proto bcm_p
  	.dequeue	= bcm_dequeue,
  };
  
@@ -66,7 +66,7 @@
  static const struct acpi_device_id bcm_acpi_match[] = {
  	{ "BCM2E39", 0 },
  	{ "BCM2E67", 0 },
-@@ -700,7 +708,9 @@ static struct platform_driver bcm_driver
+@@ -831,7 +839,9 @@ static struct platform_driver bcm_driver
  	.remove = bcm_remove,
  	.driver = {
  		.name = "hci_bcm",
diff --git a/patches/collateral-evolutions/network/0062-acpi-gpio-remove/hci_intel.patch b/patches/collateral-evolutions/network/0062-acpi-gpio-remove/hci_intel.patch
index 971bffb..0e1bea0 100644
--- a/patches/collateral-evolutions/network/0062-acpi-gpio-remove/hci_intel.patch
+++ b/patches/collateral-evolutions/network/0062-acpi-gpio-remove/hci_intel.patch
@@ -20,9 +20,9 @@
  
  		/* Provide to idev a hu reference which is used to run LPM
  		 * transactions (lpm suspend/resume) from PM callbacks.
-@@ -1352,14 +1356,17 @@ static int intel_probe(struct platform_d
- 		return -ENODEV;
- 	}
+@@ -1329,14 +1333,17 @@ static int intel_probe(struct platform_d
+ 
+ 	idev->pdev = pdev;
  
 +#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,17,0)
  	idev->reset = devm_gpiod_get_optional(&pdev->dev, "reset",
@@ -38,7 +38,7 @@
  	if (idev->irq < 0) {
  		struct gpio_desc *host_wake;
  
-@@ -1378,12 +1385,15 @@ static int intel_probe(struct platform_d
+@@ -1355,12 +1362,15 @@ static int intel_probe(struct platform_d
  			goto no_irq;
  		}
  	}
@@ -54,7 +54,7 @@
  	platform_set_drvdata(pdev, idev);
  
  	/* Place this instance on the device list */
-@@ -1391,8 +1401,10 @@ no_irq:
+@@ -1368,8 +1378,10 @@ no_irq:
  	list_add_tail(&idev->list, &intel_device_list);
  	mutex_unlock(&intel_device_list_lock);
  
-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
