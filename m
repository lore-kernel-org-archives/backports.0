Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:35744 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752405AbbINHtA (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 14 Sep 2015 03:49:00 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 01/10] header: add acpi_dev_remove_driver_gpios()
Date: Mon, 14 Sep 2015 09:48:33 +0200
Message-Id: <1442216922-3318-2-git-send-email-hauke@hauke-m.de> (sfid-20150914_094902_227107_368DB457)
In-Reply-To: <1442216922-3318-1-git-send-email-hauke@hauke-m.de>
References: <1442216922-3318-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This adds an empty implementation of acpi_dev_remove_driver_gpios() for
kernel version < 3.19, on these versions we do not support these acpi
features.
This is used by hci_bcm.c

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/acpi.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/backport/backport-include/linux/acpi.h b/backport/backport-include/linux/acpi.h
index ff55d76..395ca18 100644
--- a/backport/backport-include/linux/acpi.h
+++ b/backport/backport-include/linux/acpi.h
@@ -54,4 +54,10 @@ static inline struct acpi_device *_acpi_get_companion(struct device *dev)
 #define ACPI_COMPANION(dev)	(NULL)
 #endif /* CONFIG_ACPI */
 #endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3, 13, 0) */
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,19,0)
+#define acpi_dev_remove_driver_gpios LINUX_BACKPORT(acpi_dev_remove_driver_gpios)
+static inline void acpi_dev_remove_driver_gpios(struct acpi_device *adev) {}
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3, 19, 0) */
+
 #endif /* __BACKPORT_LINUX_ACPI_H */
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe backports" in
