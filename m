Return-path: <backports-owner@vger.kernel.org>
Received: from mx2.mailbox.org ([80.241.60.215]:52096 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932491AbeCDW5q (ORCPT <rfc822;backports@vger.kernel.org>);
        Sun, 4 Mar 2018 17:57:46 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: johannes@sipsolutions.net, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 03/14] patches: Use old parameter type for DEFINE_TIMER
Date: Sun,  4 Mar 2018 23:57:06 +0100
Message-Id: <20180304225717.20890-4-hauke@hauke-m.de> (sfid-20180304_235755_436114_A44F937D)
In-Reply-To: <20180304225717.20890-1-hauke@hauke-m.de>
References: <20180304225717.20890-1-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Use the unsigned long parameters on kernel versions < 4.15 for the
DEFINE_TIMER callback. This was changed in Linux mainline commit
24ed960abf1d ("treewide: Switch DEFINE_TIMER callbacks to struct
timer_list *")

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 patches/0083-timer_list.patch | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 patches/0083-timer_list.patch

diff --git a/patches/0083-timer_list.patch b/patches/0083-timer_list.patch
new file mode 100644
index 00000000..dca3b948
--- /dev/null
+++ b/patches/0083-timer_list.patch
@@ -0,0 +1,22 @@
+--- a/drivers/net/wireless/atmel/at76c50x-usb.c
++++ b/drivers/net/wireless/atmel/at76c50x-usb.c
+@@ -518,11 +518,19 @@ exit:
+ 
+ /* LED trigger */
+ static int tx_activity;
++#if LINUX_VERSION_IS_LESS(4,15,0)
++static void at76_ledtrig_tx_timerfunc(unsigned long data);
++#else
+ static void at76_ledtrig_tx_timerfunc(struct timer_list *unused);
++#endif
+ static DEFINE_TIMER(ledtrig_tx_timer, at76_ledtrig_tx_timerfunc);
+ DEFINE_LED_TRIGGER(ledtrig_tx);
+ 
++#if LINUX_VERSION_IS_LESS(4,15,0)
++static void at76_ledtrig_tx_timerfunc(unsigned long data)
++#else
+ static void at76_ledtrig_tx_timerfunc(struct timer_list *unused)
++#endif
+ {
+ 	static int tx_lastactivity;
+ 
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
