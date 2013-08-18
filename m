Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:60812 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755685Ab3HRXiS (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 18 Aug 2013 19:38:18 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>,
	Arik Nemtsov <arik@wizery.com>
Subject: [PATCH v2 01/19] backports: fix conditional include of arch_phys_wc_add()
Date: Mon, 19 Aug 2013 01:37:46 +0200
Message-Id: <1376869084-16513-2-git-send-email-hauke@hauke-m.de> (sfid-20130819_013819_948617_B0C28228)
In-Reply-To: <1376869084-16513-1-git-send-email-hauke@hauke-m.de>
References: <1376869084-16513-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This fixes a problem introduced in this commit:
commit c871780b5afa182878884bf5ccd8df4817a2660f
Author: Arik Nemtsov <arik@wizery.com>
Date:   Wed Aug 14 10:48:05 2013 +0300

    backports: rename some mem functions to not break custom kernels

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
Cc: Arik Nemtsov <arik@wizery.com>
---
 backport/backport-include/linux/io.h |    5 ++---
 backport/compat/backport-3.11.c      |    8 ++++----
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/backport/backport-include/linux/io.h b/backport/backport-include/linux/io.h
index 5447df8..84a8c21 100644
--- a/backport/backport-include/linux/io.h
+++ b/backport/backport-include/linux/io.h
@@ -13,10 +13,11 @@
  * arch_phys_del_wc(0) or arch_phys_del_wc(any error code) is guaranteed
  * to have no effect.
  */
+#ifndef arch_phys_wc_add
+
 #define arch_phys_wc_add LINUX_BACKPORT(arch_phys_wc_add)
 #define arch_phys_wc_del LINUX_BACKPORT(arch_phys_wc_del)
 
-#ifndef arch_phys_wc_add
 #ifdef CONFIG_MTRR
 extern int __must_check arch_phys_wc_add(unsigned long base,
 					 unsigned long size);
@@ -32,8 +33,6 @@ static inline void arch_phys_wc_del(int handle)
 {
 }
 #endif /* CONFIG_MTRR */
-
-#define arch_phys_wc_add arch_phys_wc_add
 #endif
 
 #endif /* __BACKPORT_LINUX_IO_H */
diff --git a/backport/compat/backport-3.11.c b/backport/compat/backport-3.11.c
index c6d5a02..e7b93fc 100644
--- a/backport/compat/backport-3.11.c
+++ b/backport/compat/backport-3.11.c
@@ -32,7 +32,7 @@
  * Drivers must store the return value to pass to mtrr_del_wc_if_needed,
  * but drivers should not try to interpret that return value.
  */
-int arch_phys_wc_add(unsigned long base, unsigned long size)
+int backport_arch_phys_wc_add(unsigned long base, unsigned long size)
 {
 	int ret;
 
@@ -49,7 +49,7 @@ int arch_phys_wc_add(unsigned long base, unsigned long size)
 	}
 	return ret + MTRR_TO_PHYS_WC_OFFSET;
 }
-EXPORT_SYMBOL_GPL(arch_phys_wc_add);
+EXPORT_SYMBOL_GPL(backport_arch_phys_wc_add);
 
 /*
  * arch_phys_wc_del - undoes arch_phys_wc_add
@@ -60,14 +60,14 @@ EXPORT_SYMBOL_GPL(arch_phys_wc_add);
  * The API guarantees that mtrr_del_wc_if_needed(error code) and
  * mtrr_del_wc_if_needed(0) do nothing.
  */
-void arch_phys_wc_del(int handle)
+void backport_arch_phys_wc_del(int handle)
 {
 	if (handle >= 1) {
 		WARN_ON(handle < MTRR_TO_PHYS_WC_OFFSET);
 		mtrr_del(handle - MTRR_TO_PHYS_WC_OFFSET, 0, 0);
 	}
 }
-EXPORT_SYMBOL_GPL(arch_phys_wc_del);
+EXPORT_SYMBOL_GPL(backport_arch_phys_wc_del);
 
 /*
  * phys_wc_to_mtrr_index - translates arch_phys_wc_add's return value
-- 
1.7.10.4

