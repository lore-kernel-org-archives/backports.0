Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:49898 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752460AbcBLN7v (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 12 Feb 2016 08:59:51 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 2/5] backports: add div64_u64_rem()
Date: Fri, 12 Feb 2016 14:58:36 +0100
Message-Id: <1455285519-16163-3-git-send-email-hauke@hauke-m.de> (sfid-20160212_145954_819850_A7B8011C)
In-Reply-To: <1455285519-16163-1-git-send-email-hauke@hauke-m.de>
References: <1455285519-16163-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This function was added to the mainline kernel in commit eb18cba7
"math64: New separate div64_u64_rem helper" and is now used the virtual
video test driver.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/math64.h | 27 ++++++++++++++++++++
 backport/compat/backport-3.12.c          | 43 ++++++++++++++++++++++++++++++++
 2 files changed, 70 insertions(+)
 create mode 100644 backport/backport-include/linux/math64.h

diff --git a/backport/backport-include/linux/math64.h b/backport/backport-include/linux/math64.h
new file mode 100644
index 0000000..2fbde06
--- /dev/null
+++ b/backport/backport-include/linux/math64.h
@@ -0,0 +1,27 @@
+#ifndef __BACKPORT_LINUX_MATH64_H
+#define __BACKPORT_LINUX_MATH64_H
+#include_next <linux/math64.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,12,0)
+
+#if BITS_PER_LONG == 64
+/**
+ * div64_u64_rem - unsigned 64bit divide with 64bit divisor and remainder
+ */
+#define div64_u64_rem LINUX_BACKPORT(div64_u64_rem)
+static inline u64 div64_u64_rem(u64 dividend, u64 divisor, u64 *remainder)
+{
+	*remainder = dividend % divisor;
+	return dividend / divisor;
+}
+#elif BITS_PER_LONG == 32
+#ifndef div64_u64_rem
+#define div64_u64_rem LINUX_BACKPORT(div64_u64_rem)
+#define backports_div64_u64_rem_add 1
+extern u64 div64_u64_rem(u64 dividend, u64 divisor, u64 *remainder);
+#endif
+
+#endif /* BITS_PER_LONG */
+#endif /* < 3.12 */
+
+#endif /* __BACKPORT_LINUX_MATH64_H */
diff --git a/backport/compat/backport-3.12.c b/backport/compat/backport-3.12.c
index 7e3dc58..c9b21e8 100644
--- a/backport/compat/backport-3.12.c
+++ b/backport/compat/backport-3.12.c
@@ -11,6 +11,7 @@
 #include <linux/export.h>
 #include <linux/hid.h>
 #include <linux/bug.h>
+#include <linux/math64.h>
 
 /*
  * Allocator for buffer that is going to be passed to hid_output_report()
@@ -27,3 +28,45 @@ u8 *hid_alloc_report_buf(struct hid_report *report, gfp_t flags)
 	return kmalloc(len, flags);
 }
 EXPORT_SYMBOL_GPL(hid_alloc_report_buf);
+
+#if BITS_PER_LONG == 32
+/**
+ * div64_u64_rem - unsigned 64bit divide with 64bit divisor and remainder
+ * @dividend:	64bit dividend
+ * @divisor:	64bit divisor
+ * @remainder:  64bit remainder
+ *
+ * This implementation is a comparable to algorithm used by div64_u64.
+ * But this operation, which includes math for calculating the remainder,
+ * is kept distinct to avoid slowing down the div64_u64 operation on 32bit
+ * systems.
+ */
+#ifndef backports_div64_u64_rem_add
+u64 div64_u64_rem(u64 dividend, u64 divisor, u64 *remainder)
+{
+	u32 high = divisor >> 32;
+	u64 quot;
+
+	if (high == 0) {
+		u32 rem32;
+		quot = div_u64_rem(dividend, divisor, &rem32);
+		*remainder = rem32;
+	} else {
+		int n = 1 + fls(high);
+		quot = div_u64(dividend >> n, divisor >> n);
+
+		if (quot != 0)
+			quot--;
+
+		*remainder = dividend - quot * divisor;
+		if (*remainder >= divisor) {
+			quot++;
+			*remainder -= divisor;
+		}
+	}
+
+	return quot;
+}
+EXPORT_SYMBOL_GPL(div64_u64_rem);
+#endif /* backports_div64_u64_rem_add */
+#endif /* BITS_PER_LONG */
-- 
2.7.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
