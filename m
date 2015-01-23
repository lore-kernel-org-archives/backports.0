Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:40566 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751395AbbAWXUr (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 23 Jan 2015 18:20:47 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 2/3] header: add linux/hdmi.h
Date: Sat, 24 Jan 2015 00:20:39 +0100
Message-Id: <1422055240-4753-3-git-send-email-hauke@hauke-m.de> (sfid-20150124_002050_356021_E7A9E878)
In-Reply-To: <1422055240-4753-1-git-send-email-hauke@hauke-m.de>
References: <1422055240-4753-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/hdmi.h | 41 ++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 backport/backport-include/linux/hdmi.h

diff --git a/backport/backport-include/linux/hdmi.h b/backport/backport-include/linux/hdmi.h
new file mode 100644
index 0000000..a6d6880
--- /dev/null
+++ b/backport/backport-include/linux/hdmi.h
@@ -0,0 +1,41 @@
+#ifndef __BACKPORT_LINUX_HDMI_H
+#define __BACKPORT_LINUX_HDMI_H
+
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,9,0)
+#include_next <linux/hdmi.h>
+#else
+
+enum hdmi_colorspace {
+	HDMI_COLORSPACE_RGB,
+	HDMI_COLORSPACE_YUV422,
+	HDMI_COLORSPACE_YUV444,
+};
+
+enum hdmi_ycc_quantization_range {
+	HDMI_YCC_QUANTIZATION_RANGE_LIMITED,
+	HDMI_YCC_QUANTIZATION_RANGE_FULL,
+};
+
+enum hdmi_colorimetry {
+	HDMI_COLORIMETRY_NONE,
+	HDMI_COLORIMETRY_ITU_601,
+	HDMI_COLORIMETRY_ITU_709,
+	HDMI_COLORIMETRY_EXTENDED,
+};
+
+enum hdmi_extended_colorimetry {
+	HDMI_EXTENDED_COLORIMETRY_XV_YCC_601,
+	HDMI_EXTENDED_COLORIMETRY_XV_YCC_709,
+	HDMI_EXTENDED_COLORIMETRY_S_YCC_601,
+	HDMI_EXTENDED_COLORIMETRY_ADOBE_YCC_601,
+	HDMI_EXTENDED_COLORIMETRY_ADOBE_RGB,
+};
+
+enum hdmi_quantization_range {
+	HDMI_QUANTIZATION_RANGE_DEFAULT,
+	HDMI_QUANTIZATION_RANGE_LIMITED,
+	HDMI_QUANTIZATION_RANGE_FULL,
+};
+#endif
+
+#endif /* __BACKPORT_LINUX_HDMI_H */
-- 
1.9.1

