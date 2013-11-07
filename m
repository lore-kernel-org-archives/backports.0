Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:55854 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752448Ab3KGU2d (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 7 Nov 2013 15:28:33 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 07/11] backports: update kfifo
Date: Thu,  7 Nov 2013 21:27:54 +0100
Message-Id: <1383856078-19823-8-git-send-email-hauke@hauke-m.de> (sfid-20131107_212837_866513_79FD7E84)
In-Reply-To: <1383856078-19823-1-git-send-email-hauke@hauke-m.de>
References: <1383856078-19823-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This brings kfifo to the state of next-20131106.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/kfifo.h |   48 ++++++++++---------------------
 backport/compat/kfifo.c                 |   13 ++++-----
 2 files changed, 21 insertions(+), 40 deletions(-)

diff --git a/backport/backport-include/linux/kfifo.h b/backport/backport-include/linux/kfifo.h
index 49de20e..1850038 100644
--- a/backport/backport-include/linux/kfifo.h
+++ b/backport/backport-include/linux/kfifo.h
@@ -9,7 +9,7 @@
 /*
  * A generic kernel FIFO implementation
  *
- * Copyright (C) 2009/2010 Stefani Seibold <stefani@seibold.net>
+ * Copyright (C) 2013 Stefani Seibold <stefani@seibold.net>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -75,9 +75,10 @@ struct __kfifo {
 	union { \
 		struct __kfifo	kfifo; \
 		datatype	*type; \
+		const datatype	*const_type; \
 		char		(*rectype)[recsize]; \
 		ptrtype		*ptr; \
-		const ptrtype	*ptr_const; \
+		ptrtype const	*ptr_const; \
 	}
 
 #define __STRUCT_KFIFO(type, size, recsize, ptrtype) \
@@ -194,6 +195,7 @@ __kfifo_int_must_check_helper(int val)
 #define __kfifo_alloc LINUX_BACKPORT(__kfifo_alloc)
 extern int __kfifo_alloc(struct __kfifo *fifo, unsigned int size,
 	size_t esize, gfp_t gfp_mask);
+
 #define __kfifo_free LINUX_BACKPORT(__kfifo_free)
 extern void __kfifo_free(struct __kfifo *fifo);
 
@@ -477,16 +479,12 @@ __kfifo_int_must_check_helper( \
 #define	kfifo_put(fifo, val) \
 ({ \
 	typeof((fifo) + 1) __tmp = (fifo); \
-	typeof((val) + 1) __val = (val); \
+	typeof(*__tmp->const_type) __val = (val); \
 	unsigned int __ret; \
-	const size_t __recsize = sizeof(*__tmp->rectype); \
+	size_t __recsize = sizeof(*__tmp->rectype); \
 	struct __kfifo *__kfifo = &__tmp->kfifo; \
-	if (0) { \
-		typeof(__tmp->ptr_const) __dummy __attribute__ ((unused)); \
-		__dummy = (typeof(__val))NULL; \
-	} \
 	if (__recsize) \
-		__ret = __kfifo_in_r(__kfifo, __val, sizeof(*__val), \
+		__ret = __kfifo_in_r(__kfifo, &__val, sizeof(__val), \
 			__recsize); \
 	else { \
 		__ret = !kfifo_is_full(__tmp); \
@@ -495,7 +493,7 @@ __kfifo_int_must_check_helper( \
 			((typeof(__tmp->type))__kfifo->data) : \
 			(__tmp->buf) \
 			)[__kfifo->in & __tmp->kfifo.mask] = \
-				*(typeof(__tmp->type))__val; \
+				(typeof(*__tmp->type))__val; \
 			smp_wmb(); \
 			__kfifo->in++; \
 		} \
@@ -506,7 +504,7 @@ __kfifo_int_must_check_helper( \
 /**
  * kfifo_get - get data from the fifo
  * @fifo: address of the fifo to be used
- * @val: the var where to store the data to be added
+ * @val: address where to store the data
  *
  * This macro reads the data from the fifo.
  * It returns 0 if the fifo was empty. Otherwise it returns the number
@@ -519,12 +517,10 @@ __kfifo_int_must_check_helper( \
 __kfifo_uint_must_check_helper( \
 ({ \
 	typeof((fifo) + 1) __tmp = (fifo); \
-	typeof((val) + 1) __val = (val); \
+	typeof(__tmp->ptr) __val = (val); \
 	unsigned int __ret; \
 	const size_t __recsize = sizeof(*__tmp->rectype); \
 	struct __kfifo *__kfifo = &__tmp->kfifo; \
-	if (0) \
-		__val = (typeof(__tmp->ptr))0; \
 	if (__recsize) \
 		__ret = __kfifo_out_r(__kfifo, __val, sizeof(*__val), \
 			__recsize); \
@@ -547,7 +543,7 @@ __kfifo_uint_must_check_helper( \
 /**
  * kfifo_peek - get data from the fifo without removing
  * @fifo: address of the fifo to be used
- * @val: the var where to store the data to be added
+ * @val: address where to store the data
  *
  * This reads the data from the fifo without removing it from the fifo.
  * It returns 0 if the fifo was empty. Otherwise it returns the number
@@ -560,12 +556,10 @@ __kfifo_uint_must_check_helper( \
 __kfifo_uint_must_check_helper( \
 ({ \
 	typeof((fifo) + 1) __tmp = (fifo); \
-	typeof((val) + 1) __val = (val); \
+	typeof(__tmp->ptr) __val = (val); \
 	unsigned int __ret; \
 	const size_t __recsize = sizeof(*__tmp->rectype); \
 	struct __kfifo *__kfifo = &__tmp->kfifo; \
-	if (0) \
-		__val = (typeof(__tmp->ptr))NULL; \
 	if (__recsize) \
 		__ret = __kfifo_out_peek_r(__kfifo, __val, sizeof(*__val), \
 			__recsize); \
@@ -599,14 +593,10 @@ __kfifo_uint_must_check_helper( \
 #define	kfifo_in(fifo, buf, n) \
 ({ \
 	typeof((fifo) + 1) __tmp = (fifo); \
-	typeof((buf) + 1) __buf = (buf); \
+	typeof(__tmp->ptr_const) __buf = (buf); \
 	unsigned long __n = (n); \
 	const size_t __recsize = sizeof(*__tmp->rectype); \
 	struct __kfifo *__kfifo = &__tmp->kfifo; \
-	if (0) { \
-		typeof(__tmp->ptr_const) __dummy __attribute__ ((unused)); \
-		__dummy = (typeof(__buf))NULL; \
-	} \
 	(__recsize) ?\
 	__kfifo_in_r(__kfifo, __buf, __n, __recsize) : \
 	__kfifo_in(__kfifo, __buf, __n); \
@@ -652,14 +642,10 @@ __kfifo_uint_must_check_helper( \
 __kfifo_uint_must_check_helper( \
 ({ \
 	typeof((fifo) + 1) __tmp = (fifo); \
-	typeof((buf) + 1) __buf = (buf); \
+	typeof(__tmp->ptr) __buf = (buf); \
 	unsigned long __n = (n); \
 	const size_t __recsize = sizeof(*__tmp->rectype); \
 	struct __kfifo *__kfifo = &__tmp->kfifo; \
-	if (0) { \
-		typeof(__tmp->ptr) __dummy = NULL; \
-		__buf = __dummy; \
-	} \
 	(__recsize) ?\
 	__kfifo_out_r(__kfifo, __buf, __n, __recsize) : \
 	__kfifo_out(__kfifo, __buf, __n); \
@@ -864,14 +850,10 @@ __kfifo_uint_must_check_helper( \
 __kfifo_uint_must_check_helper( \
 ({ \
 	typeof((fifo) + 1) __tmp = (fifo); \
-	typeof((buf) + 1) __buf = (buf); \
+	typeof(__tmp->ptr) __buf = (buf); \
 	unsigned long __n = (n); \
 	const size_t __recsize = sizeof(*__tmp->rectype); \
 	struct __kfifo *__kfifo = &__tmp->kfifo; \
-	if (0) { \
-		typeof(__tmp->ptr) __dummy __attribute__ ((unused)) = NULL; \
-		__buf = __dummy; \
-	} \
 	(__recsize) ? \
 	__kfifo_out_peek_r(__kfifo, __buf, __n, __recsize) : \
 	__kfifo_out_peek(__kfifo, __buf, __n); \
diff --git a/backport/compat/kfifo.c b/backport/compat/kfifo.c
index 96e1bdf..3c2520f 100644
--- a/backport/compat/kfifo.c
+++ b/backport/compat/kfifo.c
@@ -20,7 +20,7 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/module.h>
+#include <linux/export.h>
 #include <linux/slab.h>
 #include <linux/err.h>
 #include <linux/log2.h>
@@ -42,8 +42,7 @@ int __kfifo_alloc(struct __kfifo *fifo, unsigned int size,
 	 * round down to the next power of 2, since our 'let the indices
 	 * wrap' technique works only in this case.
 	 */
-	if (!is_power_of_2(size))
-		size = rounddown_pow_of_two(size);
+	size = roundup_pow_of_two(size);
 
 	fifo->in = 0;
 	fifo->out = 0;
@@ -83,8 +82,7 @@ int __kfifo_init(struct __kfifo *fifo, void *buffer,
 {
 	size /= esize;
 
-	if (!is_power_of_2(size))
-		size = rounddown_pow_of_two(size);
+	size = roundup_pow_of_two(size);
 
 	fifo->in = 0;
 	fifo->out = 0;
@@ -217,7 +215,7 @@ static unsigned long kfifo_copy_from_user(struct __kfifo *fifo,
 	 * incrementing the fifo->in index counter
 	 */
 	smp_wmb();
-	*copied = len - ret;
+	*copied = len - ret * esize;
 	/* return the number of elements which are not copied */
 	return ret;
 }
@@ -277,7 +275,7 @@ static unsigned long kfifo_copy_to_user(struct __kfifo *fifo, void __user *to,
 	 * incrementing the fifo->out index counter
 	 */
 	smp_wmb();
-	*copied = len - ret;
+	*copied = len - ret * esize;
 	/* return the number of elements which are not copied */
 	return ret;
 }
@@ -402,6 +400,7 @@ unsigned int __kfifo_max_r(unsigned int len, size_t recsize)
 		return max;
 	return len;
 }
+EXPORT_SYMBOL_GPL(__kfifo_max_r);
 
 #define	__KFIFO_PEEK(data, out, mask) \
 	((data)[(out) & (mask)])
-- 
1.7.10.4

