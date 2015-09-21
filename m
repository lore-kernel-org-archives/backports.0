Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:51943 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756538AbbIUWHc (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 21 Sep 2015 18:07:32 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 06/10] dependencies: make BCMA_DRIVER_GPIO depend on kernel 3.13
Date: Tue, 22 Sep 2015 00:07:19 +0200
Message-Id: <1442873243-15490-7-git-send-email-hauke@hauke-m.de> (sfid-20150922_000738_806322_17632325)
In-Reply-To: <1442873243-15490-1-git-send-email-hauke@hauke-m.de>
References: <1442873243-15490-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

bcma gpio now uses the gpio driver subsystem which was added with
kernel 3.13.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 dependencies | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/dependencies b/dependencies
index ba78004..3290839 100644
--- a/dependencies
+++ b/dependencies
@@ -137,6 +137,9 @@ SSB_DRIVER_MIPS 3.3
 # BCMA_HOST_SOC are set.
 BCMA_HOST_SOC 3.7
 
+# linux/gpio/driver.h
+BCMA_DRIVER_GPIO 3.13
+
 # NFC core needs PF_NFC defined in socket.h which was
 # only introduced in kernel 3.1
 NFC 3.1
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe backports" in
