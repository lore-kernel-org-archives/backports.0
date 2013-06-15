Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:39381 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751048Ab3FOPim (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 15 Jun 2013 11:38:42 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 7/8] backports: add cast in class_find_device()
Date: Sat, 15 Jun 2013 17:37:57 +0200
Message-Id: <1371310678-26491-8-git-send-email-hauke@hauke-m.de> (sfid-20130615_173843_618534_BA1FEF48)
In-Reply-To: <1371310678-26491-1-git-send-email-hauke@hauke-m.de>
References: <1371310678-26491-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Also type of the 3 parameter of class_find_device() changed from void *
to const void *, add a cast to prevent a warning.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/device.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/backport/backport-include/linux/device.h b/backport/backport-include/linux/device.h
index 4c0adb7..c2f80e2 100644
--- a/backport/backport-include/linux/device.h
+++ b/backport/backport-include/linux/device.h
@@ -15,7 +15,7 @@
  */
 typedef int (backport_device_find_function_t)(struct device *, void *);
 #define class_find_device(cls, start, idx, fun) \
-	class_find_device((cls), (start), (idx),\
+	class_find_device((cls), (start), (void *)(idx),\
 			  (backport_device_find_function_t *)(fun))
 #endif
 
-- 
1.7.10.4

