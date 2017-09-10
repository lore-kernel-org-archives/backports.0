Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.mailbox.org ([80.241.60.212]:58438 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751602AbdIJWKt (ORCPT <rfc822;backports@vger.kernel.org>);
        Sun, 10 Sep 2017 18:10:49 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 8/8] dependencies: make MWIFIEX_PCIE depend on kernel > 3.16
Date: Mon, 11 Sep 2017 00:10:20 +0200
Message-Id: <20170910221020.13067-9-hauke@hauke-m.de> (sfid-20170911_001051_553871_00642A7A)
In-Reply-To: <20170910221020.13067-1-hauke@hauke-m.de>
References: <20170910221020.13067-1-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This driver needs the reset_notify member from the struct
pci_error_handlers.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 dependencies | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/dependencies b/dependencies
index c9827139..bda18659 100644
--- a/dependencies
+++ b/dependencies
@@ -59,6 +59,9 @@ NFC_TRF7970A 3.17
 # this needs devm_gpiod_get_index() with 4 arguments.
 NFC_NXP_NCI_I2C 3.17
 
+# pci_error_handlers->reset_notify is missing
+MWIFIEX_PCIE 3.16
+
 # this needs device_property..() functions and struct acpi_gpio_mapping
 NFC_FDP_I2C 3.19
 NFC_ST21NFCA_I2C 3.19
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
