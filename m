Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:46724 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754266AbaAHAf0 (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 7 Jan 2014 19:35:26 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 11/17] backports: remove CRC8 backport
Date: Wed,  8 Jan 2014 01:34:28 +0100
Message-Id: <1389141274-2002-12-git-send-email-hauke@hauke-m.de> (sfid-20140108_013529_409040_2A5785BB)
In-Reply-To: <1389141274-2002-1-git-send-email-hauke@hauke-m.de>
References: <1389141274-2002-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This is not used by any driver any more. brcmsmac was the only driver
selecting this, but did not used it since some months, now it does not
even select it any more.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/crc8.h |  109 --------------------------------
 backport/compat/Kconfig                |    9 ---
 backport/compat/Makefile               |    1 -
 backport/compat/crc8.c                 |   87 -------------------------
 4 files changed, 206 deletions(-)
 delete mode 100644 backport/backport-include/linux/crc8.h
 delete mode 100644 backport/compat/crc8.c

diff --git a/backport/backport-include/linux/crc8.h b/backport/backport-include/linux/crc8.h
deleted file mode 100644
index 611ba0d..0000000
--- a/backport/backport-include/linux/crc8.h
+++ /dev/null
@@ -1,109 +0,0 @@
-/*
- * Copyright (c) 2011 Broadcom Corporation
- *
- * Permission to use, copy, modify, and/or distribute this software for any
- * purpose with or without fee is hereby granted, provided that the above
- * copyright notice and this permission notice appear in all copies.
- *
- * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
- * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
- * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY
- * SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
- * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION
- * OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN
- * CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
- */
-#ifndef CPTCFG_BACKPORT_BUILD_CRC8_MODULE
-#include_next <linux/crc8.h>
-#else
-
-#ifndef __CRC8_H_
-#define __CRC8_H_
-
-#include <linux/types.h>
-
-/* see usage of this value in crc8() description */
-#define CRC8_INIT_VALUE		0xFF
-
-/*
- * Return value of crc8() indicating valid message+crc. This is true
- * if a CRC is inverted before transmission. The CRC computed over the
- * whole received bitstream is _table[x], where x is the bit pattern
- * of the modification (almost always 0xff).
- */
-#define CRC8_GOOD_VALUE(_table)	(_table[0xFF])
-
-/* required table size for crc8 algorithm */
-#define CRC8_TABLE_SIZE			256
-
-/* helper macro assuring right table size is used */
-#define DECLARE_CRC8_TABLE(_table) \
-	static u8 _table[CRC8_TABLE_SIZE]
-
-/**
- * crc8_populate_lsb - fill crc table for given polynomial in regular bit order.
- *
- * @table:	table to be filled.
- * @polynomial:	polynomial for which table is to be filled.
- *
- * This function fills the provided table according the polynomial provided for
- * regular bit order (lsb first). Polynomials in CRC algorithms are typically
- * represented as shown below.
- *
- *	poly = x^8 + x^7 + x^6 + x^4 + x^2 + 1
- *
- * For lsb first direction x^7 maps to the lsb. So the polynomial is as below.
- *
- * - lsb first: poly = 10101011(1) = 0xAB
- */
-#define crc8_populate_lsb LINUX_BACKPORT(crc8_populate_lsb)
-void crc8_populate_lsb(u8 table[CRC8_TABLE_SIZE], u8 polynomial);
-
-/**
- * crc8_populate_msb - fill crc table for given polynomial in reverse bit order.
- *
- * @table:	table to be filled.
- * @polynomial:	polynomial for which table is to be filled.
- *
- * This function fills the provided table according the polynomial provided for
- * reverse bit order (msb first). Polynomials in CRC algorithms are typically
- * represented as shown below.
- *
- *	poly = x^8 + x^7 + x^6 + x^4 + x^2 + 1
- *
- * For msb first direction x^7 maps to the msb. So the polynomial is as below.
- *
- * - msb first: poly = (1)11010101 = 0xD5
- */
-#define crc8_populate_msb LINUX_BACKPORT(crc8_populate_msb)
-void crc8_populate_msb(u8 table[CRC8_TABLE_SIZE], u8 polynomial);
-
-/**
- * crc8() - calculate a crc8 over the given input data.
- *
- * @table:	crc table used for calculation.
- * @pdata:	pointer to data buffer.
- * @nbytes:	number of bytes in data buffer.
- * @crc:	previous returned crc8 value.
- *
- * The CRC8 is calculated using the polynomial given in crc8_populate_msb()
- * or crc8_populate_lsb().
- *
- * The caller provides the initial value (either %CRC8_INIT_VALUE
- * or the previous returned value) to allow for processing of
- * discontiguous blocks of data.  When generating the CRC the
- * caller is responsible for complementing the final return value
- * and inserting it into the byte stream.  When validating a byte
- * stream (including CRC8), a final return value of %CRC8_GOOD_VALUE
- * indicates the byte stream data can be considered valid.
- *
- * Reference:
- * "A Painless Guide to CRC Error Detection Algorithms", ver 3, Aug 1993
- * Williams, Ross N., ross<at>ross.net
- * (see URL http://www.ross.net/crc/download/crc_v3.txt).
- */
-#define crc8 LINUX_BACKPORT(crc8)
-u8 crc8(const u8 table[CRC8_TABLE_SIZE], u8 *pdata, size_t nbytes, u8 crc);
-
-#endif /* __CRC8_H_ */
-#endif /* BACKPORT_BUILD_CRC8_MODULE */
diff --git a/backport/compat/Kconfig b/backport/compat/Kconfig
index c3e9a04..2dda9ac 100644
--- a/backport/compat/Kconfig
+++ b/backport/compat/Kconfig
@@ -93,15 +93,6 @@ config BACKPORT_BUILD_CORDIC
 config BACKPORT_CORDIC
 	bool
 
-config BACKPORT_BUILD_CRC8
-	tristate
-	depends on !CRC8
-	default m if BACKPORT_CRC8
-	default m if BACKPORT_USERSEL_BUILD_ALL
-
-config BACKPORT_CRC8
-	bool
-
 config BACKPORT_BUILD_GENERIC_ATOMIC64
 	bool
 	default y if !64BIT && !GENERIC_ATOMIC64
diff --git a/backport/compat/Makefile b/backport/compat/Makefile
index dbf2bff..94eda5f 100644
--- a/backport/compat/Makefile
+++ b/backport/compat/Makefile
@@ -10,7 +10,6 @@ sch_fq_codel-y = sch_fq_codel_core.o flow_dissector.o
 obj-$(CPTCFG_BACKPORT_USERSEL_NET_SCH_FQ_CODEL) += sch_fq_codel.o
 
 obj-$(CPTCFG_BACKPORT_BUILD_CORDIC) += cordic.o
-obj-$(CPTCFG_BACKPORT_BUILD_CRC8) += crc8.o
 
 # Compat kernel compatibility code
 compat-$(CPTCFG_BACKPORT_KERNEL_2_6_26) += compat-2.6.26.o
diff --git a/backport/compat/crc8.c b/backport/compat/crc8.c
deleted file mode 100644
index 5878171..0000000
--- a/backport/compat/crc8.c
+++ /dev/null
@@ -1,87 +0,0 @@
-/*
- * Copyright (c) 2011 Broadcom Corporation
- *
- * Permission to use, copy, modify, and/or distribute this software for any
- * purpose with or without fee is hereby granted, provided that the above
- * copyright notice and this permission notice appear in all copies.
- *
- * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
- * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
- * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY
- * SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
- * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION
- * OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN
- * CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
- */
-
-#undef pr_fmt
-#define pr_fmt(fmt)		KBUILD_MODNAME ": " fmt
-
-#include <linux/module.h>
-#include <linux/crc8.h>
-#include <linux/printk.h>
-
-/*
- * crc8_populate_msb - fill crc table for given polynomial in reverse bit order.
- *
- * table:	table to be filled.
- * polynomial:	polynomial for which table is to be filled.
- */
-void crc8_populate_msb(u8 table[CRC8_TABLE_SIZE], u8 polynomial)
-{
-	int i, j;
-	const u8 msbit = 0x80;
-	u8 t = msbit;
-
-	table[0] = 0;
-
-	for (i = 1; i < CRC8_TABLE_SIZE; i *= 2) {
-		t = (t << 1) ^ (t & msbit ? polynomial : 0);
-		for (j = 0; j < i; j++)
-			table[i+j] = table[j] ^ t;
-	}
-}
-EXPORT_SYMBOL_GPL(crc8_populate_msb);
-
-/*
- * crc8_populate_lsb - fill crc table for given polynomial in regular bit order.
- *
- * table:	table to be filled.
- * polynomial:	polynomial for which table is to be filled.
- */
-void crc8_populate_lsb(u8 table[CRC8_TABLE_SIZE], u8 polynomial)
-{
-	int i, j;
-	u8 t = 1;
-
-	table[0] = 0;
-
-	for (i = (CRC8_TABLE_SIZE >> 1); i; i >>= 1) {
-		t = (t >> 1) ^ (t & 1 ? polynomial : 0);
-		for (j = 0; j < CRC8_TABLE_SIZE; j += 2*i)
-			table[i+j] = table[j] ^ t;
-	}
-}
-EXPORT_SYMBOL_GPL(crc8_populate_lsb);
-
-/*
- * crc8 - calculate a crc8 over the given input data.
- *
- * table: crc table used for calculation.
- * pdata: pointer to data buffer.
- * nbytes: number of bytes in data buffer.
- * crc:	previous returned crc8 value.
- */
-u8 crc8(const u8 table[CRC8_TABLE_SIZE], u8 *pdata, size_t nbytes, u8 crc)
-{
-	/* loop over the buffer data */
-	while (nbytes-- > 0)
-		crc = table[(crc ^ *pdata++) & 0xff];
-
-	return crc;
-}
-EXPORT_SYMBOL_GPL(crc8);
-
-MODULE_DESCRIPTION("CRC8 (by Williams, Ross N.) function");
-MODULE_AUTHOR("Broadcom Corporation");
-MODULE_LICENSE("Dual BSD/GPL");
-- 
1.7.10.4

