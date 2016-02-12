Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:49900 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752578AbcBLN7w (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 12 Feb 2016 08:59:52 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 3/5] patches: add missing include
Date: Fri, 12 Feb 2016 14:58:37 +0100
Message-Id: <1455285519-16163-4-git-send-email-hauke@hauke-m.de> (sfid-20160212_145955_383144_BBB40A4C)
In-Reply-To: <1455285519-16163-1-git-send-email-hauke@hauke-m.de>
References: <1455285519-16163-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

media-device.h needs the size of the "struct ida" now, but the include
is missing when compile against older kernel versions.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../media/0004-missing-include/media-device.patch            | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 patches/collateral-evolutions/media/0004-missing-include/media-device.patch

diff --git a/patches/collateral-evolutions/media/0004-missing-include/media-device.patch b/patches/collateral-evolutions/media/0004-missing-include/media-device.patch
new file mode 100644
index 0000000..9e0128a
--- /dev/null
+++ b/patches/collateral-evolutions/media/0004-missing-include/media-device.patch
@@ -0,0 +1,12 @@
+diff --git a/include/media/media-device.h b/include/media/media-device.h
+index d385589..6d9a84d 100644
+--- a/include/media/media-device.h
++++ b/include/media/media-device.h
+@@ -23,6 +23,7 @@
+ #ifndef _MEDIA_DEVICE_H
+ #define _MEDIA_DEVICE_H
+ 
++#include <linux/idr.h>
+ #include <linux/list.h>
+ #include <linux/mutex.h>
+ #include <linux/spinlock.h>
-- 
2.7.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
