Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <Mridula.Prakash@lnties.com>
From: Mridula Prakash <Mridula.Prakash@lnties.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
CC: "backports@vger.kernel.org" <backports@vger.kernel.org>
Subject: [PATCH] compat-2.6: Supoprt ARM Architecture while  back porting
 for linux2.6.28 kernel
Date: Tue, 28 Aug 2012 11:38:21 +0000
Message-ID: <B0824BA06BBF0C4AA3F9BE696B46CC8C060BEA01@POCITMSEXMB01.LntUniverse.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <backports@vger.kernel.org>

Hi,

This adds support for ARM Architectures while back porting for linux-2.6.28=
 kernel. The "atomic.h" file is part of the 2.6.28 kernel for ARM Architect=
ures.

Signed-off-by: Mridula Prakash<Mridula.Prakash@lnties.com>

---
diff -uprN a/include/linux/compat-2.6.29.h b/include/linux/compat-2.6.29.h
--- a/include/linux/compat-2.6.29.h     2012-06-29 04:17:15.000000000 +0530
+++ b/include/linux/compat-2.6.29.h     2012-08-28 16:39:40.991932473 +0530
@@ -34,7 +34,9 @@ static inline int usb_autopm_get_interfa
        defined(CONFIG_SUPERH) || defined(CONFIG_SPARC) || \
        defined(CONFIG_FRV) || defined(CONFIG_X86) || \
        defined(CONFIG_M32R) || defined(CONFIG_M68K) || \
-       defined(CONFIG_MN10300) || defined(CONFIG_XTENSA)
+       defined(CONFIG_MN10300) || defined(CONFIG_XTENSA)|| \
+       defined(CONFIG_ARM)
+
 #include <asm/atomic.h>
 #else
 typedef struct {


Thanks and Regards
Mridula Prakash
Senior Software Engineer
L&T - Integrated Engineering Services (IES)
LARSEN & TOUBRO LIMITED
KIADB Industrial Area
Hebbal, Hootagalli,
Mysore 570018, India


Larsen & Toubro Limited

www.larsentoubro.com

This Email may contain confidential or privileged information for the inten=
ded recipient (s). If you are not the intended recipient, please do not use=
 or disseminate the information, notify the sender and delete it from your =
system.
