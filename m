Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:41041 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752080AbbFNO3i (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 14 Jun 2015 10:29:38 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 13/21] backports: add HDMI driver
Date: Sun, 14 Jun 2015 16:29:14 +0200
Message-Id: <1434292162-2261-14-git-send-email-hauke@hauke-m.de> (sfid-20150614_163351_071622_4A9E6562)
In-Reply-To: <1434292162-2261-1-git-send-email-hauke@hauke-m.de>
References: <1434292162-2261-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Before we only copied the hdmi.h header file and not the driver. Now
some other drivers need the hdmi driver code, also copy it now too.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/compat/Kconfig | 16 ++++++++++++++++
 copy-list               |  2 --
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/backport/compat/Kconfig b/backport/compat/Kconfig
index 8fcdb8a..ca50190 100644
--- a/backport/compat/Kconfig
+++ b/backport/compat/Kconfig
@@ -144,3 +144,19 @@ config BPAUTO_RHASHTABLE
 	default y if MAC80211
 	#h-file linux/rhashtable.h
 	#c-file lib/rhashtable.c
+
+config BPAUTO_BUILD_HDMI
+	bool
+	# the hdmi driver got some new apis like hdmi_infoframe_unpack() in
+	# kernel 4.0 which are used by some drivers
+	depends on KERNEL_4_0
+	#h-file linux/hdmi.h
+	#c-file drivers/video/hdmi.c
+
+config BPAUTO_HDMI
+	bool
+	select BPAUTO_BUILD_HDMI if KERNEL_4_0
+	# these drivers are using the new features of the hdmi driver.
+	default y if VIDEO_ADV7511
+	default y if VIDEO_ADV7604
+	default y if VIDEO_ADV7842
diff --git a/copy-list b/copy-list
index 5cd6dbf..7cfeedf 100644
--- a/copy-list
+++ b/copy-list
@@ -165,8 +165,6 @@ drivers/staging/media/cxd2099/cxd2099.h
 include/uapi/linux/ivtv.h
 include/uapi/linux/meye.h
 
-include/linux/hdmi.h
-
 drivers/media/
 include/linux/platform_data/camera-rcar.h
 include/linux/of_graph.h
-- 
2.1.4

