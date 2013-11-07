Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:55852 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752448Ab3KGU2b (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 7 Nov 2013 15:28:31 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 08/11] backports: fix kfifo_put()
Date: Thu,  7 Nov 2013 21:27:55 +0100
Message-Id: <1383856078-19823-9-git-send-email-hauke@hauke-m.de> (sfid-20131107_212837_228427_C9C8B05D)
In-Reply-To: <1383856078-19823-1-git-send-email-hauke@hauke-m.de>
References: <1383856078-19823-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

kfifo_put() now gets the second parameter by value and not by reference
any more. This replaces the in kernel implementation of kfifo_put()
with a version which is compatible to the in kernel structures but
takes the value and not a reference to the value. We wanted to do this:
 #define kfifo_put(fifo, val) kfifo_put(fifo, &val)

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/kfifo.h |   45 +++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/backport/backport-include/linux/kfifo.h b/backport/backport-include/linux/kfifo.h
index 1850038..379c1cb 100644
--- a/backport/backport-include/linux/kfifo.h
+++ b/backport/backport-include/linux/kfifo.h
@@ -5,6 +5,51 @@
 #else
 #include <linux/kfifo-new.h>
 #endif
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,13,0)
+#undef kfifo_put
+/**
+ * kfifo_put - put data into the fifo
+ * @fifo: address of the fifo to be used
+ * @val: the data to be added
+ *
+ * This macro copies the given value into the fifo.
+ * It returns 0 if the fifo was full. Otherwise it returns the number
+ * processed elements.
+ *
+ * Note that with only one concurrent reader and one concurrent
+ * writer, you don't need extra locking to use these macro.
+ */
+#define	kfifo_put(fifo, val) \
+({ \
+	typeof((fifo) + 1) __tmp = (fifo); \
+	typeof((&val) + 1) __val = (&val); \
+	unsigned int __ret; \
+	const size_t __recsize = sizeof(*__tmp->rectype); \
+	struct __kfifo *__kfifo = &__tmp->kfifo; \
+	if (0) { \
+		typeof(__tmp->ptr_const) __dummy __attribute__ ((unused)); \
+		__dummy = (typeof(__val))NULL; \
+	} \
+	if (__recsize) \
+		__ret = __kfifo_in_r(__kfifo, __val, sizeof(*__val), \
+			__recsize); \
+	else { \
+		__ret = !kfifo_is_full(__tmp); \
+		if (__ret) { \
+			(__is_kfifo_ptr(__tmp) ? \
+			((typeof(__tmp->type))__kfifo->data) : \
+			(__tmp->buf) \
+			)[__kfifo->in & __tmp->kfifo.mask] = \
+				*(typeof(__tmp->type))__val; \
+			smp_wmb(); \
+			__kfifo->in++; \
+		} \
+	} \
+	__ret; \
+})
+#endif
+
 #else
 /*
  * A generic kernel FIFO implementation
-- 
1.7.10.4

