Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:44829 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751924AbaFOVWF (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 15 Jun 2014 17:22:05 -0400
Received: from localhost (localhost [127.0.0.1])
	by hauke-m.de (Postfix) with ESMTP id 8B3227E66
	for <backports@vger.kernel.org>; Sun, 15 Jun 2014 23:22:03 +0200 (CEST)
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 01/19] backports: remove upstream patches
Date: Sun, 15 Jun 2014 23:21:29 +0200
Message-Id: <1402867307-31337-2-git-send-email-hauke@hauke-m.de> (sfid-20140615_232206_753579_070EF05A)
In-Reply-To: <1402867307-31337-1-git-send-email-hauke@hauke-m.de>
References: <1402867307-31337-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

These two patches are now in upstream linux kernel and not needed in
backports any more

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../0003-technisat-usb2-led-rename.patch           | 83 ----------------------
 .../0004-bt8xx-rename-dst-ops.patch                | 67 -----------------
 2 files changed, 150 deletions(-)
 delete mode 100644 patches/0000-upstream-backport-changes/0003-technisat-usb2-led-rename.patch
 delete mode 100644 patches/0000-upstream-backport-changes/0004-bt8xx-rename-dst-ops.patch

diff --git a/patches/0000-upstream-backport-changes/0003-technisat-usb2-led-rename.patch b/patches/0000-upstream-backport-changes/0003-technisat-usb2-led-rename.patch
deleted file mode 100644
index 4732392..0000000
--- a/patches/0000-upstream-backport-changes/0003-technisat-usb2-led-rename.patch
+++ /dev/null
@@ -1,83 +0,0 @@
-This clashes with include/linux/leds.h namespace, fix this and
-also send this upstream eventually.
-
---- a/drivers/media/usb/dvb-usb/technisat-usb2.c
-+++ b/drivers/media/usb/dvb-usb/technisat-usb2.c
-@@ -214,10 +214,10 @@ static void technisat_usb2_frontend_rese
- 
- /* LED control */
- enum technisat_usb2_led_state {
--	LED_OFF,
--	LED_BLINK,
--	LED_ON,
--	LED_UNDEFINED
-+	TECH_LED_OFF,
-+	TECH_LED_BLINK,
-+	TECH_LED_ON,
-+	TECH_LED_UNDEFINED
- };
- 
- static int technisat_usb2_set_led(struct dvb_usb_device *d, int red, enum technisat_usb2_led_state state)
-@@ -229,14 +229,14 @@ static int technisat_usb2_set_led(struct
- 		0
- 	};
- 
--	if (disable_led_control && state != LED_OFF)
-+	if (disable_led_control && state != TECH_LED_OFF)
- 		return 0;
- 
- 	switch (state) {
--	case LED_ON:
-+	case TECH_LED_ON:
- 		led[1] = 0x82;
- 		break;
--	case LED_BLINK:
-+	case TECH_LED_BLINK:
- 		led[1] = 0x82;
- 		if (red) {
- 			led[2] = 0x02;
-@@ -251,7 +251,7 @@ static int technisat_usb2_set_led(struct
- 		break;
- 
- 	default:
--	case LED_OFF:
-+	case TECH_LED_OFF:
- 		led[1] = 0x80;
- 		break;
- 	}
-@@ -310,11 +310,11 @@ static void technisat_usb2_green_led_con
- 				goto schedule;
- 
- 			if (ber > 1000)
--				technisat_usb2_set_led(state->dev, 0, LED_BLINK);
-+				technisat_usb2_set_led(state->dev, 0, TECH_LED_BLINK);
- 			else
--				technisat_usb2_set_led(state->dev, 0, LED_ON);
-+				technisat_usb2_set_led(state->dev, 0, TECH_LED_ON);
- 		} else
--			technisat_usb2_set_led(state->dev, 0, LED_OFF);
-+			technisat_usb2_set_led(state->dev, 0, TECH_LED_OFF);
- 	}
- 
- schedule:
-@@ -365,9 +365,9 @@ static int technisat_usb2_power_ctrl(str
- 		return 0;
- 
- 	/* green led is turned off in any case - will be turned on when tuning */
--	technisat_usb2_set_led(d, 0, LED_OFF);
-+	technisat_usb2_set_led(d, 0, TECH_LED_OFF);
- 	/* red led is turned on all the time */
--	technisat_usb2_set_led(d, 1, LED_ON);
-+	technisat_usb2_set_led(d, 1, TECH_LED_ON);
- 	return 0;
- }
- 
-@@ -667,7 +667,7 @@ static int technisat_usb2_rc_query(struc
- 		return 0;
- 
- 	if (!disable_led_control)
--		technisat_usb2_set_led(d, 1, LED_BLINK);
-+		technisat_usb2_set_led(d, 1, TECH_LED_BLINK);
- 
- 	return 0;
- }
diff --git a/patches/0000-upstream-backport-changes/0004-bt8xx-rename-dst-ops.patch b/patches/0000-upstream-backport-changes/0004-bt8xx-rename-dst-ops.patch
deleted file mode 100644
index 2e8e1b3..0000000
--- a/patches/0000-upstream-backport-changes/0004-bt8xx-rename-dst-ops.patch
+++ /dev/null
@@ -1,67 +0,0 @@
-This will be sent upstream... there is a conflict with these
-names and another symbol from older kernels.
-
---- a/drivers/media/pci/bt8xx/dst.c
-+++ b/drivers/media/pci/bt8xx/dst.c
-@@ -1544,7 +1544,7 @@ static int dst_send_burst(struct dvb_fro
- }
- 
- 
--static int dst_init(struct dvb_frontend *fe)
-+static int bt8xx_dst_init(struct dvb_frontend *fe)
- {
- 	struct dst_state *state = fe->demodulator_priv;
- 
-@@ -1707,7 +1707,7 @@ static int dst_get_frontend(struct dvb_f
- 	return 0;
- }
- 
--static void dst_release(struct dvb_frontend *fe)
-+static void bt8xx_dst_release(struct dvb_frontend *fe)
- {
- 	struct dst_state *state = fe->demodulator_priv;
- 	if (state->dst_ca) {
-@@ -1776,8 +1776,8 @@ static struct dvb_frontend_ops dst_dvbt_
- 			FE_CAN_GUARD_INTERVAL_AUTO
- 	},
- 
--	.release = dst_release,
--	.init = dst_init,
-+	.release = bt8xx_dst_release,
-+	.init = bt8xx_dst_init,
- 	.tune = dst_tune_frontend,
- 	.set_frontend = dst_set_frontend,
- 	.get_frontend = dst_get_frontend,
-@@ -1801,8 +1801,8 @@ static struct dvb_frontend_ops dst_dvbs_
- 		.caps = FE_CAN_FEC_AUTO | FE_CAN_QPSK
- 	},
- 
--	.release = dst_release,
--	.init = dst_init,
-+	.release = bt8xx_dst_release,
-+	.init = bt8xx_dst_init,
- 	.tune = dst_tune_frontend,
- 	.set_frontend = dst_set_frontend,
- 	.get_frontend = dst_get_frontend,
-@@ -1834,8 +1834,8 @@ static struct dvb_frontend_ops dst_dvbc_
- 			FE_CAN_QAM_256
- 	},
- 
--	.release = dst_release,
--	.init = dst_init,
-+	.release = bt8xx_dst_release,
-+	.init = bt8xx_dst_init,
- 	.tune = dst_tune_frontend,
- 	.set_frontend = dst_set_frontend,
- 	.get_frontend = dst_get_frontend,
-@@ -1857,8 +1857,8 @@ static struct dvb_frontend_ops dst_atsc_
- 		.caps = FE_CAN_FEC_AUTO | FE_CAN_QAM_AUTO | FE_CAN_QAM_64 | FE_CAN_QAM_256 | FE_CAN_8VSB
- 	},
- 
--	.release = dst_release,
--	.init = dst_init,
-+	.release = bt8xx_dst_release,
-+	.init = bt8xx_dst_init,
- 	.tune = dst_tune_frontend,
- 	.set_frontend = dst_set_frontend,
- 	.get_frontend = dst_get_frontend,
-- 
1.9.1

