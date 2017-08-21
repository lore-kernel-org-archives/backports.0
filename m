Return-path: <backports-owner@vger.kernel.org>
Received: from mx2.mailbox.org ([80.241.60.215]:42942 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754260AbdHUW2q (ORCPT <rfc822;backports@vger.kernel.org>);
        Mon, 21 Aug 2017 18:28:46 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 11/21] backport: add __print_array()
Date: Tue, 22 Aug 2017 00:28:07 +0200
Message-Id: <20170821222817.17376-12-hauke@hauke-m.de> (sfid-20170822_002848_924392_8E10AEC0)
In-Reply-To: <20170821222817.17376-1-hauke@hauke-m.de>
References: <20170821222817.17376-1-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This is used in the tracing system and needed by wireless now, it was
introduced in commit 6ea22486ba46bc ("tracing: Add array printing
helper").
This code is copied from kernel 4.0.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/ftrace_event.h | 10 ++++++
 backport/backport-include/trace/ftrace.h       |  9 +++++
 backport/compat/backport-4.0.c                 | 46 ++++++++++++++++++++++++++
 3 files changed, 65 insertions(+)
 create mode 100644 backport/backport-include/linux/ftrace_event.h
 create mode 100644 backport/backport-include/trace/ftrace.h

diff --git a/backport/backport-include/linux/ftrace_event.h b/backport/backport-include/linux/ftrace_event.h
new file mode 100644
index 00000000..edea21ee
--- /dev/null
+++ b/backport/backport-include/linux/ftrace_event.h
@@ -0,0 +1,10 @@
+#ifndef __BACKPORT_LINUX_FTRACE_EVENT_H
+#define __BACKPORT_LINUX_FTRACE_EVENT_H
+#include_next <linux/ftrace_event.h>
+
+#if LINUX_VERSION_IS_LESS(4,0,0)
+const char *ftrace_print_array_seq(struct trace_seq *p,
+				   const void *buf, int buf_len,
+				   size_t el_size);
+#endif
+#endif /* __BACKPORT_LINUX_FTRACE_EVENT_H */
diff --git a/backport/backport-include/trace/ftrace.h b/backport/backport-include/trace/ftrace.h
new file mode 100644
index 00000000..5fda0ce5
--- /dev/null
+++ b/backport/backport-include/trace/ftrace.h
@@ -0,0 +1,9 @@
+#undef __print_array
+#define __print_array(array, count, el_size)				\
+	({								\
+		BUILD_BUG_ON(el_size != 1 && el_size != 2 &&		\
+			     el_size != 4 && el_size != 8);		\
+		ftrace_print_array_seq(p, array, count, el_size);	\
+	})
+
+#include_next <trace/ftrace.h>
diff --git a/backport/compat/backport-4.0.c b/backport/compat/backport-4.0.c
index 8ae16115..71095f19 100644
--- a/backport/compat/backport-4.0.c
+++ b/backport/compat/backport-4.0.c
@@ -14,6 +14,8 @@
 #include <linux/ctype.h>
 #include <linux/printk.h>
 #include <linux/export.h>
+#include <linux/trace_seq.h>
+#include <linux/ftrace_event.h>
 #include <asm/unaligned.h>
 
 static __always_inline long __get_user_pages_locked(struct task_struct *tsk,
@@ -321,3 +323,47 @@ overflow1:
 	return ascii ? ascii_column + len : (groupsize * 2 + 1) * ngroups - 1;
 }
 EXPORT_SYMBOL_GPL(hex_dump_to_buffer);
+
+const char *
+ftrace_print_array_seq(struct trace_seq *p, const void *buf, int buf_len,
+		       size_t el_size)
+{
+	const char *ret = trace_seq_buffer_ptr(p);
+	const char *prefix = "";
+	void *ptr = (void *)buf;
+
+	trace_seq_putc(p, '{');
+
+	while (ptr < buf + buf_len) {
+		switch (el_size) {
+		case 1:
+			trace_seq_printf(p, "%s0x%x", prefix,
+					 *(u8 *)ptr);
+			break;
+		case 2:
+			trace_seq_printf(p, "%s0x%x", prefix,
+					 *(u16 *)ptr);
+			break;
+		case 4:
+			trace_seq_printf(p, "%s0x%x", prefix,
+					 *(u32 *)ptr);
+			break;
+		case 8:
+			trace_seq_printf(p, "%s0x%llx", prefix,
+					 *(u64 *)ptr);
+			break;
+		default:
+			trace_seq_printf(p, "BAD SIZE:%zu 0x%x", el_size,
+					 *(u8 *)ptr);
+			el_size = 1;
+		}
+		prefix = ",";
+		ptr += el_size;
+	}
+
+	trace_seq_putc(p, '}');
+	trace_seq_putc(p, 0);
+
+	return ret;
+}
+EXPORT_SYMBOL(ftrace_print_array_seq);
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
