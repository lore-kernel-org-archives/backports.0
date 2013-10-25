Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:46020 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752312Ab3JYV6k (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 25 Oct 2013 17:58:40 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 2/4] backports: fix usb-sg for usbnet
Date: Fri, 25 Oct 2013 23:58:25 +0200
Message-Id: <1382738307-16123-3-git-send-email-hauke@hauke-m.de> (sfid-20131025_235841_716895_E6F82578)
In-Reply-To: <1382738307-16123-1-git-send-email-hauke@hauke-m.de>
References: <1382738307-16123-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This adapts the changes from:
commit 60e453a940ac678565b6641d65f8c18541bb9f28
Author: Ming Lei <ming.lei@canonical.com>
Date:   Mon Sep 23 20:59:35 2013 +0800

    USBNET: fix handling padding packet

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../network/78-usb-sg/usbnet.patch                 |   28 +++++++++++++++++---
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/patches/collateral-evolutions/network/78-usb-sg/usbnet.patch b/patches/collateral-evolutions/network/78-usb-sg/usbnet.patch
index 07d9d96..afea0cb 100644
--- a/patches/collateral-evolutions/network/78-usb-sg/usbnet.patch
+++ b/patches/collateral-evolutions/network/78-usb-sg/usbnet.patch
@@ -8,7 +8,7 @@
  static int build_dma_sg(const struct sk_buff *skb, struct urb *urb)
  {
  	unsigned num_sgs, total_len = 0;
-@@ -1264,6 +1265,12 @@ static int build_dma_sg(const struct sk_
+@@ -1266,6 +1267,12 @@ static int build_dma_sg(const struct sk_
  
  	return 1;
  }
@@ -21,7 +21,27 @@
  
  netdev_tx_t usbnet_start_xmit (struct sk_buff *skb,
  				     struct net_device *net)
-@@ -1377,7 +1384,9 @@ not_drop:
+@@ -1322,12 +1329,19 @@ netdev_tx_t usbnet_start_xmit (struct sk
+ 		if (!(info->flags & FLAG_SEND_ZLP)) {
+ 			if (!(info->flags & FLAG_MULTI_PACKET)) {
+ 				length++;
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,35,0)
+ 				if (skb_tailroom(skb) && !urb->num_sgs) {
+ 					skb->data[skb->len] = 0;
+ 					__skb_put(skb, 1);
+ 				} else if (urb->num_sgs)
+ 					sg_set_buf(&urb->sg[urb->num_sgs++],
+ 							dev->padding_pkt, 1);
++#else
++				if (skb_tailroom(skb)) {
++					skb->data[skb->len] = 0;
++					__skb_put(skb, 1);
++				}
++#endif
+ 			}
+ 		} else
+ 			urb->transfer_flags |= URB_ZERO_PACKET;
+@@ -1382,7 +1396,9 @@ not_drop:
  		if (skb)
  			dev_kfree_skb_any (skb);
  		if (urb) {
@@ -31,7 +51,7 @@
  			usb_free_urb(urb);
  		}
  	} else
-@@ -1430,7 +1439,9 @@ static void usbnet_bh (unsigned long par
+@@ -1435,7 +1451,9 @@ static void usbnet_bh (unsigned long par
  			rx_process (dev, skb);
  			continue;
  		case tx_done:
@@ -41,7 +61,7 @@
  		case rx_cleanup:
  			usb_free_urb (entry->urb);
  			dev_kfree_skb (skb);
-@@ -1773,7 +1784,9 @@ int usbnet_resume (struct usb_interface
+@@ -1788,7 +1806,9 @@ int usbnet_resume (struct usb_interface
  			retval = usb_submit_urb(res, GFP_ATOMIC);
  			if (retval < 0) {
  				dev_kfree_skb_any(skb);
-- 
1.7.10.4

