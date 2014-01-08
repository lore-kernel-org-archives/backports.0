Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:47031 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754266AbaAHBC6 (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 7 Jan 2014 20:02:58 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH] backports: add prefix infront of led_blink_set()
Date: Wed,  8 Jan 2014 02:02:50 +0100
Message-Id: <1389142970-2379-1-git-send-email-hauke@hauke-m.de> (sfid-20140108_020300_514226_BDC64B87)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

led_blink_set() is also exported by the RedHat 6.5 kernel and collides
with backports when loading the compat.ko module. This fixes the
problem by prefixing the symbol.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---

This should also go into backports-3.12

 backport/backport-include/linux/leds.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/backport/backport-include/linux/leds.h b/backport/backport-include/linux/leds.h
index b8a9e2a..6148040 100644
--- a/backport/backport-include/linux/leds.h
+++ b/backport/backport-include/linux/leds.h
@@ -28,6 +28,7 @@
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,37) && \
     !defined(CPTCFG_BACKPORT_BUILD_LEDS)
+#define led_blink_set LINUX_BACKPORT(led_blink_set)
 extern void led_blink_set(struct led_classdev *led_cdev,
 			  unsigned long *delay_on,
 			  unsigned long *delay_off);
-- 
1.7.10.4

