Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:48300 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752742Ab3KXVYI (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 24 Nov 2013 16:24:08 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 10/15] backports: remove hex_byte_pack()
Date: Sun, 24 Nov 2013 22:23:13 +0100
Message-Id: <1385328198-28520-11-git-send-email-hauke@hauke-m.de> (sfid-20131124_223807_503591_1151DBCB)
In-Reply-To: <1385328198-28520-1-git-send-email-hauke@hauke-m.de>
References: <1385328198-28520-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

hex_byte_pack() was never called by any code.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/kernel.h |   20 --------------------
 backport/compat/compat-2.6.26.c          |    3 ---
 2 files changed, 23 deletions(-)

diff --git a/backport/backport-include/linux/kernel.h b/backport/backport-include/linux/kernel.h
index 4e249db..01e2e9a 100644
--- a/backport/backport-include/linux/kernel.h
+++ b/backport/backport-include/linux/kernel.h
@@ -20,26 +20,6 @@
 #define SIZE_MAX    (~(size_t)0)
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,26)
-extern const char hex_asc[];
-#endif
-
-#ifndef hex_asc_hi
-#define hex_asc_hi(x)	hex_asc[((x) & 0xf0) >> 4]
-#endif
-#ifndef hex_asc_lo
-#define hex_asc_lo(x)	hex_asc[((x) & 0x0f)]
-#endif
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,2,0)
-static inline char *hex_byte_pack(char *buf, u8 byte)
-{
-	*buf++ = hex_asc_hi(byte);
-	*buf++ = hex_asc_lo(byte);
-	return buf;
-}
-#endif
-
 /* This backports:
  *
  * commit 36a26c69b4c70396ef569c3452690fba0c1dec08
diff --git a/backport/compat/compat-2.6.26.c b/backport/compat/compat-2.6.26.c
index 72b1707..9ff1f76 100644
--- a/backport/compat/compat-2.6.26.c
+++ b/backport/compat/compat-2.6.26.c
@@ -17,9 +17,6 @@
 #include <net/sock.h>
 #include <net/compat.h>
 
-const char hex_asc[] = "0123456789abcdef";
-EXPORT_SYMBOL_GPL(hex_asc);
-
 /**
  * kobject_set_name_vargs - Set the name of an kobject
  * @kobj: struct kobject to set the name of
-- 
1.7.10.4

