Return-path: <backports-owner@vger.kernel.org>
Received: from paleale.coelho.fi ([176.9.41.70]:50998 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727029AbeITRL5 (ORCPT
        <rfc822;backports@vger.kernel.org>); Thu, 20 Sep 2018 13:11:57 -0400
From: Luca Coelho <luca@coelho.fi>
To: backports@vger.kernel.org
Cc: Luca Coelho <luciano.coelho@intel.com>
Date: Thu, 20 Sep 2018 14:28:37 +0300
Message-Id: <20180920112842.27198-10-luca@coelho.fi> (sfid-20180920_132856_540776_D55FC53C)
In-Reply-To: <20180920112842.27198-1-luca@coelho.fi>
References: <20180920112842.27198-1-luca@coelho.fi>
Subject: [PATCH 09/14] backport: make ktime_get_boottime_seconds() non-inline
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Luca Coelho <luciano.coelho@intel.com>

With kernels < 3.17, we need to include hrtimer.h to get ktime_divns()
for the ktime_get_boottime_seconds() backport.  But we can't just
include htrtimer.h in the backport timekeeping.h because we run into
some cyclical inclusions that cause problems.  To solve that make
ktime_get_boottime_seconds() non-inline and add it to a new
backport-4.18.c file.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 backport/backport-include/linux/timekeeping.h |  5 +----
 backport/compat/Makefile                      |  1 +
 backport/compat/backport-4.18.c               | 11 +++++++++++
 3 files changed, 13 insertions(+), 4 deletions(-)
 create mode 100644 backport/compat/backport-4.18.c

diff --git a/backport/backport-include/linux/timekeeping.h b/backport/backport-include/linux/timekeeping.h
index 73ce9f1797ed..aebb00ca366b 100644
--- a/backport/backport-include/linux/timekeeping.h
+++ b/backport/backport-include/linux/timekeeping.h
@@ -25,10 +25,7 @@ static inline u64 ktime_get_boot_ns(void)
 #endif /* < 3.17 */
 
 #if LINUX_VERSION_IS_LESS(4,18,0)
-static inline time64_t ktime_get_boottime_seconds(void)
-{
-	return ktime_divns(ktime_get_boottime(), NSEC_PER_SEC);
-}
+extern time64_t ktime_get_boottime_seconds(void);
 #endif /* < 4.18 */
 
 #if LINUX_VERSION_IS_LESS(3,19,0)
diff --git a/backport/compat/Makefile b/backport/compat/Makefile
index 12c4121ff7e1..f5b1886e2d8e 100644
--- a/backport/compat/Makefile
+++ b/backport/compat/Makefile
@@ -37,6 +37,7 @@ compat-$(CPTCFG_KERNEL_4_7) += backport-4.7.o
 compat-$(CPTCFG_KERNEL_4_8) += backport-4.8.o
 compat-$(CPTCFG_KERNEL_4_10) += backport-4.10.o
 compat-$(CPTCFG_KERNEL_4_12) += backport-4.12.o
+compat-$(CPTCFG_KERNEL_4_18) += backport-4.18.o
 
 compat-$(CPTCFG_BPAUTO_CRYPTO_SKCIPHER) += crypto-skcipher.o
 
diff --git a/backport/compat/backport-4.18.c b/backport/compat/backport-4.18.c
new file mode 100644
index 000000000000..c47fabe5a7a1
--- /dev/null
+++ b/backport/compat/backport-4.18.c
@@ -0,0 +1,11 @@
+/*
+ * Copyright (C) 2018 Intel Corporation
+ */
+
+#include <linux/hrtimer.h>
+
+time64_t ktime_get_boottime_seconds(void)
+{
+	return ktime_divns(ktime_get_boottime(), NSEC_PER_SEC);
+}
+EXPORT_SYMBOL_GPL(ktime_get_boottime_seconds);
-- 
2.18.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
