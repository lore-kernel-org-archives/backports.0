Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:49597 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752323AbcD3VBJ (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 30 Apr 2016 17:01:09 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 16/16] patches: refresh on next-20160216
Date: Sat, 30 Apr 2016 23:00:48 +0200
Message-Id: <1462050048-8953-17-git-send-email-hauke@hauke-m.de> (sfid-20160430_230722_201860_A2583920)
In-Reply-To: <1462050048-8953-1-git-send-email-hauke@hauke-m.de>
References: <1462050048-8953-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

1   3.0.101             [  OK  ]
2   3.1.10              [  OK  ]
3   3.2.79              [  OK  ]
4   3.3.8               [  OK  ]
5   3.4.112             [  OK  ]
6   3.5.7               [  OK  ]
7   3.6.11              [  OK  ]
8   3.7.10              [  OK  ]
9   3.8.13              [  OK  ]
10  3.9.11              [  OK  ]
11  3.10.101            [  OK  ]
12  3.11.10             [  OK  ]
13  3.12.59             [  OK  ]
14  3.13.11             [  OK  ]
15  3.14.67             [  OK  ]
16  3.15.10             [  OK  ]
17  3.16.7              [  OK  ]
18  3.17.8              [  OK  ]
19  3.18.32             [  OK  ]
20  4.1.23              [  OK  ]
21  4.3.6               [  OK  ]
22  4.4.8               [  OK  ]
23  4.5.2               [  OK  ]
24  4.6-rc5             [  FAIL  ]

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../media/0001-dma_mmap_coherent-revert.patch          |  4 ++--
 .../0002-disable-dump-adjust-on-old-kernels.patch      |  4 ++--
 .../include_net_cfg80211.patch                         |  2 +-
 .../0014-netlink_seq/net_wireless_nl80211.patch        |  2 +-
 .../drivers_net_wireless_libertas_if_usb.patch         |  4 ++--
 .../network/0024-led-blink-api/mac80211.patch          |  2 +-
 .../network/0028-select_queue/mac80211.patch           |  4 ++--
 .../network/0028-select_queue/mwifiex.patch            |  2 +-
 .../network/0030-qdisc_tx_busylock/bluetooth.patch     |  4 ++--
 .../network/0050-iov_iter/bluetooth.patch              | 18 +++++++++---------
 .../network/0053-possible_net_t.patch                  |  2 +-
 .../network/0061-termios_rwsem/nfc.patch               |  2 +-
 12 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/patches/collateral-evolutions/media/0001-dma_mmap_coherent-revert.patch b/patches/collateral-evolutions/media/0001-dma_mmap_coherent-revert.patch
index b15c922..352a542 100644
--- a/patches/collateral-evolutions/media/0001-dma_mmap_coherent-revert.patch
+++ b/patches/collateral-evolutions/media/0001-dma_mmap_coherent-revert.patch
@@ -25,7 +25,7 @@ Date:   Thu Jun 14 11:32:21 2012 -0300
 
 --- a/drivers/media/v4l2-core/videobuf2-dma-contig.c
 +++ b/drivers/media/v4l2-core/videobuf2-dma-contig.c
-@@ -169,6 +169,52 @@ static void *vb2_dc_alloc(void *alloc_ct
+@@ -177,6 +177,52 @@ static void *vb2_dc_alloc(void *alloc_ct
  	return buf;
  }
  
@@ -78,7 +78,7 @@ Date:   Thu Jun 14 11:32:21 2012 -0300
  static int vb2_dc_mmap(void *buf_priv, struct vm_area_struct *vma)
  {
  	struct vb2_dc_buf *buf = buf_priv;
-@@ -205,6 +251,7 @@ static int vb2_dc_mmap(void *buf_priv, s
+@@ -213,6 +259,7 @@ static int vb2_dc_mmap(void *buf_priv, s
  
  	return 0;
  }
diff --git a/patches/collateral-evolutions/network/0002-disable-dump-adjust-on-old-kernels.patch b/patches/collateral-evolutions/network/0002-disable-dump-adjust-on-old-kernels.patch
index bb8565f..c5332f5 100644
--- a/patches/collateral-evolutions/network/0002-disable-dump-adjust-on-old-kernels.patch
+++ b/patches/collateral-evolutions/network/0002-disable-dump-adjust-on-old-kernels.patch
@@ -28,7 +28,7 @@ Date:   Fri Mar 1 14:03:49 2013 +0100
 
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -1816,6 +1816,7 @@ static int nl80211_dump_wiphy(struct sk_
+@@ -1817,6 +1817,7 @@ static int nl80211_dump_wiphy(struct sk_
  						 cb->nlh->nlmsg_seq,
  						 NLM_F_MULTI, state);
  			if (ret < 0) {
@@ -36,7 +36,7 @@ Date:   Fri Mar 1 14:03:49 2013 +0100
  				/*
  				 * If sending the wiphy data didn't fit (ENOBUFS
  				 * or EMSGSIZE returned), this SKB is still
-@@ -1837,6 +1838,7 @@ static int nl80211_dump_wiphy(struct sk_
+@@ -1838,6 +1839,7 @@ static int nl80211_dump_wiphy(struct sk_
  					rtnl_unlock();
  					return 1;
  				}
diff --git a/patches/collateral-evolutions/network/0003-cfg80211-wext-padding/include_net_cfg80211.patch b/patches/collateral-evolutions/network/0003-cfg80211-wext-padding/include_net_cfg80211.patch
index 5bc2906..959ad9e 100644
--- a/patches/collateral-evolutions/network/0003-cfg80211-wext-padding/include_net_cfg80211.patch
+++ b/patches/collateral-evolutions/network/0003-cfg80211-wext-padding/include_net_cfg80211.patch
@@ -1,6 +1,6 @@
 --- a/include/net/cfg80211.h
 +++ b/include/net/cfg80211.h
-@@ -3182,6 +3182,9 @@ struct wiphy_vendor_command {
+@@ -3188,6 +3188,9 @@ struct wiphy_vendor_command {
  struct wiphy {
  	/* assign these fields before you register the wiphy */
  
diff --git a/patches/collateral-evolutions/network/0014-netlink_seq/net_wireless_nl80211.patch b/patches/collateral-evolutions/network/0014-netlink_seq/net_wireless_nl80211.patch
index f86b06a..362c26c 100644
--- a/patches/collateral-evolutions/network/0014-netlink_seq/net_wireless_nl80211.patch
+++ b/patches/collateral-evolutions/network/0014-netlink_seq/net_wireless_nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -6848,7 +6848,9 @@ static int nl80211_dump_scan(struct sk_b
+@@ -6853,7 +6853,9 @@ static int nl80211_dump_scan(struct sk_b
  	spin_lock_bh(&rdev->bss_lock);
  	cfg80211_bss_expire(rdev);
  
diff --git a/patches/collateral-evolutions/network/0016-libertas-olpc-ec-wakeup/drivers_net_wireless_libertas_if_usb.patch b/patches/collateral-evolutions/network/0016-libertas-olpc-ec-wakeup/drivers_net_wireless_libertas_if_usb.patch
index e197d42..10f5943 100644
--- a/patches/collateral-evolutions/network/0016-libertas-olpc-ec-wakeup/drivers_net_wireless_libertas_if_usb.patch
+++ b/patches/collateral-evolutions/network/0016-libertas-olpc-ec-wakeup/drivers_net_wireless_libertas_if_usb.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/marvell/libertas/if_usb.c
 +++ b/drivers/net/wireless/marvell/libertas/if_usb.c
-@@ -959,6 +959,7 @@ static int if_usb_suspend(struct usb_int
+@@ -960,6 +960,7 @@ static int if_usb_suspend(struct usb_int
  		goto out;
  	}
  
@@ -8,7 +8,7 @@
  #ifdef CONFIG_OLPC
  	if (machine_is_olpc()) {
  		if (priv->wol_criteria == EHS_REMOVE_WAKEUP)
-@@ -967,6 +968,7 @@ static int if_usb_suspend(struct usb_int
+@@ -968,6 +969,7 @@ static int if_usb_suspend(struct usb_int
  			olpc_ec_wakeup_set(EC_SCI_SRC_WLAN);
  	}
  #endif
diff --git a/patches/collateral-evolutions/network/0024-led-blink-api/mac80211.patch b/patches/collateral-evolutions/network/0024-led-blink-api/mac80211.patch
index 9b61411..e7b9b84 100644
--- a/patches/collateral-evolutions/network/0024-led-blink-api/mac80211.patch
+++ b/patches/collateral-evolutions/network/0024-led-blink-api/mac80211.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/ieee80211_i.h
 +++ b/net/mac80211/ieee80211_i.h
-@@ -1251,6 +1251,7 @@ struct ieee80211_local {
+@@ -1252,6 +1252,7 @@ struct ieee80211_local {
  	struct mutex chanctx_mtx;
  
  #ifdef CONFIG_MAC80211_LEDS
diff --git a/patches/collateral-evolutions/network/0028-select_queue/mac80211.patch b/patches/collateral-evolutions/network/0028-select_queue/mac80211.patch
index d78d2cc..39a9d4a 100644
--- a/patches/collateral-evolutions/network/0028-select_queue/mac80211.patch
+++ b/patches/collateral-evolutions/network/0028-select_queue/mac80211.patch
@@ -1,6 +1,6 @@
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -1097,10 +1097,20 @@ static void ieee80211_uninit(struct net_
+@@ -1101,10 +1101,20 @@ static void ieee80211_uninit(struct net_
  	ieee80211_teardown_sdata(IEEE80211_DEV_TO_SUB_IF(dev));
  }
  
@@ -21,7 +21,7 @@
  {
  	return ieee80211_select_queue(IEEE80211_DEV_TO_SUB_IF(dev), skb);
  }
-@@ -1146,10 +1156,20 @@ static const struct net_device_ops ieee8
+@@ -1150,10 +1160,20 @@ static const struct net_device_ops ieee8
  	.ndo_get_stats64	= ieee80211_get_stats64,
  };
  
diff --git a/patches/collateral-evolutions/network/0028-select_queue/mwifiex.patch b/patches/collateral-evolutions/network/0028-select_queue/mwifiex.patch
index 5376d33..61a091b 100644
--- a/patches/collateral-evolutions/network/0028-select_queue/mwifiex.patch
+++ b/patches/collateral-evolutions/network/0028-select_queue/mwifiex.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/marvell/mwifiex/main.c
 +++ b/drivers/net/wireless/marvell/mwifiex/main.c
-@@ -1185,9 +1185,19 @@ static struct net_device_stats *mwifiex_
+@@ -1199,9 +1199,19 @@ static struct net_device_stats *mwifiex_
  	return &priv->stats;
  }
  
diff --git a/patches/collateral-evolutions/network/0030-qdisc_tx_busylock/bluetooth.patch b/patches/collateral-evolutions/network/0030-qdisc_tx_busylock/bluetooth.patch
index 6778681..0b88b61 100644
--- a/patches/collateral-evolutions/network/0030-qdisc_tx_busylock/bluetooth.patch
+++ b/patches/collateral-evolutions/network/0030-qdisc_tx_busylock/bluetooth.patch
@@ -1,6 +1,6 @@
 --- a/net/bluetooth/6lowpan.c
 +++ b/net/bluetooth/6lowpan.c
-@@ -623,7 +623,9 @@ static netdev_tx_t bt_xmit(struct sk_buf
+@@ -628,7 +628,9 @@ static netdev_tx_t bt_xmit(struct sk_buf
  	return err < 0 ? NET_XMIT_DROP : err;
  }
  
@@ -10,7 +10,7 @@
  static struct lock_class_key bt_netdev_xmit_lock_key;
  
  static void bt_set_lockdep_class_one(struct net_device *dev,
-@@ -636,7 +638,9 @@ static void bt_set_lockdep_class_one(str
+@@ -641,7 +643,9 @@ static void bt_set_lockdep_class_one(str
  static int bt_dev_init(struct net_device *dev)
  {
  	netdev_for_each_tx_queue(dev, bt_set_lockdep_class_one, NULL);
diff --git a/patches/collateral-evolutions/network/0050-iov_iter/bluetooth.patch b/patches/collateral-evolutions/network/0050-iov_iter/bluetooth.patch
index 4ff6f7f..ef5bd6a 100644
--- a/patches/collateral-evolutions/network/0050-iov_iter/bluetooth.patch
+++ b/patches/collateral-evolutions/network/0050-iov_iter/bluetooth.patch
@@ -1,6 +1,6 @@
 --- a/include/net/bluetooth/l2cap.h
 +++ b/include/net/bluetooth/l2cap.h
-@@ -613,6 +613,12 @@ struct l2cap_ops {
+@@ -619,6 +619,12 @@ struct l2cap_ops {
  	struct sk_buff		*(*alloc_skb) (struct l2cap_chan *chan,
  					       unsigned long hdr_len,
  					       unsigned long len, int nb);
@@ -13,7 +13,7 @@
  };
  
  struct l2cap_conn {
-@@ -906,6 +912,33 @@ static inline long l2cap_chan_no_get_snd
+@@ -912,6 +918,33 @@ static inline long l2cap_chan_no_get_snd
  	return 0;
  }
  
@@ -49,7 +49,7 @@
  int l2cap_init_sockets(void);
 --- a/net/bluetooth/6lowpan.c
 +++ b/net/bluetooth/6lowpan.c
-@@ -510,11 +510,18 @@ static int send_pkt(struct l2cap_chan *c
+@@ -515,11 +515,18 @@ static int send_pkt(struct l2cap_chan *c
  	 */
  	chan->data = skb;
  
@@ -68,7 +68,7 @@
  
  	err = l2cap_chan_send(chan, &msg, skb->len);
  	if (err > 0) {
-@@ -1012,6 +1019,9 @@ static const struct l2cap_ops bt_6lowpan
+@@ -1017,6 +1024,9 @@ static const struct l2cap_ops bt_6lowpan
  	.suspend		= chan_suspend_cb,
  	.get_sndtimeo		= chan_get_sndtimeo_cb,
  	.alloc_skb		= chan_alloc_skb_cb,
@@ -105,7 +105,7 @@
  static struct l2cap_chan *a2mp_chan_open(struct l2cap_conn *conn, bool locked)
 --- a/net/bluetooth/l2cap_core.c
 +++ b/net/bluetooth/l2cap_core.c
-@@ -2116,7 +2116,12 @@ static inline int l2cap_skbuff_fromiovec
+@@ -2126,7 +2126,12 @@ static inline int l2cap_skbuff_fromiovec
  	struct sk_buff **frag;
  	int sent = 0;
  
@@ -118,7 +118,7 @@
  		return -EFAULT;
  
  	sent += count;
-@@ -2136,8 +2141,13 @@ static inline int l2cap_skbuff_fromiovec
+@@ -2146,8 +2151,13 @@ static inline int l2cap_skbuff_fromiovec
  
  		*frag = tmp;
  
@@ -162,7 +162,7 @@
  static void l2cap_sock_destruct(struct sock *sk)
 --- a/net/bluetooth/smp.c
 +++ b/net/bluetooth/smp.c
-@@ -619,7 +619,12 @@ static void smp_send_cmd(struct l2cap_co
+@@ -612,7 +612,12 @@ static void smp_send_cmd(struct l2cap_co
  
  	memset(&msg, 0, sizeof(msg));
  
@@ -175,7 +175,7 @@
  
  	l2cap_chan_send(chan, &msg, 1 + len);
  
-@@ -3089,6 +3094,9 @@ static const struct l2cap_ops smp_chan_o
+@@ -3066,6 +3071,9 @@ static const struct l2cap_ops smp_chan_o
  	.suspend		= l2cap_chan_no_suspend,
  	.set_shutdown		= l2cap_chan_no_set_shutdown,
  	.get_sndtimeo		= l2cap_chan_no_get_sndtimeo,
@@ -185,7 +185,7 @@
  };
  
  static inline struct l2cap_chan *smp_new_conn_cb(struct l2cap_chan *pchan)
-@@ -3137,6 +3145,9 @@ static const struct l2cap_ops smp_root_c
+@@ -3114,6 +3122,9 @@ static const struct l2cap_ops smp_root_c
  	.resume			= l2cap_chan_no_resume,
  	.set_shutdown		= l2cap_chan_no_set_shutdown,
  	.get_sndtimeo		= l2cap_chan_no_get_sndtimeo,
diff --git a/patches/collateral-evolutions/network/0053-possible_net_t.patch b/patches/collateral-evolutions/network/0053-possible_net_t.patch
index 6549e43..f70dd80 100644
--- a/patches/collateral-evolutions/network/0053-possible_net_t.patch
+++ b/patches/collateral-evolutions/network/0053-possible_net_t.patch
@@ -2,7 +2,7 @@ diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
 index 04e5785..a251da1 100644
 --- a/include/net/cfg80211.h
 +++ b/include/net/cfg80211.h
-@@ -3308,12 +3308,12 @@ struct wiphy {
+@@ -3314,12 +3314,12 @@ struct wiphy {
  
  static inline struct net *wiphy_net(struct wiphy *wiphy)
  {
diff --git a/patches/collateral-evolutions/network/0061-termios_rwsem/nfc.patch b/patches/collateral-evolutions/network/0061-termios_rwsem/nfc.patch
index 4829bee..7371415 100644
--- a/patches/collateral-evolutions/network/0061-termios_rwsem/nfc.patch
+++ b/patches/collateral-evolutions/network/0061-termios_rwsem/nfc.patch
@@ -1,6 +1,6 @@
 --- a/net/nfc/nci/uart.c
 +++ b/net/nfc/nci/uart.c
-@@ -446,9 +446,17 @@ void nci_uart_set_config(struct nci_uart
+@@ -439,9 +439,17 @@ void nci_uart_set_config(struct nci_uart
  	if (!nu->tty)
  		return;
  
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
