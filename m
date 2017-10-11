Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.63.242]:48822 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751712AbdJKOb7 (ORCPT
        <rfc822;backports@vger.kernel.org>); Wed, 11 Oct 2017 10:31:59 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 5/5] backports: add crypto_memneq()
Date: Wed, 11 Oct 2017 16:31:47 +0200
Message-Id: <20171011143147.3337-5-johannes@sipsolutions.net> (sfid-20171011_163301_413489_F83A5F30)
In-Reply-To: <20171011143147.3337-1-johannes@sipsolutions.net>
References: <20171011143147.3337-1-johannes@sipsolutions.net>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/crypto/algapi.h | 16 ++++++++++++++++
 backport/compat/Makefile                  |  2 +-
 copy-list                                 |  3 +++
 3 files changed, 20 insertions(+), 1 deletion(-)
 create mode 100644 backport/backport-include/crypto/algapi.h

diff --git a/backport/backport-include/crypto/algapi.h b/backport/backport-include/crypto/algapi.h
new file mode 100644
index 000000000000..b6fbdd9bf224
--- /dev/null
+++ b/backport/backport-include/crypto/algapi.h
@@ -0,0 +1,16 @@
+#ifndef __BP_ALGAPI_H
+#define __BP_ALGAPI_H
+#include <linux/version.h>
+#include_next <crypto/algapi.h>
+
+#if LINUX_VERSION_IS_LESS(3,13,0)
+#define __crypto_memneq LINUX_BACKPORT(__crypto_memneq)
+noinline unsigned long __crypto_memneq(const void *a, const void *b, size_t size);
+#define crypto_memneq LINUX_BACKPORT(crypto_memneq)
+static inline int crypto_memneq(const void *a, const void *b, size_t size)
+{
+        return __crypto_memneq(a, b, size) != 0UL ? 1 : 0;
+}
+#endif
+
+#endif /* __BP_ALGAPI_H */
diff --git a/backport/compat/Makefile b/backport/compat/Makefile
index 1078357fd04b..1658f588c68f 100644
--- a/backport/compat/Makefile
+++ b/backport/compat/Makefile
@@ -20,7 +20,7 @@ compat-$(CPTCFG_KERNEL_3_9) += compat-3.9.o
 compat-$(CPTCFG_KERNEL_3_10) += backport-3.10.o
 compat-$(CPTCFG_KERNEL_3_11) += backport-3.11.o
 compat-$(CPTCFG_KERNEL_3_12) += backport-3.12.o
-compat-$(CPTCFG_KERNEL_3_13) += backport-3.13.o
+compat-$(CPTCFG_KERNEL_3_13) += backport-3.13.o memneq.o
 compat-$(CPTCFG_KERNEL_3_14) += backport-3.14.o
 compat-$(CPTCFG_KERNEL_3_15) += backport-3.15.o
 compat-$(CPTCFG_KERNEL_3_17) += backport-3.17.o
diff --git a/copy-list b/copy-list
index 88e91c617125..678ebe2f59fc 100644
--- a/copy-list
+++ b/copy-list
@@ -20,6 +20,9 @@ include/linux/fixp-arith.h
 include/linux/bitfield.h
 include/linux/average.h
 
+# crypto_memneq
+crypto/memneq.c -> compat/memneq.c
+
 # 802.11
 drivers/net/wireless/Kconfig
 drivers/net/wireless/Makefile
-- 
2.14.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
