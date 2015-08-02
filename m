Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:39113 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751763AbbHBWh5 (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 2 Aug 2015 18:37:57 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@kernel.org
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 2/8] backports: add hex_dump_to_buffer() with int return value
Date: Mon,  3 Aug 2015 00:37:41 +0200
Message-Id: <1438555067-15301-3-git-send-email-hauke@hauke-m.de> (sfid-20150803_003803_858657_AA31EEF1)
In-Reply-To: <1438555067-15301-1-git-send-email-hauke@hauke-m.de>
References: <1438555067-15301-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

In the kernel hex_dump_to_buffer() got an int return value, returning
the amount of bytes written into the buffer. This new return value is
needed by seq_hex_dump() which we also backport.

This change was done in the following commit in mainline Linux kernel:
commit 114fc1afb2de7dec40da137dc2a55cd38fc220f2
Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date:   Thu Feb 12 15:02:29 2015 -0800

    hexdump: make it return number of bytes placed in buffer

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/printk.h |   8 ++
 backport/compat/backport-4.0.c           | 132 +++++++++++++++++++++++++++++++
 2 files changed, 140 insertions(+)

diff --git a/backport/backport-include/linux/printk.h b/backport/backport-include/linux/printk.h
index 88989a9..d8083ac 100644
--- a/backport/backport-include/linux/printk.h
+++ b/backport/backport-include/linux/printk.h
@@ -138,6 +138,14 @@ do {									\
 #endif
 #endif /* pr_debug_ratelimited */
 
+/* replace hex_dump_to_buffer() with a version which returns the length */
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4,0,0)
+#define hex_dump_to_buffer LINUX_BACKPORT(hex_dump_to_buffer)
+extern int hex_dump_to_buffer(const void *buf, size_t len, int rowsize,
+			      int groupsize, char *linebuf, size_t linebuflen,
+			      bool ascii);
+#endif
+
 #endif	/* _COMPAT_LINUX_PRINTK_H */
 
 /* This must be outside -- see also kernel.h */
diff --git a/backport/compat/backport-4.0.c b/backport/compat/backport-4.0.c
index 3de1211..acec0af 100644
--- a/backport/compat/backport-4.0.c
+++ b/backport/compat/backport-4.0.c
@@ -11,7 +11,10 @@
 #include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/sched.h>
+#include <linux/ctype.h>
+#include <linux/printk.h>
 #include <linux/export.h>
+#include <asm/unaligned.h>
 
 static __always_inline long __get_user_pages_locked(struct task_struct *tsk,
 						struct mm_struct *mm,
@@ -191,3 +194,132 @@ long get_user_pages_unlocked(struct task_struct *tsk, struct mm_struct *mm,
 					 force, pages, FOLL_TOUCH);
 }
 EXPORT_SYMBOL_GPL(get_user_pages_unlocked);
+
+
+/**
+ * hex_dump_to_buffer - convert a blob of data to "hex ASCII" in memory
+ * @buf: data blob to dump
+ * @len: number of bytes in the @buf
+ * @rowsize: number of bytes to print per line; must be 16 or 32
+ * @groupsize: number of bytes to print at a time (1, 2, 4, 8; default = 1)
+ * @linebuf: where to put the converted data
+ * @linebuflen: total size of @linebuf, including space for terminating NUL
+ * @ascii: include ASCII after the hex output
+ *
+ * hex_dump_to_buffer() works on one "line" of output at a time, i.e.,
+ * 16 or 32 bytes of input data converted to hex + ASCII output.
+ *
+ * Given a buffer of u8 data, hex_dump_to_buffer() converts the input data
+ * to a hex + ASCII dump at the supplied memory location.
+ * The converted output is always NUL-terminated.
+ *
+ * E.g.:
+ *   hex_dump_to_buffer(frame->data, frame->len, 16, 1,
+ *			linebuf, sizeof(linebuf), true);
+ *
+ * example output buffer:
+ * 40 41 42 43 44 45 46 47 48 49 4a 4b 4c 4d 4e 4f  @ABCDEFGHIJKLMNO
+ *
+ * Return:
+ * The amount of bytes placed in the buffer without terminating NUL. If the
+ * output was truncated, then the return value is the number of bytes
+ * (excluding the terminating NUL) which would have been written to the final
+ * string if enough space had been available.
+ */
+int hex_dump_to_buffer(const void *buf, size_t len, int rowsize, int groupsize,
+		       char *linebuf, size_t linebuflen, bool ascii)
+{
+	const u8 *ptr = buf;
+	int ngroups;
+	u8 ch;
+	int j, lx = 0;
+	int ascii_column;
+	int ret;
+
+	if (rowsize != 16 && rowsize != 32)
+		rowsize = 16;
+
+	if (len > rowsize)		/* limit to one line at a time */
+		len = rowsize;
+	if (!is_power_of_2(groupsize) || groupsize > 8)
+		groupsize = 1;
+	if ((len % groupsize) != 0)	/* no mixed size output */
+		groupsize = 1;
+
+	ngroups = len / groupsize;
+	ascii_column = rowsize * 2 + rowsize / groupsize + 1;
+
+	if (!linebuflen)
+		goto overflow1;
+
+	if (!len)
+		goto nil;
+
+	if (groupsize == 8) {
+		const u64 *ptr8 = buf;
+
+		for (j = 0; j < ngroups; j++) {
+			ret = snprintf(linebuf + lx, linebuflen - lx,
+				       "%s%16.16llx", j ? " " : "",
+				       get_unaligned(ptr8 + j));
+			if (ret >= linebuflen - lx)
+				goto overflow1;
+			lx += ret;
+		}
+	} else if (groupsize == 4) {
+		const u32 *ptr4 = buf;
+
+		for (j = 0; j < ngroups; j++) {
+			ret = snprintf(linebuf + lx, linebuflen - lx,
+				       "%s%8.8x", j ? " " : "",
+				       get_unaligned(ptr4 + j));
+			if (ret >= linebuflen - lx)
+				goto overflow1;
+			lx += ret;
+		}
+	} else if (groupsize == 2) {
+		const u16 *ptr2 = buf;
+
+		for (j = 0; j < ngroups; j++) {
+			ret = snprintf(linebuf + lx, linebuflen - lx,
+				       "%s%4.4x", j ? " " : "",
+				       get_unaligned(ptr2 + j));
+			if (ret >= linebuflen - lx)
+				goto overflow1;
+			lx += ret;
+		}
+	} else {
+		for (j = 0; j < len; j++) {
+			if (linebuflen < lx + 3)
+				goto overflow2;
+			ch = ptr[j];
+			linebuf[lx++] = hex_asc_hi(ch);
+			linebuf[lx++] = hex_asc_lo(ch);
+			linebuf[lx++] = ' ';
+		}
+		if (j)
+			lx--;
+	}
+	if (!ascii)
+		goto nil;
+
+	while (lx < ascii_column) {
+		if (linebuflen < lx + 2)
+			goto overflow2;
+		linebuf[lx++] = ' ';
+	}
+	for (j = 0; j < len; j++) {
+		if (linebuflen < lx + 2)
+			goto overflow2;
+		ch = ptr[j];
+		linebuf[lx++] = (isascii(ch) && isprint(ch)) ? ch : '.';
+	}
+nil:
+	linebuf[lx] = '\0';
+	return lx;
+overflow2:
+	linebuf[lx++] = '\0';
+overflow1:
+	return ascii ? ascii_column + len : (groupsize * 2 + 1) * ngroups - 1;
+}
+EXPORT_SYMBOL_GPL(hex_dump_to_buffer);
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe backports" in
