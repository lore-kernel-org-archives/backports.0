Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:54773 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754971Ab3HPR1E (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 16 Aug 2013 13:27:04 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>,
	Arik Nemtsov <arik@wizery.com>
Subject: [PATCH 02/13] backports: fix conditional include of arch_phys_wc_add()
Date: Fri, 16 Aug 2013 19:26:32 +0200
Message-Id: <1376674003-5801-2-git-send-email-hauke@hauke-m.de> (sfid-20130816_192737_081197_C4CFF1FF)
In-Reply-To: <1376674003-5801-1-git-send-email-hauke@hauke-m.de>
References: <1376674003-5801-1-git-send-email-hauke@hauke-m.de>
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
 1 file changed, 2 insertions(+), 3 deletions(-)

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
-- 
1.7.10.4

