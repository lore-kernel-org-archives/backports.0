Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:47169 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752931AbaBJWr6 (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 10 Feb 2014 17:47:58 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 4/6] backports: copy cordic from kernel
Date: Mon, 10 Feb 2014 23:47:32 +0100
Message-Id: <1392072454-18538-5-git-send-email-hauke@hauke-m.de> (sfid-20140210_234800_248269_95CCFF54)
In-Reply-To: <1392072454-18538-1-git-send-email-hauke@hauke-m.de>
References: <1392072454-18538-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Instead of using an own version of cordic.c make backports copy that
code from the kernel and use that. This ensures that we will always use
the latest version.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/compat/Kconfig  |    2 +
 backport/compat/Makefile |    2 -
 backport/compat/cordic.c |  101 ----------------------------------------------
 3 files changed, 2 insertions(+), 103 deletions(-)
 delete mode 100644 backport/compat/cordic.c

diff --git a/backport/compat/Kconfig b/backport/compat/Kconfig
index 91531c3..8209d42 100644
--- a/backport/compat/Kconfig
+++ b/backport/compat/Kconfig
@@ -89,6 +89,8 @@ config BACKPORT_BUILD_CORDIC
 	depends on !CORDIC
 	default m if BACKPORT_CORDIC
 	default m if BACKPORT_USERSEL_BUILD_ALL
+	#module-name cordic
+	#c-file lib/cordic.c
 
 config BACKPORT_CORDIC
 	bool
diff --git a/backport/compat/Makefile b/backport/compat/Makefile
index d3f40f9..f26ad9f 100644
--- a/backport/compat/Makefile
+++ b/backport/compat/Makefile
@@ -9,8 +9,6 @@ obj-$(CPTCFG_BACKPORT_USERSEL_NET_SCH_CODEL) += sch_codel.o
 sch_fq_codel-y = sch_fq_codel_core.o flow_dissector.o
 obj-$(CPTCFG_BACKPORT_USERSEL_NET_SCH_FQ_CODEL) += sch_fq_codel.o
 
-obj-$(CPTCFG_BACKPORT_BUILD_CORDIC) += cordic.o
-
 # Compat kernel compatibility code
 compat-$(CPTCFG_BACKPORT_KERNEL_2_6_26) += compat-2.6.26.o
 compat-$(CPTCFG_BACKPORT_KERNEL_2_6_27) += compat-2.6.27.o
diff --git a/backport/compat/cordic.c b/backport/compat/cordic.c
deleted file mode 100644
index a6340b6..0000000
--- a/backport/compat/cordic.c
+++ /dev/null
@@ -1,101 +0,0 @@
-/*
- * Copyright (c) 2011 Broadcom Corporation
- *
- * Permission to use, copy, modify, and/or distribute this software for any
- * purpose with or without fee is hereby granted, provided that the above
- * copyright notice and this permission notice appear in all copies.
- *
- * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
- * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
- * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY
- * SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
- * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION
- * OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN
- * CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
- */
-#include <linux/module.h>
-#include <linux/cordic.h>
-
-#define CORDIC_ANGLE_GEN	39797
-#define CORDIC_PRECISION_SHIFT	16
-#define	CORDIC_NUM_ITER		(CORDIC_PRECISION_SHIFT + 2)
-
-#define	FIXED(X)	((s32)((X) << CORDIC_PRECISION_SHIFT))
-#define	FLOAT(X)	(((X) >= 0) \
-		? ((((X) >> (CORDIC_PRECISION_SHIFT - 1)) + 1) >> 1) \
-		: -((((-(X)) >> (CORDIC_PRECISION_SHIFT - 1)) + 1) >> 1))
-
-static const s32 arctan_table[] = {
-	2949120,
-	1740967,
-	919879,
-	466945,
-	234379,
-	117304,
-	58666,
-	29335,
-	14668,
-	7334,
-	3667,
-	1833,
-	917,
-	458,
-	229,
-	115,
-	57,
-	29
-};
-
-/*
- * cordic_calc_iq() - calculates the i/q coordinate for given angle
- *
- * theta: angle in degrees for which i/q coordinate is to be calculated
- * coord: function output parameter holding the i/q coordinate
- */
-struct cordic_iq cordic_calc_iq(s32 theta)
-{
-	struct cordic_iq coord;
-	s32 angle, valtmp;
-	unsigned iter;
-	int signx = 1;
-	int signtheta;
-
-	coord.i = CORDIC_ANGLE_GEN;
-	coord.q = 0;
-	angle = 0;
-
-	theta = FIXED(theta);
-	signtheta = (theta < 0) ? -1 : 1;
-	theta = ((theta + FIXED(180) * signtheta) % FIXED(360)) -
-		FIXED(180) * signtheta;
-
-	if (FLOAT(theta) > 90) {
-		theta -= FIXED(180);
-		signx = -1;
-	} else if (FLOAT(theta) < -90) {
-		theta += FIXED(180);
-		signx = -1;
-	}
-
-	for (iter = 0; iter < CORDIC_NUM_ITER; iter++) {
-		if (theta > angle) {
-			valtmp = coord.i - (coord.q >> iter);
-			coord.q += (coord.i >> iter);
-			angle += arctan_table[iter];
-		} else {
-			valtmp = coord.i + (coord.q >> iter);
-			coord.q -= (coord.i >> iter);
-			angle -= arctan_table[iter];
-		}
-		coord.i = valtmp;
-	}
-
-	coord.i *= signx;
-	coord.q *= signx;
-	return coord;
-}
-EXPORT_SYMBOL_GPL(cordic_calc_iq);
-
-MODULE_DESCRIPTION("Cordic functions");
-MODULE_AUTHOR("Broadcom Corporation");
-MODULE_LICENSE("Dual BSD/GPL");
-- 
1.7.10.4

