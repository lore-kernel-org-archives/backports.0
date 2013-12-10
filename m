Return-path: <backports-owner@vger.kernel.org>
Received: from mail-la0-f42.google.com ([209.85.215.42]:47744 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752816Ab3LJPgP (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 10 Dec 2013 10:36:15 -0500
Received: by mail-la0-f42.google.com with SMTP id ec20so2822629lab.1
        for <backports@vger.kernel.org>; Tue, 10 Dec 2013 07:36:14 -0800 (PST)
Received: from [192.168.1.20] ([193.15.182.253])
        by mx.google.com with ESMTPSA id e10sm22485342laa.6.2013.12.10.07.36.13
        for <backports@vger.kernel.org>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 10 Dec 2013 07:36:13 -0800 (PST)
Message-ID: <1386689770.5956.4.camel@asus> (sfid-20131210_163617_710999_14F5BF21)
Subject: [PATCH] compat.3.7, compat.3.8: Adds missing of.h include
From: Richard =?ISO-8859-1?Q?R=F6jfors?= <richard.rojfors@gmail.com>
To: backports@vger.kernel.org
Date: Tue, 10 Dec 2013 16:36:10 +0100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This applies to 3.13-rc2

The compat-3.7.c och compat-3.8.c uses of-functions if supported by the
kernel, but there is a missing include for linux/of.h.

This patch fixes the compile error which looks like this:

| NOTE: make -j 8 ARCH=arm KLIB_BUILD=/path/usr/src/kernel KLIB=/path/image
|   CC [M]  /path/backports-3.13-rc2-1/compat/compat-3.7.o
| /path/backports-3.13-rc2-1/compat/compat-3.7.c: In function 'of_get_child_by_name':
| /path/backports-3.13-rc2-1/compat/compat-3.7.c:274:1: error: unknown type name 'z'
| /path/backports-3.13-rc2-1/compat/compat-3.7.c:276:3: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'if'
| make[6]: *** [/path/backports-3.13-rc2-1/compat/compat-3.7.o] Error 1
| make[5]: *** [/path/backports-3.13-rc2-1/compat] Error 2
| make[4]: *** [_module_/path/backports/3.13-rc2-1-r0/backports-3.13-rc2-1] Error 2
| make[3]: *** [modules] Error 2
| make[2]: *** [modules] Error 2
| make[1]: *** [modules] Error 2
| make: *** [default] Error 2

Signed-off-by: Richard Röjfors <richard.rojfors@gmail.com>
---
--- backports-3.13-rc2-1.org/compat/compat-3.7.c	2013-12-05 12:19:56.161016836 +0100
+++ backports-3.13-rc2-1.new/compat/compat-3.7.c	2013-12-05 12:18:40.257012431 +0100
@@ -256,6 +256,8 @@
 
 #ifdef CONFIG_OF
 #if (LINUX_VERSION_CODE < KERNEL_VERSION(3,7,0))
+#include <linux/of.h>
+
 /**
  *	of_get_child_by_name - Find the child node by name for a given parent
  *	@node:	parent node
--- backports-3.13-rc2-1.org/compat/compat-3.8.c	2013-12-05 12:17:53.093009694 +0100
+++ backports-3.13-rc2-1.new/compat/compat-3.8.c	2013-12-05 12:18:42.745012576 +0100
@@ -420,6 +420,8 @@
 EXPORT_SYMBOL_GPL(vm_iomap_memory);
 
 #ifdef CONFIG_OF
+#include <linux/of.h>
+
 /**
  * of_find_property_value_of_size
  *

