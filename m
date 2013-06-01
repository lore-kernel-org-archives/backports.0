Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:33242 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751291Ab3FAQAm (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 1 Jun 2013 12:00:42 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 04/11] backports: no kfifo.h when !CPTCFG_BACKPORT_BUILD_KFIFO
Date: Sat,  1 Jun 2013 18:00:10 +0200
Message-Id: <1370102417-6711-5-git-send-email-hauke@hauke-m.de> (sfid-20130601_181039_525840_4010F52C)
In-Reply-To: <1370102417-6711-1-git-send-email-hauke@hauke-m.de>
References: <1370102417-6711-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

When CPTCFG_BACKPORT_BUILD_KFIFO is not selected the default kernel
header file should be used and not the backport code from backports. On
RHEL 6.4 the kfido-new.h is included instead of the normal kfifo.h.

The kfifo backport code is only build when CPTCFG_BACKPORT_BUILD_KFIFO
is set and not depending on some kernel version.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/kfifo.h |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/backport/backport-include/linux/kfifo.h b/backport/backport-include/linux/kfifo.h
index 398b00d..49de20e 100644
--- a/backport/backport-include/linux/kfifo.h
+++ b/backport/backport-include/linux/kfifo.h
@@ -1,7 +1,11 @@
 #include <linux/version.h>
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36))
+#ifndef CPTCFG_BACKPORT_BUILD_KFIFO
+#if (RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(6,4))
 #include_next <linux/kfifo.h>
 #else
+#include <linux/kfifo-new.h>
+#endif
+#else
 /*
  * A generic kernel FIFO implementation
  *
-- 
1.7.10.4

