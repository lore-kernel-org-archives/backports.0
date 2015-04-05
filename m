Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:40010 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752626AbbDEWNd (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 5 Apr 2015 18:13:33 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 7/7] patches: refresh on next-20150313
Date: Mon,  6 Apr 2015 00:13:20 +0200
Message-Id: <1428272000-19929-8-git-send-email-hauke@hauke-m.de> (sfid-20150406_001339_257909_601A5048)
In-Reply-To: <1428272000-19929-1-git-send-email-hauke@hauke-m.de>
References: <1428272000-19929-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

1   3.0.101             [  OK  ]
2   3.1.10              [  OK  ]
3   3.2.68              [  OK  ]
4   3.3.8               [  OK  ]
5   3.4.106             [  OK  ]
6   3.5.7               [  OK  ]
7   3.6.11              [  OK  ]
8   3.7.10              [  OK  ]
9   3.8.13              [  OK  ]
10  3.9.11              [  OK  ]
11  3.10.73             [  OK  ]
12  3.11.10             [  OK  ]
13  3.12.39             [  OK  ]
14  3.13.11             [  OK  ]
15  3.14.37             [  OK  ]
16  3.15.10             [  OK  ]
17  3.16.7              [  OK  ]
18  3.17.8              [  OK  ]
19  3.18.10             [  OK  ]
20  3.19.3              [  OK  ]
21  4.0-rc6             [  OK  ]

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../collateral-evolutions/network/0025-usb-sg/usbnet.patch   | 12 ++++++------
 .../network/0027-genl-const/hwsim.patch                      |  2 +-
 .../network/0028-select_queue/mwifiex.patch                  |  2 +-
 .../network/0046-mmc_rescan_entered/mwifiex.patch            |  2 +-
 .../network/0050-iov_iter/bluetooth.patch                    |  4 ++--
 .../network/0053-remove_wait_on_bit_timeout/btusb.patch      | 12 ++++++------
 6 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/patches/collateral-evolutions/network/0025-usb-sg/usbnet.patch b/patches/collateral-evolutions/network/0025-usb-sg/usbnet.patch
index 6d556b9..8616213 100644
--- a/patches/collateral-evolutions/network/0025-usb-sg/usbnet.patch
+++ b/patches/collateral-evolutions/network/0025-usb-sg/usbnet.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/usb/usbnet.c
 +++ b/drivers/net/usb/usbnet.c
-@@ -1251,6 +1251,7 @@ EXPORT_SYMBOL_GPL(usbnet_tx_timeout);
+@@ -1250,6 +1250,7 @@ EXPORT_SYMBOL_GPL(usbnet_tx_timeout);
  
  /*-------------------------------------------------------------------------*/
  
@@ -8,7 +8,7 @@
  static int build_dma_sg(const struct sk_buff *skb, struct urb *urb)
  {
  	unsigned num_sgs, total_len = 0;
-@@ -1283,6 +1284,12 @@ static int build_dma_sg(const struct sk_
+@@ -1282,6 +1283,12 @@ static int build_dma_sg(const struct sk_
  
  	return 1;
  }
@@ -21,7 +21,7 @@
  
  netdev_tx_t usbnet_start_xmit (struct sk_buff *skb,
  				     struct net_device *net)
-@@ -1339,12 +1346,19 @@ netdev_tx_t usbnet_start_xmit (struct sk
+@@ -1338,12 +1345,19 @@ netdev_tx_t usbnet_start_xmit (struct sk
  		if (!(info->flags & FLAG_SEND_ZLP)) {
  			if (!(info->flags & FLAG_MULTI_PACKET)) {
  				length++;
@@ -41,7 +41,7 @@
  			}
  		} else
  			urb->transfer_flags |= URB_ZERO_PACKET;
-@@ -1399,7 +1413,9 @@ not_drop:
+@@ -1400,7 +1414,9 @@ not_drop:
  		if (skb)
  			dev_kfree_skb_any (skb);
  		if (urb) {
@@ -51,7 +51,7 @@
  			usb_free_urb(urb);
  		}
  	} else
-@@ -1452,7 +1468,9 @@ static void usbnet_bh (unsigned long par
+@@ -1453,7 +1469,9 @@ static void usbnet_bh (unsigned long par
  			rx_process (dev, skb);
  			continue;
  		case tx_done:
@@ -61,7 +61,7 @@
  		case rx_cleanup:
  			usb_free_urb (entry->urb);
  			dev_kfree_skb (skb);
-@@ -1808,7 +1826,9 @@ int usbnet_resume (struct usb_interface
+@@ -1809,7 +1827,9 @@ int usbnet_resume (struct usb_interface
  			retval = usb_submit_urb(res, GFP_ATOMIC);
  			if (retval < 0) {
  				dev_kfree_skb_any(skb);
diff --git a/patches/collateral-evolutions/network/0027-genl-const/hwsim.patch b/patches/collateral-evolutions/network/0027-genl-const/hwsim.patch
index 9f87acb..0383c30 100644
--- a/patches/collateral-evolutions/network/0027-genl-const/hwsim.patch
+++ b/patches/collateral-evolutions/network/0027-genl-const/hwsim.patch
@@ -9,7 +9,7 @@
  	[HWSIM_MCGRP_CONFIG] = { .name = "config", },
  };
  
-@@ -2942,7 +2942,7 @@ done:
+@@ -2945,7 +2945,7 @@ done:
  }
  
  /* Generic Netlink operations array */
diff --git a/patches/collateral-evolutions/network/0028-select_queue/mwifiex.patch b/patches/collateral-evolutions/network/0028-select_queue/mwifiex.patch
index 046801c..7026737 100644
--- a/patches/collateral-evolutions/network/0028-select_queue/mwifiex.patch
+++ b/patches/collateral-evolutions/network/0028-select_queue/mwifiex.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/mwifiex/main.c
 +++ b/drivers/net/wireless/mwifiex/main.c
-@@ -920,9 +920,19 @@ static struct net_device_stats *mwifiex_
+@@ -922,9 +922,19 @@ static struct net_device_stats *mwifiex_
  	return &priv->stats;
  }
  
diff --git a/patches/collateral-evolutions/network/0046-mmc_rescan_entered/mwifiex.patch b/patches/collateral-evolutions/network/0046-mmc_rescan_entered/mwifiex.patch
index bfbbb7b..63a295f 100644
--- a/patches/collateral-evolutions/network/0046-mmc_rescan_entered/mwifiex.patch
+++ b/patches/collateral-evolutions/network/0046-mmc_rescan_entered/mwifiex.patch
@@ -1,6 +1,6 @@
 --- a/drivers/net/wireless/mwifiex/sdio.c
 +++ b/drivers/net/wireless/mwifiex/sdio.c
-@@ -1967,7 +1967,9 @@ static void mwifiex_sdio_card_reset_work
+@@ -1968,7 +1968,9 @@ static void mwifiex_sdio_card_reset_work
  	mmc_remove_host(target);
  	/* 200ms delay is based on experiment with sdhci controller */
  	mdelay(200);
diff --git a/patches/collateral-evolutions/network/0050-iov_iter/bluetooth.patch b/patches/collateral-evolutions/network/0050-iov_iter/bluetooth.patch
index 8939638..836a177 100644
--- a/patches/collateral-evolutions/network/0050-iov_iter/bluetooth.patch
+++ b/patches/collateral-evolutions/network/0050-iov_iter/bluetooth.patch
@@ -175,7 +175,7 @@
  
  	l2cap_chan_send(chan, &msg, 1 + len);
  
-@@ -2871,6 +2876,9 @@ static const struct l2cap_ops smp_chan_o
+@@ -2877,6 +2882,9 @@ static const struct l2cap_ops smp_chan_o
  	.suspend		= l2cap_chan_no_suspend,
  	.set_shutdown		= l2cap_chan_no_set_shutdown,
  	.get_sndtimeo		= l2cap_chan_no_get_sndtimeo,
@@ -185,7 +185,7 @@
  };
  
  static inline struct l2cap_chan *smp_new_conn_cb(struct l2cap_chan *pchan)
-@@ -2919,6 +2927,9 @@ static const struct l2cap_ops smp_root_c
+@@ -2925,6 +2933,9 @@ static const struct l2cap_ops smp_root_c
  	.resume			= l2cap_chan_no_resume,
  	.set_shutdown		= l2cap_chan_no_set_shutdown,
  	.get_sndtimeo		= l2cap_chan_no_get_sndtimeo,
diff --git a/patches/collateral-evolutions/network/0053-remove_wait_on_bit_timeout/btusb.patch b/patches/collateral-evolutions/network/0053-remove_wait_on_bit_timeout/btusb.patch
index e4b5b28..0ba2509 100644
--- a/patches/collateral-evolutions/network/0053-remove_wait_on_bit_timeout/btusb.patch
+++ b/patches/collateral-evolutions/network/0053-remove_wait_on_bit_timeout/btusb.patch
@@ -1,6 +1,6 @@
 --- a/drivers/bluetooth/btusb.c
 +++ b/drivers/bluetooth/btusb.c
-@@ -1806,8 +1806,12 @@ static int btusb_recv_event_intel(struct
+@@ -1823,8 +1823,12 @@ static int btusb_recv_event_intel(struct
  			if (test_and_clear_bit(BTUSB_DOWNLOADING,
  					       &data->flags) &&
  			    test_bit(BTUSB_FIRMWARE_LOADED, &data->flags)) {
@@ -13,7 +13,7 @@
  			}
  		}
  
-@@ -1818,8 +1822,12 @@ static int btusb_recv_event_intel(struct
+@@ -1835,8 +1839,12 @@ static int btusb_recv_event_intel(struct
  		if (skb->len == 9 && hdr->evt == 0xff && hdr->plen == 0x07 &&
  		    skb->data[2] == 0x02) {
  			if (test_and_clear_bit(BTUSB_BOOTING, &data->flags)) {
@@ -26,7 +26,7 @@
  			}
  		}
  	}
-@@ -2187,6 +2195,7 @@ static int btusb_setup_intel_new(struct
+@@ -2204,6 +2212,7 @@ static int btusb_setup_intel_new(struct
  	 * and thus just timeout if that happens and fail the setup
  	 * of this device.
  	 */
@@ -34,7 +34,7 @@
  	err = wait_on_bit_timeout(&data->flags, BTUSB_DOWNLOADING,
  				  TASK_INTERRUPTIBLE,
  				  msecs_to_jiffies(5000));
-@@ -2201,6 +2210,31 @@ static int btusb_setup_intel_new(struct
+@@ -2218,6 +2227,31 @@ static int btusb_setup_intel_new(struct
  		err = -ETIMEDOUT;
  		goto done;
  	}
@@ -66,7 +66,7 @@
  
  	if (test_bit(BTUSB_FIRMWARE_FAILED, &data->flags)) {
  		BT_ERR("%s: Firmware loading failed", hdev->name);
-@@ -2240,6 +2274,7 @@ done:
+@@ -2257,6 +2291,7 @@ done:
  	 */
  	BT_INFO("%s: Waiting for device to boot", hdev->name);
  
@@ -74,7 +74,7 @@
  	err = wait_on_bit_timeout(&data->flags, BTUSB_BOOTING,
  				  TASK_INTERRUPTIBLE,
  				  msecs_to_jiffies(1000));
-@@ -2253,6 +2288,33 @@ done:
+@@ -2270,6 +2305,33 @@ done:
  		BT_ERR("%s: Device boot timeout", hdev->name);
  		return -ETIMEDOUT;
  	}
-- 
1.9.1

