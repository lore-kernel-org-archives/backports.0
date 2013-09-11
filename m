Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:40702 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751335Ab3IKMMR (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 11 Sep 2013 08:12:17 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 03/11] backports: add HDMI_INFOFRAME_SIZE
Date: Wed, 11 Sep 2013 14:11:47 +0200
Message-Id: <1378901515-14206-4-git-send-email-hauke@hauke-m.de> (sfid-20130911_141219_276930_BAEDA02D)
In-Reply-To: <1378901515-14206-1-git-send-email-hauke@hauke-m.de>
References: <1378901515-14206-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Add the missing define.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/hdmi.h |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/backport/backport-include/linux/hdmi.h b/backport/backport-include/linux/hdmi.h
index c02787c..41a5387 100644
--- a/backport/backport-include/linux/hdmi.h
+++ b/backport/backport-include/linux/hdmi.h
@@ -28,4 +28,9 @@ hdmi_infoframe_pack(union hdmi_infoframe *frame, void *buffer, size_t size);
 #endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,12,0)*/ 
 #endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,9,0) */
 
+#ifndef HDMI_INFOFRAME_SIZE
+#define HDMI_INFOFRAME_SIZE(type)	\
+	(HDMI_INFOFRAME_HEADER_SIZE + HDMI_ ## type ## _INFOFRAME_SIZE)
+#endif
+
 #endif /* __BACKPORT_LINUX_HDMI_H */
-- 
1.7.10.4

