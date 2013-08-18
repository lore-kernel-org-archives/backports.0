Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:60831 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755738Ab3HRXiY (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 18 Aug 2013 19:38:24 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH v2 04/19] backports: do not copy wrong header files for regulators
Date: Mon, 19 Aug 2013 01:37:49 +0200
Message-Id: <1376869084-16513-5-git-send-email-hauke@hauke-m.de> (sfid-20130819_013825_419863_C3034DB8)
In-Reply-To: <1376869084-16513-1-git-send-email-hauke@hauke-m.de>
References: <1376869084-16513-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Some of the header files for the regulators framework where used by
regulator core, which does not get backported or some of them are also
used by mfd drivers. Now only the headers which are only used by the
regulator driver are copied, it could still be that these headers are
also used in some platform specific code where the driver gets
registered.
This patch then fixed some dependencies which where wrong because of
using the wrong header files.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 copy-list    |    9 ---------
 dependencies |   58 +++++++++++++++++++++++++++++++++-------------------------
 2 files changed, 33 insertions(+), 34 deletions(-)

diff --git a/copy-list b/copy-list
index 1a7fa93..534f0b4 100644
--- a/copy-list
+++ b/copy-list
@@ -141,25 +141,16 @@ include/linux/platform_data/pn544.h
 # include/linux/regulator/consumer.h and dummy.h
 include/linux/regulator/ab8500.h
 include/linux/regulator/db8500-prcmu.h
-include/linux/regulator/driver.h
 include/linux/regulator/fan53555.h
-include/linux/regulator/fixed.h
 include/linux/regulator/gpio-regulator.h
 include/linux/regulator/lp3971.h
 include/linux/regulator/lp3972.h
 include/linux/regulator/lp872x.h
-include/linux/regulator/machine.h
 include/linux/regulator/max1586.h
 include/linux/regulator/max8649.h
 include/linux/regulator/max8660.h
 include/linux/regulator/max8952.h
 include/linux/regulator/max8973-regulator.h
-include/linux/mfd/max77693.h
-include/linux/mfd/max77693-private.h
-include/linux/mfd/max8998.h
-include/linux/mfd/max8998-private.h
-include/linux/mfd/samsung/s2mps11.h
-include/linux/regulator/of_regulator.h
 include/linux/regulator/tps51632-regulator.h
 include/linux/regulator/tps62360.h
 include/linux/regulator/tps6507x.h
diff --git a/dependencies b/dependencies
index 9bd5763..6b42c4f 100644
--- a/dependencies
+++ b/dependencies
@@ -71,47 +71,55 @@ DRM_QXL 3.3
 # vmlinux.
 REGULATOR 3.4
 # requires some work
-REGULATOR_ARIZONA DISABLE
-REGULATOR_MAX8973 DISABLE
-REGULATOR_MAX77693 3.6
-REGULATOR_MAX77686 DISABLE
-REGULATOR_MAX8997 DISABLE
-REGULATOR_RC5T583 DISABLE
-REGULATOR_TPS62360 DISABLE
-REGULATOR_TPS65910 DISABLE
-REGULATOR_TPS65090 DISABLE
-REGULATOR_TPS65217 DISABLE
-REGULATOR_TPS6586X DISABLE
-REGULATOR_WM831X DISABLE
-REGULATOR_WM8350 DISABLE
-REGULATOR_PALMAS DISABLE
-REGULATOR_DA9055 DISABLE
-REGULATOR_S5M8767 DISABLE
-# These have further core regulator kernel dependencies
-# we can't easily backport.
+REGULATOR_88PM800 3.12
 REGULATOR_AAT2870 3.6
+REGULATOR_AD5398 3.5
+REGULATOR_ARIZONA 3.8
+REGULATOR_AS3711 3.12
 REGULATOR_DA903X 3.5
-REGULATOR_DA9052 3.5
+REGULATOR_DA9052 3.9
+REGULATOR_DA9055 3.8
 REGULATOR_FAN53555 3.5
+REGULATOR_FIXED_VOLTAGE 3.6
+REGULATOR_GPIO 3.6
 REGULATOR_ISL6271A 3.5
 REGULATOR_LP3971 3.6
 REGULATOR_LP3972 3.6
-REGULATOR_LP8755 3.5
+REGULATOR_LP8755 3.6
 REGULATOR_MAX1586 3.6
-REGULATOR_MAX8649 3.5
+REGULATOR_MAX77686 3.7
+REGULATOR_MAX77693 3.11
+REGULATOR_MAX8649 3.10
 REGULATOR_MAX8660 3.5
 REGULATOR_MAX8925 3.5
-REGULATOR_MAX8998 3.5
+REGULATOR_MAX8952 3.6
+REGULATOR_MAX8973 3.6
+REGULATOR_MAX8997 3.8
+REGULATOR_MAX8998 3.11
 REGULATOR_MC13783 3.6
 REGULATOR_MC13892 3.6
 REGULATOR_MC13XXX_CORE 3.6
+REGULATOR_PALMAS 3.11
 REGULATOR_PCAP 3.6
-REGULATOR_PCF50633 3.5
-REGULATOR_TPS51632 3.6
+REGULATOR_PCF50633 3.8
+REGULATOR_PFUZE100 3.6
+REGULATOR_RC5T583 3.6
+REGULATOR_S2MPS11 3.12
+REGULATOR_S5M8767 3.9
+REGULATOR_TPS51632 3.8
 REGULATOR_TPS6105X 3.6
-REGULATOR_TPS65023 3.6
+REGULATOR_TPS62360 3.6
+REGULATOR_TPS62360 3.6
+REGULATOR_TPS65023 3.9
 REGULATOR_TPS6507X 3.6
+REGULATOR_TPS65090 3.9
+REGULATOR_TPS65217 3.6
 REGULATOR_TPS6524X 3.6
+REGULATOR_TPS6586X 3.9
+REGULATOR_TPS65910 3.6
+REGULATOR_TPS65912 3.12
+REGULATOR_WM831X 3.12
+REGULATOR_WM8350 3.12
 REGULATOR_WM8400 3.12
 REGULATOR_WM8994 3.8
 
-- 
1.7.10.4

