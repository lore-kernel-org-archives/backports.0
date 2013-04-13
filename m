Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:44255 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753678Ab3DMXze (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 13 Apr 2013 19:55:34 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [RFC/RFT 27/42] backports: dissolve compat-2.6.33.h
Date: Sun, 14 Apr 2013 01:53:47 +0200
Message-Id: <1365897243-31214-28-git-send-email-johannes@sipsolutions.net> (sfid-20130414_015640_464216_AE9841EB)
In-Reply-To: <1365897243-31214-1-git-send-email-johannes@sipsolutions.net>
References: <1365897243-31214-1-git-send-email-johannes@sipsolutions.net>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/compat-2.6.33.h | 190 ------------------------
 backport/backport-include/linux/compiler.h      |   8 +
 backport/backport-include/linux/err.h           |  10 ++
 backport/backport-include/linux/firmware.h      |  21 +++
 backport/backport-include/linux/if.h            |   5 +
 backport/backport-include/linux/input.h         |   4 +
 backport/backport-include/linux/netdevice.h     |   6 +
 backport/backport-include/linux/pci.h           |  20 +++
 backport/backport-include/linux/pm.h            |  13 ++
 backport/backport-include/linux/rculist.h       |   7 +
 backport/backport-include/linux/skbuff.h        |  15 ++
 backport/backport-include/linux/usb.h           |  18 +++
 backport/backport-include/net/sock.h            |   4 +
 backport/backport-include/pcmcia/ds.h           |  19 +++
 14 files changed, 150 insertions(+), 190 deletions(-)
 delete mode 100644 backport/backport-include/linux/compat-2.6.33.h
 create mode 100644 backport/backport-include/linux/firmware.h

diff --git a/backport/backport-include/linux/compat-2.6.33.h b/backport/backport-include/linux/compat-2.6.33.h
deleted file mode 100644
index b03fe40..0000000
--- a/backport/backport-include/linux/compat-2.6.33.h
+++ /dev/null
@@ -1,190 +0,0 @@
-#ifndef LINUX_26_33_COMPAT_H
-#define LINUX_26_33_COMPAT_H
-
-#include <linux/version.h>
-
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,33))
-
-#include <linux/skbuff.h>
-#include <linux/pci.h>
-#include <linux/usb.h>
-#if defined(CONFIG_PCCARD) || defined(CONFIG_PCCARD_MODULE)
-#include <pcmcia/cs_types.h>
-#include <pcmcia/cistpl.h>
-#include <pcmcia/ds.h>
-#endif
-#include <linux/firmware.h>
-#include <linux/input.h>
-
-#define usb_autopm_get_interface_no_resume LINUX_BACKPORT(usb_autopm_get_interface_no_resume)
-#define usb_autopm_put_interface_no_suspend LINUX_BACKPORT(usb_autopm_put_interface_no_suspend)
-#ifdef CONFIG_USB_SUSPEND
-extern void usb_autopm_get_interface_no_resume(struct usb_interface *intf);
-extern void usb_autopm_put_interface_no_suspend(struct usb_interface *intf);
-#else
-static inline void usb_autopm_get_interface_no_resume(struct usb_interface *intf)
-{
-	atomic_inc(&intf->pm_usage_cnt);
-}
-static inline void usb_autopm_put_interface_no_suspend(struct usb_interface *intf)
-{
-	atomic_dec(&intf->pm_usage_cnt);
-}
-#endif /* CONFIG_USB_SUSPEND */
-
-#if defined(CPTCFG_BACKPORT_BUILD_FW_LOADER_MODULE)
-#define request_firmware_nowait LINUX_BACKPORT(request_firmware_nowait)
-#define request_firmware LINUX_BACKPORT(request_firmware)
-#define release_firmware LINUX_BACKPORT(release_firmware)
-
-int request_firmware(const struct firmware **fw, const char *name,
-		     struct device *device);
-int request_firmware_nowait(
-	struct module *module, int uevent,
-	const char *name, struct device *device, gfp_t gfp, void *context,
-	void (*cont)(const struct firmware *fw, void *context));
-
-void release_firmware(const struct firmware *fw);
-#endif
-
-/* mask KEY_RFKILL as RHEL6 backports this */
-#if !defined(KEY_RFKILL)
-#define KEY_RFKILL		247	/* Key that controls all radios */
-#endif
-
-/* mask IFF_DONT_BRIDGE as RHEL6 backports this */
-#if !defined(IFF_DONT_BRIDGE)
-#define IFF_DONT_BRIDGE 0x800		/* disallow bridging this ether dev */
-/* source: include/linux/if.h */
-#endif
-
-/* mask NETDEV_POST_INIT as RHEL6 backports this */
-/* this will never happen on older kernels */
-#if !defined(NETDEV_POST_INIT)
-#define NETDEV_POST_INIT 0xffff
-#endif
-
-/* mask netdev_alloc_skb_ip_align as debian squeeze also backports this */
-#define netdev_alloc_skb_ip_align(a, b) compat_netdev_alloc_skb_ip_align(a, b)
-
-static inline struct sk_buff *netdev_alloc_skb_ip_align(struct net_device *dev,
-                unsigned int length)
-{
-	struct sk_buff *skb = netdev_alloc_skb(dev, length + NET_IP_ALIGN);
-
-	if (NET_IP_ALIGN && skb)
-		skb_reserve(skb, NET_IP_ALIGN);
-	return skb;
-}
-
-#if defined(CONFIG_PCCARD) || defined(CONFIG_PCCARD_MODULE)
-
-#if defined(CONFIG_PCMCIA) || defined(CONFIG_PCMCIA_MODULE)
-
-#define pcmcia_request_window(a, b, c) pcmcia_request_window(&a, b, c)
-
-#define pcmcia_map_mem_page(a, b, c) pcmcia_map_mem_page(b, c)
-
-/* loop over CIS entries */
-#define pcmcia_loop_tuple LINUX_BACKPORT(pcmcia_loop_tuple)
-int pcmcia_loop_tuple(struct pcmcia_device *p_dev, cisdata_t code,
-		      int (*loop_tuple) (struct pcmcia_device *p_dev,
-					 tuple_t *tuple,
-					 void *priv_data),
-		      void *priv_data);
-
-#endif /* CONFIG_PCMCIA */
-
-/* loop over CIS entries */
-#define pccard_loop_tuple LINUX_BACKPORT(pccard_loop_tuple)
-int pccard_loop_tuple(struct pcmcia_socket *s, unsigned int function,
-		      cisdata_t code, cisparse_t *parse, void *priv_data,
-		      int (*loop_tuple) (tuple_t *tuple,
-					 cisparse_t *parse,
-					 void *priv_data));
-
-#endif /* CONFIG_PCCARD */
-
-/**
- * list_for_each_entry_continue_rcu - continue iteration over list of given type
- * @pos:	the type * to use as a loop cursor.
- * @head:	the head for your list.
- * @member:	the name of the list_struct within the struct.
- *
- * Continue to iterate over list of given type, continuing after
- * the current position.
- */
-#define list_for_each_entry_continue_rcu(pos, head, member) 		\
-	for (pos = list_entry_rcu(pos->member.next, typeof(*pos), member); \
-	     prefetch(pos->member.next), &pos->member != (head);	\
-	     pos = list_entry_rcu(pos->member.next, typeof(*pos), member))
-
-#define sock_recv_ts_and_drops(msg, sk, skb) sock_recv_timestamp(msg, sk, skb)
-
-/* mask pci_pcie_cap as debian squeeze also backports this */
-#define pci_pcie_cap(a) compat_pci_pcie_cap(a)
-
-/**
- * pci_pcie_cap - get the saved PCIe capability offset
- * @dev: PCI device
- *
- * PCIe capability offset is calculated at PCI device initialization
- * time and saved in the data structure. This function returns saved
- * PCIe capability offset. Using this instead of pci_find_capability()
- * reduces unnecessary search in the PCI configuration space. If you
- * need to calculate PCIe capability offset from raw device for some
- * reasons, please use pci_find_capability() instead.
- */
-static inline int pci_pcie_cap(struct pci_dev *dev)
-{
-	return pci_find_capability(dev, PCI_CAP_ID_EXP);
-}
-
-/* mask pci_is_pcie as RHEL6 backports this */
-#define pci_is_pcie(a) compat_pci_is_pcie(a)
-
-/**
- * pci_is_pcie - check if the PCI device is PCI Express capable
- * @dev: PCI device
- *
- * Retrun true if the PCI device is PCI Express capable, false otherwise.
- */
-static inline bool pci_is_pcie(struct pci_dev *dev)
-{
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,24))
-	return dev->is_pcie;
-#else
-	return !!pci_pcie_cap(dev);
-#endif
-}
-
-#ifdef __GNUC__
-#define __always_unused			__attribute__((unused))
-#else
-#define __always_unused			/* unimplemented */
-#endif
-
-/* mask IS_ERR_OR_NULL as debian squeeze also backports this */
-#define IS_ERR_OR_NULL(a) compat_IS_ERR_OR_NULL(a)
-
-static inline long __must_check IS_ERR_OR_NULL(const void *ptr)
-{
-	return !ptr || IS_ERR_VALUE((unsigned long)ptr);
-}
-
-#if (LINUX_VERSION_CODE == KERNEL_VERSION(2,6,32))
-#undef SIMPLE_DEV_PM_OPS
-#define SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
-const struct dev_pm_ops name = { \
-	.suspend = suspend_fn, \
-	.resume = resume_fn, \
-	.freeze = suspend_fn, \
-	.thaw = resume_fn, \
-	.poweroff = suspend_fn, \
-	.restore = resume_fn, \
-}
-#endif /* (LINUX_VERSION_CODE == KERNEL_VERSION(2,6,32)) */
-
-#endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,33)) */
-
-#endif /* LINUX_26_33_COMPAT_H */
diff --git a/backport/backport-include/linux/compiler.h b/backport/backport-include/linux/compiler.h
index 34c4a4f..0f5dfe4 100644
--- a/backport/backport-include/linux/compiler.h
+++ b/backport/backport-include/linux/compiler.h
@@ -6,4 +6,12 @@
 #define __rcu
 #endif
 
+#ifndef __always_unused
+#ifdef __GNUC__
+#define __always_unused			__attribute__((unused))
+#else
+#define __always_unused			/* unimplemented */
+#endif
+#endif
+
 #endif /* __BACKPORT_LINUX_COMPILER_H */
diff --git a/backport/backport-include/linux/err.h b/backport/backport-include/linux/err.h
index cf63ea0..f62e3bf 100644
--- a/backport/backport-include/linux/err.h
+++ b/backport/backport-include/linux/err.h
@@ -13,4 +13,14 @@ static inline int __must_check PTR_RET(const void *ptr)
 }
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,33)
+/* mask IS_ERR_OR_NULL as debian squeeze also backports this */
+#define IS_ERR_OR_NULL LINUX_BACKPORT(IS_ERR_OR_NULL)
+
+static inline long __must_check IS_ERR_OR_NULL(const void *ptr)
+{
+	return !ptr || IS_ERR_VALUE((unsigned long)ptr);
+}
+#endif
+
 #endif /* __BACKPORT_LINUX_ERR_H */
diff --git a/backport/backport-include/linux/firmware.h b/backport/backport-include/linux/firmware.h
new file mode 100644
index 0000000..9271f96
--- /dev/null
+++ b/backport/backport-include/linux/firmware.h
@@ -0,0 +1,21 @@
+#ifndef __BACKPORT_LINUX_FIRMWARE_H
+#define __BACKPORT_LINUX_FIRMWARE_H
+#include_next <linux/firmware.h>
+#include <linux/version.h>
+
+#if defined(CPTCFG_BACKPORT_BUILD_FW_LOADER_MODULE)
+#define request_firmware_nowait LINUX_BACKPORT(request_firmware_nowait)
+#define request_firmware LINUX_BACKPORT(request_firmware)
+#define release_firmware LINUX_BACKPORT(release_firmware)
+
+int request_firmware(const struct firmware **fw, const char *name,
+		     struct device *device);
+int request_firmware_nowait(
+	struct module *module, int uevent,
+	const char *name, struct device *device, gfp_t gfp, void *context,
+	void (*cont)(const struct firmware *fw, void *context));
+
+void release_firmware(const struct firmware *fw);
+#endif
+
+#endif /* __BACKPORT_LINUX_FIRMWARE_H */
diff --git a/backport/backport-include/linux/if.h b/backport/backport-include/linux/if.h
index 53f615c..7926082 100644
--- a/backport/backport-include/linux/if.h
+++ b/backport/backport-include/linux/if.h
@@ -3,6 +3,11 @@
 #include_next <linux/if.h>
 #include <linux/version.h>
 
+/* mask IFF_DONT_BRIDGE as RHEL6 backports this */
+#if !defined(IFF_DONT_BRIDGE)
+#define IFF_DONT_BRIDGE 0x800		/* disallow bridging this ether dev */
+#endif
+
 #if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,36))
 #define br_port_exists(dev)	(dev->br_port)
 #else
diff --git a/backport/backport-include/linux/input.h b/backport/backport-include/linux/input.h
index 0d58f9b..fa95263 100644
--- a/backport/backport-include/linux/input.h
+++ b/backport/backport-include/linux/input.h
@@ -10,4 +10,8 @@
 #define KEY_WPS_BUTTON		0x211
 #endif
 
+#ifndef KEY_RFKILL
+#define KEY_RFKILL		247
+#endif
+
 #endif /* __BACKPORT_INPUT_H */
diff --git a/backport/backport-include/linux/netdevice.h b/backport/backport-include/linux/netdevice.h
index b18d9c7..b4bbf16 100644
--- a/backport/backport-include/linux/netdevice.h
+++ b/backport/backport-include/linux/netdevice.h
@@ -277,4 +277,10 @@ do {								\
 
 #endif /* < 2.6.34 */
 
+/* mask NETDEV_POST_INIT as RHEL6 backports this */
+/* this will never happen on older kernels */
+#ifndef NETDEV_POST_INIT
+#define NETDEV_POST_INIT 0xffff
+#endif
+
 #endif /* __BACKPORT_NETDEVICE_H */
diff --git a/backport/backport-include/linux/pci.h b/backport/backport-include/linux/pci.h
index eb985f1..e85db3a 100644
--- a/backport/backport-include/linux/pci.h
+++ b/backport/backport-include/linux/pci.h
@@ -78,4 +78,24 @@ static inline void __iomem *pci_platform_rom(struct pci_dev *pdev, size_t *size)
 }
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,33)
+/* mask pci_pcie_cap as debian squeeze also backports this */
+#define pci_pcie_cap LINUX_BACKPORT(pci_pcie_cap)
+static inline int pci_pcie_cap(struct pci_dev *dev)
+{
+	return pci_find_capability(dev, PCI_CAP_ID_EXP);
+}
+
+/* mask pci_is_pcie as RHEL6 backports this */
+#define pci_is_pcie LINUX_BACKPORT(pci_is_pcie)
+static inline bool pci_is_pcie(struct pci_dev *dev)
+{
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,24))
+	return dev->is_pcie;
+#else
+	return !!pci_pcie_cap(dev);
+#endif
+}
+#endif /* < 2.6.33 */
+
 #endif /* _BACKPORT_LINUX_PCI_H */
diff --git a/backport/backport-include/linux/pm.h b/backport/backport-include/linux/pm.h
index 09ab926..b637763 100644
--- a/backport/backport-include/linux/pm.h
+++ b/backport/backport-include/linux/pm.h
@@ -10,4 +10,17 @@
 #define PMSG_IS_AUTO(msg)	(((msg).event & PM_EVENT_AUTO) != 0)
 #endif
 
+#if LINUX_VERSION_CODE == KERNEL_VERSION(2,6,32)
+#undef SIMPLE_DEV_PM_OPS
+#define SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
+const struct dev_pm_ops name = { \
+	.suspend = suspend_fn, \
+	.resume = resume_fn, \
+	.freeze = suspend_fn, \
+	.thaw = resume_fn, \
+	.poweroff = suspend_fn, \
+	.restore = resume_fn, \
+}
+#endif /* 2.6.32 */
+
 #endif /* __BACKPORT_PM_H */
diff --git a/backport/backport-include/linux/rculist.h b/backport/backport-include/linux/rculist.h
index 38afa4b..bb9f367 100644
--- a/backport/backport-include/linux/rculist.h
+++ b/backport/backport-include/linux/rculist.h
@@ -39,4 +39,11 @@
 
 #endif /* < 2.6.37 */
 
+#ifndef list_for_each_entry_continue_rcu
+#define list_for_each_entry_continue_rcu(pos, head, member) 		\
+	for (pos = list_entry_rcu(pos->member.next, typeof(*pos), member); \
+	     prefetch(pos->member.next), &pos->member != (head);	\
+	     pos = list_entry_rcu(pos->member.next, typeof(*pos), member))
+#endif
+
 #endif /* __BACKPORT_RCULIST_H */
diff --git a/backport/backport-include/linux/skbuff.h b/backport/backport-include/linux/skbuff.h
index 5107f65..e7f667e 100644
--- a/backport/backport-include/linux/skbuff.h
+++ b/backport/backport-include/linux/skbuff.h
@@ -102,4 +102,19 @@ static inline void skb_tx_timestamp(struct sk_buff *skb)
 }
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,33)
+/* mask netdev_alloc_skb_ip_align as debian squeeze also backports this */
+#define netdev_alloc_skb_ip_align LINUX_BACKPORT(netdev_alloc_skb_ip_align)
+
+static inline struct sk_buff *netdev_alloc_skb_ip_align(struct net_device *dev,
+                unsigned int length)
+{
+	struct sk_buff *skb = netdev_alloc_skb(dev, length + NET_IP_ALIGN);
+
+	if (NET_IP_ALIGN && skb)
+		skb_reserve(skb, NET_IP_ALIGN);
+	return skb;
+}
+#endif
+
 #endif /* __BACKPORT_SKBUFF_H */
diff --git a/backport/backport-include/linux/usb.h b/backport/backport-include/linux/usb.h
index d67317f..79ac140 100644
--- a/backport/backport-include/linux/usb.h
+++ b/backport/backport-include/linux/usb.h
@@ -74,4 +74,22 @@ static inline int usb_disable_autosuspend(struct usb_device *udev)
 { return 0; }
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,33)
+#define usb_autopm_get_interface_no_resume LINUX_BACKPORT(usb_autopm_get_interface_no_resume)
+#define usb_autopm_put_interface_no_suspend LINUX_BACKPORT(usb_autopm_put_interface_no_suspend)
+#ifdef CONFIG_USB_SUSPEND
+extern void usb_autopm_get_interface_no_resume(struct usb_interface *intf);
+extern void usb_autopm_put_interface_no_suspend(struct usb_interface *intf);
+#else
+static inline void usb_autopm_get_interface_no_resume(struct usb_interface *intf)
+{
+	atomic_inc(&intf->pm_usage_cnt);
+}
+static inline void usb_autopm_put_interface_no_suspend(struct usb_interface *intf)
+{
+	atomic_dec(&intf->pm_usage_cnt);
+}
+#endif /* CONFIG_USB_SUSPEND */
+#endif /* < 2.6.33 */
+
 #endif /* __BACKPORT_USB_H */
diff --git a/backport/backport-include/net/sock.h b/backport/backport-include/net/sock.h
index 6943721..93dc6a8 100644
--- a/backport/backport-include/net/sock.h
+++ b/backport/backport-include/net/sock.h
@@ -52,4 +52,8 @@ static inline struct sock *sk_entry(const struct hlist_node *node)
 }
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,33)
+#define sock_recv_ts_and_drops(msg, sk, skb) sock_recv_timestamp(msg, sk, skb)
+#endif
+
 #endif /* __BACKPORT_NET_SOCK_H */
diff --git a/backport/backport-include/pcmcia/ds.h b/backport/backport-include/pcmcia/ds.h
index 7c49500..5cc2e60 100644
--- a/backport/backport-include/pcmcia/ds.h
+++ b/backport/backport-include/pcmcia/ds.h
@@ -47,4 +47,23 @@ static inline int pcmcia_write_config_byte(struct pcmcia_device *p_dev, off_t wh
 }
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,33)
+#define pcmcia_request_window(a, b, c) pcmcia_request_window(&a, b, c)
+#define pcmcia_map_mem_page(a, b, c) pcmcia_map_mem_page(b, c)
+
+#define pcmcia_loop_tuple LINUX_BACKPORT(pcmcia_loop_tuple)
+int pcmcia_loop_tuple(struct pcmcia_device *p_dev, cisdata_t code,
+		      int (*loop_tuple) (struct pcmcia_device *p_dev,
+					 tuple_t *tuple,
+					 void *priv_data),
+		      void *priv_data);
+
+#define pccard_loop_tuple LINUX_BACKPORT(pccard_loop_tuple)
+int pccard_loop_tuple(struct pcmcia_socket *s, unsigned int function,
+		      cisdata_t code, cisparse_t *parse, void *priv_data,
+		      int (*loop_tuple) (tuple_t *tuple,
+					 cisparse_t *parse,
+					 void *priv_data));
+#endif /* < 2.6.33 */
+
 #endif /* __BACKPORT_PCMCIA_DS_H */
-- 
1.8.0

