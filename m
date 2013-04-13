Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:44225 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753966Ab3DMXyN (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 13 Apr 2013 19:54:13 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [RFC/RFT 09/42] backports: dissolve compat-3.10.h
Date: Sun, 14 Apr 2013 01:53:29 +0200
Message-Id: <1365897243-31214-10-git-send-email-johannes@sipsolutions.net> (sfid-20130414_015419_950283_6DB199AD)
In-Reply-To: <1365897243-31214-1-git-send-email-johannes@sipsolutions.net>
References: <1365897243-31214-1-git-send-email-johannes@sipsolutions.net>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/backport/backport.h |   1 -
 backport/backport-include/linux/compat-3.10.h | 145 --------------------------
 backport/backport-include/linux/fb.h          |  48 +++++++++
 backport/backport-include/linux/if_ether.h    |  17 +++
 backport/backport-include/linux/pci.h         |  17 +++
 backport/backport-include/linux/proc_fs.h     |  17 +++
 backport/backport-include/linux/scatterlist.h |  24 +++++
 backport/backport-include/linux/socket.h      |  13 +++
 backport/backport-include/net/sock.h          |  11 ++
 backport/backport-include/pcmcia/ds.h         |  29 ++++++
 10 files changed, 176 insertions(+), 146 deletions(-)
 delete mode 100644 backport/backport-include/linux/compat-3.10.h
 create mode 100644 backport/backport-include/linux/fb.h
 create mode 100644 backport/backport-include/linux/if_ether.h
 create mode 100644 backport/backport-include/linux/pci.h
 create mode 100644 backport/backport-include/linux/proc_fs.h
 create mode 100644 backport/backport-include/linux/socket.h
 create mode 100644 backport/backport-include/pcmcia/ds.h

diff --git a/backport/backport-include/backport/backport.h b/backport/backport-include/backport/backport.h
index e343bf8..a50e488 100644
--- a/backport/backport-include/backport/backport.h
+++ b/backport/backport-include/backport/backport.h
@@ -80,7 +80,6 @@ void backport_dependency_symbol(void);
 #include <linux/compat-3.6.h>
 #include <linux/compat-3.7.h>
 #include <linux/compat-3.8.h>
-#include <linux/compat-3.10.h>
 
 #endif /* __ASSEMBLY__ */
 
diff --git a/backport/backport-include/linux/compat-3.10.h b/backport/backport-include/linux/compat-3.10.h
deleted file mode 100644
index b4d8bc5..0000000
--- a/backport/backport-include/linux/compat-3.10.h
+++ /dev/null
@@ -1,145 +0,0 @@
-#ifndef LINUX_3_10_COMPAT_H
-#define LINUX_3_10_COMPAT_H
-
-#include <linux/version.h>
-
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,10,0))
-
-#include <linux/scatterlist.h>
-#include <linux/mm.h>
-#include <linux/fb.h>
-#include <linux/proc_fs.h>
-#include <linux/printk.h>
-
-#define sg_page_iter_page LINUX_BACKPORT(sg_page_iter_page)
-/**
- * sg_page_iter_page - get the current page held by the page iterator
- * @piter:     page iterator holding the page
- */
-static inline struct page *sg_page_iter_page(struct sg_page_iter *piter)
-{
-	return nth_page(sg_page(piter->sg), piter->sg_pgoffset);
-}
-
-#define sg_page_iter_dma_address LINUX_BACKPORT(sg_page_iter_dma_address)
-/**
- * sg_page_iter_dma_address - get the dma address of the current page held by
- * the page iterator.
- * @piter:     page iterator holding the page
- */
-static inline dma_addr_t sg_page_iter_dma_address(struct sg_page_iter *piter)
-{
-	return sg_dma_address(piter->sg) + (piter->sg_pgoffset << PAGE_SHIFT);
-}
-
-/*
- * This is a linux-next data structure element collateral evolution,
- * we use a wrapper to avoid #ifdef hell to backport it. This allows
- * us to use a simple fb_info_skip_vt_switch() replacement for when
- * the new data structure element is used. If coccinelle SmPL grammar
- * could be used to express the transformation for us on compat-drivers
- * it means we'd need to express it only once. If the structure element
- * collateral evolution were to be used *at development* time and we'd
- * have a way to express the inverse through SmPL we'd be able to
- * backport this collateral evolution automatically for any new driver
- * that used it. We'd use coccinelle to look for it and do the
- * transformations for us based on the original commit (maybe SmPL
- * would be listed on the commit log.
- *
- * We may need the LINUX_BACKPORT() call that adds the backport_
- * prefix for older kernels than 3.10 if distros decide to
- * add this same static inline themselves (although unlikely).
- */
-#define fb_enable_skip_vt_switch LINUX_BACKPORT(fb_enable_skip_vt_switch)
-static inline void fb_enable_skip_vt_switch(struct fb_info *info)
-{
-}
-
-/**
- * backport of:
- *
- * commit 6ed7ffddcf61f668114edb676417e5fb33773b59
- * Author: H Hartley Sweeten <hsweeten@visionengravers.com>
- * Date:   Wed Mar 6 11:24:44 2013 -0700
- *
- *     pcmcia/ds.h: introduce helper for pcmcia_driver module boilerplate
- */
-
-/**
- * module_pcmcia_driver() - Helper macro for registering a pcmcia driver
- * @__pcmcia_driver: pcmcia_driver struct
- *
- * Helper macro for pcmcia drivers which do not do anything special in module
- * init/exit. This eliminates a lot of boilerplate. Each module may only use
- * this macro once, and calling it replaces module_init() and module_exit().
- */
-#define module_pcmcia_driver(__pcmcia_driver) \
-	module_driver(__pcmcia_driver, pcmcia_register_driver, \
-			pcmcia_unregister_driver)
-
-/*
- * backport of:
- * commit e5c5d22e8dcf7c2d430336cbf8e180bd38e8daf1
- * Author: Simon Horman <horms@verge.net.au>
- * Date:   Thu Mar 28 13:38:25 2013 +0900
- * 
- *     net: add ETH_P_802_3_MIN
- */
-#ifndef ETH_P_802_3_MIN
-#define ETH_P_802_3_MIN 0x0600
-#endif
-
-/*
- * backport of:
- * procfs: new helper - PDE_DATA(inode)
- */
-static inline void *PDE_DATA(const struct inode *inode)
-{
-	return PROC_I(inode)->pde->data;
-}
-
-/*
- * backport SOCK_SELECT_ERR_QUEUE -- see commit
- * "net: add option to enable error queue packets waking select"
- *
- * Adding 14 to SOCK_QUEUE_SHRUNK will reach a bet that can't be
- * set on older kernels, so sock_flag() will always return false.
- */
-#define SOCK_SELECT_ERR_QUEUE (SOCK_QUEUE_SHRUNK + 14)
-
-/*
- * DRM requires this, but we can't really backport it well
- */
-static inline void __iomem *pci_platform_rom(struct pci_dev *pdev, size_t *size)
-{
-	printk(KERN_WARNING "compat: not providing pci_platform_rom!\n");
-	return NULL;
-}
-
-/*
- * backport SOL_NFC -- see commit:
- * NFC: llcp: Implement socket options
- */
-#define SOL_NFC		280
-
-#else /* kernel is >= 3.10 */
-/*
- * We'd delete this upstream ever got this, we use our
- * backport_ prefix with LINUX_BACKPORT() so that if this
- * does get upstream we would not have to add another ifdef
- * here for the kernels in between v3.10.. up to the point
- * the routine would have gotten added, we'd just delete this
- * #else condition completely. If we didn't have this and
- * say 3.12 added the static inline upstream, we'd have a
- * clash on the backport for 3.12 as the routine would
- * already be defined *but* we'd need it for 3.11.
- */
-#define fb_enable_skip_vt_switch LINUX_BACKPORT(fb_enable_skip_vt_switch)
-static inline void fb_enable_skip_vt_switch(struct fb_info *info)
-{
-	info->skip_vt_switch = true;
-}
-
-#endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(3,10,0)) */
-
-#endif /* LINUX_3_10_COMPAT_H */
diff --git a/backport/backport-include/linux/fb.h b/backport/backport-include/linux/fb.h
new file mode 100644
index 0000000..4522e25
--- /dev/null
+++ b/backport/backport-include/linux/fb.h
@@ -0,0 +1,48 @@
+#ifndef __BACKPORT_FB_H
+#define __BACKPORT_FB_H
+#include_next <linux/fb.h>
+#include <linux/version.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,10,0)
+/*
+ * This is a linux-next data structure element collateral evolution,
+ * we use a wrapper to avoid #ifdef hell to backport it. This allows
+ * us to use a simple fb_info_skip_vt_switch() replacement for when
+ * the new data structure element is used. If coccinelle SmPL grammar
+ * could be used to express the transformation for us on compat-drivers
+ * it means we'd need to express it only once. If the structure element
+ * collateral evolution were to be used *at development* time and we'd
+ * have a way to express the inverse through SmPL we'd be able to
+ * backport this collateral evolution automatically for any new driver
+ * that used it. We'd use coccinelle to look for it and do the
+ * transformations for us based on the original commit (maybe SmPL
+ * would be listed on the commit log.
+ *
+ * We may need the LINUX_BACKPORT() call that adds the backport_
+ * prefix for older kernels than 3.10 if distros decide to
+ * add this same static inline themselves (although unlikely).
+ */
+#define fb_enable_skip_vt_switch LINUX_BACKPORT(fb_enable_skip_vt_switch)
+static inline void fb_enable_skip_vt_switch(struct fb_info *info)
+{
+}
+#else /* kernel is >= 3.10 */
+/*
+ * We'd delete this upstream ever got this, we use our
+ * backport_ prefix with LINUX_BACKPORT() so that if this
+ * does get upstream we would not have to add another ifdef
+ * here for the kernels in between v3.10.. up to the point
+ * the routine would have gotten added, we'd just delete this
+ * #else condition completely. If we didn't have this and
+ * say 3.12 added the static inline upstream, we'd have a
+ * clash on the backport for 3.12 as the routine would
+ * already be defined *but* we'd need it for 3.11.
+ */
+#define fb_enable_skip_vt_switch LINUX_BACKPORT(fb_enable_skip_vt_switch)
+static inline void fb_enable_skip_vt_switch(struct fb_info *info)
+{
+	info->skip_vt_switch = true;
+}
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,10,0) */
+
+#endif /* __BACKPORT_FB_H */
diff --git a/backport/backport-include/linux/if_ether.h b/backport/backport-include/linux/if_ether.h
new file mode 100644
index 0000000..a3c6e45
--- /dev/null
+++ b/backport/backport-include/linux/if_ether.h
@@ -0,0 +1,17 @@
+#ifndef __BACKPORT_IF_ETHER_H
+#define __BACKPORT_IF_ETHER_H
+#include_next <linux/if_ether.h>
+
+/*
+ * backport of:
+ * commit e5c5d22e8dcf7c2d430336cbf8e180bd38e8daf1
+ * Author: Simon Horman <horms@verge.net.au>
+ * Date:   Thu Mar 28 13:38:25 2013 +0900
+ * 
+ *     net: add ETH_P_802_3_MIN
+ */
+#ifndef ETH_P_802_3_MIN
+#define ETH_P_802_3_MIN 0x0600
+#endif
+
+#endif /* __BACKPORT_IF_ETHER_H */
diff --git a/backport/backport-include/linux/pci.h b/backport/backport-include/linux/pci.h
new file mode 100644
index 0000000..d8410a4
--- /dev/null
+++ b/backport/backport-include/linux/pci.h
@@ -0,0 +1,17 @@
+#ifndef _BACKPORT_LINUX_PCI_H
+#define _BACKPORT_LINUX_PCI_H
+#include_next <linux/pci.h>
+#include <linux/version.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,10,0)
+/*
+ * DRM requires this, but we can't really backport it well
+ */
+static inline void __iomem *pci_platform_rom(struct pci_dev *pdev, size_t *size)
+{
+	printk(KERN_WARNING "compat: not providing pci_platform_rom!\n");
+	return NULL;
+}
+#endif
+
+#endif /* _BACKPORT_LINUX_PCI_H */
diff --git a/backport/backport-include/linux/proc_fs.h b/backport/backport-include/linux/proc_fs.h
new file mode 100644
index 0000000..5a1bec1
--- /dev/null
+++ b/backport/backport-include/linux/proc_fs.h
@@ -0,0 +1,17 @@
+#ifndef __BACKPORT_PROC_FS_H
+#define __BACKPORT_PROC_FS_H
+#include_next <linux/proc_fs.h>
+#include <linux/version.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,10,0)
+/*
+ * backport of:
+ * procfs: new helper - PDE_DATA(inode)
+ */
+static inline void *PDE_DATA(const struct inode *inode)
+{
+	return PROC_I(inode)->pde->data;
+}
+#endif
+
+#endif /* __BACKPORT_PROC_FS_H */
diff --git a/backport/backport-include/linux/scatterlist.h b/backport/backport-include/linux/scatterlist.h
index aaa7371..66bce16 100644
--- a/backport/backport-include/linux/scatterlist.h
+++ b/backport/backport-include/linux/scatterlist.h
@@ -48,4 +48,28 @@ void __sg_page_iter_start(struct sg_page_iter *piter,
 #endif /* for_each_sg_page assumption */
 #endif /* version < 3.9 */
 
+#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,10,0))
+
+#define sg_page_iter_page LINUX_BACKPORT(sg_page_iter_page)
+/**
+ * sg_page_iter_page - get the current page held by the page iterator
+ * @piter:     page iterator holding the page
+ */
+static inline struct page *sg_page_iter_page(struct sg_page_iter *piter)
+{
+	return nth_page(sg_page(piter->sg), piter->sg_pgoffset);
+}
+
+#define sg_page_iter_dma_address LINUX_BACKPORT(sg_page_iter_dma_address)
+/**
+ * sg_page_iter_dma_address - get the dma address of the current page held by
+ * the page iterator.
+ * @piter:     page iterator holding the page
+ */
+static inline dma_addr_t sg_page_iter_dma_address(struct sg_page_iter *piter)
+{
+	return sg_dma_address(piter->sg) + (piter->sg_pgoffset << PAGE_SHIFT);
+}
+#endif /* version < 3.10 */
+
 #endif /* __BACKPORT_SCATTERLIST_H */
diff --git a/backport/backport-include/linux/socket.h b/backport/backport-include/linux/socket.h
new file mode 100644
index 0000000..4187af2
--- /dev/null
+++ b/backport/backport-include/linux/socket.h
@@ -0,0 +1,13 @@
+#ifndef __BACKPORT_SOCKET_H
+#define __BACKPORT_SOCKET_H
+#include_next <linux/socket.h>
+
+#ifndef SOL_NFC
+/*
+ * backport SOL_NFC -- see commit:
+ * NFC: llcp: Implement socket options
+ */
+#define SOL_NFC		280
+#endif
+
+#endif /* __BACKPORT_SOCKET_H */
diff --git a/backport/backport-include/net/sock.h b/backport/backport-include/net/sock.h
index c9ec1fc..ec67b9e 100644
--- a/backport/backport-include/net/sock.h
+++ b/backport/backport-include/net/sock.h
@@ -27,4 +27,15 @@
 
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,10,0)
+/*
+ * backport SOCK_SELECT_ERR_QUEUE -- see commit
+ * "net: add option to enable error queue packets waking select"
+ *
+ * Adding 14 to SOCK_QUEUE_SHRUNK will reach a bet that can't be
+ * set on older kernels, so sock_flag() will always return false.
+ */
+#define SOCK_SELECT_ERR_QUEUE (SOCK_QUEUE_SHRUNK + 14)
+#endif
+
 #endif /* __BACKPORT_NET_SOCK_H */
diff --git a/backport/backport-include/pcmcia/ds.h b/backport/backport-include/pcmcia/ds.h
new file mode 100644
index 0000000..45ab33a
--- /dev/null
+++ b/backport/backport-include/pcmcia/ds.h
@@ -0,0 +1,29 @@
+#ifndef __BACKPORT_PCMCIA_DS_H
+#define __BACKPORT_PCMCIA_DS_H
+#include_next <pcmcia/ds.h>
+
+#ifndef module_pcmcia_driver
+/**
+ * backport of:
+ *
+ * commit 6ed7ffddcf61f668114edb676417e5fb33773b59
+ * Author: H Hartley Sweeten <hsweeten@visionengravers.com>
+ * Date:   Wed Mar 6 11:24:44 2013 -0700
+ *
+ *     pcmcia/ds.h: introduce helper for pcmcia_driver module boilerplate
+ */
+
+/**
+ * module_pcmcia_driver() - Helper macro for registering a pcmcia driver
+ * @__pcmcia_driver: pcmcia_driver struct
+ *
+ * Helper macro for pcmcia drivers which do not do anything special in module
+ * init/exit. This eliminates a lot of boilerplate. Each module may only use
+ * this macro once, and calling it replaces module_init() and module_exit().
+ */
+#define module_pcmcia_driver(__pcmcia_driver) \
+	module_driver(__pcmcia_driver, pcmcia_register_driver, \
+			pcmcia_unregister_driver)
+#endif
+
+#endif /* __BACKPORT_PCMCIA_DS_H */
-- 
1.8.0

