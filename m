Return-path: <backports-owner@vger.kernel.org>
Received: from mxz.fh-kl.de ([143.93.17.66]:32826 "EHLO mxz.fh-kl.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750936Ab3HBLaV (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 2 Aug 2013 07:30:21 -0400
Message-ID: <51FB9846.5050307@fh-kl.de> (sfid-20130802_133022_466792_74649C55)
Date: Fri, 2 Aug 2013 13:30:14 +0200
From: Patrick Ziegler <patrick.ziegler@fh-kl.de>
MIME-Version: 1.0
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
CC: <backports@vger.kernel.org>
Subject: [PATCH 9/9] backports: add wwan device drivers
References: <cover.1375442885.git.patrick.ziegler@fh-kl.de>
In-Reply-To: <cover.1375442885.git.patrick.ziegler@fh-kl.de>
Content-Type: text/plain; charset="ISO-8859-15"
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Add cdc_mbim, cdc_ncm, sierra_net, qmi_wwan device drivers.

Signed-off-by: Patrick Ziegler <patrick.ziegler@fh-kl.de>
---
 backport/Kconfig                                           |  2 ++
 backport/Makefile.kernel                                   |  3 +++
 copy-list                                                  | 14 ++++++++++++++
 .../network/0001-netdev_ops/qmi_wwan.patch                 | 11 +++++++++++
 .../network/0001-netdev_ops/sierra_net.patch               | 11 +++++++++++
 .../62-usb_driver_lpm/drivers_net_usb_cdc_mbim.patch       | 12 ++++++++++++
 .../62-usb_driver_lpm/drivers_net_usb_cdc_ncm.patch        | 12 ++++++++++++
 .../62-usb_driver_lpm/drivers_net_usb_qmi_wwan.patch       | 12 ++++++++++++
 .../62-usb_driver_lpm/drivers_net_usb_sierra_net.patch     | 12 ++++++++++++
 .../62-usb_driver_lpm/drivers_usb_class_cdc-wdm.patch      | 12 ++++++++++++
 10 files changed, 101 insertions(+)
 create mode 100644 patches/collateral-evolutions/network/0001-netdev_ops/qmi_wwan.patch
 create mode 100644 patches/collateral-evolutions/network/0001-netdev_ops/sierra_net.patch
 create mode 100644 patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_cdc_mbim.patch
 create mode 100644 patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_cdc_ncm.patch
 create mode 100644 patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_qmi_wwan.patch
 create mode 100644 patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_sierra_net.patch
 create mode 100644 patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_usb_class_cdc-wdm.patch

diff --git a/backport/Kconfig b/backport/Kconfig
index 845b233..64a5f8b 100644
--- a/backport/Kconfig
+++ b/backport/Kconfig
@@ -48,3 +48,5 @@ source drivers/platform/x86/Kconfig
 source net/ieee802154/Kconfig
 source net/mac802154/Kconfig
 source drivers/net/ieee802154/Kconfig
+
+source drivers/usb/class/Kconfig
diff --git a/backport/Makefile.kernel b/backport/Makefile.kernel
index ac29dea..ca75ce1 100644
--- a/backport/Makefile.kernel
+++ b/backport/Makefile.kernel
@@ -40,3 +40,6 @@ obj-$(CPTCFG_INTEL_IPS) += drivers/platform/x86/
 obj-$(CPTCFG_IEEE802154) += net/ieee802154/
 obj-$(CPTCFG_MAC802154) += net/mac802154/
 obj-$(CPTCFG_IEEE802154) += drivers/net/ieee802154/
+
+obj-$(CPTCFG_USB_WDM) += drivers/usb/class/
+obj-$(CPTCFG_USB_USBNET) += drivers/net/usb/
diff --git a/copy-list b/copy-list
index aaf5ae9..7da4bb7 100644
--- a/copy-list
+++ b/copy-list
@@ -100,6 +100,20 @@ drivers/net/ethernet/broadcom/Makefile
 drivers/net/ethernet/broadcom/b44.c
 drivers/net/ethernet/broadcom/b44.h
 
+# wwan drivers
+include/uapi/linux/usb/cdc.h
+include/uapi/linux/usb/cdc-wdm.h
+include/linux/usb/cdc_ncm.h
+include/linux/usb/cdc-wdm.h
+
+drivers/usb/class/Makefile
+drivers/usb/class/Kconfig
+drivers/usb/class/cdc-wdm.c
+drivers/net/usb/cdc_mbim.c
+drivers/net/usb/cdc_ncm.c
+drivers/net/usb/sierra_net.c
+drivers/net/usb/qmi_wwan.c
+
 # DRM
 include/drm/
 include/uapi/drm/
diff --git a/patches/collateral-evolutions/network/0001-netdev_ops/qmi_wwan.patch b/patches/collateral-evolutions/network/0001-netdev_ops/qmi_wwan.patch
new file mode 100644
index 0000000..6281c8d
--- /dev/null
+++ b/patches/collateral-evolutions/network/0001-netdev_ops/qmi_wwan.patch
@@ -0,0 +1,11 @@
+--- a/drivers/net/usb/qmi_wwan.c
++++ b/drivers/net/usb/qmi_wwan.c
+@@ -331,7 +331,7 @@
+ 		dev->net->dev_addr[0] |= 0x02;	/* set local assignment bit */
+ 		dev->net->dev_addr[0] &= 0xbf;	/* clear "IP" bit */
+ 	}
+-	dev->net->netdev_ops = &qmi_wwan_netdev_ops;
++	netdev_attach_ops(dev->net, &qmi_wwan_netdev_ops);
+ err:
+ 	return status;
+ }
diff --git a/patches/collateral-evolutions/network/0001-netdev_ops/sierra_net.patch b/patches/collateral-evolutions/network/0001-netdev_ops/sierra_net.patch
new file mode 100644
index 0000000..e7ff14b
--- /dev/null
+++ b/patches/collateral-evolutions/network/0001-netdev_ops/sierra_net.patch
@@ -0,0 +1,11 @@
+--- a/drivers/net/usb/sierra_net.c
++++ b/drivers/net/usb/sierra_net.c
+@@ -695,7 +695,7 @@
+ 
+ 	priv->usbnet = dev;
+ 	priv->ifnum = ifacenum;
+-	dev->net->netdev_ops = &sierra_net_device_ops;
++	netdev_attach_ops(dev->net, &sierra_net_device_ops);
+ 
+ 	/* change MAC addr to include, ifacenum, and to be unique */
+ 	dev->net->dev_addr[ETH_ALEN-2] = atomic_inc_return(&iface_counter);
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_cdc_mbim.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_cdc_mbim.patch
new file mode 100644
index 0000000..0feffc8
--- /dev/null
+++ b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_cdc_mbim.patch
@@ -0,0 +1,12 @@
+--- a/drivers/net/usb/cdc_mbim.c
++++ b/drivers/net/usb/cdc_mbim.c
+@@ -417,7 +417,9 @@
+ 	.resume = cdc_mbim_resume,
+ 	.reset_resume =	cdc_mbim_resume,
+ 	.supports_autosuspend = 1,
++#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0))
+ 	.disable_hub_initiated_lpm = 1,
++#endif
+ };
+ module_usb_driver(cdc_mbim_driver);
+ 
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_cdc_ncm.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_cdc_ncm.patch
new file mode 100644
index 0000000..c6419fe
--- /dev/null
+++ b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_cdc_ncm.patch
@@ -0,0 +1,12 @@
+--- a/drivers/net/usb/cdc_ncm.c
++++ b/drivers/net/usb/cdc_ncm.c
+@@ -1271,7 +1271,9 @@
+ 	.resume = usbnet_resume,
+ 	.reset_resume =	usbnet_resume,
+ 	.supports_autosuspend = 1,
++#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0))
+ 	.disable_hub_initiated_lpm = 1,
++#endif
+ };
+ 
+ module_usb_driver(cdc_ncm_driver);
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_qmi_wwan.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_qmi_wwan.patch
new file mode 100644
index 0000000..8f3355d
--- /dev/null
+++ b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_qmi_wwan.patch
@@ -0,0 +1,12 @@
+--- a/drivers/net/usb/qmi_wwan.c
++++ b/drivers/net/usb/qmi_wwan.c
+@@ -672,7 +672,9 @@
+ 	.resume		      =	qmi_wwan_resume,
+ 	.reset_resume         = qmi_wwan_resume,
+ 	.supports_autosuspend = 1,
++#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0))
+ 	.disable_hub_initiated_lpm = 1,
++#endif
+ };
+ 
+ module_usb_driver(qmi_wwan_driver);
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_sierra_net.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_sierra_net.patch
new file mode 100644
index 0000000..553f2ca
--- /dev/null
+++ b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_net_usb_sierra_net.patch
@@ -0,0 +1,12 @@
+--- a/drivers/net/usb/sierra_net.c
++++ b/drivers/net/usb/sierra_net.c
+@@ -959,7 +959,9 @@
+ 	.suspend = usbnet_suspend,
+ 	.resume = usbnet_resume,
+ 	.no_dynamic_id = 1,
++#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0))
+ 	.disable_hub_initiated_lpm = 1,
++#endif
+ };
+ 
+ module_usb_driver(sierra_net_driver);
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_usb_class_cdc-wdm.patch b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_usb_class_cdc-wdm.patch
new file mode 100644
index 0000000..c3af4a1
--- /dev/null
+++ b/patches/collateral-evolutions/network/62-usb_driver_lpm/drivers_usb_class_cdc-wdm.patch
@@ -0,0 +1,12 @@
+--- a/drivers/usb/class/cdc-wdm.c
++++ b/drivers/usb/class/cdc-wdm.c
+@@ -1060,7 +1060,9 @@
+ 	.post_reset =	wdm_post_reset,
+ 	.id_table =	wdm_ids,
+ 	.supports_autosuspend = 1,
++#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0))
+ 	.disable_hub_initiated_lpm = 1,
++#endif
+ };
+ 
+ module_usb_driver(wdm_driver);
-- 
1.8.1.2


-- 
Dipl.-Inf. (FH) Patrick Ziegler

University Of Applied Sciences
Kaiserslautern

Amerikastrasse 1
D-66482 Zweibruecken
Germany

Phone:  +49 631 3724 5526
Mail:   patrick.ziegler@fh-kl.de
PGP KeyID 0xB4796B8C

http://www.fh-kl.de
http://www.fh-kl.de/fachbereiche/imst/iuk-knowhow.html
