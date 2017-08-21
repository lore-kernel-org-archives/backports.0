Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.mailbox.org ([80.241.60.212]:48925 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754035AbdHUW2o (ORCPT <rfc822;backports@vger.kernel.org>);
        Mon, 21 Aug 2017 18:28:44 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 08/21] header: backport devm_acpi_dev_add_driver_gpios()
Date: Tue, 22 Aug 2017 00:28:04 +0200
Message-Id: <20170821222817.17376-9-hauke@hauke-m.de> (sfid-20170822_002845_485339_DE72ECAB)
In-Reply-To: <20170821222817.17376-1-hauke@hauke-m.de>
References: <20170821222817.17376-1-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This is used by some NFC drivers to get information from the ACPI.
This was added in kernel 4.13, but backporting it to older kernel
versions than 3.19 is hard because such old kernel versions do not even
have struct acpi_gpio_mapping. This only adds the empty version of this
function as this normally needed some extra support in the generic ACPI
code and I do not care about this functionality.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/acpi.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/backport/backport-include/linux/acpi.h b/backport/backport-include/linux/acpi.h
index c63648b6..fe183626 100644
--- a/backport/backport-include/linux/acpi.h
+++ b/backport/backport-include/linux/acpi.h
@@ -60,4 +60,13 @@ static inline struct acpi_device *_acpi_get_companion(struct device *dev)
 static inline void acpi_dev_remove_driver_gpios(struct acpi_device *adev) {}
 #endif /* LINUX_VERSION_IS_LESS(3, 19, 0) */
 
+#if LINUX_VERSION_IN_RANGE(3,19,0, 4,13,0)
+#define devm_acpi_dev_add_driver_gpios LINUX_BACKPORT(devm_acpi_dev_add_driver_gpios)
+static inline int devm_acpi_dev_add_driver_gpios(struct device *dev,
+			      const struct acpi_gpio_mapping *gpios)
+{
+	return -ENXIO;
+}
+#endif /* LINUX_VERSION_IN_RANGE(4,19,0, 4,13,0) */
+
 #endif /* __BACKPORT_LINUX_ACPI_H */
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
