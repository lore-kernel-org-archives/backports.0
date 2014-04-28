Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:39992 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755747AbaD1NMZ (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 28 Apr 2014 09:12:25 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] backports: remove more old ifdef/compat code
Date: Mon, 28 Apr 2014 15:12:15 +0200
Message-Id: <1398690735-6313-1-git-send-email-johannes@sipsolutions.net> (sfid-20140428_151232_114427_2D2EDAF6)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

Since support for kernels < 3.0 was removed, there's now a bunch
of dead code that can be removed - do it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/device.h          |  16 ----
 backport/backport-include/linux/mmc/host.h        |  11 ---
 backport/backport-include/linux/netdev_features.h |   4 -
 backport/backport-include/linux/netdevice.h       |  11 ---
 backport/backport-include/linux/pci.h             | 102 +---------------------
 backport/backport-include/linux/rcupdate.h        |   7 --
 backport/backport-include/net/netlink.h           |   4 -
 backport/compat/backport-3.10.c                   |   3 -
 backport/compat/backport-3.13.c                   |  79 -----------------
 backport/compat/backport-3.14.c                   |   2 -
 backport/compat/compat-3.3.c                      |  16 ----
 backport/compat/compat-3.8.c                      |  13 ---
 12 files changed, 1 insertion(+), 267 deletions(-)
 delete mode 100644 backport/backport-include/linux/mmc/host.h

diff --git a/backport/backport-include/linux/device.h b/backport/backport-include/linux/device.h
index 3f57bd9affc7..04533bdd2673 100644
--- a/backport/backport-include/linux/device.h
+++ b/backport/backport-include/linux/device.h
@@ -124,19 +124,11 @@ static void init_##_name##_attrs(void)				\
 }
 
 #ifndef __ATTRIBUTE_GROUPS
-#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,31))
 #define __ATTRIBUTE_GROUPS(_name)				\
 static const struct attribute_group *_name##_groups[] = {	\
 	&_name##_group,						\
 	NULL,							\
 }
-#else
-#define __ATTRIBUTE_GROUPS(_name)				\
-static struct attribute_group *_name##_groups[] = {		\
-	&_name##_group,						\
-	NULL,							\
-}
-#endif /* (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,31)) */
 #endif /* __ATTRIBUTE_GROUPS */
 
 #undef ATTRIBUTE_GROUPS
@@ -147,14 +139,6 @@ static const struct attribute_group _name##_group = {		\
 static inline void init_##_name##_attrs(void) {}		\
 __ATTRIBUTE_GROUPS(_name)
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,32)
-#define dev_get_platdata LINUX_BACKPORT(dev_get_platdata)
-static inline void *dev_get_platdata(const struct device *dev)
-{
-	return dev->platform_data;
-}
-#endif
-
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3,13,0)
 #define devm_kmalloc(dev, size, flags) devm_kzalloc(dev, size, flags) 
 #endif
diff --git a/backport/backport-include/linux/mmc/host.h b/backport/backport-include/linux/mmc/host.h
deleted file mode 100644
index 49ca5c212135..000000000000
--- a/backport/backport-include/linux/mmc/host.h
+++ /dev/null
@@ -1,11 +0,0 @@
-#ifndef __BACKPORT_MMC_HOST_H
-#define __BACKPORT_MMC_HOST_H
-#include <linux/version.h>
-#include_next <linux/mmc/host.h>
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,37)
-/* rename member in struct mmc_host */
-#define max_segs	max_hw_segs
-#endif
-
-#endif /* __BACKPORT_MMC_HOST_H */
diff --git a/backport/backport-include/linux/netdev_features.h b/backport/backport-include/linux/netdev_features.h
index 76fb463963a9..350283d6abd4 100644
--- a/backport/backport-include/linux/netdev_features.h
+++ b/backport/backport-include/linux/netdev_features.h
@@ -8,15 +8,11 @@
 #include <linux/types.h>
 
 /* added via 9356b8fc */
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,14)
 #define NETIF_F_HW_VLAN_CTAG_RX			NETIF_F_HW_VLAN_RX
 #define NETIF_F_HW_VLAN_CTAG_TX			NETIF_F_HW_VLAN_TX
-#endif
 
 /* added via d314774c */
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,29)
 #define NETIF_F_HW_VLAN_CTAG_FILTER		NETIF_F_HW_VLAN_FILTER
-#endif
 
 /* c8f44aff made this u32 but later a861a8b2 changed it to u64 both on v3.3 */
 typedef u32 netdev_features_t;
diff --git a/backport/backport-include/linux/netdevice.h b/backport/backport-include/linux/netdevice.h
index 04b310dbcffd..2abb47d747c8 100644
--- a/backport/backport-include/linux/netdevice.h
+++ b/backport/backport-include/linux/netdevice.h
@@ -82,17 +82,6 @@ static inline void dev_consume_skb_any(struct sk_buff *skb)
 }
 #endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,14,0) */
 
-/* d1c76af9e */
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,30)
-enum { /* backport: provide the enum name already */
-	GRO_MERGED,
-	GRO_MERGED_FREE,
-	GRO_HELD,
-	GRO_NORMAL,
-	GRO_DROP,
-};
-#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(2,6,30) */
-
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3,7,8)
 #define netdev_set_default_ethtool_ops LINUX_BACKPORT(netdev_set_default_ethtool_ops)
 extern void netdev_set_default_ethtool_ops(struct net_device *dev,
diff --git a/backport/backport-include/linux/pci.h b/backport/backport-include/linux/pci.h
index e438f143174a..3dd2c7e470a1 100644
--- a/backport/backport-include/linux/pci.h
+++ b/backport/backport-include/linux/pci.h
@@ -3,73 +3,6 @@
 #include_next <linux/pci.h>
 #include <linux/version.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,29)
-#define compat_pci_suspend(fn)						\
-	int fn##_compat(struct pci_dev *pdev, pm_message_t state) 	\
-	{								\
-		int r;							\
-									\
-		r = fn(&pdev->dev);					\
-		if (r)							\
-			return r;					\
-									\
-		pci_save_state(pdev);					\
-		pci_disable_device(pdev);				\
-		pci_set_power_state(pdev, PCI_D3hot);			\
-									\
-		return 0;						\
-	}
-
-#define compat_pci_resume(fn)						\
-	int fn##_compat(struct pci_dev *pdev)				\
-	{								\
-		int r;							\
-									\
-		pci_set_power_state(pdev, PCI_D0);			\
-		r = pci_enable_device(pdev);				\
-		if (r)							\
-			return r;					\
-		pci_restore_state(pdev);				\
-									\
-		return fn(&pdev->dev);					\
-	}
-#elif LINUX_VERSION_CODE == KERNEL_VERSION(2,6,29)
-#define compat_pci_suspend(fn)						\
-	int fn##_compat(struct device *dev)			 	\
-	{								\
-		struct pci_dev *pdev = to_pci_dev(dev);			\
-		int r;							\
-									\
-		r = fn(&pdev->dev);					\
-		if (r)							\
-			return r;					\
-									\
-		pci_save_state(pdev);					\
-		pci_disable_device(pdev);				\
-		pci_set_power_state(pdev, PCI_D3hot);			\
-									\
-		return 0;						\
-	}
-
-#define compat_pci_resume(fn)						\
-	int fn##_compat(struct device *dev)				\
-	{								\
-		struct pci_dev *pdev = to_pci_dev(dev);			\
-		int r;							\
-									\
-		pci_set_power_state(pdev, PCI_D0);			\
-		r = pci_enable_device(pdev);				\
-		if (r)							\
-			return r;					\
-		pci_restore_state(pdev);				\
-									\
-		return fn(&pdev->dev);					\
-	}
-#else
-#define compat_pci_suspend(fn)
-#define compat_pci_resume(fn)
-#endif
-
 #ifndef module_pci_driver
 /**
  * module_pci_driver() - Helper macro for registering a PCI driver
@@ -129,39 +62,6 @@ static inline int pcie_capability_clear_dword(struct pci_dev *dev, int pos,
 }
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,33)
-/* mask pci_pcie_cap as debian squeeze also backports this */
-#define pci_pcie_cap LINUX_BACKPORT(pci_pcie_cap)
-static inline int pci_pcie_cap(struct pci_dev *dev)
-{
-	return pci_find_capability(dev, PCI_CAP_ID_EXP);
-}
-
-/* mask pci_is_pcie as RHEL6 backports this */
-#define pci_is_pcie LINUX_BACKPORT(pci_is_pcie)
-static inline bool pci_is_pcie(struct pci_dev *dev)
-{
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,24))
-	return dev->is_pcie;
-#else
-	return !!pci_pcie_cap(dev);
-#endif
-}
-#endif /* < 2.6.33 */
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,28)
-#define pci_ioremap_bar LINUX_BACKPORT(pci_ioremap_bar)
-void __iomem *pci_ioremap_bar(struct pci_dev *pdev, int bar);
-
-#define pci_wake_from_d3 LINUX_BACKPORT(pci_wake_from_d3)
-int pci_wake_from_d3(struct pci_dev *dev, bool enable);
-#endif
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,27)
-#define pci_pme_capable LINUX_BACKPORT(pci_pme_capable)
-bool pci_pme_capable(struct pci_dev *dev, pci_power_t state);
-#endif
-
 #ifndef PCI_DEVICE_SUB
 /**
  * PCI_DEVICE_SUB - macro used to describe a specific pci device with subsystem
@@ -234,7 +134,7 @@ static inline int pci_vfs_assigned(struct pci_dev *dev)
 
 #endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,10,0) */
 
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,14,0)) && (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,30))
+#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,14,0))
 #define pci_enable_msi_range LINUX_BACKPORT(pci_enable_msi_range)
 #ifdef CONFIG_PCI_MSI
 int pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec);
diff --git a/backport/backport-include/linux/rcupdate.h b/backport/backport-include/linux/rcupdate.h
index d6d9262bb64d..230d12f8c9cd 100644
--- a/backport/backport-include/linux/rcupdate.h
+++ b/backport/backport-include/linux/rcupdate.h
@@ -41,11 +41,4 @@
 #define rcu_dereference_raw(p)	rcu_dereference(p)
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,34)
-static inline int rcu_read_lock_held(void)
-{
-	return 1;
-}
-#endif
-
 #endif /* __BACKPORT_LINUX_RCUPDATE_H */
diff --git a/backport/backport-include/net/netlink.h b/backport/backport-include/net/netlink.h
index 4f8308adbada..9324d02d2c86 100644
--- a/backport/backport-include/net/netlink.h
+++ b/backport/backport-include/net/netlink.h
@@ -87,11 +87,7 @@ static inline s8 nla_get_s8(const struct nlattr *nla)
  * @nla: s64 netlink attribute
  */
 #define nla_get_s64 LINUX_BACKPORT(nla_get_s64)
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,29))
 static inline s64 nla_get_s64(const struct nlattr *nla)
-#else
-static inline s64 nla_get_s64(struct nlattr *nla)
-#endif
 {
 	s64 tmp;
 
diff --git a/backport/compat/backport-3.10.c b/backport/compat/backport-3.10.c
index c7a1c182a9d1..9bcb8059506a 100644
--- a/backport/compat/backport-3.10.c
+++ b/backport/compat/backport-3.10.c
@@ -96,7 +96,6 @@ unsigned int get_random_int(void)
 }
 EXPORT_SYMBOL_GPL(get_random_int);
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,28))
 #ifdef CONFIG_TTY
 /**
  * tty_port_tty_wakeup - helper to wake up a tty
@@ -174,8 +173,6 @@ int pci_vfs_assigned(struct pci_dev *dev)
 EXPORT_SYMBOL_GPL(pci_vfs_assigned);
 #endif /* CONFIG_PCI_IOV */
 
-#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,28)) */
-
 #ifdef CONFIG_OF
 /**
  * of_find_property_value_of_size
diff --git a/backport/compat/backport-3.13.c b/backport/compat/backport-3.13.c
index a76108818cbf..fd562bb1d605 100644
--- a/backport/compat/backport-3.13.c
+++ b/backport/compat/backport-3.13.c
@@ -93,62 +93,6 @@ EXPORT_SYMBOL_GPL(devm_regulator_unregister);
 #undef genl_register_family
 #undef genl_unregister_family
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,37)
-#undef genl_info
-static LIST_HEAD(backport_nl_fam);
-
-static struct genl_ops *genl_get_cmd(u8 cmd, struct genl_family *family)
-{
-	struct genl_ops *ops;
-
-	list_for_each_entry(ops, &family->family.ops_list, ops.ops_list)
-		if (ops->cmd == cmd)
-			return ops;
-
-	return NULL;
-}
-
-static int nl_doit_wrapper(struct sk_buff *skb, struct genl_info *info)
-{
-	struct backport_genl_info backport_info;
-	struct genl_family *family;
-	struct genl_ops *ops;
-	int err;
-
-	list_for_each_entry(family, &backport_nl_fam, list) {
-		if (family->id == info->nlhdr->nlmsg_type)
-			goto found;
-	}
-	return -ENOENT;
-
-found:
-	ops = genl_get_cmd(info->genlhdr->cmd, family);
-	if (!ops)
-		return -ENOENT;
-
-	memset(&backport_info.user_ptr, 0, sizeof(backport_info.user_ptr));
-	backport_info.info = info;
-#define __copy(_field) backport_info._field = info->_field
-	__copy(snd_seq);
-	__copy(snd_pid);
-	__copy(genlhdr);
-	__copy(attrs);
-#undef __copy
-	if (family->pre_doit) {
-		err = family->pre_doit(ops, skb, &backport_info);
-		if (err)
-			return err;
-	}
-
-	err = ops->doit(skb, &backport_info);
-
-	if (family->post_doit)
-		family->post_doit(ops, skb, &backport_info);
-
-	return err;
-}
-#endif /* < 2.6.37 */
-
 int __backport_genl_register_family(struct genl_family *family)
 {
 	int i, ret;
@@ -159,13 +103,9 @@ int __backport_genl_register_family(struct genl_family *family)
 	__copy(version);
 	__copy(maxattr);
 	strncpy(family->family.name, family->name, sizeof(family->family.name));
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,32)
 	__copy(netnsok);
-#endif
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,37)
 	__copy(pre_doit);
 	__copy(post_doit);
-#endif
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(3,10,0)
 	__copy(parallel_ops);
 #endif
@@ -182,26 +122,10 @@ int __backport_genl_register_family(struct genl_family *family)
 	family->id = family->family.id;
 
 	for (i = 0; i < family->n_ops; i++) {
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,37)
-#define __copy(_field) family->ops[i].ops._field = family->ops[i]._field
-		__copy(cmd);
-		__copy(flags);
-		__copy(policy);
-		__copy(dumpit);
-		__copy(done);
-#undef __copy
-		if (family->ops[i].doit)
-			family->ops[i].ops.doit = nl_doit_wrapper;
-		ret = genl_register_ops(&family->family, &family->ops[i].ops);
-#else
 		ret = genl_register_ops(&family->family, &family->ops[i]);
-#endif
 		if (ret < 0)
 			goto error;
 	}
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,37)
-	list_add(&family->list, &backport_nl_fam);
-#endif
 
 	for (i = 0; i < family->n_mcgrps; i++) {
 		ret = genl_register_mc_group(&family->family,
@@ -222,9 +146,6 @@ int backport_genl_unregister_family(struct genl_family *family)
 {
 	int err;
 	err = genl_unregister_family(&family->family);
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,37)
-	list_del(&family->list);
-#endif
 	return err;
 }
 EXPORT_SYMBOL_GPL(backport_genl_unregister_family);
diff --git a/backport/compat/backport-3.14.c b/backport/compat/backport-3.14.c
index bce50dc55d52..aeb300454215 100644
--- a/backport/compat/backport-3.14.c
+++ b/backport/compat/backport-3.14.c
@@ -11,7 +11,6 @@
 #include <linux/kernel.h>
 #include <linux/pci.h>
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,30)
 #ifdef CONFIG_PCI_MSI
 /**
  * pci_enable_msi_range - configure device's MSI capability structure
@@ -48,7 +47,6 @@ int pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec)
 }
 EXPORT_SYMBOL(pci_enable_msi_range);
 #endif
-#endif
 
 #ifdef CONFIG_PCI_MSI
 /**
diff --git a/backport/compat/compat-3.3.c b/backport/compat/compat-3.3.c
index 75bd5e530e1e..7ddc2bd277de 100644
--- a/backport/compat/compat-3.3.c
+++ b/backport/compat/compat-3.3.c
@@ -23,12 +23,8 @@ static void __copy_skb_header(struct sk_buff *new, const struct sk_buff *old)
 	new->transport_header	= old->transport_header;
 	new->network_header	= old->network_header;
 	new->mac_header		= old->mac_header;
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
 	skb_dst_copy(new, old);
 	new->rxhash		= old->rxhash;
-#else
-	skb_dst_set(new, dst_clone(skb_dst(old)));
-#endif
 #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,1,0))
 	new->ooo_okay		= old->ooo_okay;
 #endif
@@ -50,9 +46,7 @@ static void __copy_skb_header(struct sk_buff *new, const struct sk_buff *old)
 #endif
 	new->protocol		= old->protocol;
 	new->mark		= old->mark;
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,33))
 	new->skb_iif		= old->skb_iif;
-#endif
 	__nf_copy(new, old);
 #if IS_ENABLED(CONFIG_NETFILTER_XT_TARGET_TRACE)
 	new->nf_trace		= old->nf_trace;
@@ -63,9 +57,7 @@ static void __copy_skb_header(struct sk_buff *new, const struct sk_buff *old)
 	new->tc_verd		= old->tc_verd;
 #endif
 #endif
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,27))
 	new->vlan_tci		= old->vlan_tci;
-#endif
 
 	skb_copy_secmark(new, old);
 }
@@ -198,15 +190,7 @@ backport_alloc_workqueue(const char *fmt, unsigned int flags,
 	vsnprintf(n->name, sizeof(n->name), fmt, args);
 	va_end(args);
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,36)
-	wq = __create_workqueue_key(n->name, max_active == 1, 0,
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,28)
-				    0,
-#endif
-				    key, lock_name);
-#else
 	wq = __alloc_workqueue_key(n->name, flags, max_active, key, lock_name);
-#endif
 	if (!wq) {
 		kfree(n);
 		return NULL;
diff --git a/backport/compat/compat-3.8.c b/backport/compat/compat-3.8.c
index 49dc44bd4664..a318c15bd775 100644
--- a/backport/compat/compat-3.8.c
+++ b/backport/compat/compat-3.8.c
@@ -333,37 +333,24 @@ bool hid_ignore(struct hid_device *hdev)
 			return true;
 		break;
 	case USB_VENDOR_ID_JESS:
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,28))
 		if (hdev->product == USB_DEVICE_ID_JESS_YUREX &&
 				hdev->type == HID_TYPE_USBNONE)
 			return true;
-#else
-		if (hdev->product == USB_DEVICE_ID_JESS_YUREX)
-			return true;
-#endif
 		break;
 	case USB_VENDOR_ID_DWAV:
 		/* These are handled by usbtouchscreen. hdev->type is probably
 		 * HID_TYPE_USBNONE, but we say !HID_TYPE_USBMOUSE to match
 		 * usbtouchscreen. */
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,28))
 		if ((hdev->product == USB_DEVICE_ID_EGALAX_TOUCHCONTROLLER ||
 		     hdev->product == USB_DEVICE_ID_DWAV_TOUCHCONTROLLER) &&
 		    hdev->type != HID_TYPE_USBMOUSE)
 			return true;
-#else
-		if (hdev->product == USB_DEVICE_ID_EGALAX_TOUCHCONTROLLER ||
-		     hdev->product == USB_DEVICE_ID_DWAV_TOUCHCONTROLLER)
-			return true;
-#endif
 		break;
 	}
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,28))
 	if (hdev->type == HID_TYPE_USBMOUSE &&
 			hid_match_id(hdev, hid_mouse_ignore_list))
 		return true;
-#endif
 
 	return !!hid_match_id(hdev, hid_ignore_list);
 }
-- 
1.9.0

