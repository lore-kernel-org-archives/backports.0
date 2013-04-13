Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:44233 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753678Ab3DMXzO (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 13 Apr 2013 19:55:14 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [RFC/RFT 31/42] backports: dissolve compat-2.6.29.h
Date: Sun, 14 Apr 2013 01:53:51 +0200
Message-Id: <1365897243-31214-32-git-send-email-johannes@sipsolutions.net> (sfid-20130414_015517_068247_39295C4F)
In-Reply-To: <1365897243-31214-1-git-send-email-johannes@sipsolutions.net>
References: <1365897243-31214-1-git-send-email-johannes@sipsolutions.net>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/compat-2.6.29.h | 431 ------------------------
 backport/backport-include/linux/etherdevice.h   |   9 +
 backport/backport-include/linux/kernel.h        |  12 +
 backport/backport-include/linux/netdevice.h     | 110 ++++++
 backport/backport-include/linux/pci.h           |  67 ++++
 backport/backport-include/linux/pci_regs.h      |   8 +
 backport/backport-include/linux/skbuff.h        |  15 +
 backport/backport-include/linux/types.h         |  26 ++
 backport/backport-include/linux/usb.h           |  15 +
 backport/backport-include/net/net_namespace.h   |  18 +
 10 files changed, 280 insertions(+), 431 deletions(-)
 delete mode 100644 backport/backport-include/linux/compat-2.6.29.h

diff --git a/backport/backport-include/linux/compat-2.6.29.h b/backport/backport-include/linux/compat-2.6.29.h
deleted file mode 100644
index adcde36..0000000
--- a/backport/backport-include/linux/compat-2.6.29.h
+++ /dev/null
@@ -1,431 +0,0 @@
-#ifndef LINUX_26_29_COMPAT_H
-#define LINUX_26_29_COMPAT_H
-
-#include <linux/version.h>
-struct net_device;
-#include <linux/netdevice.h>
-#include <linux/if_link.h>
-
-/*
- * I kow this looks odd.. but 2.6.32 added the netdev_tx_t
- * and we backport that there so inlcude that header first
- * as we need it for the netdev ops.
- */
-#include <linux/compat-2.6.32.h>
-
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,29))
-
-#include <linux/skbuff.h>
-#include <linux/usb.h>
-#include <linux/types.h>
-#include <linux/pci_regs.h>
-
-#define napi_gro_receive(napi, skb) netif_receive_skb(skb)
-
-/* backports  */
-static inline void usb_autopm_put_interface_async(struct usb_interface *intf)
-{ }
-static inline int usb_autopm_get_interface_async(struct usb_interface *intf)
-{ return 0; }
-
-#if \
-	defined(CONFIG_ALPHA) || defined(CONFIG_AVR32) || \
-	defined(CONFIG_BLACKFIN) || defined(CONFIG_CRIS) || \
-	defined(CONFIG_H8300) || defined(CONFIG_IA64) || \
-	defined(CONFIG_M68K) ||  defined(CONFIG_MIPS) || \
-	defined(CONFIG_PARISC) || defined(CONFIG_S390) || \
-	defined(CONFIG_PPC64) || defined(CONFIG_PPC32) || \
-	defined(CONFIG_SUPERH) || defined(CONFIG_SPARC) || \
-	defined(CONFIG_FRV) || defined(CONFIG_X86) || \
-	defined(CONFIG_M32R) || defined(CONFIG_M68K) || \
-	defined(CONFIG_MN10300) || defined(CONFIG_XTENSA) || \
-	defined(CONFIG_ARM)
-#include <asm/atomic.h>
-#else
-typedef struct {
-	volatile int counter;
-} atomic_t;
-
-#ifdef CONFIG_64BIT
-typedef struct {
-	volatile long counter;
-} atomic64_t;
-#endif /* CONFIG_64BIT */
-
-#endif
-
-#define  PCI_EXP_LNKCTL_ES     0x0080  /* Extended Synch */
-
-/*
- * Older kernels do not have struct net_device_ops but what we can
- * do is just define the data structure and use a caller to let us
- * set the data structure's routines onto the old netdev, essentially
- * doing it the old way. This avoids huge deltas on our backports.
- */
-
-/*
- * This structure defines the management hooks for network devices.
- * The following hooks can be defined; unless noted otherwise, they are
- * optional and can be filled with a null pointer.
- *
- * int (*ndo_init)(struct net_device *dev);
- *     This function is called once when network device is registered.
- *     The network device can use this to any late stage initializaton
- *     or semantic validattion. It can fail with an error code which will
- *     be propogated back to register_netdev
- *
- * void (*ndo_uninit)(struct net_device *dev);
- *     This function is called when device is unregistered or when registration
- *     fails. It is not called if init fails.
- *
- * int (*ndo_open)(struct net_device *dev);
- *     This function is called when network device transistions to the up
- *     state.
- *
- * int (*ndo_stop)(struct net_device *dev);
- *     This function is called when network device transistions to the down
- *     state.
- *
- * netdev_tx_t (*ndo_start_xmit)(struct sk_buff *skb,
- *                               struct net_device *dev);
- *	Called when a packet needs to be transmitted.
- *	Must return NETDEV_TX_OK , NETDEV_TX_BUSY.
- *        (can also return NETDEV_TX_LOCKED iff NETIF_F_LLTX)
- *	Required can not be NULL.
- *
- * u16 (*ndo_select_queue)(struct net_device *dev, struct sk_buff *skb);
- *	Called to decide which queue to when device supports multiple
- *	transmit queues.
- *
- * void (*ndo_change_rx_flags)(struct net_device *dev, int flags);
- *	This function is called to allow device receiver to make
- *	changes to configuration when multicast or promiscious is enabled.
- *
- * void (*ndo_set_rx_mode)(struct net_device *dev);
- *	This function is called device changes address list filtering.
- *
- * void (*ndo_set_multicast_list)(struct net_device *dev);
- *	This function is called when the multicast address list changes.
- *
- * int (*ndo_set_mac_address)(struct net_device *dev, void *addr);
- *	This function  is called when the Media Access Control address
- *	needs to be changed. If this interface is not defined, the
- *	mac address can not be changed.
- *
- * int (*ndo_validate_addr)(struct net_device *dev);
- *	Test if Media Access Control address is valid for the device.
- *
- * int (*ndo_do_ioctl)(struct net_device *dev, struct ifreq *ifr, int cmd);
- *	Called when a user request an ioctl which can't be handled by
- *	the generic interface code. If not defined ioctl's return
- *	not supported error code.
- *
- * int (*ndo_set_config)(struct net_device *dev, struct ifmap *map);
- *	Used to set network devices bus interface parameters. This interface
- *	is retained for legacy reason, new devices should use the bus
- *	interface (PCI) for low level management.
- *
- * int (*ndo_change_mtu)(struct net_device *dev, int new_mtu);
- *	Called when a user wants to change the Maximum Transfer Unit
- *	of a device. If not defined, any request to change MTU will
- *	will return an error.
- *
- * void (*ndo_tx_timeout)(struct net_device *dev);
- *	Callback uses when the transmitter has not made any progress
- *	for dev->watchdog ticks.
- *
- * struct net_device_stats* (*ndo_get_stats)(struct net_device *dev);
- *	Called when a user wants to get the network device usage
- *	statistics. If not defined, the counters in dev->stats will
- *	be used.
- *
- * void (*ndo_vlan_rx_register)(struct net_device *dev, struct vlan_group *grp);
- *	If device support VLAN receive accleration
- *	(ie. dev->features & NETIF_F_HW_VLAN_RX), then this function is called
- *	when vlan groups for the device changes.  Note: grp is NULL
- *	if no vlan's groups are being used.
- *
- * void (*ndo_vlan_rx_add_vid)(struct net_device *dev, unsigned short vid);
- *	If device support VLAN filtering (dev->features & NETIF_F_HW_VLAN_FILTER)
- *	this function is called when a VLAN id is registered.
- *
- * void (*ndo_vlan_rx_kill_vid)(struct net_device *dev, unsigned short vid);
- *	If device support VLAN filtering (dev->features & NETIF_F_HW_VLAN_FILTER)
- *	this function is called when a VLAN id is unregistered.
- *
- * void (*ndo_poll_controller)(struct net_device *dev);
- *
- *	SR-IOV management functions.
- * int (*ndo_set_vf_mac)(struct net_device *dev, int vf, u8* mac);
- * int (*ndo_set_vf_vlan)(struct net_device *dev, int vf, u16 vlan, u8 qos);
- * int (*ndo_set_vf_tx_rate)(struct net_device *dev, int vf, int rate);
- * int (*ndo_get_vf_config)(struct net_device *dev,
- *			    int vf, struct ifla_vf_info *ivf);
- */
-#define HAVE_NET_DEVICE_OPS
-struct net_device_ops {
-	int			(*ndo_init)(struct net_device *dev);
-	void			(*ndo_uninit)(struct net_device *dev);
-	int			(*ndo_open)(struct net_device *dev);
-	int			(*ndo_stop)(struct net_device *dev);
-	netdev_tx_t		(*ndo_start_xmit) (struct sk_buff *skb,
-						   struct net_device *dev);
-	u16			(*ndo_select_queue)(struct net_device *dev,
-						    struct sk_buff *skb);
-	void			(*ndo_change_rx_flags)(struct net_device *dev,
-						       int flags);
-	void			(*ndo_set_rx_mode)(struct net_device *dev);
-	void			(*ndo_set_multicast_list)(struct net_device *dev);
-	int			(*ndo_set_mac_address)(struct net_device *dev,
-						       void *addr);
-	int			(*ndo_validate_addr)(struct net_device *dev);
-	int			(*ndo_do_ioctl)(struct net_device *dev,
-					        struct ifreq *ifr, int cmd);
-	int			(*ndo_set_config)(struct net_device *dev,
-					          struct ifmap *map);
-	int			(*ndo_change_mtu)(struct net_device *dev,
-						  int new_mtu);
-	int			(*ndo_neigh_setup)(struct net_device *dev,
-						   struct neigh_parms *);
-	void			(*ndo_tx_timeout) (struct net_device *dev);
-
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36))
-	struct rtnl_link_stats64* (*ndo_get_stats64)(struct net_device *dev,
-						     struct rtnl_link_stats64 *storage);
-#endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,36)) */
-
-	struct net_device_stats* (*ndo_get_stats)(struct net_device *dev);
-
-	void			(*ndo_vlan_rx_register)(struct net_device *dev,
-						        struct vlan_group *grp);
-	void			(*ndo_vlan_rx_add_vid)(struct net_device *dev,
-						       unsigned short vid);
-	void			(*ndo_vlan_rx_kill_vid)(struct net_device *dev,
-						        unsigned short vid);
-#ifdef CONFIG_NET_POLL_CONTROLLER
-	void                    (*ndo_poll_controller)(struct net_device *dev);
-#endif
-	int			(*ndo_set_vf_mac)(struct net_device *dev,
-						  int queue, u8 *mac);
-	int			(*ndo_set_vf_vlan)(struct net_device *dev,
-						   int queue, u16 vlan, u8 qos);
-	int			(*ndo_set_vf_tx_rate)(struct net_device *dev,
-						      int vf, int rate);
-/*
- * The struct ifla_vf_info was added via b280da8d54b8d82b52f368a8703b7ada6c1744d5
- * on the v2.6.34-rc1~233^2~338 release
- */
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,34))
-	int			(*ndo_get_vf_config)(struct net_device *dev,
-						     int vf,
-						     struct ifla_vf_info *ivf);
-#endif
-#if defined(CONFIG_FCOE) || defined(CONFIG_FCOE_MODULE)
-	int			(*ndo_fcoe_enable)(struct net_device *dev);
-	int			(*ndo_fcoe_disable)(struct net_device *dev);
-	int			(*ndo_fcoe_ddp_setup)(struct net_device *dev,
-						      u16 xid,
-						      struct scatterlist *sgl,
-						      unsigned int sgc);
-	int			(*ndo_fcoe_ddp_done)(struct net_device *dev,
-						     u16 xid);
-#define NETDEV_FCOE_WWNN 0
-#define NETDEV_FCOE_WWPN 1
-	int			(*ndo_fcoe_get_wwn)(struct net_device *dev,
-						    u64 *wwn, int type);
-#endif
-};
-
-static inline int ndo_do_ioctl(struct net_device *dev,
-			       struct ifreq *ifr,
-			       int cmd)
-{
-	if (dev->do_ioctl)
-		return dev->do_ioctl(dev, ifr, cmd);
-	return -EOPNOTSUPP;
-}
-
-
-#define netdev_attach_ops LINUX_BACKPORT(netdev_attach_ops)
-void netdev_attach_ops(struct net_device *dev,
-		       const struct net_device_ops *ops);
-
-/**
- *	skb_queue_is_first - check if skb is the first entry in the queue
- *	@list: queue head
- *	@skb: buffer
- *
- *	Returns true if @skb is the first buffer on the list.
- */
-static inline bool skb_queue_is_first(const struct sk_buff_head *list,
-				      const struct sk_buff *skb)
-{
-	return (skb->prev == (struct sk_buff *) list);
-}
-
-/**
- *	skb_queue_prev - return the prev packet in the queue
- *	@list: queue head
- *	@skb: current buffer
- *
- *	Return the prev packet in @list before @skb.  It is only valid to
- *	call this if skb_queue_is_first() evaluates to false.
- */
-static inline struct sk_buff *skb_queue_prev(const struct sk_buff_head *list,
-					     const struct sk_buff *skb)
-{
-	/* This BUG_ON may seem severe, but if we just return then we
-	 * are going to dereference garbage.
-	 */
-	BUG_ON(skb_queue_is_first(list, skb));
-	return skb->prev;
-}
-
-
-static inline struct net_device_stats *dev_get_stats(struct net_device *dev)
-{
-	return dev->get_stats(dev);
-}
-
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,23))
-#if defined(CONFIG_USB) || defined(CONFIG_USB_MODULE)
-#define usb_unpoison_anchored_urbs LINUX_BACKPORT(usb_unpoison_anchored_urbs)
-extern void usb_unpoison_anchored_urbs(struct usb_anchor *anchor);
-#endif /* CONFIG_USB */
-#endif
-
-#define DIV_ROUND_CLOSEST(x, divisor)(			\
-{							\
-	typeof(divisor) __divisor = divisor;		\
-	(((x) + ((__divisor) / 2)) / (__divisor));	\
-}							\
-)
-
-#define eth_mac_addr LINUX_BACKPORT(eth_mac_addr)
-extern int eth_mac_addr(struct net_device *dev, void *p);
-#define eth_change_mtu LINUX_BACKPORT(eth_change_mtu)
-extern int eth_change_mtu(struct net_device *dev, int new_mtu);
-#define eth_validate_addr LINUX_BACKPORT(eth_validate_addr)
-extern int eth_validate_addr(struct net_device *dev);
-
-#ifdef CONFIG_NET_NS
-
-static inline void write_pnet(struct net **pnet, struct net *net)
-{
-	*pnet = net;
-}
-
-static inline struct net *read_pnet(struct net * const *pnet)
-{
-	return *pnet;
-}
-
-#else
-
-#define write_pnet(pnet, net)	do { (void)(net);} while (0)
-#define read_pnet(pnet)		(&init_net)
-
-/*
- * swap - swap value of @a and @b
- */
-#define swap(a, b) \
-	do { typeof(a) __tmp = (a); (a) = (b); (b) = __tmp; } while (0)
-
-#endif
-
-#define init_dummy_netdev LINUX_BACKPORT(init_dummy_netdev)
-extern int		init_dummy_netdev(struct net_device *dev);
-
-#else /* (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,29)) */
-
-/* Kernels >= 2.6.29 follows */
-
-/* XXX: this can probably just go upstream ! */
-static inline void netdev_attach_ops(struct net_device *dev,
-		       const struct net_device_ops *ops)
-{
-	dev->netdev_ops = ops;
-}
-
-/* XXX: this can probably just go upstream! */
-static inline int ndo_do_ioctl(struct net_device *dev,
-			       struct ifreq *ifr,
-			       int cmd)
-{
-	if (dev->netdev_ops && dev->netdev_ops->ndo_do_ioctl)
-		return dev->netdev_ops->ndo_do_ioctl(dev, ifr, cmd);
-	return -EOPNOTSUPP;
-}
-
-#endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,29)) */
-
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
-#define  PCI_EXP_SLTSTA_PDS	0x0040  /* Presence Detect State */
-
-#endif /*  LINUX_26_29_COMPAT_H */
diff --git a/backport/backport-include/linux/etherdevice.h b/backport/backport-include/linux/etherdevice.h
index b35735d..03208b6 100644
--- a/backport/backport-include/linux/etherdevice.h
+++ b/backport/backport-include/linux/etherdevice.h
@@ -103,6 +103,15 @@ static inline int is_unicast_ether_addr(const u8 *addr)
 }
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,29)
+#define eth_mac_addr LINUX_BACKPORT(eth_mac_addr)
+extern int eth_mac_addr(struct net_device *dev, void *p);
+#define eth_change_mtu LINUX_BACKPORT(eth_change_mtu)
+extern int eth_change_mtu(struct net_device *dev, int new_mtu);
+#define eth_validate_addr LINUX_BACKPORT(eth_validate_addr)
+extern int eth_validate_addr(struct net_device *dev);
+#endif /* < 2.6.29 */
+
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,35)
 #define netdev_hw_addr dev_mc_list
 #endif
diff --git a/backport/backport-include/linux/kernel.h b/backport/backport-include/linux/kernel.h
index f189f54..19ea0e9 100644
--- a/backport/backport-include/linux/kernel.h
+++ b/backport/backport-include/linux/kernel.h
@@ -190,4 +190,16 @@ int hex_to_bin(char ch);
 #define round_down(x, y) ((x) & ~__round_mask(x, y))
 #endif
 
+#ifndef DIV_ROUND_CLOSEST
+#define DIV_ROUND_CLOSEST(x, divisor) ({		\
+	typeof(divisor) __divisor = divisor;		\
+	(((x) + ((__divisor) / 2)) / (__divisor));	\
+})
+#endif
+
+#ifndef swap
+#define swap(a, b) \
+	do { typeof(a) __tmp = (a); (a) = (b); (b) = __tmp; } while (0)
+#endif
+
 #endif /* __BACKPORT_KERNEL_H */
diff --git a/backport/backport-include/linux/netdevice.h b/backport/backport-include/linux/netdevice.h
index 0300ca0..dc08764 100644
--- a/backport/backport-include/linux/netdevice.h
+++ b/backport/backport-include/linux/netdevice.h
@@ -15,6 +15,84 @@
 typedef int netdev_tx_t;
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,29)
+/*
+ * Older kernels do not have struct net_device_ops but what we can
+ * do is just define the data structure and use a caller to let us
+ * set the data structure's routines onto the old netdev, essentially
+ * doing it the old way. This avoids huge deltas on our backports.
+ */
+#define HAVE_NET_DEVICE_OPS
+struct net_device_ops {
+	int			(*ndo_init)(struct net_device *dev);
+	void			(*ndo_uninit)(struct net_device *dev);
+	int			(*ndo_open)(struct net_device *dev);
+	int			(*ndo_stop)(struct net_device *dev);
+	netdev_tx_t		(*ndo_start_xmit) (struct sk_buff *skb,
+						   struct net_device *dev);
+	u16			(*ndo_select_queue)(struct net_device *dev,
+						    struct sk_buff *skb);
+	void			(*ndo_change_rx_flags)(struct net_device *dev,
+						       int flags);
+	void			(*ndo_set_rx_mode)(struct net_device *dev);
+	void			(*ndo_set_multicast_list)(struct net_device *dev);
+	int			(*ndo_set_mac_address)(struct net_device *dev,
+						       void *addr);
+	int			(*ndo_validate_addr)(struct net_device *dev);
+	int			(*ndo_do_ioctl)(struct net_device *dev,
+					        struct ifreq *ifr, int cmd);
+	int			(*ndo_set_config)(struct net_device *dev,
+					          struct ifmap *map);
+	int			(*ndo_change_mtu)(struct net_device *dev,
+						  int new_mtu);
+	int			(*ndo_neigh_setup)(struct net_device *dev,
+						   struct neigh_parms *);
+	void			(*ndo_tx_timeout) (struct net_device *dev);
+
+	struct net_device_stats* (*ndo_get_stats)(struct net_device *dev);
+
+	void			(*ndo_vlan_rx_register)(struct net_device *dev,
+						        struct vlan_group *grp);
+	void			(*ndo_vlan_rx_add_vid)(struct net_device *dev,
+						       unsigned short vid);
+	void			(*ndo_vlan_rx_kill_vid)(struct net_device *dev,
+						        unsigned short vid);
+#ifdef CONFIG_NET_POLL_CONTROLLER
+	void                    (*ndo_poll_controller)(struct net_device *dev);
+#endif
+	int			(*ndo_set_vf_mac)(struct net_device *dev,
+						  int queue, u8 *mac);
+	int			(*ndo_set_vf_vlan)(struct net_device *dev,
+						   int queue, u16 vlan, u8 qos);
+	int			(*ndo_set_vf_tx_rate)(struct net_device *dev,
+						      int vf, int rate);
+#if defined(CONFIG_FCOE) || defined(CONFIG_FCOE_MODULE)
+	int			(*ndo_fcoe_enable)(struct net_device *dev);
+	int			(*ndo_fcoe_disable)(struct net_device *dev);
+	int			(*ndo_fcoe_ddp_setup)(struct net_device *dev,
+						      u16 xid,
+						      struct scatterlist *sgl,
+						      unsigned int sgc);
+	int			(*ndo_fcoe_ddp_done)(struct net_device *dev,
+						     u16 xid);
+#define NETDEV_FCOE_WWNN 0
+#define NETDEV_FCOE_WWPN 1
+	int			(*ndo_fcoe_get_wwn)(struct net_device *dev,
+						    u64 *wwn, int type);
+#endif
+};
+
+static inline struct net_device_stats *dev_get_stats(struct net_device *dev)
+{
+	return dev->get_stats(dev);
+}
+
+#define init_dummy_netdev LINUX_BACKPORT(init_dummy_netdev)
+extern int init_dummy_netdev(struct net_device *dev);
+
+#define napi_gro_receive(napi, skb) netif_receive_skb(skb)
+#endif /* < 2.6.29 */
+
 #if (LINUX_VERSION_CODE < KERNEL_VERSION(3,8,0))
 #define netdev_set_default_ethtool_ops LINUX_BACKPORT(netdev_set_default_ethtool_ops)
 extern void netdev_set_default_ethtool_ops(struct net_device *dev,
@@ -28,6 +106,38 @@ extern int __dev_addr_sync(struct dev_addr_list **to, int *to_count, struct dev_
 extern void __dev_addr_unsync(struct dev_addr_list **to, int *to_count, struct dev_addr_list **from, int *from_count);
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,29)
+#define netdev_attach_ops LINUX_BACKPORT(netdev_attach_ops)
+void netdev_attach_ops(struct net_device *dev,
+		       const struct net_device_ops *ops);
+
+static inline int ndo_do_ioctl(struct net_device *dev,
+			       struct ifreq *ifr,
+			       int cmd)
+{
+	if (dev->do_ioctl)
+		return dev->do_ioctl(dev, ifr, cmd);
+	return -EOPNOTSUPP;
+}
+#else
+/* XXX: this can probably just go upstream ! */
+static inline void netdev_attach_ops(struct net_device *dev,
+		       const struct net_device_ops *ops)
+{
+	dev->netdev_ops = ops;
+}
+
+/* XXX: this can probably just go upstream! */
+static inline int ndo_do_ioctl(struct net_device *dev,
+			       struct ifreq *ifr,
+			       int cmd)
+{
+	if (dev->netdev_ops && dev->netdev_ops->ndo_do_ioctl)
+		return dev->netdev_ops->ndo_do_ioctl(dev, ifr, cmd);
+	return -EOPNOTSUPP;
+}
+#endif
+
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3,3,0)
 /*
  * BQL was added as of v3.3 but some Linux distributions
diff --git a/backport/backport-include/linux/pci.h b/backport/backport-include/linux/pci.h
index e85db3a..49bcc6f 100644
--- a/backport/backport-include/linux/pci.h
+++ b/backport/backport-include/linux/pci.h
@@ -12,6 +12,73 @@ int __must_check pci_enable_device_mem(struct pci_dev *dev);
 	const struct pci_device_id _table[] __devinitdata
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,29)
+#define compat_pci_suspend(fn)						\
+	int fn##_compat(struct pci_dev *pdev, pm_message_t state) 	\
+	{								\
+		int r;							\
+									\
+		r = fn(&pdev->dev);					\
+		if (r)							\
+			return r;					\
+									\
+		pci_save_state(pdev);					\
+		pci_disable_device(pdev);				\
+		pci_set_power_state(pdev, PCI_D3hot);			\
+									\
+		return 0;						\
+	}
+
+#define compat_pci_resume(fn)						\
+	int fn##_compat(struct pci_dev *pdev)				\
+	{								\
+		int r;							\
+									\
+		pci_set_power_state(pdev, PCI_D0);			\
+		r = pci_enable_device(pdev);				\
+		if (r)							\
+			return r;					\
+		pci_restore_state(pdev);				\
+									\
+		return fn(&pdev->dev);					\
+	}
+#elif LINUX_VERSION_CODE == KERNEL_VERSION(2,6,29)
+#define compat_pci_suspend(fn)						\
+	int fn##_compat(struct device *dev)			 	\
+	{								\
+		struct pci_dev *pdev = to_pci_dev(dev);			\
+		int r;							\
+									\
+		r = fn(&pdev->dev);					\
+		if (r)							\
+			return r;					\
+									\
+		pci_save_state(pdev);					\
+		pci_disable_device(pdev);				\
+		pci_set_power_state(pdev, PCI_D3hot);			\
+									\
+		return 0;						\
+	}
+
+#define compat_pci_resume(fn)						\
+	int fn##_compat(struct device *dev)				\
+	{								\
+		struct pci_dev *pdev = to_pci_dev(dev);			\
+		int r;							\
+									\
+		pci_set_power_state(pdev, PCI_D0);			\
+		r = pci_enable_device(pdev);				\
+		if (r)							\
+			return r;					\
+		pci_restore_state(pdev);				\
+									\
+		return fn(&pdev->dev);					\
+	}
+#else
+#define compat_pci_suspend(fn)
+#define compat_pci_resume(fn)
+#endif
+
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3,4,0)
 /**
  * module_pci_driver() - Helper macro for registering a PCI driver
diff --git a/backport/backport-include/linux/pci_regs.h b/backport/backport-include/linux/pci_regs.h
index f7bfd9a..2591a14 100644
--- a/backport/backport-include/linux/pci_regs.h
+++ b/backport/backport-include/linux/pci_regs.h
@@ -103,4 +103,12 @@
 #define PCI_EXP_SLTCTL2			56      /* Slot Control 2 */
 #endif
 
+#ifndef PCI_EXP_LNKCTL_ES
+#define PCI_EXP_LNKCTL_ES     0x0080  /* Extended Synch */
+#endif
+
+#ifndef PCI_EXP_SLTSTA_PDS
+#define PCI_EXP_SLTSTA_PDS	0x0040  /* Presence Detect State */
+#endif
+
 #endif /* __BACKPORT_UAPI_PCI_REGS_H */
diff --git a/backport/backport-include/linux/skbuff.h b/backport/backport-include/linux/skbuff.h
index cc145a6..007d21d 100644
--- a/backport/backport-include/linux/skbuff.h
+++ b/backport/backport-include/linux/skbuff.h
@@ -122,4 +122,19 @@ static inline struct sk_buff *netdev_alloc_skb_ip_align(struct net_device *dev,
 	for (iter = skb_shinfo(skb)->frag_list; iter; iter = iter->next)
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,29)
+static inline bool skb_queue_is_first(const struct sk_buff_head *list,
+				      const struct sk_buff *skb)
+{
+	return (skb->prev == (struct sk_buff *) list);
+}
+
+static inline struct sk_buff *skb_queue_prev(const struct sk_buff_head *list,
+					     const struct sk_buff *skb)
+{
+	BUG_ON(skb_queue_is_first(list, skb));
+	return skb->prev;
+}
+#endif
+
 #endif /* __BACKPORT_SKBUFF_H */
diff --git a/backport/backport-include/linux/types.h b/backport/backport-include/linux/types.h
index b787df6..504a615 100644
--- a/backport/backport-include/linux/types.h
+++ b/backport/backport-include/linux/types.h
@@ -32,4 +32,30 @@ typedef u32 phys_addr_t;
 
 #endif /* < 2.6.28 */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,29) && \
+	(defined(CONFIG_ALPHA) || defined(CONFIG_AVR32) || \
+	 defined(CONFIG_BLACKFIN) || defined(CONFIG_CRIS) || \
+	 defined(CONFIG_H8300) || defined(CONFIG_IA64) || \
+	 defined(CONFIG_M68K) ||  defined(CONFIG_MIPS) || \
+	 defined(CONFIG_PARISC) || defined(CONFIG_S390) || \
+	 defined(CONFIG_PPC64) || defined(CONFIG_PPC32) || \
+	 defined(CONFIG_SUPERH) || defined(CONFIG_SPARC) || \
+	 defined(CONFIG_FRV) || defined(CONFIG_X86) || \
+	 defined(CONFIG_M32R) || defined(CONFIG_M68K) || \
+	 defined(CONFIG_MN10300) || defined(CONFIG_XTENSA) || \
+	 defined(CONFIG_ARM))
+#include <asm/atomic.h>
+#elif LINUX_VERSION_CODE < KERNEL_VERSION(2,6,29)
+typedef struct {
+	volatile int counter;
+} atomic_t;
+
+#ifdef CONFIG_64BIT
+typedef struct {
+	volatile long counter;
+} atomic64_t;
+#endif /* CONFIG_64BIT */
+
+#endif
+
 #endif /* __BACKPORT_TYPES_H */
diff --git a/backport/backport-include/linux/usb.h b/backport/backport-include/linux/usb.h
index 4ed9617..e155d72 100644
--- a/backport/backport-include/linux/usb.h
+++ b/backport/backport-include/linux/usb.h
@@ -97,4 +97,19 @@ static inline void usb_autopm_put_interface_no_suspend(struct usb_interface *int
 #define USB_SUBCLASS_VENDOR_SPEC	0xff
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,29)
+static inline void usb_autopm_put_interface_async(struct usb_interface *intf)
+{ }
+static inline int usb_autopm_get_interface_async(struct usb_interface *intf)
+{ return 0; }
+#endif
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,29) && \
+    LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,23)
+#if defined(CONFIG_USB) || defined(CONFIG_USB_MODULE)
+#define usb_unpoison_anchored_urbs LINUX_BACKPORT(usb_unpoison_anchored_urbs)
+extern void usb_unpoison_anchored_urbs(struct usb_anchor *anchor);
+#endif /* CONFIG_USB */
+#endif /* 2.6.23 - 2.6.28 */
+
 #endif /* __BACKPORT_USB_H */
diff --git a/backport/backport-include/net/net_namespace.h b/backport/backport-include/net/net_namespace.h
index 0f74944..edd02ff 100644
--- a/backport/backport-include/net/net_namespace.h
+++ b/backport/backport-include/net/net_namespace.h
@@ -7,4 +7,22 @@
 #include_next <net/net_namespace.h>
 #endif /* (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,23)) */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,29)
+#ifdef CONFIG_NET_NS
+static inline void write_pnet(struct net **pnet, struct net *net)
+{
+	*pnet = net;
+}
+
+static inline struct net *read_pnet(struct net * const *pnet)
+{
+	return *pnet;
+}
+
+#else
+#define write_pnet(pnet, net)	do { (void)(net);} while (0)
+#define read_pnet(pnet)		(&init_net)
+#endif
+#endif /* < 2.6.29 */
+
 #endif	/* _COMPAT_NET_NET_NAMESPACE_H */
-- 
1.8.0

