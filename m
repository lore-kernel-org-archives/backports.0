Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:37449 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753832AbbLFNSh (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 6 Dec 2015 08:18:37 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 08/12] header: fix include old media header files from new positions for kernel 4.4
Date: Sun,  6 Dec 2015 14:18:24 +0100
Message-Id: <1449407908-15547-9-git-send-email-hauke@hauke-m.de> (sfid-20151206_141842_429802_E9BE36B6)
In-Reply-To: <1449407908-15547-1-git-send-email-hauke@hauke-m.de>
References: <1449407908-15547-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The change done in backports commit b9100fac "header: include old media
header files from new positions" is also needed for kernel 4.4.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/platform_data/media/si4713.h          | 4 ++--
 .../backport-include/linux/platform_data/media/soc_camera_platform.h  | 4 ++--
 backport/backport-include/linux/platform_data/media/timb_radio.h      | 4 ++--
 backport/backport-include/linux/platform_data/media/timb_video.h      | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/backport/backport-include/linux/platform_data/media/si4713.h b/backport/backport-include/linux/platform_data/media/si4713.h
index b602bc2..7a00018 100644
--- a/backport/backport-include/linux/platform_data/media/si4713.h
+++ b/backport/backport-include/linux/platform_data/media/si4713.h
@@ -1,10 +1,10 @@
 #ifndef __BACKPORT_SI4713_H
 #define __BACKPORT_SI4713_H
 #include <linux/version.h>
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,4,0)
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,5,0)
 #include_next <linux/platform_data/media/si4713.h>
 #else
 #include <media/si4713.h>
-#endif /* < 4.4 */
+#endif /* < 4.5 */
 
 #endif /* __BACKPORT_SI4713_H */
diff --git a/backport/backport-include/linux/platform_data/media/soc_camera_platform.h b/backport/backport-include/linux/platform_data/media/soc_camera_platform.h
index ce2dd17..9367202 100644
--- a/backport/backport-include/linux/platform_data/media/soc_camera_platform.h
+++ b/backport/backport-include/linux/platform_data/media/soc_camera_platform.h
@@ -1,10 +1,10 @@
 #ifndef __BACKPORT_SOC_CAMERA_H__
 #define __BACKPORT_SOC_CAMERA_H__
 #include <linux/version.h>
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,4,0)
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,5,0)
 #include_next <linux/platform_data/media/soc_camera_platform.h>
 #else
 #include <media/soc_camera_platform.h>
-#endif /* < 4.4 */
+#endif /* < 4.5 */
 
 #endif /* __BACKPORT_SOC_CAMERA_H__ */
diff --git a/backport/backport-include/linux/platform_data/media/timb_radio.h b/backport/backport-include/linux/platform_data/media/timb_radio.h
index 88dd20f..91923fd 100644
--- a/backport/backport-include/linux/platform_data/media/timb_radio.h
+++ b/backport/backport-include/linux/platform_data/media/timb_radio.h
@@ -1,10 +1,10 @@
 #ifndef __BACKPORT_TIMB_RADIO_
 #define __BACKPORT_TIMB_RADIO_
 #include <linux/version.h>
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,4,0)
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,5,0)
 #include_next <linux/platform_data/media/timb_radio.h>
 #else
 #include <media/timb_radio.h>
-#endif /* < 4.4 */
+#endif /* < 4.5 */
 
 #endif /* __BACKPORT_TIMB_RADIO_ */
diff --git a/backport/backport-include/linux/platform_data/media/timb_video.h b/backport/backport-include/linux/platform_data/media/timb_video.h
index a729ee8..f714b83 100644
--- a/backport/backport-include/linux/platform_data/media/timb_video.h
+++ b/backport/backport-include/linux/platform_data/media/timb_video.h
@@ -1,10 +1,10 @@
 #ifndef __BACKPORT_TIMB_VIDEO_
 #define __BACKPORT_TIMB_VIDEO_
 #include <linux/version.h>
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,4,0)
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,5,0)
 #include_next <linux/platform_data/media/timb_video.h>
 #else
 #include <media/timb_video.h>
-#endif /* < 4.4 */
+#endif /* < 4.5 */
 
 #endif /* __BACKPORT_TIMB_VIDEO_ */
-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
