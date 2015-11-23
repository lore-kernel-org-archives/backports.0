Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:41648 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753320AbbKWXLM (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 23 Nov 2015 18:11:12 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 06/14] header: include old media header files from new positions
Date: Tue, 24 Nov 2015 00:10:56 +0100
Message-Id: <1448320264-15070-7-git-send-email-hauke@hauke-m.de> (sfid-20151124_001116_416740_4110AF3C)
In-Reply-To: <1448320264-15070-1-git-send-email-hauke@hauke-m.de>
References: <1448320264-15070-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The media header files were reorganized and the platform header files
are now moved to include/linux/platform_data/media/. place some dummy
files there and include the original files from there.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/platform_data/media/si4713.h   | 10 ++++++++++
 .../linux/platform_data/media/soc_camera_platform.h            | 10 ++++++++++
 .../backport-include/linux/platform_data/media/timb_radio.h    | 10 ++++++++++
 .../backport-include/linux/platform_data/media/timb_video.h    | 10 ++++++++++
 4 files changed, 40 insertions(+)
 create mode 100644 backport/backport-include/linux/platform_data/media/si4713.h
 create mode 100644 backport/backport-include/linux/platform_data/media/soc_camera_platform.h
 create mode 100644 backport/backport-include/linux/platform_data/media/timb_radio.h
 create mode 100644 backport/backport-include/linux/platform_data/media/timb_video.h

diff --git a/backport/backport-include/linux/platform_data/media/si4713.h b/backport/backport-include/linux/platform_data/media/si4713.h
new file mode 100644
index 0000000..b602bc2
--- /dev/null
+++ b/backport/backport-include/linux/platform_data/media/si4713.h
@@ -0,0 +1,10 @@
+#ifndef __BACKPORT_SI4713_H
+#define __BACKPORT_SI4713_H
+#include <linux/version.h>
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,4,0)
+#include_next <linux/platform_data/media/si4713.h>
+#else
+#include <media/si4713.h>
+#endif /* < 4.4 */
+
+#endif /* __BACKPORT_SI4713_H */
diff --git a/backport/backport-include/linux/platform_data/media/soc_camera_platform.h b/backport/backport-include/linux/platform_data/media/soc_camera_platform.h
new file mode 100644
index 0000000..ce2dd17
--- /dev/null
+++ b/backport/backport-include/linux/platform_data/media/soc_camera_platform.h
@@ -0,0 +1,10 @@
+#ifndef __BACKPORT_SOC_CAMERA_H__
+#define __BACKPORT_SOC_CAMERA_H__
+#include <linux/version.h>
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,4,0)
+#include_next <linux/platform_data/media/soc_camera_platform.h>
+#else
+#include <media/soc_camera_platform.h>
+#endif /* < 4.4 */
+
+#endif /* __BACKPORT_SOC_CAMERA_H__ */
diff --git a/backport/backport-include/linux/platform_data/media/timb_radio.h b/backport/backport-include/linux/platform_data/media/timb_radio.h
new file mode 100644
index 0000000..88dd20f
--- /dev/null
+++ b/backport/backport-include/linux/platform_data/media/timb_radio.h
@@ -0,0 +1,10 @@
+#ifndef __BACKPORT_TIMB_RADIO_
+#define __BACKPORT_TIMB_RADIO_
+#include <linux/version.h>
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,4,0)
+#include_next <linux/platform_data/media/timb_radio.h>
+#else
+#include <media/timb_radio.h>
+#endif /* < 4.4 */
+
+#endif /* __BACKPORT_TIMB_RADIO_ */
diff --git a/backport/backport-include/linux/platform_data/media/timb_video.h b/backport/backport-include/linux/platform_data/media/timb_video.h
new file mode 100644
index 0000000..a729ee8
--- /dev/null
+++ b/backport/backport-include/linux/platform_data/media/timb_video.h
@@ -0,0 +1,10 @@
+#ifndef __BACKPORT_TIMB_VIDEO_
+#define __BACKPORT_TIMB_VIDEO_
+#include <linux/version.h>
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,4,0)
+#include_next <linux/platform_data/media/timb_video.h>
+#else
+#include <media/timb_video.h>
+#endif /* < 4.4 */
+
+#endif /* __BACKPORT_TIMB_VIDEO_ */
-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
