Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:35211 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753239Ab3JWSZl (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 23 Oct 2013 14:25:41 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 18/18] backports: remove vga_switcheroo.h
Date: Wed, 23 Oct 2013 20:24:25 +0200
Message-Id: <1382552665-15678-19-git-send-email-hauke@hauke-m.de> (sfid-20131023_203807_766960_F8AF9BE3)
In-Reply-To: <1382552665-15678-1-git-send-email-hauke@hauke-m.de>
References: <1382552665-15678-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This only used by the DRM drivers

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/vga_switcheroo.h |   43 ----------------------
 1 file changed, 43 deletions(-)
 delete mode 100644 backport/backport-include/linux/vga_switcheroo.h

diff --git a/backport/backport-include/linux/vga_switcheroo.h b/backport/backport-include/linux/vga_switcheroo.h
deleted file mode 100644
index 698f3f7..0000000
--- a/backport/backport-include/linux/vga_switcheroo.h
+++ /dev/null
@@ -1,43 +0,0 @@
-#ifndef __BACKPORT_VGA_SWITCHEROO_H
-#define __BACKPORT_VGA_SWITCHEROO_H
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,34)
-#include_next <linux/vga_switcheroo.h>
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,5,0)
-/*
- * This backports:
- *
- *   From 26ec685ff9d9c16525d8ec4c97e52fcdb187b302 Mon Sep 17 00:00:00 2001
- *   From: Takashi Iwai <tiwai@suse.de>
- *   Date: Fri, 11 May 2012 07:51:17 +0200
- *   Subject: [PATCH] vga_switcheroo: Introduce struct vga_switcheroo_client_ops
- *
- */
-
-struct vga_switcheroo_client_ops {
-    void (*set_gpu_state)(struct pci_dev *dev, enum vga_switcheroo_state);
-    void (*reprobe)(struct pci_dev *dev);
-    bool (*can_switch)(struct pci_dev *dev);
-};
-
-/* Wrap around the old code and redefine vga_switcheroo_register_client()
- * for older kernels < 3.5.0.
- */
-static inline int compat_vga_switcheroo_register_client(struct pci_dev *dev,
-		const struct vga_switcheroo_client_ops *ops) {
-
-	return vga_switcheroo_register_client(dev,
-					      ops->set_gpu_state,
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,38))
-					      ops->reprobe,
-#endif
-					      ops->can_switch);
-}
-
-#define vga_switcheroo_register_client(_dev, _ops) \
-	compat_vga_switcheroo_register_client(_dev, _ops)
-
-#endif /* < 3.5 */
-
-#endif /* >= 2.6.34 */
-#endif /* __BACKPORT_VGA_SWITCHEROO_H */
-- 
1.7.10.4

