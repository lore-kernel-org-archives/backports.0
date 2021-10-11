Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6463EC4332F
	for <backports@archiver.kernel.org>; Mon, 11 Oct 2021 22:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 461CD60EDF
	for <backports@archiver.kernel.org>; Mon, 11 Oct 2021 22:23:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235535AbhJKWZJ (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 11 Oct 2021 18:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235540AbhJKWZB (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 11 Oct 2021 18:25:01 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050::465:201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E950C06161C
        for <backports@vger.kernel.org>; Mon, 11 Oct 2021 15:22:59 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4HStbP22zBzQk9Q;
        Tue, 12 Oct 2021 00:22:57 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1633990975;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TcSyGrhGA7VkEGP/2cKQG50v4S5G5pyuqM85Tm7HOGA=;
        b=0ssCjfvWVBHixzOJqhJrHIACS2GBe9opL1wbcpvu6hS074d1jTxIbn9e+eOo2DG+vSKJVR
        wQe4/g3xGh8j+rHTDA/mxUhciW2OdbVqip6H/CqSqdkR/Vw0x3jbb6zCiX+OKE057/g/iv
        v9074fGue9KBN2ZyWff/eHsnh6naqQLTqAfUKwwiCo5LZgZgTdQZQXTqxzS54G7ZDZhnlF
        3qZbXPgbIVegGM6vojjirF9aDu6S1x8HLIFprFoEhcJ4J3WST6TW9yCltUUYlS4n8zdA8P
        hhIWDEOW2qQNnrKxYTdEmwHtnhjjqbQimDXSIjlv4OvZdeC9PVgQyQZu3WPHVA==
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes.berg@intel.com, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 10/14] backports: Remove support for kernel smaller than 4.0
Date:   Tue, 12 Oct 2021 00:22:23 +0200
Message-Id: <20211011222227.1189850-11-hauke@hauke-m.de>
In-Reply-To: <20211011222227.1189850-1-hauke@hauke-m.de>
References: <20211011222227.1189850-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7318118BF
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

This removes all the code which is needed to support kernel 3.19.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 README                                        |   2 +-
 .../backport-include/linux/ftrace_event.h     |  10 -
 backport/backport-include/linux/iopoll.h      |   2 -
 backport/backport-include/linux/printk.h      |  15 --
 backport/compat/Makefile                      |   1 -
 backport/compat/backport-4.0.c                | 191 ------------------
 6 files changed, 1 insertion(+), 220 deletions(-)
 delete mode 100644 backport/backport-include/linux/ftrace_event.h
 delete mode 100644 backport/backport-include/linux/printk.h
 delete mode 100644 backport/compat/backport-4.0.c

diff --git a/README b/README
index b2995c74..e283d766 100644
--- a/README
+++ b/README
@@ -8,7 +8,7 @@ down to older kernels. It currently backports the following subsystems:
   * WWAN
 
 This package provides the latest Linux kernel subsystem enhancements
-for kernels 3.19 and above.
+for kernels 4.0 and above.
 
 # Documentation
 
diff --git a/backport/backport-include/linux/ftrace_event.h b/backport/backport-include/linux/ftrace_event.h
deleted file mode 100644
index edea21ee..00000000
--- a/backport/backport-include/linux/ftrace_event.h
+++ /dev/null
@@ -1,10 +0,0 @@
-#ifndef __BACKPORT_LINUX_FTRACE_EVENT_H
-#define __BACKPORT_LINUX_FTRACE_EVENT_H
-#include_next <linux/ftrace_event.h>
-
-#if LINUX_VERSION_IS_LESS(4,0,0)
-const char *ftrace_print_array_seq(struct trace_seq *p,
-				   const void *buf, int buf_len,
-				   size_t el_size);
-#endif
-#endif /* __BACKPORT_LINUX_FTRACE_EVENT_H */
diff --git a/backport/backport-include/linux/iopoll.h b/backport/backport-include/linux/iopoll.h
index f50187ad..7db0f9d4 100644
--- a/backport/backport-include/linux/iopoll.h
+++ b/backport/backport-include/linux/iopoll.h
@@ -1,9 +1,7 @@
 #ifndef _BACKPORTS_LINUX_IOPOLL_H
 #define _BACKPORTS_LINUX_IOPOLL_H 1
 
-#if LINUX_VERSION_IS_GEQ(4,0,0)
 #include_next <linux/iopoll.h>
-#endif
 
 #ifndef read_poll_timeout
 /**
diff --git a/backport/backport-include/linux/printk.h b/backport/backport-include/linux/printk.h
deleted file mode 100644
index 2527aeaa..00000000
--- a/backport/backport-include/linux/printk.h
+++ /dev/null
@@ -1,15 +0,0 @@
-#ifndef _COMPAT_LINUX_PRINTK_H
-#define _COMPAT_LINUX_PRINTK_H 1
-
-#include <linux/version.h>
-#include_next <linux/printk.h>
-
-/* replace hex_dump_to_buffer() with a version which returns the length */
-#if LINUX_VERSION_IS_LESS(4,0,0)
-#define hex_dump_to_buffer LINUX_BACKPORT(hex_dump_to_buffer)
-extern int hex_dump_to_buffer(const void *buf, size_t len, int rowsize,
-			      int groupsize, char *linebuf, size_t linebuflen,
-			      bool ascii);
-#endif
-
-#endif	/* _COMPAT_LINUX_PRINTK_H */
diff --git a/backport/compat/Makefile b/backport/compat/Makefile
index 74602628..2d7af92f 100644
--- a/backport/compat/Makefile
+++ b/backport/compat/Makefile
@@ -7,7 +7,6 @@ endif
 compat-y += main.o
 
 # Kernel backport compatibility code
-compat-$(CPTCFG_KERNEL_4_0) += backport-4.0.o
 compat-$(CPTCFG_KERNEL_4_1) += backport-4.1.o
 compat-$(CPTCFG_KERNEL_4_2) += backport-4.2.o
 compat-$(CPTCFG_KERNEL_4_3) += backport-4.3.o
diff --git a/backport/compat/backport-4.0.c b/backport/compat/backport-4.0.c
deleted file mode 100644
index f540594f..00000000
--- a/backport/compat/backport-4.0.c
+++ /dev/null
@@ -1,191 +0,0 @@
-/*
- * Copyright (c) 2015  Hauke Mehrtens <hauke@hauke-m.de>
- *
- * Backport functionality introduced in Linux 4.0.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/kernel.h>
-#include <linux/mm.h>
-#include <linux/sched.h>
-#include <linux/ctype.h>
-#include <linux/printk.h>
-#include <linux/export.h>
-#include <linux/trace_seq.h>
-#include <linux/ftrace_event.h>
-#include <asm/unaligned.h>
-
-/**
- * hex_dump_to_buffer - convert a blob of data to "hex ASCII" in memory
- * @buf: data blob to dump
- * @len: number of bytes in the @buf
- * @rowsize: number of bytes to print per line; must be 16 or 32
- * @groupsize: number of bytes to print at a time (1, 2, 4, 8; default = 1)
- * @linebuf: where to put the converted data
- * @linebuflen: total size of @linebuf, including space for terminating NUL
- * @ascii: include ASCII after the hex output
- *
- * hex_dump_to_buffer() works on one "line" of output at a time, i.e.,
- * 16 or 32 bytes of input data converted to hex + ASCII output.
- *
- * Given a buffer of u8 data, hex_dump_to_buffer() converts the input data
- * to a hex + ASCII dump at the supplied memory location.
- * The converted output is always NUL-terminated.
- *
- * E.g.:
- *   hex_dump_to_buffer(frame->data, frame->len, 16, 1,
- *			linebuf, sizeof(linebuf), true);
- *
- * example output buffer:
- * 40 41 42 43 44 45 46 47 48 49 4a 4b 4c 4d 4e 4f  @ABCDEFGHIJKLMNO
- *
- * Return:
- * The amount of bytes placed in the buffer without terminating NUL. If the
- * output was truncated, then the return value is the number of bytes
- * (excluding the terminating NUL) which would have been written to the final
- * string if enough space had been available.
- */
-int hex_dump_to_buffer(const void *buf, size_t len, int rowsize, int groupsize,
-		       char *linebuf, size_t linebuflen, bool ascii)
-{
-	const u8 *ptr = buf;
-	int ngroups;
-	u8 ch;
-	int j, lx = 0;
-	int ascii_column;
-	int ret;
-
-	if (rowsize != 16 && rowsize != 32)
-		rowsize = 16;
-
-	if (len > rowsize)		/* limit to one line at a time */
-		len = rowsize;
-	if (!is_power_of_2(groupsize) || groupsize > 8)
-		groupsize = 1;
-	if ((len % groupsize) != 0)	/* no mixed size output */
-		groupsize = 1;
-
-	ngroups = len / groupsize;
-	ascii_column = rowsize * 2 + rowsize / groupsize + 1;
-
-	if (!linebuflen)
-		goto overflow1;
-
-	if (!len)
-		goto nil;
-
-	if (groupsize == 8) {
-		const u64 *ptr8 = buf;
-
-		for (j = 0; j < ngroups; j++) {
-			ret = snprintf(linebuf + lx, linebuflen - lx,
-				       "%s%16.16llx", j ? " " : "",
-				       get_unaligned(ptr8 + j));
-			if (ret >= linebuflen - lx)
-				goto overflow1;
-			lx += ret;
-		}
-	} else if (groupsize == 4) {
-		const u32 *ptr4 = buf;
-
-		for (j = 0; j < ngroups; j++) {
-			ret = snprintf(linebuf + lx, linebuflen - lx,
-				       "%s%8.8x", j ? " " : "",
-				       get_unaligned(ptr4 + j));
-			if (ret >= linebuflen - lx)
-				goto overflow1;
-			lx += ret;
-		}
-	} else if (groupsize == 2) {
-		const u16 *ptr2 = buf;
-
-		for (j = 0; j < ngroups; j++) {
-			ret = snprintf(linebuf + lx, linebuflen - lx,
-				       "%s%4.4x", j ? " " : "",
-				       get_unaligned(ptr2 + j));
-			if (ret >= linebuflen - lx)
-				goto overflow1;
-			lx += ret;
-		}
-	} else {
-		for (j = 0; j < len; j++) {
-			if (linebuflen < lx + 3)
-				goto overflow2;
-			ch = ptr[j];
-			linebuf[lx++] = hex_asc_hi(ch);
-			linebuf[lx++] = hex_asc_lo(ch);
-			linebuf[lx++] = ' ';
-		}
-		if (j)
-			lx--;
-	}
-	if (!ascii)
-		goto nil;
-
-	while (lx < ascii_column) {
-		if (linebuflen < lx + 2)
-			goto overflow2;
-		linebuf[lx++] = ' ';
-	}
-	for (j = 0; j < len; j++) {
-		if (linebuflen < lx + 2)
-			goto overflow2;
-		ch = ptr[j];
-		linebuf[lx++] = (isascii(ch) && isprint(ch)) ? ch : '.';
-	}
-nil:
-	linebuf[lx] = '\0';
-	return lx;
-overflow2:
-	linebuf[lx++] = '\0';
-overflow1:
-	return ascii ? ascii_column + len : (groupsize * 2 + 1) * ngroups - 1;
-}
-EXPORT_SYMBOL_GPL(hex_dump_to_buffer);
-
-const char *
-ftrace_print_array_seq(struct trace_seq *p, const void *buf, int buf_len,
-		       size_t el_size)
-{
-	const char *ret = trace_seq_buffer_ptr(p);
-	const char *prefix = "";
-	void *ptr = (void *)buf;
-
-	trace_seq_putc(p, '{');
-
-	while (ptr < buf + buf_len) {
-		switch (el_size) {
-		case 1:
-			trace_seq_printf(p, "%s0x%x", prefix,
-					 *(u8 *)ptr);
-			break;
-		case 2:
-			trace_seq_printf(p, "%s0x%x", prefix,
-					 *(u16 *)ptr);
-			break;
-		case 4:
-			trace_seq_printf(p, "%s0x%x", prefix,
-					 *(u32 *)ptr);
-			break;
-		case 8:
-			trace_seq_printf(p, "%s0x%llx", prefix,
-					 *(u64 *)ptr);
-			break;
-		default:
-			trace_seq_printf(p, "BAD SIZE:%zu 0x%x", el_size,
-					 *(u8 *)ptr);
-			el_size = 1;
-		}
-		prefix = ",";
-		ptr += el_size;
-	}
-
-	trace_seq_putc(p, '}');
-	trace_seq_putc(p, 0);
-
-	return ret;
-}
-EXPORT_SYMBOL(ftrace_print_array_seq);
-- 
2.30.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
