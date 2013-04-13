Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:44261 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753678Ab3DMXzk (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 13 Apr 2013 19:55:40 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [RFC/RFT 42/42] backports: automatically backport EWMA lib
Date: Sun, 14 Apr 2013 01:54:02 +0200
Message-Id: <1365897243-31214-43-git-send-email-johannes@sipsolutions.net> (sfid-20130414_015641_884074_34F66841)
In-Reply-To: <1365897243-31214-1-git-send-email-johannes@sipsolutions.net>
References: <1365897243-31214-1-git-send-email-johannes@sipsolutions.net>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

Use the scripting to always copy the latest version.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/average.h | 34 -------------------
 backport/compat/Kconfig                   |  2 ++
 backport/compat/Makefile                  |  1 -
 backport/compat/average.c                 | 54 -------------------------------
 4 files changed, 2 insertions(+), 89 deletions(-)
 delete mode 100644 backport/backport-include/linux/average.h
 delete mode 100644 backport/compat/average.c

diff --git a/backport/backport-include/linux/average.h b/backport/backport-include/linux/average.h
deleted file mode 100644
index 2d6210e..0000000
--- a/backport/backport-include/linux/average.h
+++ /dev/null
@@ -1,34 +0,0 @@
-#include <linux/version.h>
-
-#ifndef CPTCFG_BACKPORT_BUILD_AVERAGE
-#include_next <linux/average.h>
-#else
-/* Exponentially weighted moving average (EWMA) */
-
-/* For more documentation see lib/average.c */
-
-struct ewma {
-	unsigned long internal;
-	unsigned long factor;
-	unsigned long weight;
-};
-
-#define ewma_init LINUX_BACKPORT(ewma_init)
-extern void ewma_init(struct ewma *avg, unsigned long factor,
-		      unsigned long weight);
-
-#define ewma_add LINUX_BACKPORT(ewma_add)
-extern struct ewma *ewma_add(struct ewma *avg, unsigned long val);
-
-#define ewma_read LINUX_BACKPORT(ewma_read)
-/**
- * ewma_read() - Get average value
- * @avg: Average structure
- *
- * Returns the average value held in @avg.
- */
-static inline unsigned long ewma_read(const struct ewma *avg)
-{
-	return avg->internal >> avg->factor;
-}
-#endif /* (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,37)) */
diff --git a/backport/compat/Kconfig b/backport/compat/Kconfig
index df58dcc..0a2499e 100644
--- a/backport/compat/Kconfig
+++ b/backport/compat/Kconfig
@@ -116,6 +116,8 @@ config BACKPORT_BUILD_AVERAGE
 	depends on !AVERAGE
 	default y if BACKPORT_USERSEL_BUILD_ALL
 	default y if BACKPORT_AVERAGE
+	#h-file linux/average.h
+	#c-file lib/average.c
 
 config BACKPORT_AVERAGE
 	bool
diff --git a/backport/compat/Makefile b/backport/compat/Makefile
index 59584f1..41f223f 100644
--- a/backport/compat/Makefile
+++ b/backport/compat/Makefile
@@ -24,7 +24,6 @@ compat-$(CPTCFG_BACKPORT_KERNEL_2_6_34) += compat-2.6.34.o
 compat-$(CPTCFG_BACKPORT_KERNEL_2_6_35) += compat-2.6.35.o
 compat-$(CPTCFG_BACKPORT_KERNEL_2_6_36) += compat-2.6.36.o
 compat-$(CPTCFG_BACKPORT_KERNEL_2_6_37) += compat-2.6.37.o
-compat-$(CPTCFG_BACKPORT_BUILD_AVERAGE) += average.o
 compat-$(CPTCFG_BACKPORT_KERNEL_2_6_39) += compat-2.6.39.o kstrtox.o
 compat-$(CPTCFG_BACKPORT_KERNEL_3_0) += compat-3.0.o
 compat-$(CPTCFG_BACKPORT_KERNEL_3_1) += compat-3.1.o
diff --git a/backport/compat/average.c b/backport/compat/average.c
deleted file mode 100644
index b7a51a1..0000000
--- a/backport/compat/average.c
+++ /dev/null
@@ -1,54 +0,0 @@
-/*
- * Copyright 2010    Hauke Mehrtens <hauke@hauke-m.de>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * Compatibility file for Linux wireless for kernels 2.6.38.
- */
-
-#include <linux/average.h>
-#include <linux/module.h>
-#include <linux/bug.h>
-#include <linux/log2.h>
-
-/**
- * ewma_init() - Initialize EWMA parameters
- * @avg: Average structure
- * @factor: Factor to use for the scaled up internal value. The maximum value
- *	of averages can be ULONG_MAX/(factor*weight). For performance reasons
- *	factor has to be a power of 2.
- * @weight: Exponential weight, or decay rate. This defines how fast the
- *	influence of older values decreases. For performance reasons weight has
- *	to be a power of 2.
- *
- * Initialize the EWMA parameters for a given struct ewma @avg.
- */
-void ewma_init(struct ewma *avg, unsigned long factor, unsigned long weight)
-{
-	WARN_ON(!is_power_of_2(weight) || !is_power_of_2(factor));
-
-	avg->weight = ilog2(weight);
-	avg->factor = ilog2(factor);
-	avg->internal = 0;
-}
-EXPORT_SYMBOL_GPL(ewma_init);
-
-/**
- * ewma_add() - Exponentially weighted moving average (EWMA)
- * @avg: Average structure
- * @val: Current value
- *
- * Add a sample to the average.
- */
-struct ewma *ewma_add(struct ewma *avg, unsigned long val)
-{
-	avg->internal = avg->internal  ?
-		(((avg->internal << avg->weight) - avg->internal) +
-			(val << avg->factor)) >> avg->weight :
-		(val << avg->factor);
-	return avg;
-}
-EXPORT_SYMBOL_GPL(ewma_add);
-
-- 
1.8.0

