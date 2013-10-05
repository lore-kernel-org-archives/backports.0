Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:50872 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752427Ab3JEWoi (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 5 Oct 2013 18:44:38 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, ozancag@gmail.com,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [RFC 03/15] backports: remove BACKPORT_BUILD_CROSS_RESERVATION
Date: Sun,  6 Oct 2013 00:43:52 +0200
Message-Id: <1381013044-7724-4-git-send-email-hauke@hauke-m.de> (sfid-20131006_004439_466303_D1617FDF)
In-Reply-To: <1381013044-7724-1-git-send-email-hauke@hauke-m.de>
References: <1381013044-7724-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This was only needed for some of the DRM drivers, remove it.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/reservation.h |   70 -------------------------
 backport/compat/Kconfig                       |    7 ---
 backport/compat/Makefile                      |    1 -
 backport/compat/drivers-base-reservation.c    |   39 --------------
 4 files changed, 117 deletions(-)
 delete mode 100644 backport/backport-include/linux/reservation.h
 delete mode 100644 backport/compat/drivers-base-reservation.c

diff --git a/backport/backport-include/linux/reservation.h b/backport/backport-include/linux/reservation.h
deleted file mode 100644
index ff79ae8..0000000
--- a/backport/backport-include/linux/reservation.h
+++ /dev/null
@@ -1,70 +0,0 @@
-#ifndef _BACKPORT_LINUX_RESERVATION_H
-#define _BACKPORT_LINUX_RESERVATION_H
-
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0)
-#include_next <linux/reservation.h>
-#else
-#ifdef CPTCFG_BACKPORT_BUILD_CROSS_RESERVATION
-/*
- * Header file for reservations for dma-buf and ttm
- *
- * Copyright(C) 2011 Linaro Limited. All rights reserved.
- * Copyright (C) 2012-2013 Canonical Ltd
- * Copyright (C) 2012 Texas Instruments
- *
- * Authors:
- * Rob Clark <rob.clark@linaro.org>
- * Maarten Lankhorst <maarten.lankhorst@canonical.com>
- * Thomas Hellstrom <thellstrom-at-vmware-dot-com>
- *
- * Based on bo.c which bears the following copyright notice,
- * but is dual licensed:
- *
- * Copyright (c) 2006-2009 VMware, Inc., Palo Alto, CA., USA
- * All Rights Reserved.
- *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the
- * "Software"), to deal in the Software without restriction, including
- * without limitation the rights to use, copy, modify, merge, publish,
- * distribute, sub license, and/or sell copies of the Software, and to
- * permit persons to whom the Software is furnished to do so, subject to
- * the following conditions:
- *
- * The above copyright notice and this permission notice (including the
- * next paragraph) shall be included in all copies or substantial portions
- * of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL
- * THE COPYRIGHT HOLDERS, AUTHORS AND/OR ITS SUPPLIERS BE LIABLE FOR ANY CLAIM,
- * DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
- * OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
- * USE OR OTHER DEALINGS IN THE SOFTWARE.
- */
-#include <linux/ww_mutex.h>
-
-extern struct ww_class reservation_ww_class;
-
-struct reservation_object {
-	struct ww_mutex lock;
-};
-
-#define reservation_object_init LINUX_BACKPORT(reservation_object_init)
-static inline void
-reservation_object_init(struct reservation_object *obj)
-{
-	ww_mutex_init(&obj->lock, &reservation_ww_class);
-}
-
-#define reservation_object_fini LINUX_BACKPORT(reservation_object_fini)
-static inline void
-reservation_object_fini(struct reservation_object *obj)
-{
-	ww_mutex_destroy(&obj->lock);
-}
-
-#endif /* BACKPORT_BUILD_CROSS_RESERVATION */
-#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0) */
-#endif /* _BACKPORT_LINUX_RESERVATION_H */
diff --git a/backport/compat/Kconfig b/backport/compat/Kconfig
index 8377013..f3c1ab3 100644
--- a/backport/compat/Kconfig
+++ b/backport/compat/Kconfig
@@ -139,13 +139,6 @@ config BACKPORT_BUILD_DMA_SHARED_BUFFER
 	#h-file linux/dma-buf.h
 	#c-file drivers/base/dma-buf.c
 
-config BACKPORT_BUILD_CROSS_RESERVATION
-	bool
-	# not possible on kernel < 3.2
-	depends on !BACKPORT_KERNEL_3_2
-	depends on BACKPORT_BUILD_DMA_SHARED_BUFFER || DMA_SHARED_BUFFER
-	default y if BACKPORT_USERSEL_BUILD_ALL
-
 config BACKPORT_DMA_SHARED_BUFFER
 	bool
 
diff --git a/backport/compat/Makefile b/backport/compat/Makefile
index 14b4076..101d0f3 100644
--- a/backport/compat/Makefile
+++ b/backport/compat/Makefile
@@ -42,4 +42,3 @@ compat-$(CPTCFG_BACKPORT_BUILD_GENERIC_ATOMIC64) += compat_atomic.o
 compat-$(CPTCFG_BACKPORT_BUILD_DMA_SHARED_HELPERS) += dma-shared-helpers.o
 compat-$(CPTCFG_BACKPORT_BUILD_RADIX_HELPERS) += lib-radix-tree-helpers.o
 compat-$(CPTCFG_BACKPORT_BUILD_WW_MUTEX) += kernel/ww_mutex.o
-compat-$(CPTCFG_BACKPORT_BUILD_CROSS_RESERVATION) += drivers-base-reservation.o
diff --git a/backport/compat/drivers-base-reservation.c b/backport/compat/drivers-base-reservation.c
deleted file mode 100644
index 840ca1a..0000000
--- a/backport/compat/drivers-base-reservation.c
+++ /dev/null
@@ -1,39 +0,0 @@
-/*
- * Copyright (C) 2012-2013 Canonical Ltd
- *
- * Based on bo.c which bears the following copyright notice,
- * but is dual licensed:
- *
- * Copyright (c) 2006-2009 VMware, Inc., Palo Alto, CA., USA
- * All Rights Reserved.
- *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the
- * "Software"), to deal in the Software without restriction, including
- * without limitation the rights to use, copy, modify, merge, publish,
- * distribute, sub license, and/or sell copies of the Software, and to
- * permit persons to whom the Software is furnished to do so, subject to
- * the following conditions:
- *
- * The above copyright notice and this permission notice (including the
- * next paragraph) shall be included in all copies or substantial portions
- * of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL
- * THE COPYRIGHT HOLDERS, AUTHORS AND/OR ITS SUPPLIERS BE LIABLE FOR ANY CLAIM,
- * DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
- * OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
- * USE OR OTHER DEALINGS IN THE SOFTWARE.
- *
- **************************************************************************/
-/*
- * Authors: Thomas Hellstrom <thellstrom-at-vmware-dot-com>
- */
-
-#include <linux/reservation.h>
-#include <linux/export.h>
-
-DEFINE_WW_CLASS(reservation_ww_class);
-EXPORT_SYMBOL_GPL(reservation_ww_class);
-- 
1.7.10.4

