Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:35239 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752927AbaFGT3n (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 7 Jun 2014 15:29:43 -0400
Received: from localhost (localhost [127.0.0.1])
	by hauke-m.de (Postfix) with ESMTP id 115BF7E73
	for <backports@vger.kernel.org>; Sat,  7 Jun 2014 21:29:42 +0200 (CEST)
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 2/7] backports: handle changes to vlan_rx_add/kill pointers in cdc_mbim.c
Date: Sat,  7 Jun 2014 21:29:11 +0200
Message-Id: <1402169356-1267-3-git-send-email-hauke@hauke-m.de> (sfid-20140607_212944_415911_4B3ADC8F)
In-Reply-To: <1402169356-1267-1-git-send-email-hauke@hauke-m.de>
References: <1402169356-1267-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

These callback pointers are now also used in cdc_mbim.c

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../network/0033-ndo_vlan_rx_vid/cdc_mbim.patch    | 50 ++++++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/cdc_mbim.patch

diff --git a/patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/cdc_mbim.patch b/patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/cdc_mbim.patch
new file mode 100644
index 0000000..de3ad1d
--- /dev/null
+++ b/patches/collateral-evolutions/network/0033-ndo_vlan_rx_vid/cdc_mbim.patch
@@ -0,0 +1,50 @@
+diff --git a/drivers/net/usb/cdc_mbim.c b/drivers/net/usb/cdc_mbim.c
+index bc23273..459730d 100644
+--- a/drivers/net/usb/cdc_mbim.c
++++ b/drivers/net/usb/cdc_mbim.c
+@@ -70,7 +70,13 @@ static int cdc_mbim_wdm_manage_power(str
+ 	return cdc_mbim_manage_power(dev, status);
+ }
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,10,0)
+ static int cdc_mbim_rx_add_vid(struct net_device *netdev, __be16 proto, u16 vid)
++#elif LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0)
++static int cdc_mbim_rx_add_vid(struct net_device *netdev, u16 vid)
++#else
++static void cdc_mbim_rx_add_vid(struct net_device *netdev, u16 vid)
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,10,0) */
+ {
+ 	struct usbnet *dev = netdev_priv(netdev);
+ 	struct cdc_mbim_state *info = (void *)&dev->data;
+@@ -78,13 +84,21 @@ static int cdc_mbim_rx_add_vid(struct ne
+ 	/* creation of this VLAN is a request to tag IP session 0 */
+ 	if (vid == MBIM_IPS0_VID)
+ 		info->flags |= FLAG_IPS0_VLAN;
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0)
+ 	else
+ 		if (vid >= 512)	/* we don't map these to MBIM session */
+ 			return -EINVAL;
+ 	return 0;
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0) */
+ }
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,10,0)
+ static int cdc_mbim_rx_kill_vid(struct net_device *netdev, __be16 proto, u16 vid)
++#elif LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0)
++static int cdc_mbim_rx_kill_vid(struct net_device *netdev, u16 vid)
++#else
++static void cdc_mbim_rx_kill_vid(struct net_device *netdev, u16 vid)
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,10,0) */
+ {
+ 	struct usbnet *dev = netdev_priv(netdev);
+ 	struct cdc_mbim_state *info = (void *)&dev->data;
+@@ -92,7 +106,9 @@ static int cdc_mbim_rx_kill_vid(struct n
+ 	/* this is a request for an untagged IP session 0 */
+ 	if (vid == MBIM_IPS0_VID)
+ 		info->flags &= ~FLAG_IPS0_VLAN;
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0)
+ 	return 0;
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0) */
+ }
+ 
+ static const struct net_device_ops cdc_mbim_netdev_ops = {
-- 
1.9.1

