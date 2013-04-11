Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:37212 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750731Ab3DKXnk (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 11 Apr 2013 19:43:40 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [RFC/WIP 22/24] backports: dissolve compat-3.7.h
Date: Fri, 12 Apr 2013 01:42:49 +0200
Message-Id: <1365723771-10660-23-git-send-email-johannes@sipsolutions.net> (sfid-20130412_014408_560157_44CFCFC9)
In-Reply-To: <1365723771-10660-1-git-send-email-johannes@sipsolutions.net>
References: <1365723771-10660-1-git-send-email-johannes@sipsolutions.net>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/backport/backport.h     |   1 -
 backport/backport-include/linux/compat-3.7.h      | 216 ----------------------
 backport/backport-include/linux/etherdevice.h     |  16 ++
 backport/backport-include/linux/mm.h              |   9 +
 backport/backport-include/linux/netlink.h         |  15 ++
 backport/backport-include/linux/pci.h             |  41 ++++
 backport/backport-include/linux/pci_regs.h        |   4 +
 backport/backport-include/linux/platform_device.h |   8 +
 backport/backport-include/linux/seq_file.h        |  33 ++++
 backport/backport-include/linux/tty.h             |  15 ++
 backport/backport-include/linux/workqueue.h       |  12 ++
 backport/backport-include/net/genetlink.h         |  12 ++
 backport/backport-include/net/netlink.h           |  96 ++++++++++
 backport/compat/compat-3.7.c                      |   2 +
 14 files changed, 263 insertions(+), 217 deletions(-)
 delete mode 100644 backport/backport-include/linux/compat-3.7.h
 create mode 100644 backport/backport-include/linux/mm.h
 create mode 100644 backport/backport-include/linux/netlink.h
 create mode 100644 backport/backport-include/linux/seq_file.h
 create mode 100644 backport/backport-include/linux/tty.h
 create mode 100644 backport/backport-include/linux/workqueue.h
 create mode 100644 backport/backport-include/net/genetlink.h
 create mode 100644 backport/backport-include/net/netlink.h

diff --git a/backport/backport-include/backport/backport.h b/backport/backport-include/backport/backport.h
index d8b2464..e892279 100644
--- a/backport/backport-include/backport/backport.h
+++ b/backport/backport-include/backport/backport.h
@@ -77,7 +77,6 @@ void backport_dependency_symbol(void);
 #include <linux/compat-3.4.h>
 #include <linux/compat-3.5.h>
 #include <linux/compat-3.6.h>
-#include <linux/compat-3.7.h>
 
 #endif /* __ASSEMBLY__ */
 
diff --git a/backport/backport-include/linux/compat-3.7.h b/backport/backport-include/linux/compat-3.7.h
deleted file mode 100644
index 96662e3..0000000
--- a/backport/backport-include/linux/compat-3.7.h
+++ /dev/null
@@ -1,216 +0,0 @@
-#ifndef LINUX_3_7_COMPAT_H
-#define LINUX_3_7_COMPAT_H
-
-#include <linux/version.h>
-
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,7,0))
-
-#include <linux/workqueue.h>
-#include <linux/tty.h>
-#include <linux/pci.h>
-#include <linux/pci_regs.h>
-#include <linux/mm.h>
-#include <linux/user_namespace.h>
-#include <linux/file.h>
-#include <linux/seq_file.h>
-#include <net/netlink.h>
-
-#define VM_DONTDUMP    VM_NODUMP
-
-#ifdef CONFIG_USER_NS
-
-#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,38))
-static inline struct user_namespace *seq_user_ns(struct seq_file *seq)
-{
-	struct file *f = container_of((void *) seq, struct file, private_data);
-
-	return f->f_cred->user_ns;
-}
-#else
-static inline struct user_namespace *seq_user_ns(struct seq_file *seq)
-{
-	return current_user_ns();
-}
-#endif /* (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,38)) */
-
-#else
-static inline struct user_namespace *seq_user_ns(struct seq_file *seq)
-{
-	extern struct user_namespace init_user_ns;
-	return &init_user_ns;
-}
-#endif /* CONFIG_USER_NS */
-
-#define netlink_notify_portid(__notify) (__notify->pid)
-#define genl_info_snd_portid(__genl_info) (__genl_info->snd_pid)
-#define NETLINK_CB_PORTID(__skb) NETLINK_CB(cb->skb).pid
-
-#define mod_delayed_work LINUX_BACKPORT(mod_delayed_work)
-bool mod_delayed_work(struct workqueue_struct *wq, struct delayed_work *dwork,
-		      unsigned long delay);
-
-/* Backports tty_lock: Localise the lock */
-#define tty_lock(__tty) tty_lock()
-#define tty_unlock(__tty) tty_unlock()
-
-#define tty_port_register_device(port, driver, index, device) \
-	tty_register_device(driver, index, device)
-
-#define pcie_capability_read_word LINUX_BACKPORT(pcie_capability_read_word)
-int pcie_capability_read_word(struct pci_dev *dev, int pos, u16 *val);
-#define pcie_capability_read_dword LINUX_BACKPORT(pcie_capability_read_dword)
-int pcie_capability_read_dword(struct pci_dev *dev, int pos, u32 *val);
-#define pcie_capability_write_word LINUX_BACKPORT(pcie_capability_write_word)
-int pcie_capability_write_word(struct pci_dev *dev, int pos, u16 val);
-#define pcie_capability_write_dword LINUX_BACKPORT(pcie_capability_write_dword)
-int pcie_capability_write_dword(struct pci_dev *dev, int pos, u32 val);
-#define pcie_capability_clear_and_set_word LINUX_BACKPORT(pcie_capability_clear_and_set_word)
-int pcie_capability_clear_and_set_word(struct pci_dev *dev, int pos,
-				       u16 clear, u16 set);
-#define pcie_capability_clear_and_set_dword LINUX_BACKPORT(pcie_capability_clear_and_set_dword)
-int pcie_capability_clear_and_set_dword(struct pci_dev *dev, int pos,
-					u32 clear, u32 set);
-
-static inline int pcie_capability_set_word(struct pci_dev *dev, int pos,
-					   u16 set)
-{
-	return pcie_capability_clear_and_set_word(dev, pos, 0, set);
-}
-
-static inline int pcie_capability_set_dword(struct pci_dev *dev, int pos,
-					    u32 set)
-{
-	return pcie_capability_clear_and_set_dword(dev, pos, 0, set);
-}
-
-static inline int pcie_capability_clear_word(struct pci_dev *dev, int pos,
-					     u16 clear)
-{
-	return pcie_capability_clear_and_set_word(dev, pos, clear, 0);
-}
-
-static inline int pcie_capability_clear_dword(struct pci_dev *dev, int pos,
-					      u32 clear)
-{
-	return pcie_capability_clear_and_set_dword(dev, pos, clear, 0);
-}
-
-#define PCI_EXP_LNKSTA2			50      /* Link Status 2 */
-
-/* This backports:
- *
- * commit 6d57e9078e880a3dd232d579f42ac437a8f1ef7b
- * Author: Duan Jiong <djduanjiong@gmail.com>
- * Date:   Sat Sep 8 16:32:28 2012 +0000
- * 
- *     etherdevice: introduce help function eth_zero_addr() 
- */
-/**
- * eth_zero_addr - Assign zero address
- * @addr: Pointer to a six-byte array containing the Ethernet address
- *
- * Assign the zero address to the given address array.
- */
-static inline void eth_zero_addr(u8 *addr)
-{
-	memset(addr, 0x00, ETH_ALEN);
-}
-
-/**
- * nla_put_s8 - Add a s8 netlink attribute to a socket buffer
- * @skb: socket buffer to add attribute to
- * @attrtype: attribute type
- * @value: numeric value
- */
-static inline int nla_put_s8(struct sk_buff *skb, int attrtype, s8 value)
-{
-	return nla_put(skb, attrtype, sizeof(s8), &value);
-}
-
-/**
- * nla_put_s16 - Add a s16 netlink attribute to a socket buffer
- * @skb: socket buffer to add attribute to
- * @attrtype: attribute type
- * @value: numeric value
- */
-static inline int nla_put_s16(struct sk_buff *skb, int attrtype, s16 value)
-{
-	return nla_put(skb, attrtype, sizeof(s16), &value);
-}
-
-/**
- * nla_put_s32 - Add a s32 netlink attribute to a socket buffer
- * @skb: socket buffer to add attribute to
- * @attrtype: attribute type
- * @value: numeric value
- */
-static inline int nla_put_s32(struct sk_buff *skb, int attrtype, s32 value)
-{
-	return nla_put(skb, attrtype, sizeof(s32), &value);
-}
-
-/**
- * nla_put_s64 - Add a s64 netlink attribute to a socket buffer
- * @skb: socket buffer to add attribute to
- * @attrtype: attribute type
- * @value: numeric value
- */
-static inline int nla_put_s64(struct sk_buff *skb, int attrtype, s64 value)
-{
-	return nla_put(skb, attrtype, sizeof(s64), &value);
-}
-
-/**
- * nla_get_s32 - return payload of s32 attribute
- * @nla: s32 netlink attribute
- */
-static inline s32 nla_get_s32(const struct nlattr *nla)
-{
-	return *(s32 *) nla_data(nla);
-}
-
-/**
- * nla_get_s16 - return payload of s16 attribute
- * @nla: s16 netlink attribute
- */
-static inline s16 nla_get_s16(const struct nlattr *nla)
-{
-	return *(s16 *) nla_data(nla);
-}
-
-/**
- * nla_get_s8 - return payload of s8 attribute
- * @nla: s8 netlink attribute
- */
-static inline s8 nla_get_s8(const struct nlattr *nla)
-{
-	return *(s8 *) nla_data(nla);
-}
-
-/**
- * nla_get_s64 - return payload of s64 attribute
- * @nla: s64 netlink attribute
- */
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,29))
-static inline s64 nla_get_s64(const struct nlattr *nla)
-#else
-static inline s64 nla_get_s64(struct nlattr *nla)
-#endif
-{
-	s64 tmp;
-
-	nla_memcpy(&tmp, nla, sizeof(tmp));
-
-	return tmp;
-}
-
-#define PLATFORM_DEVID_NONE	(-1)
-#define PLATFORM_DEVID_AUTO	(-1)
-
-#else /* (LINUX_VERSION_CODE > KERNEL_VERSION(3,7,0)) */
-#define netlink_notify_portid(__notify) (__notify->portid)
-#define genl_info_snd_portid(__genl_info) (__genl_info->snd_portid)
-#define NETLINK_CB_PORTID(__skb) NETLINK_CB(cb->skb).portid
-#endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(3,7,0)) */
-
-#endif /* LINUX_3_7_COMPAT_H */
diff --git a/backport/backport-include/linux/etherdevice.h b/backport/backport-include/linux/etherdevice.h
index 9360aa4..6a657e6 100644
--- a/backport/backport-include/linux/etherdevice.h
+++ b/backport/backport-include/linux/etherdevice.h
@@ -37,4 +37,20 @@ static inline void eth_hw_addr_random(struct net_device *dev)
 }
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,7,0)
+
+/* This backports:
+ *
+ * commit 6d57e9078e880a3dd232d579f42ac437a8f1ef7b
+ * Author: Duan Jiong <djduanjiong@gmail.com>
+ * Date:   Sat Sep 8 16:32:28 2012 +0000
+ * 
+ *     etherdevice: introduce help function eth_zero_addr() 
+ */
+static inline void eth_zero_addr(u8 *addr)
+{
+	memset(addr, 0x00, ETH_ALEN);
+}
+#endif
+
 #endif /* _BACKPORT_LINUX_ETHERDEVICE_H */
diff --git a/backport/backport-include/linux/mm.h b/backport/backport-include/linux/mm.h
new file mode 100644
index 0000000..bfb771c
--- /dev/null
+++ b/backport/backport-include/linux/mm.h
@@ -0,0 +1,9 @@
+#ifndef __BACKPORT_MM_H
+#define __BACKPORT_MM_H
+#include_next <linux/mm.h>
+
+#ifndef VM_DONTDUMP
+#define VM_DONTDUMP    VM_NODUMP
+#endif
+
+#endif /* __BACKPORT_MM_H */
diff --git a/backport/backport-include/linux/netlink.h b/backport/backport-include/linux/netlink.h
new file mode 100644
index 0000000..2058a90
--- /dev/null
+++ b/backport/backport-include/linux/netlink.h
@@ -0,0 +1,15 @@
+#ifndef __BACKPORT_LINUX_NETLINK_H
+#define __BACKPORT_LINUX_NETLINK_H
+#include_next <linux/netlink.h>
+#include <linux/version.h>
+
+/* this is for patches we apply */
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,7,0)
+#define netlink_notify_portid(__notify) (__notify->pid)
+#define NETLINK_CB_PORTID(__skb) NETLINK_CB(cb->skb).pid
+#else
+#define netlink_notify_portid(__notify) (__notify->portid)
+#define NETLINK_CB_PORTID(__skb) NETLINK_CB(cb->skb).portid
+#endif
+
+#endif /* __BACKPORT_LINUX_NETLINK_H */
diff --git a/backport/backport-include/linux/pci.h b/backport/backport-include/linux/pci.h
index e78865f..9537332 100644
--- a/backport/backport-include/linux/pci.h
+++ b/backport/backport-include/linux/pci.h
@@ -96,6 +96,47 @@ int __must_check pci_enable_device_mem(struct pci_dev *dev);
 		       pci_unregister_driver)
 #endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(3,4,0)) */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,7,0)
+#define pcie_capability_read_word LINUX_BACKPORT(pcie_capability_read_word)
+int pcie_capability_read_word(struct pci_dev *dev, int pos, u16 *val);
+#define pcie_capability_read_dword LINUX_BACKPORT(pcie_capability_read_dword)
+int pcie_capability_read_dword(struct pci_dev *dev, int pos, u32 *val);
+#define pcie_capability_write_word LINUX_BACKPORT(pcie_capability_write_word)
+int pcie_capability_write_word(struct pci_dev *dev, int pos, u16 val);
+#define pcie_capability_write_dword LINUX_BACKPORT(pcie_capability_write_dword)
+int pcie_capability_write_dword(struct pci_dev *dev, int pos, u32 val);
+#define pcie_capability_clear_and_set_word LINUX_BACKPORT(pcie_capability_clear_and_set_word)
+int pcie_capability_clear_and_set_word(struct pci_dev *dev, int pos,
+				       u16 clear, u16 set);
+#define pcie_capability_clear_and_set_dword LINUX_BACKPORT(pcie_capability_clear_and_set_dword)
+int pcie_capability_clear_and_set_dword(struct pci_dev *dev, int pos,
+					u32 clear, u32 set);
+
+static inline int pcie_capability_set_word(struct pci_dev *dev, int pos,
+					   u16 set)
+{
+	return pcie_capability_clear_and_set_word(dev, pos, 0, set);
+}
+
+static inline int pcie_capability_set_dword(struct pci_dev *dev, int pos,
+					    u32 set)
+{
+	return pcie_capability_clear_and_set_dword(dev, pos, 0, set);
+}
+
+static inline int pcie_capability_clear_word(struct pci_dev *dev, int pos,
+					     u16 clear)
+{
+	return pcie_capability_clear_and_set_word(dev, pos, clear, 0);
+}
+
+static inline int pcie_capability_clear_dword(struct pci_dev *dev, int pos,
+					      u32 clear)
+{
+	return pcie_capability_clear_and_set_dword(dev, pos, clear, 0);
+}
+#endif
+
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3,10,0)
 /*
  * DRM requires this, but we can't really backport it well
diff --git a/backport/backport-include/linux/pci_regs.h b/backport/backport-include/linux/pci_regs.h
index ec8c59f..dd13eb3 100644
--- a/backport/backport-include/linux/pci_regs.h
+++ b/backport/backport-include/linux/pci_regs.h
@@ -26,4 +26,8 @@
 #define  PCI_EXP_LNKCAP_SLS_5_0GB 0x2	/* LNKCAP2 SLS Vector bit 1 (5.0GT/s) */
 #endif
 
+#ifndef PCI_EXP_LNKSTA2
+#define PCI_EXP_LNKSTA2			50      /* Link Status 2 */
+#endif
+
 #endif /* __BACKPORT_UAPI_PCI_REGS_H */
diff --git a/backport/backport-include/linux/platform_device.h b/backport/backport-include/linux/platform_device.h
index acb4aba..f0d6f89 100644
--- a/backport/backport-include/linux/platform_device.h
+++ b/backport/backport-include/linux/platform_device.h
@@ -19,4 +19,12 @@ static void __exit __platform_driver##_exit(void) \
 module_exit(__platform_driver##_exit);
 #endif
 
+#ifndef PLATFORM_DEVID_NONE
+#define PLATFORM_DEVID_NONE	(-1)
+#endif
+
+#ifndef PLATFORM_DEVID_AUTO
+#define PLATFORM_DEVID_AUTO	(-1)
+#endif
+
 #endif /* __BACKPORT_PLATFORM_DEVICE_H */
diff --git a/backport/backport-include/linux/seq_file.h b/backport/backport-include/linux/seq_file.h
new file mode 100644
index 0000000..0ee8ae2
--- /dev/null
+++ b/backport/backport-include/linux/seq_file.h
@@ -0,0 +1,33 @@
+#ifndef __BACKPORT_SEQ_FILE_H
+#define __BACKPORT_SEQ_FILE_H
+#include_next <linux/seq_file.h>
+#include <linux/version.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,7,0)
+#include <linux/user_namespace.h>
+#include <linux/file.h>
+#ifdef CONFIG_USER_NS
+#if LINUX_VERSION_CODE > KERNEL_VERSION(2,6,38)
+static inline struct user_namespace *seq_user_ns(struct seq_file *seq)
+{
+	struct file *f = container_of((void *) seq, struct file, private_data);
+
+	return f->f_cred->user_ns;
+}
+#else
+static inline struct user_namespace *seq_user_ns(struct seq_file *seq)
+{
+	return current_user_ns();
+}
+#endif /* (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,38)) */
+
+#else
+static inline struct user_namespace *seq_user_ns(struct seq_file *seq)
+{
+	extern struct user_namespace init_user_ns;
+	return &init_user_ns;
+}
+#endif /* CONFIG_USER_NS */
+#endif /* < 3.7 */
+
+#endif /* __BACKPORT_SEQ_FILE_H */
diff --git a/backport/backport-include/linux/tty.h b/backport/backport-include/linux/tty.h
new file mode 100644
index 0000000..3aa10eb
--- /dev/null
+++ b/backport/backport-include/linux/tty.h
@@ -0,0 +1,15 @@
+#ifndef __BACKPORT_LINUX_TTY_H
+#define __BACKPORT_LINUX_TTY_H
+#include_next <linux/tty.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,7,0)
+
+/* Backports tty_lock: Localise the lock */
+#define tty_lock(__tty) tty_lock()
+#define tty_unlock(__tty) tty_unlock()
+
+#define tty_port_register_device(port, driver, index, device) \
+	tty_register_device(driver, index, device)
+#endif
+
+#endif /* __BACKPORT_LINUX_TTY_H */
diff --git a/backport/backport-include/linux/workqueue.h b/backport/backport-include/linux/workqueue.h
new file mode 100644
index 0000000..6e9796f
--- /dev/null
+++ b/backport/backport-include/linux/workqueue.h
@@ -0,0 +1,12 @@
+#ifndef __BACKPORT_LINUX_WORKQUEUE_H
+#define __BACKPORT_LINUX_WORKQUEUE_H
+#include_next <linux/workqueue.h>
+#include <linux/version.h>
+
+#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,7,0))
+#define mod_delayed_work LINUX_BACKPORT(mod_delayed_work)
+bool mod_delayed_work(struct workqueue_struct *wq, struct delayed_work *dwork,
+		      unsigned long delay);
+#endif
+
+#endif /* __BACKPORT_LINUX_WORKQUEUE_H */
diff --git a/backport/backport-include/net/genetlink.h b/backport/backport-include/net/genetlink.h
new file mode 100644
index 0000000..9512549
--- /dev/null
+++ b/backport/backport-include/net/genetlink.h
@@ -0,0 +1,12 @@
+#ifndef __BACKPORT_NET_GENETLINK_H
+#define __BACKPORT_NET_GENETLINK_H
+#include_next <net/genetlink.h>
+
+/* this is for patches we apply */
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,7,0)
+#define genl_info_snd_portid(__genl_info) (__genl_info->snd_pid)
+#else
+#define genl_info_snd_portid(__genl_info) (__genl_info->snd_portid)
+#endif
+
+#endif /* __BACKPORT_NET_GENETLINK_H */
diff --git a/backport/backport-include/net/netlink.h b/backport/backport-include/net/netlink.h
new file mode 100644
index 0000000..ee51de6
--- /dev/null
+++ b/backport/backport-include/net/netlink.h
@@ -0,0 +1,96 @@
+#ifndef __BACKPORT_NET_NETLINK_H
+#define __BACKPORT_NET_NETLINK_H
+#include_next <net/netlink.h>
+#include <linux/version.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,7,0)
+/**
+ * nla_put_s8 - Add a s8 netlink attribute to a socket buffer
+ * @skb: socket buffer to add attribute to
+ * @attrtype: attribute type
+ * @value: numeric value
+ */
+static inline int nla_put_s8(struct sk_buff *skb, int attrtype, s8 value)
+{
+	return nla_put(skb, attrtype, sizeof(s8), &value);
+}
+
+/**
+ * nla_put_s16 - Add a s16 netlink attribute to a socket buffer
+ * @skb: socket buffer to add attribute to
+ * @attrtype: attribute type
+ * @value: numeric value
+ */
+static inline int nla_put_s16(struct sk_buff *skb, int attrtype, s16 value)
+{
+	return nla_put(skb, attrtype, sizeof(s16), &value);
+}
+
+/**
+ * nla_put_s32 - Add a s32 netlink attribute to a socket buffer
+ * @skb: socket buffer to add attribute to
+ * @attrtype: attribute type
+ * @value: numeric value
+ */
+static inline int nla_put_s32(struct sk_buff *skb, int attrtype, s32 value)
+{
+	return nla_put(skb, attrtype, sizeof(s32), &value);
+}
+
+/**
+ * nla_put_s64 - Add a s64 netlink attribute to a socket buffer
+ * @skb: socket buffer to add attribute to
+ * @attrtype: attribute type
+ * @value: numeric value
+ */
+static inline int nla_put_s64(struct sk_buff *skb, int attrtype, s64 value)
+{
+	return nla_put(skb, attrtype, sizeof(s64), &value);
+}
+
+/**
+ * nla_get_s32 - return payload of s32 attribute
+ * @nla: s32 netlink attribute
+ */
+static inline s32 nla_get_s32(const struct nlattr *nla)
+{
+	return *(s32 *) nla_data(nla);
+}
+
+/**
+ * nla_get_s16 - return payload of s16 attribute
+ * @nla: s16 netlink attribute
+ */
+static inline s16 nla_get_s16(const struct nlattr *nla)
+{
+	return *(s16 *) nla_data(nla);
+}
+
+/**
+ * nla_get_s8 - return payload of s8 attribute
+ * @nla: s8 netlink attribute
+ */
+static inline s8 nla_get_s8(const struct nlattr *nla)
+{
+	return *(s8 *) nla_data(nla);
+}
+
+/**
+ * nla_get_s64 - return payload of s64 attribute
+ * @nla: s64 netlink attribute
+ */
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,29))
+static inline s64 nla_get_s64(const struct nlattr *nla)
+#else
+static inline s64 nla_get_s64(struct nlattr *nla)
+#endif
+{
+	s64 tmp;
+
+	nla_memcpy(&tmp, nla, sizeof(tmp));
+
+	return tmp;
+}
+#endif /* < 3.7.0 */
+
+#endif /* __BACKPORT_NET_NETLINK_H */
diff --git a/backport/compat/compat-3.7.c b/backport/compat/compat-3.7.c
index 226d136..284e8dc 100644
--- a/backport/compat/compat-3.7.c
+++ b/backport/compat/compat-3.7.c
@@ -10,6 +10,8 @@
 
 #include <linux/workqueue.h>
 #include <linux/export.h>
+#include <linux/pci.h>
+#include <linux/pci_regs.h>
 
 bool mod_delayed_work(struct workqueue_struct *wq, struct delayed_work *dwork,
 		      unsigned long delay)
-- 
1.8.0

