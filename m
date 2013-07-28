Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:50055 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752870Ab3G1BRq (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 27 Jul 2013 21:17:46 -0400
Received: by mail-pd0-f179.google.com with SMTP id v10so4032746pde.10
        for <backports@vger.kernel.org>; Sat, 27 Jul 2013 18:17:46 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	maarten.lankhorst@canonical.com, jglisse@redhat.com,
	airlied@redhat.com
Subject: [RFC 8/9] backports: backport cross-device reservation support
Date: Sat, 27 Jul 2013 18:16:29 -0700
Message-Id: <1374974190-31561-9-git-send-email-mcgrof@do-not-panic.com> (sfid-20130728_031748_329642_2D1C1EF2)
In-Reply-To: <1374974190-31561-1-git-send-email-mcgrof@do-not-panic.com>
References: <1374974190-31561-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

This backports cross-device reservation support.
Given that this feature is built around the
CONFIG_DMA_SHARED_BUFFER and given that some older kernels
will have DMA_SHARED_BUFFER without cross device reservation
support we can't use the c-file and h-file backports Kconfig
trick to automatically backport this feature from the
target git tree.

commit 786d7257e537da0674c02e16e3b30a44665d1cee
Author: Maarten Lankhorst <m.b.lankhorst@gmail.com>
Date:   Thu Jun 27 13:48:16 2013 +0200

    reservation: cross-device reservation support, v4

    This adds support for a generic reservations framework that can be
    hooked up to ttm and dma-buf and allows easy sharing of reservations
    across devices.

    The idea is that a dma-buf and ttm object both will get a pointer
    to a struct reservation_object, which has to be reserved before
    anything is done with the contents of the dma-buf.

    Changes since v1:
     - Fix locking issue in ticket_reserve, which could cause
       mutex_unlock
       to be called too many times.
    Changes since v2:
     - All fence related calls and members have been taken out for now,
       what's left is the bare minimum to be useful for ttm locking conversion.
    Changes since v3:
     - Removed helper functions too. The documentation has an example
       implementation for locking. With the move to ww_mutex there is no
       need to have much logic any more.

    Signed-off-by: Maarten Lankhorst <maarten.lankhorst@canonical.com>
    Reviewed-by: Jerome Glisse <jglisse@redhat.com>
    Signed-off-by: Dave Airlie <airlied@redhat.com>

Cc: maarten.lankhorst@canonical.com
Cc: jglisse@redhat.com
Cc: airlied@redhat.com
Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 backport/backport-include/linux/reservation.h |   70 +++++++++++++++++++++++++
 backport/compat/Kconfig                       |    7 +++
 backport/compat/Makefile                      |    1 +
 backport/compat/drivers-base-reservation.c    |   39 ++++++++++++++
 4 files changed, 117 insertions(+)
 create mode 100644 backport/backport-include/linux/reservation.h
 create mode 100644 backport/compat/drivers-base-reservation.c

diff --git a/backport/backport-include/linux/reservation.h b/backport/backport-include/linux/reservation.h
new file mode 100644
index 0000000..ff79ae8
--- /dev/null
+++ b/backport/backport-include/linux/reservation.h
@@ -0,0 +1,70 @@
+#ifndef _BACKPORT_LINUX_RESERVATION_H
+#define _BACKPORT_LINUX_RESERVATION_H
+
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0)
+#include_next <linux/reservation.h>
+#else
+#ifdef CPTCFG_BACKPORT_BUILD_CROSS_RESERVATION
+/*
+ * Header file for reservations for dma-buf and ttm
+ *
+ * Copyright(C) 2011 Linaro Limited. All rights reserved.
+ * Copyright (C) 2012-2013 Canonical Ltd
+ * Copyright (C) 2012 Texas Instruments
+ *
+ * Authors:
+ * Rob Clark <rob.clark@linaro.org>
+ * Maarten Lankhorst <maarten.lankhorst@canonical.com>
+ * Thomas Hellstrom <thellstrom-at-vmware-dot-com>
+ *
+ * Based on bo.c which bears the following copyright notice,
+ * but is dual licensed:
+ *
+ * Copyright (c) 2006-2009 VMware, Inc., Palo Alto, CA., USA
+ * All Rights Reserved.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the
+ * "Software"), to deal in the Software without restriction, including
+ * without limitation the rights to use, copy, modify, merge, publish,
+ * distribute, sub license, and/or sell copies of the Software, and to
+ * permit persons to whom the Software is furnished to do so, subject to
+ * the following conditions:
+ *
+ * The above copyright notice and this permission notice (including the
+ * next paragraph) shall be included in all copies or substantial portions
+ * of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDERS, AUTHORS AND/OR ITS SUPPLIERS BE LIABLE FOR ANY CLAIM,
+ * DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
+ * OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
+ * USE OR OTHER DEALINGS IN THE SOFTWARE.
+ */
+#include <linux/ww_mutex.h>
+
+extern struct ww_class reservation_ww_class;
+
+struct reservation_object {
+	struct ww_mutex lock;
+};
+
+#define reservation_object_init LINUX_BACKPORT(reservation_object_init)
+static inline void
+reservation_object_init(struct reservation_object *obj)
+{
+	ww_mutex_init(&obj->lock, &reservation_ww_class);
+}
+
+#define reservation_object_fini LINUX_BACKPORT(reservation_object_fini)
+static inline void
+reservation_object_fini(struct reservation_object *obj)
+{
+	ww_mutex_destroy(&obj->lock);
+}
+
+#endif /* BACKPORT_BUILD_CROSS_RESERVATION */
+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0) */
+#endif /* _BACKPORT_LINUX_RESERVATION_H */
diff --git a/backport/compat/Kconfig b/backport/compat/Kconfig
index f3c1ab3..8377013 100644
--- a/backport/compat/Kconfig
+++ b/backport/compat/Kconfig
@@ -139,6 +139,13 @@ config BACKPORT_BUILD_DMA_SHARED_BUFFER
 	#h-file linux/dma-buf.h
 	#c-file drivers/base/dma-buf.c
 
+config BACKPORT_BUILD_CROSS_RESERVATION
+	bool
+	# not possible on kernel < 3.2
+	depends on !BACKPORT_KERNEL_3_2
+	depends on BACKPORT_BUILD_DMA_SHARED_BUFFER || DMA_SHARED_BUFFER
+	default y if BACKPORT_USERSEL_BUILD_ALL
+
 config BACKPORT_DMA_SHARED_BUFFER
 	bool
 
diff --git a/backport/compat/Makefile b/backport/compat/Makefile
index fec01c4..80c0294 100644
--- a/backport/compat/Makefile
+++ b/backport/compat/Makefile
@@ -42,3 +42,4 @@ compat-$(CPTCFG_BACKPORT_BUILD_GENERIC_ATOMIC64) += compat_atomic.o
 compat-$(CPTCFG_BACKPORT_BUILD_DMA_SHARED_HELPERS) += dma-shared-helpers.o
 compat-$(CPTCFG_BACKPORT_BUILD_RADIX_HELPERS) += lib-radix-tree-helpers.o
 compat-$(CPTCFG_BACKPORT_BUILD_WW_MUTEX) += kernel/ww_mutex.o
+compat-$(CPTCFG_BACKPORT_BUILD_CROSS_RESERVATION) += drivers-base-reservation.o
diff --git a/backport/compat/drivers-base-reservation.c b/backport/compat/drivers-base-reservation.c
new file mode 100644
index 0000000..a73fbf3
--- /dev/null
+++ b/backport/compat/drivers-base-reservation.c
@@ -0,0 +1,39 @@
+/*
+ * Copyright (C) 2012-2013 Canonical Ltd
+ *
+ * Based on bo.c which bears the following copyright notice,
+ * but is dual licensed:
+ *
+ * Copyright (c) 2006-2009 VMware, Inc., Palo Alto, CA., USA
+ * All Rights Reserved.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the
+ * "Software"), to deal in the Software without restriction, including
+ * without limitation the rights to use, copy, modify, merge, publish,
+ * distribute, sub license, and/or sell copies of the Software, and to
+ * permit persons to whom the Software is furnished to do so, subject to
+ * the following conditions:
+ *
+ * The above copyright notice and this permission notice (including the
+ * next paragraph) shall be included in all copies or substantial portions
+ * of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDERS, AUTHORS AND/OR ITS SUPPLIERS BE LIABLE FOR ANY CLAIM,
+ * DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
+ * OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
+ * USE OR OTHER DEALINGS IN THE SOFTWARE.
+ *
+ **************************************************************************/
+/*
+ * Authors: Thomas Hellstrom <thellstrom-at-vmware-dot-com>
+ */
+
+#include <linux/reservation.h>
+#include <linux/export.h>
+
+DEFINE_WW_CLASS(reservation_ww_class);
+EXPORT_SYMBOL(reservation_ww_class);
-- 
1.7.10.4

