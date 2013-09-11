Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:40731 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751716Ab3IKMMa (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 11 Sep 2013 08:12:30 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 08/11] backports: do not use DMA SG on old kernel versions
Date: Wed, 11 Sep 2013 14:11:52 +0200
Message-Id: <1378901515-14206-9-git-send-email-hauke@hauke-m.de> (sfid-20130911_141231_559909_788AB195)
In-Reply-To: <1378901515-14206-1-git-send-email-hauke@hauke-m.de>
References: <1378901515-14206-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

the usb net driver now uses the dma sg api which is not available on
old kernels, this patch removed the usage of the dma sg api for old
kernel versions.

This backports the following upstream commit:
commit 638c5115a794981441246fa8fa5d95c1875af5ba
Author: Ming Lei <ming.lei@canonical.com>
Date:   Thu Aug 8 21:48:24 2013 +0800

    USBNET: support DMA SG

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../collateral-evolutions/network/78-usb-sg/INFO   |   12 +++++
 .../network/78-usb-sg/usbnet.patch                 |   53 ++++++++++++++++++++
 2 files changed, 65 insertions(+)
 create mode 100644 patches/collateral-evolutions/network/78-usb-sg/INFO
 create mode 100644 patches/collateral-evolutions/network/78-usb-sg/usbnet.patch

diff --git a/patches/collateral-evolutions/network/78-usb-sg/INFO b/patches/collateral-evolutions/network/78-usb-sg/INFO
new file mode 100644
index 0000000..2277f82
--- /dev/null
+++ b/patches/collateral-evolutions/network/78-usb-sg/INFO
@@ -0,0 +1,12 @@
+backports: do not use DMA SG on old kernel versions
+
+the usb net driver now uses the dma sg api which is not available on
+old kernels, this patch removed the usage of the dma sg api for old
+kernel versions.
+
+This backports the following upstream commit:
+commit 638c5115a794981441246fa8fa5d95c1875af5ba
+Author: Ming Lei <ming.lei@canonical.com>
+Date:   Thu Aug 8 21:48:24 2013 +0800
+
+    USBNET: support DMA SG
diff --git a/patches/collateral-evolutions/network/78-usb-sg/usbnet.patch b/patches/collateral-evolutions/network/78-usb-sg/usbnet.patch
new file mode 100644
index 0000000..e7c841c
--- /dev/null
+++ b/patches/collateral-evolutions/network/78-usb-sg/usbnet.patch
@@ -0,0 +1,53 @@
+--- a/drivers/net/usb/usbnet.c
++++ b/drivers/net/usb/usbnet.c
+@@ -1234,6 +1234,7 @@ EXPORT_SYMBOL_GPL(usbnet_tx_timeout);
+ 
+ /*-------------------------------------------------------------------------*/
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,35,0)
+ static int build_dma_sg(const struct sk_buff *skb, struct urb *urb)
+ {
+ 	unsigned num_sgs, total_len = 0;
+@@ -1264,6 +1265,12 @@ static int build_dma_sg(const struct sk_
+ 
+ 	return 1;
+ }
++#else
++static int build_dma_sg(const struct sk_buff *skb, struct urb *urb)
++{
++	return -ENXIO;
++}
++#endif
+ 
+ netdev_tx_t usbnet_start_xmit (struct sk_buff *skb,
+ 				     struct net_device *net)
+@@ -1377,7 +1384,9 @@ not_drop:
+ 		if (skb)
+ 			dev_kfree_skb_any (skb);
+ 		if (urb) {
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,35,0)
+ 			kfree(urb->sg);
++#endif
+ 			usb_free_urb(urb);
+ 		}
+ 	} else
+@@ -1430,7 +1439,9 @@ static void usbnet_bh (unsigned long par
+ 			rx_process (dev, skb);
+ 			continue;
+ 		case tx_done:
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,35,0)
+ 			kfree(entry->urb->sg);
++#endif
+ 		case rx_cleanup:
+ 			usb_free_urb (entry->urb);
+ 			dev_kfree_skb (skb);
+@@ -1767,7 +1778,9 @@ int usbnet_resume (struct usb_interface
+ 			retval = usb_submit_urb(res, GFP_ATOMIC);
+ 			if (retval < 0) {
+ 				dev_kfree_skb_any(skb);
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,35,0)
+ 				kfree(res->sg);
++#endif
+ 				usb_free_urb(res);
+ 				usb_autopm_put_interface_async(dev->intf);
+ 			} else {
-- 
1.7.10.4

