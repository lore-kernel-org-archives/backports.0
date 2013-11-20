Return-path: <backports-owner@vger.kernel.org>
Received: from mail.xlhost.de ([84.200.252.118]:50851 "EHLO app1b.xlhost.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750855Ab3KTIhV (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 20 Nov 2013 03:37:21 -0500
Message-ID: <528C7302.5030501@kpanic.de> (sfid-20131120_093723_472153_8805D308)
Date: Wed, 20 Nov 2013 09:29:54 +0100
From: Stefan Assmann <sassmann@kpanic.de>
MIME-Version: 1.0
To: Hauke Mehrtens <hauke@hauke-m.de>
CC: mcgrof@kernel.org, backports@vger.kernel.org,
	johannes@sipsolutions.net
Subject: Re: [PATCH] backports: remove obsolete linux/bitops.h header
References: <1384784803-16935-1-git-send-email-sassmann@kpanic.de> <528BEB63.3080600@hauke-m.de>
In-Reply-To: <528BEB63.3080600@hauke-m.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 19.11.2013 23:51, Hauke Mehrtens wrote:
> On 11/18/2013 03:26 PM, Stefan Assmann wrote:
>> The header seems to be obsolete. Removing it and running devel/ckmake didn't
>> reveal any errors. Missing parts can always be re-added in the new
>> include_next fashion if necessary.
>>
>> Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
> 
> Some of these functions are needed, because they are not provided by old
> kernel versions.

Let me know what's a good way of figuring out what's still needed and
I'll replace the old header the way that Johannes suggested.
Thanks!

  Stefan

> 
>> ---
>>  backport/backport-include/linux/bitops.h | 211 -------------------------------
>>  1 file changed, 211 deletions(-)
>>  delete mode 100644 backport/backport-include/linux/bitops.h
>>
>> diff --git a/backport/backport-include/linux/bitops.h b/backport/backport-include/linux/bitops.h
>> deleted file mode 100644
>> index aa76af1..0000000
>> --- a/backport/backport-include/linux/bitops.h
>> +++ /dev/null
>> @@ -1,211 +0,0 @@
>> -#ifndef _LINUX_BITOPS_H
>> -#define _LINUX_BITOPS_H
>> -#include <asm/types.h>
>> -
>> -#ifdef	__KERNEL__
>> -#define BIT(nr)			(1UL << (nr))
>> -#define BIT_MASK(nr)		(1UL << ((nr) % BITS_PER_LONG))
>> -#define BIT_WORD(nr)		((nr) / BITS_PER_LONG)
>> -#define BITS_PER_BYTE		8
>> -#ifndef BITS_TO_LONGS /* Older kernels define this already */
>> -#define BITS_TO_LONGS(nr)	DIV_ROUND_UP(nr, BITS_PER_BYTE * sizeof(long))
>> -#endif
>> -#endif
>> -
>> -extern unsigned int __sw_hweight8(unsigned int w);
>> -extern unsigned int __sw_hweight16(unsigned int w);
>> -extern unsigned int __sw_hweight32(unsigned int w);
>> -extern unsigned long __sw_hweight64(__u64 w);
>> -
>> -/*
>> - * Include this here because some architectures need generic_ffs/fls in
>> - * scope
>> - */
>> -#include <asm/bitops.h>
>> -
>> -#define for_each_set_bit(bit, addr, size) \
>> -	for ((bit) = find_first_bit((addr), (size)); \
>> -	     (bit) < (size); \
>> -	     (bit) = find_next_bit((addr), (size), (bit) + 1))
> 
> for_each_set_bit was added in kernel 2.6.34 and it is used by iwlwifi.
> 
>> -
>> -static __inline__ int get_bitmask_order(unsigned int count)
>> -{
>> -	int order;
>> -
>> -	order = fls(count);
>> -	return order;	/* We could be slightly more clever with -1 here... */
>> -}
>> -
>> -static __inline__ int get_count_order(unsigned int count)
>> -{
>> -	int order;
>> -
>> -	order = fls(count) - 1;
>> -	if (count & (count - 1))
>> -		order++;
>> -	return order;
>> -}
>> -
>> -static inline unsigned long hweight_long(unsigned long w)
>> -{
>> -	return sizeof(w) == 4 ? hweight32(w) : hweight64(w);
>> -}
>> -
>> -/**
>> - * rol32 - rotate a 32-bit value left
>> - * @word: value to rotate
>> - * @shift: bits to roll
>> - */
>> -static inline __u32 rol32(__u32 word, unsigned int shift)
>> -{
>> -	return (word << shift) | (word >> (32 - shift));
>> -}
>> -
>> -/**
>> - * ror32 - rotate a 32-bit value right
>> - * @word: value to rotate
>> - * @shift: bits to roll
>> - */
>> -static inline __u32 ror32(__u32 word, unsigned int shift)
>> -{
>> -	return (word >> shift) | (word << (32 - shift));
>> -}
>> -
>> -/**
>> - * rol16 - rotate a 16-bit value left
>> - * @word: value to rotate
>> - * @shift: bits to roll
>> - */
>> -static inline __u16 rol16(__u16 word, unsigned int shift)
>> -{
>> -	return (word << shift) | (word >> (16 - shift));
>> -}
>> -
>> -/**
>> - * ror16 - rotate a 16-bit value right
>> - * @word: value to rotate
>> - * @shift: bits to roll
>> - */
>> -static inline __u16 ror16(__u16 word, unsigned int shift)
>> -{
>> -	return (word >> shift) | (word << (16 - shift));
>> -}
>> -
>> -/**
>> - * rol8 - rotate an 8-bit value left
>> - * @word: value to rotate
>> - * @shift: bits to roll
>> - */
>> -static inline __u8 rol8(__u8 word, unsigned int shift)
>> -{
>> -	return (word << shift) | (word >> (8 - shift));
>> -}
>> -
>> -/**
>> - * ror8 - rotate an 8-bit value right
>> - * @word: value to rotate
>> - * @shift: bits to roll
>> - */
>> -static inline __u8 ror8(__u8 word, unsigned int shift)
>> -{
>> -	return (word >> shift) | (word << (8 - shift));
>> -}
>> -
>> -/**
>> - * sign_extend32 - sign extend a 32-bit value using specified bit as sign-bit
>> - * @value: value to sign extend
>> - * @index: 0 based bit index (0<=index<32) to sign bit
>> - */
>> -static inline __s32 sign_extend32(__u32 value, int index)
>> -{
>> -	__u8 shift = 31 - index;
>> -	return (__s32)(value << shift) >> shift;
>> -}
> 
> sign_extend32 was added in kernel 2.6.38, and we have to backport it
> because iwlegacy, ath5k and probably more are using it.
> 
>> -
>> -static inline unsigned fls_long(unsigned long l)
>> -{
>> -	if (sizeof(l) == 4)
>> -		return fls(l);
>> -	return fls64(l);
>> -}
>> -
>> -/**
>> - * __ffs64 - find first set bit in a 64 bit word
>> - * @word: The 64 bit word
>> - *
>> - * On 64 bit arches this is a synomyn for __ffs
>> - * The result is not defined if no bits are set, so check that @word
>> - * is non-zero before calling this.
>> - */
>> -static inline unsigned long __ffs64(u64 word)
>> -{
>> -#if BITS_PER_LONG == 32
>> -	if (((u32)word) == 0UL)
>> -		return __ffs((u32)(word >> 32)) + 32;
>> -#elif BITS_PER_LONG != 64
>> -#error BITS_PER_LONG not 32 or 64
>> -#endif
>> -	return __ffs((unsigned long)word);
>> -}
> 
> __ffs64 was added in kernel 2.6.30 and it is used by mac80211
> 
>> -
>> -#ifdef __KERNEL__
>> -#ifdef CONFIG_GENERIC_FIND_FIRST_BIT
>> -
>> -/**
>> - * find_first_bit - find the first set bit in a memory region
>> - * @addr: The address to start the search at
>> - * @size: The maximum size to search
>> - *
>> - * Returns the bit number of the first set bit.
>> - */
>> -extern unsigned long find_first_bit(const unsigned long *addr,
>> -				    unsigned long size);
>> -
>> -/**
>> - * find_first_zero_bit - find the first cleared bit in a memory region
>> - * @addr: The address to start the search at
>> - * @size: The maximum size to search
>> - *
>> - * Returns the bit number of the first cleared bit.
>> - */
>> -extern unsigned long find_first_zero_bit(const unsigned long *addr,
>> -					 unsigned long size);
>> -#endif /* CONFIG_GENERIC_FIND_FIRST_BIT */
>> -
>> -#ifdef CONFIG_GENERIC_FIND_LAST_BIT
>> -/**
>> - * find_last_bit - find the last set bit in a memory region
>> - * @addr: The address to start the search at
>> - * @size: The maximum size to search
>> - *
>> - * Returns the bit number of the first set bit, or size.
>> - */
>> -extern unsigned long find_last_bit(const unsigned long *addr,
>> -				   unsigned long size);
>> -#endif /* CONFIG_GENERIC_FIND_LAST_BIT */
>> -
>> -#ifdef CONFIG_GENERIC_FIND_NEXT_BIT
>> -
>> -/**
>> - * find_next_bit - find the next set bit in a memory region
>> - * @addr: The address to base the search on
>> - * @offset: The bitnumber to start searching at
>> - * @size: The bitmap size in bits
>> - */
>> -extern unsigned long find_next_bit(const unsigned long *addr,
>> -				   unsigned long size, unsigned long offset);
>> -
>> -/**
>> - * find_next_zero_bit - find the next cleared bit in a memory region
>> - * @addr: The address to base the search on
>> - * @offset: The bitnumber to start searching at
>> - * @size: The bitmap size in bits
>> - */
>> -
>> -extern unsigned long find_next_zero_bit(const unsigned long *addr,
>> -					unsigned long size,
>> -					unsigned long offset);
>> -
>> -#endif /* CONFIG_GENERIC_FIND_NEXT_BIT */
>> -#endif /* __KERNEL__ */
>> -#endif
>>
> 

