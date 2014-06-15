Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:44803 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751133AbaFOVV0 (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 15 Jun 2014 17:21:26 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH] MIPS: Reimplement get_cycles().
Date: Sun, 15 Jun 2014 23:21:11 +0200
Message-Id: <1402867271-31207-1-git-send-email-hauke@hauke-m.de> (sfid-20140615_232130_194767_48EFFDDD)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Ralf Baechle <ralf@linux-mips.org>

This essentially reverts commit efb9ca08b5a2374b29938cdcab417ce4feb14b54
(kernel.org) / 58020a106879a8b372068741c81f0015c9b0b96dbv [[MIPS] Change
get_cycles to always return 0.]

Most users of get_cycles() invoke it as a timing interface.  That's why
in modern kernels it was never very much missed for.  /dev/random however
uses get_cycles() in the how the jitter in the interrupt timing contains
some useful entropy.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
---
 arch/mips/include/asm/timex.h |   33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/timex.h b/arch/mips/include/asm/timex.h
index 6529704..c542475 100644
--- a/arch/mips/include/asm/timex.h
+++ b/arch/mips/include/asm/timex.h
@@ -10,7 +10,9 @@
 
 #ifdef __KERNEL__
 
+#include <asm/cpu-features.h>
 #include <asm/mipsregs.h>
+#include <asm/cpu-type.h>
 
 /*
  * This is the clock rate of the i8253 PIT.  A MIPS system may not have
@@ -33,9 +35,38 @@
 
 typedef unsigned int cycles_t;
 
+/*
+ * On R4000/R4400 before version 5.0 an erratum exists such that if the
+ * cycle counter is read in the exact moment that it is matching the
+ * compare register, no interrupt will be generated.
+ *
+ * There is a suggested workaround and also the erratum can't strike if
+ * the compare interrupt isn't being used as the clock source device.
+ * However for now the implementaton of this function doesn't get these
+ * fine details right.
+ */
 static inline cycles_t get_cycles(void)
 {
-	return 0;
+	switch (boot_cpu_type()) {
+	case CPU_R4400PC:
+	case CPU_R4400SC:
+	case CPU_R4400MC:
+		if ((read_c0_prid() & 0xff) >= 0x0050)
+			return read_c0_count();
+		break;
+
+        case CPU_R4000PC:
+        case CPU_R4000SC:
+        case CPU_R4000MC:
+		break;
+
+	default:
+		if (cpu_has_counter)
+			return read_c0_count();
+		break;
+	}
+
+	return 0;	/* no usable counter */
 }
 
 #endif /* __KERNEL__ */
-- 
1.7.10.4

