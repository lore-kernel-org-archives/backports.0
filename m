Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:38544 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753108Ab3HWK21 (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 23 Aug 2013 06:28:27 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] backport: backport device_move() properly
Date: Fri, 23 Aug 2013 12:28:19 +0200
Message-Id: <1377253699-31896-1-git-send-email-johannes@sipsolutions.net> (sfid-20130823_122829_183086_0AE7A8ED)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

This was causing conflicts again when updating against
wireless-next, so instead of adjusting the patches just
provide a proper static inline backport.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
Note: I haven't done ckmake on this, only tested against 2.6.29
---
 backport/backport-include/linux/device.h           | 10 +++++++++
 .../16-bluetooth/net_bluetooth_hci_sysfs.patch     | 12 -----------
 .../16-bluetooth/net_bluetooth_rfcomm_tty.patch    | 25 ----------------------
 3 files changed, 10 insertions(+), 37 deletions(-)

diff --git a/backport/backport-include/linux/device.h b/backport/backport-include/linux/device.h
index 909a534..90a5c71 100644
--- a/backport/backport-include/linux/device.h
+++ b/backport/backport-include/linux/device.h
@@ -28,6 +28,16 @@ typedef int (backport_device_find_function_t)(struct device *, void *);
 	dev_printk(KERN_CRIT , dev , format , ## arg)
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,30)
+static inline int
+backport_device_move(struct device *dev, struct device *new_parent,
+		     enum dpm_order dpm_order)
+{
+	return device_move(dev, new_parent);
+}
+#define device_move LINUX_BACKPORT(device_move)
+#endif
+
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3,3,0)
 /**
  * module_driver() - Helper macro for drivers that don't do anything
diff --git a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_hci_sysfs.patch b/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_hci_sysfs.patch
index 4def823..b4f7b1d 100644
--- a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_hci_sysfs.patch
+++ b/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_hci_sysfs.patch
@@ -12,18 +12,6 @@
  	&bt_link_group,
  	NULL
  };
-@@ -141,7 +145,11 @@ void hci_conn_del_sysfs(struct hci_conn
- 		dev = device_find_child(&conn->dev, NULL, __match_tty);
- 		if (!dev)
- 			break;
-+#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,29))
- 		device_move(dev, NULL, DPM_ORDER_DEV_LAST);
-+#else
-+		device_move(dev, NULL);
-+#endif
- 		put_device(dev);
- 	}
- 
 @@ -378,7 +386,11 @@ static struct attribute_group bt_host_gr
  	.attrs = bt_host_attrs,
  };
diff --git a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_rfcomm_tty.patch b/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_rfcomm_tty.patch
index 7653c0b..dac5ace 100644
--- a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_rfcomm_tty.patch
+++ b/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_rfcomm_tty.patch
@@ -1,30 +1,5 @@
 --- a/net/bluetooth/rfcomm/tty.c
 +++ b/net/bluetooth/rfcomm/tty.c
-@@ -708,8 +708,12 @@ static int rfcomm_tty_open(struct tty_st
- 	remove_wait_queue(&dev->wait, &wait);
- 
- 	if (err == 0)
-+#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,29))
- 		device_move(dev->tty_dev, rfcomm_get_device(dev),
- 			    DPM_ORDER_DEV_AFTER_PARENT);
-+#else
-+		device_move(dev->tty_dev, rfcomm_get_device(dev));
-+#endif
- 
- 	rfcomm_tty_copy_pending(dev);
- 
-@@ -733,7 +737,11 @@ static void rfcomm_tty_close(struct tty_
- 	if (!--dev->port.count) {
- 		spin_unlock_irqrestore(&dev->port.lock, flags);
- 		if (dev->tty_dev->parent)
-+#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,29))
- 			device_move(dev->tty_dev, NULL, DPM_ORDER_DEV_LAST);
-+#else
-+			device_move(dev->tty_dev, NULL);
-+#endif
- 
- 		/* Close DLC and dettach TTY */
- 		rfcomm_dlc_close(dev->dlc, 0);
 @@ -809,7 +817,11 @@ static int rfcomm_tty_write_room(struct
  	return room;
  }
-- 
1.8.4.rc2

