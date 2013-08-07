Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:37596 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933530Ab3HGWx7 (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 7 Aug 2013 18:53:59 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 06/10] backports: try to backport acpi_video_register_with_quirks()
Date: Thu,  8 Aug 2013 00:53:21 +0200
Message-Id: <1375916005-16411-7-git-send-email-hauke@hauke-m.de> (sfid-20130808_005400_423672_026833EE)
In-Reply-To: <1375916005-16411-1-git-send-email-hauke@hauke-m.de>
References: <1375916005-16411-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Original the i915 driver called acpi_video_register(), but that was
replaced with acpi_video_register_with_quirks(), which we can not
backport easily, replace it with the old call to
acpi_video_register() again.

Thos backports the following commit:
commit 8c5bd7adb2ce47e6aa39d17b2375f69b0c0aa255
Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Date:   Thu Jul 18 02:08:06 2013 +0200

    ACPI / video / i915: No ACPI backlight if firmware expects Windows 8

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/acpi/video.h |   13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 backport/backport-include/acpi/video.h

diff --git a/backport/backport-include/acpi/video.h b/backport/backport-include/acpi/video.h
new file mode 100644
index 0000000..ff5c776
--- /dev/null
+++ b/backport/backport-include/acpi/video.h
@@ -0,0 +1,13 @@
+#ifndef __BACKPORT_ACPI_VIDEO_H
+#define __BACKPORT_ACPI_VIDEO_H
+#include_next <acpi/video.h>
+#include <linux/version.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,12,0)
+static inline int acpi_video_register_with_quirks(void)
+{
+	return acpi_video_register();
+}
+#endif
+
+#endif /*  __BACKPORT_ACPI_VIDEO_H */
-- 
1.7.10.4

