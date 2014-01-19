Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:58467 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752366AbaASQuX (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 19 Jan 2014 11:50:23 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 03/16] backports: do not activate BCMA_HOST_SOC on kernel < 3.7
Date: Sun, 19 Jan 2014 17:47:24 +0100
Message-Id: <1390150057-11652-4-git-send-email-hauke@hauke-m.de> (sfid-20140119_175025_671821_27A94359)
In-Reply-To: <1390150057-11652-1-git-send-email-hauke@hauke-m.de>
References: <1390150057-11652-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

drivers/bcma/driver_gpio.c calls irq_set_chip_and_handler() when
BCMA_HOST_SOC is activated. irq_set_chip_and_handler() gets exported on
kernel >= 3.7, we should not activate this on any older kernel.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 dependencies |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/dependencies b/dependencies
index 4eabc25..7f6b95a 100644
--- a/dependencies
+++ b/dependencies
@@ -183,6 +183,12 @@ BCMA_DRIVER_GPIO 3.0
 BCMA_DRIVER_MIPS 3.3
 SSB_DRIVER_MIPS 3.3
 
+# the irq handler in the gpio driver uses 
+# irq_set_chip_and_handler_name() which gets exported starting with 
+# kernel 3.7. This code is only compiled if BCMA_DRIVER_GPIO and
+# BCMA_HOST_SOC are set.
+BCMA_HOST_SOC 3.7
+
 # rfkill-regulator uses a kernel header file
 # (rfkill-regulator.h) that we don't backport
 # right now, so make it depend on 3.0
-- 
1.7.10.4

