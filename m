Return-path: <backports-owner@vger.kernel.org>
Received: from mail-gw2-out.broadcom.com ([216.31.210.63]:9866 "EHLO
	mail-gw2-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753813AbbE0TPZ (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 27 May 2015 15:15:25 -0400
From: Arend van Spriel <arend@broadcom.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
CC: <backports@vger.kernel.org>, Arend van Spriel <arend@broadcom.com>
Subject: [PATCH] backports: include: introduce backport for ACPI_COMPANION() macro
Date: Wed, 27 May 2015 21:15:05 +0200
Message-ID: <1432754105-9939-1-git-send-email-arend@broadcom.com> (sfid-20150527_211610_951818_548A0FF7)
MIME-Version: 1.0
Content-Type: text/plain
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The brcmfmac driver now uses the ACPI_COMPANION() macro which was
introduced in v3.13 kernel. This provides a backport of that macro
for older kernels.

Signed-off-by: Arend van Spriel <arend@broadcom.com>
---
Not sure if this correctly does conversion from ACPI handle to acpi_device.

Regards,
Arend
---
 backport/backport-include/linux/acpi.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/backport/backport-include/linux/acpi.h b/backport/backport-include/linux/acpi.h
index 506df15..ff55d76 100644
--- a/backport/backport-include/linux/acpi.h
+++ b/backport/backport-include/linux/acpi.h
@@ -36,4 +36,22 @@
 #endif /* CONFIG_ACPI */
 #endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,8,0) */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 13, 0)
+#ifdef CONFIG_ACPI
+static inline struct acpi_device *_acpi_get_companion(struct device *dev)
+{
+	struct acpi_device *adev;
+	int ret;
+
+	ret = acpi_bus_get_device(ACPI_HANDLE(dev), &adev);
+	if (ret < 0)
+		adev = NULL;
+
+	return adev;
+}
+#define ACPI_COMPANION(dev)	_acpi_get_companion(dev)
+#else
+#define ACPI_COMPANION(dev)	(NULL)
+#endif /* CONFIG_ACPI */
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3, 13, 0) */
 #endif /* __BACKPORT_LINUX_ACPI_H */
-- 
1.9.1

