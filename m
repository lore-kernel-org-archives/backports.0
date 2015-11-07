Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:52917 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753992AbbKGQzW (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 7 Nov 2015 11:55:22 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 07/10] header: change check for ACPI_COMPANION
Date: Sat,  7 Nov 2015 17:55:07 +0100
Message-Id: <1446915310-8278-8-git-send-email-hauke@hauke-m.de> (sfid-20151107_175527_093058_9856EC58)
In-Reply-To: <1446915310-8278-1-git-send-email-hauke@hauke-m.de>
References: <1446915310-8278-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Instead of using the kernel version to check if we have to add a
backport for ACPI_COMPANION check for it directly. RedHat 7 backported
this change to their kernel and writes a warning without this change.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/acpi.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/backport/backport-include/linux/acpi.h b/backport/backport-include/linux/acpi.h
index 395ca18..4c63a26 100644
--- a/backport/backport-include/linux/acpi.h
+++ b/backport/backport-include/linux/acpi.h
@@ -36,7 +36,7 @@
 #endif /* CONFIG_ACPI */
 #endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,8,0) */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 13, 0)
+#ifndef ACPI_COMPANION
 #ifdef CONFIG_ACPI
 static inline struct acpi_device *_acpi_get_companion(struct device *dev)
 {
@@ -53,7 +53,7 @@ static inline struct acpi_device *_acpi_get_companion(struct device *dev)
 #else
 #define ACPI_COMPANION(dev)	(NULL)
 #endif /* CONFIG_ACPI */
-#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3, 13, 0) */
+#endif /* ACPI_COMPANION */
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3,19,0)
 #define acpi_dev_remove_driver_gpios LINUX_BACKPORT(acpi_dev_remove_driver_gpios)
-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
