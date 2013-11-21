Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:62121 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754148Ab3KUOwq (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 21 Nov 2013 09:52:46 -0500
From: Stefan Assmann <sassmann@kpanic.de>
To: mcgrof@kernel.org
Cc: backports@vger.kernel.org, hauke@hauke-m.de, sassmann@kpanic.de,
	johannes@sipsolutions.net
Subject: [PATCH v2] backports: replace linux/bitops.h header
Date: Thu, 21 Nov 2013 15:51:57 +0100
Message-Id: <1385045517-15868-1-git-send-email-sassmann@kpanic.de> (sfid-20131121_155256_096617_1727BB11)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Instead of copying bitops.h from upstream just add what's missing in
older kernel.

Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
---
 backport/backport-include/linux/bitops.h | 217 +++----------------------------
 1 file changed, 20 insertions(+), 197 deletions(-)

diff --git a/backport/backport-include/linux/bitops.h b/backport/backport-include/linux/bitops.h
index aa76af1..f2d2faf 100644
--- a/backport/backport-include/linux/bitops.h
+++ b/backport/backport-include/linux/bitops.h
@@ -1,142 +1,9 @@
-#ifndef _LINUX_BITOPS_H
-#define _LINUX_BITOPS_H
-#include <asm/types.h>
+#ifndef __BACKPORT_BITOPS_H
+#define __BACKPORT_BITOPS_H
+#include_next <linux/bitops.h>
+#include <linux/version.h>
 
-#ifdef	__KERNEL__
-#define BIT(nr)			(1UL << (nr))
-#define BIT_MASK(nr)		(1UL << ((nr) % BITS_PER_LONG))
-#define BIT_WORD(nr)		((nr) / BITS_PER_LONG)
-#define BITS_PER_BYTE		8
-#ifndef BITS_TO_LONGS /* Older kernels define this already */
-#define BITS_TO_LONGS(nr)	DIV_ROUND_UP(nr, BITS_PER_BYTE * sizeof(long))
-#endif
-#endif
-
-extern unsigned int __sw_hweight8(unsigned int w);
-extern unsigned int __sw_hweight16(unsigned int w);
-extern unsigned int __sw_hweight32(unsigned int w);
-extern unsigned long __sw_hweight64(__u64 w);
-
-/*
- * Include this here because some architectures need generic_ffs/fls in
- * scope
- */
-#include <asm/bitops.h>
-
-#define for_each_set_bit(bit, addr, size) \
-	for ((bit) = find_first_bit((addr), (size)); \
-	     (bit) < (size); \
-	     (bit) = find_next_bit((addr), (size), (bit) + 1))
-
-static __inline__ int get_bitmask_order(unsigned int count)
-{
-	int order;
-
-	order = fls(count);
-	return order;	/* We could be slightly more clever with -1 here... */
-}
-
-static __inline__ int get_count_order(unsigned int count)
-{
-	int order;
-
-	order = fls(count) - 1;
-	if (count & (count - 1))
-		order++;
-	return order;
-}
-
-static inline unsigned long hweight_long(unsigned long w)
-{
-	return sizeof(w) == 4 ? hweight32(w) : hweight64(w);
-}
-
-/**
- * rol32 - rotate a 32-bit value left
- * @word: value to rotate
- * @shift: bits to roll
- */
-static inline __u32 rol32(__u32 word, unsigned int shift)
-{
-	return (word << shift) | (word >> (32 - shift));
-}
-
-/**
- * ror32 - rotate a 32-bit value right
- * @word: value to rotate
- * @shift: bits to roll
- */
-static inline __u32 ror32(__u32 word, unsigned int shift)
-{
-	return (word >> shift) | (word << (32 - shift));
-}
-
-/**
- * rol16 - rotate a 16-bit value left
- * @word: value to rotate
- * @shift: bits to roll
- */
-static inline __u16 rol16(__u16 word, unsigned int shift)
-{
-	return (word << shift) | (word >> (16 - shift));
-}
-
-/**
- * ror16 - rotate a 16-bit value right
- * @word: value to rotate
- * @shift: bits to roll
- */
-static inline __u16 ror16(__u16 word, unsigned int shift)
-{
-	return (word >> shift) | (word << (16 - shift));
-}
-
-/**
- * rol8 - rotate an 8-bit value left
- * @word: value to rotate
- * @shift: bits to roll
- */
-static inline __u8 rol8(__u8 word, unsigned int shift)
-{
-	return (word << shift) | (word >> (8 - shift));
-}
-
-/**
- * ror8 - rotate an 8-bit value right
- * @word: value to rotate
- * @shift: bits to roll
- */
-static inline __u8 ror8(__u8 word, unsigned int shift)
-{
-	return (word >> shift) | (word << (8 - shift));
-}
-
-/**
- * sign_extend32 - sign extend a 32-bit value using specified bit as sign-bit
- * @value: value to sign extend
- * @index: 0 based bit index (0<=index<32) to sign bit
- */
-static inline __s32 sign_extend32(__u32 value, int index)
-{
-	__u8 shift = 31 - index;
-	return (__s32)(value << shift) >> shift;
-}
-
-static inline unsigned fls_long(unsigned long l)
-{
-	if (sizeof(l) == 4)
-		return fls(l);
-	return fls64(l);
-}
-
-/**
- * __ffs64 - find first set bit in a 64 bit word
- * @word: The 64 bit word
- *
- * On 64 bit arches this is a synomyn for __ffs
- * The result is not defined if no bits are set, so check that @word
- * is non-zero before calling this.
- */
+#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,30))
 static inline unsigned long __ffs64(u64 word)
 {
 #if BITS_PER_LONG == 32
@@ -147,65 +14,21 @@ static inline unsigned long __ffs64(u64 word)
 #endif
 	return __ffs((unsigned long)word);
 }
+#endif /* < 2.6.30 */
 
-#ifdef __KERNEL__
-#ifdef CONFIG_GENERIC_FIND_FIRST_BIT
-
-/**
- * find_first_bit - find the first set bit in a memory region
- * @addr: The address to start the search at
- * @size: The maximum size to search
- *
- * Returns the bit number of the first set bit.
- */
-extern unsigned long find_first_bit(const unsigned long *addr,
-				    unsigned long size);
-
-/**
- * find_first_zero_bit - find the first cleared bit in a memory region
- * @addr: The address to start the search at
- * @size: The maximum size to search
- *
- * Returns the bit number of the first cleared bit.
- */
-extern unsigned long find_first_zero_bit(const unsigned long *addr,
-					 unsigned long size);
-#endif /* CONFIG_GENERIC_FIND_FIRST_BIT */
-
-#ifdef CONFIG_GENERIC_FIND_LAST_BIT
-/**
- * find_last_bit - find the last set bit in a memory region
- * @addr: The address to start the search at
- * @size: The maximum size to search
- *
- * Returns the bit number of the first set bit, or size.
- */
-extern unsigned long find_last_bit(const unsigned long *addr,
-				   unsigned long size);
-#endif /* CONFIG_GENERIC_FIND_LAST_BIT */
-
-#ifdef CONFIG_GENERIC_FIND_NEXT_BIT
-
-/**
- * find_next_bit - find the next set bit in a memory region
- * @addr: The address to base the search on
- * @offset: The bitnumber to start searching at
- * @size: The bitmap size in bits
- */
-extern unsigned long find_next_bit(const unsigned long *addr,
-				   unsigned long size, unsigned long offset);
-
-/**
- * find_next_zero_bit - find the next cleared bit in a memory region
- * @addr: The address to base the search on
- * @offset: The bitnumber to start searching at
- * @size: The bitmap size in bits
- */
+#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,34))
+#define for_each_set_bit(bit, addr, size) \
+	for ((bit) = find_first_bit((addr), (size));		\
+	     (bit) < (size);					\
+	     (bit) = find_next_bit((addr), (size), (bit) + 1))
+#endif /* < 2.6.34 */
 
-extern unsigned long find_next_zero_bit(const unsigned long *addr,
-					unsigned long size,
-					unsigned long offset);
+#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,38))
+static inline __s32 sign_extend32(__u32 value, int index)
+{
+	__u8 shift = 31 - index;
+	return (__s32)(value << shift) >> shift;
+}
+#endif /* < 2.6.38 */
 
-#endif /* CONFIG_GENERIC_FIND_NEXT_BIT */
-#endif /* __KERNEL__ */
-#endif
+#endif /* __BACKPORT_BITOPS_H */
-- 
1.8.3.1

