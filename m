Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH for 3.8 8/9] compat: check if efi_enabled() was already backported
Date: Tue, 26 Feb 2013 22:03:11 +0100
Message-Id: <1361912592-29591-9-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1361912592-29591-1-git-send-email-hauke@hauke-m.de>
References: <1361912592-29591-1-git-send-email-hauke@hauke-m.de>
List-ID: <backports@vger.kernel.org>

Upstream commit 28c1dde0df2c9e01e8d57a774687734ed21bd208

efi_enabled() gets backported to older kernel versions and if this is
the case compat should not try to do the same.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 include/linux/compat-3.8.h |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/compat-3.8.h b/include/linux/compat-3.8.h
index b55a46d..c913188 100644
--- a/include/linux/compat-3.8.h
+++ b/include/linux/compat-3.8.h
@@ -58,6 +58,8 @@ static inline int __must_check kref_get_unless_zero(struct kref *kref)
  *     efi: Make 'efi_enabled' a function to query EFI facilities
  *
  */
+/* check first if this was already backported */
+#ifndef EFI_BOOT
 /*
  * We play games with efi_enabled so that the compiler will, if
  * possible, remove EFI-related code altogether.
@@ -101,6 +103,7 @@ static inline int compat_efi_enabled(int facility)
 #undef efi_enabled
 #endif
 #define efi_enabled(facility) compat_efi_enabled(facility)
+#endif /* EFI_BOOT */
 
 #endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(3,8,0)) */
 
-- 
1.7.10.4
