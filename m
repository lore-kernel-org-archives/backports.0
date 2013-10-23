Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:36132 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751531Ab3JWVhE (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 23 Oct 2013 17:37:04 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 2/8] backports: remove addr_assign_type from usbnet
Date: Wed, 23 Oct 2013 23:36:44 +0200
Message-Id: <1382564210-15230-3-git-send-email-hauke@hauke-m.de> (sfid-20131023_233708_007553_A2CA7AF9)
In-Reply-To: <1382564210-15230-1-git-send-email-hauke@hauke-m.de>
References: <1382564210-15230-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

addr_assign_type was added with kernel 2.6.36. This is just used to
inform userspace, so removing it is no problem.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../network/61-netdev-addr_assign_type/usbnet.patch      |   14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 patches/collateral-evolutions/network/61-netdev-addr_assign_type/usbnet.patch

diff --git a/patches/collateral-evolutions/network/61-netdev-addr_assign_type/usbnet.patch b/patches/collateral-evolutions/network/61-netdev-addr_assign_type/usbnet.patch
new file mode 100644
index 0000000..a82c478
--- /dev/null
+++ b/patches/collateral-evolutions/network/61-netdev-addr_assign_type/usbnet.patch
@@ -0,0 +1,14 @@
+--- a/drivers/net/usb/usbnet.c
++++ b/drivers/net/usb/usbnet.c
+@@ -1669,9 +1669,11 @@ usbnet_probe (struct usb_interface *udev
+ 		dev->rx_urb_size = dev->hard_mtu;
+ 	dev->maxpacket = usb_maxpacket (dev->udev, dev->out, 1);
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36)
+ 	/* let userspace know we have a random address */
+ 	if (ether_addr_equal(net->dev_addr, node_id))
+ 		net->addr_assign_type = NET_ADDR_RANDOM;
++#endif
+ 
+ 	if ((dev->driver_info->flags & FLAG_WLAN) != 0)
+ 		SET_NETDEV_DEVTYPE(net, &wlan_type);
-- 
1.7.10.4

