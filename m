Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.mailbox.org ([80.241.60.212]:48971 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754242AbdHUW2s (ORCPT <rfc822;backports@vger.kernel.org>);
        Mon, 21 Aug 2017 18:28:48 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 15/21] dependencies: add deps for struct acpi_gpio_mapping
Date: Tue, 22 Aug 2017 00:28:11 +0200
Message-Id: <20170821222817.17376-16-hauke@hauke-m.de> (sfid-20170822_002850_728091_87E78DD4)
In-Reply-To: <20170821222817.17376-1-hauke@hauke-m.de>
References: <20170821222817.17376-1-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

These NFC drivers are using struct acpi_gpio_mapping which was added in
kernel 3.19. Do not try to build them on older kernel versions where
this structures is not available.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 dependencies | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/dependencies b/dependencies
index f97e12ad..9b46abc1 100644
--- a/dependencies
+++ b/dependencies
@@ -58,11 +58,12 @@ NFC_PN544_I2C 3.17
 # this needs devm_gpiod_get_index() with 4 arguments.
 NFC_NXP_NCI_I2C 3.17
 
-# this needs device_property..() functions
-NFC_FDP_I2C 3.18
-NFC_ST21NFCA_I2C 3.18
-NFC_ST_NCI_I2C 3.18
-NFC_ST_NCI_SPI 3.18
+# this needs device_property..() functions and struct acpi_gpio_mapping
+NFC_FDP_I2C 3.19
+NFC_ST21NFCA_I2C 3.19
+NFC_ST_NCI_I2C 3.19
+NFC_ST_NCI_SPI 3.19
+NFC_PN544_I2C 3.19
 
 # for whoever wants to backport this: GPIOF_EXPORT was redefined via commit
 # 79a9becd on v3.13-rc1~120^2~15, before this it was redefined via commit
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
