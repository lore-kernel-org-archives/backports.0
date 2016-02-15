Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:51554 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751555AbcBOPZK (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 15 Feb 2016 10:25:10 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 07/12] dependencies: make BCMA_DRIVER_GPIO depend on kernel >= 4.5
Date: Mon, 15 Feb 2016 16:24:54 +0100
Message-Id: <1455549899-14564-8-git-send-email-hauke@hauke-m.de> (sfid-20160215_184437_891911_6831C5C7)
In-Reply-To: <1455549899-14564-1-git-send-email-hauke@hauke-m.de>
References: <1455549899-14564-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

CONFIG_BCMA_DRIVER_GPIO now uses gpiochip_get_data() which was added in
kernel 4.5

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 dependencies | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/dependencies b/dependencies
index 50ed87b..7017c2c 100644
--- a/dependencies
+++ b/dependencies
@@ -152,8 +152,8 @@ SSB_DRIVER_MIPS 3.3
 # BCMA_HOST_SOC are set.
 BCMA_HOST_SOC 3.7
 
-# linux/gpio/driver.h
-BCMA_DRIVER_GPIO 3.13
+# Uses gpiochip_get_data()
+BCMA_DRIVER_GPIO 4.5
 
 # NFC core needs PF_NFC defined in socket.h which was
 # only introduced in kernel 3.1
-- 
2.7.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
