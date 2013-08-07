Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:37589 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933530Ab3HGWxx (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 7 Aug 2013 18:53:53 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 04/10] backports: update kernel version to test against
Date: Thu,  8 Aug 2013 00:53:19 +0200
Message-Id: <1375916005-16411-5-git-send-email-hauke@hauke-m.de> (sfid-20130808_005355_130669_7DB59790)
In-Reply-To: <1375916005-16411-1-git-send-email-hauke@hauke-m.de>
References: <1375916005-16411-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 devel/get-compat-kernels |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/devel/get-compat-kernels b/devel/get-compat-kernels
index 4fd4486..036b482 100755
--- a/devel/get-compat-kernels
+++ b/devel/get-compat-kernels
@@ -47,7 +47,7 @@ KERNELS="$KERNELS ${KPATH}/v2.6.28.10/linux-headers-2.6.28-02062810_2.6.28-02062
 KERNELS="$KERNELS ${KPATH}/v2.6.29.6/linux-headers-2.6.29-02062906_2.6.29-02062906_all.deb"
 KERNELS="$KERNELS ${KPATH}/v2.6.30.10/linux-headers-2.6.30-02063010_2.6.30-02063010_all.deb"
 KERNELS="$KERNELS ${KPATH}/v2.6.31.13-karmic/linux-headers-2.6.31-02063113_2.6.31-02063113_all.deb"
-KERNELS="$KERNELS ${KPATH}/v2.6.32.60-lucid/linux-headers-2.6.32-02063260_2.6.32-02063260.201210082135_all.deb"
+KERNELS="$KERNELS ${KPATH}/v2.6.32.61-lucid/linux-headers-2.6.32-02063261_2.6.32-02063261.201306101105_all.deb"
 KERNELS="$KERNELS ${KPATH}/v2.6.33.20-maverick/linux-headers-2.6.33-02063320_2.6.33-02063320.201111071735_all.deb"
 KERNELS="$KERNELS ${KPATH}/v2.6.34.14-maverick/linux-headers-2.6.34-02063414_2.6.34-02063414.201301162135_all.deb"
 KERNELS="$KERNELS ${KPATH}/v2.6.35.13-original-maverick/linux-headers-2.6.35-02063513_2.6.35-02063513.201107261012_all.deb"
@@ -55,17 +55,18 @@ KERNELS="$KERNELS ${KPATH}/v2.6.36.4-natty/linux-headers-2.6.36-02063604_2.6.36-
 KERNELS="$KERNELS ${KPATH}/v2.6.37.6-natty/linux-headers-2.6.37-02063706_2.6.37-02063706.201103281005_all.deb"
 KERNELS="$KERNELS ${KPATH}/v2.6.38.8-natty/linux-headers-2.6.38-02063808_2.6.38-02063808.201106040910_all.deb"
 KERNELS="$KERNELS ${KPATH}/v2.6.39.4-oneiric/linux-headers-2.6.39-02063904_2.6.39-02063904.201108040905_all.deb"
-KERNELS="$KERNELS ${KPATH}/v3.0.79-oneiric/linux-headers-3.0.79-030079_3.0.79-030079.201305191335_all.deb"
+KERNELS="$KERNELS ${KPATH}/v3.0.89-oneiric/linux-headers-3.0.89-030089_3.0.89-030089.201308040535_all.deb"
 KERNELS="$KERNELS ${KPATH}/v3.1.10-precise/linux-headers-3.1.10-030110_3.1.10-030110.201201181135_all.deb"
-KERNELS="$KERNELS ${KPATH}/v3.2.45-precise/linux-headers-3.2.45-030245_3.2.45-030245.201305140735_all.deb"
+KERNELS="$KERNELS ${KPATH}/v3.2.50-precise/linux-headers-3.2.50-030250_3.2.50-030250.201308021735_all.deb"
 KERNELS="$KERNELS ${KPATH}/v3.3.8-quantal/linux-headers-3.3.8-030308_3.3.8-030308.201206041356_all.deb"
-KERNELS="$KERNELS ${KPATH}/v3.4.46-quantal/linux-headers-3.4.46-030446_3.4.46-030446.201305191435_all.deb"
+KERNELS="$KERNELS ${KPATH}/v3.4.56-quantal/linux-headers-3.4.56-030456_3.4.56-030456.201308040635_all.deb"
 KERNELS="$KERNELS ${KPATH}/v3.5.7.12-quantal/linux-headers-3.5.7-03050712_3.5.7-03050712.201305111435_all.deb"
 KERNELS="$KERNELS ${KPATH}/v3.6.11-raring/linux-headers-3.6.11-030611_3.6.11-030611.201212171335_all.deb"
 KERNELS="$KERNELS ${KPATH}/v3.7.10-raring/linux-headers-3.7.10-030710_3.7.10-030710.201302271235_all.deb"
 KERNELS="$KERNELS ${KPATH}/v3.8.13-raring/linux-headers-3.8.13-030813_3.8.13-030813.201305111843_all.deb"
-KERNELS="$KERNELS ${KPATH}/v3.9.3-saucy/linux-headers-3.9.3-030903_3.9.3-030903.201305191535_all.deb"
-KERNELS="$KERNELS ${KPATH}/v3.10-rc1-saucy/linux-headers-3.10.0-031000rc1_3.10.0-031000rc1.201305130510_all.deb"
+KERNELS="$KERNELS ${KPATH}/v3.9.11-saucy/linux-headers-3.9.11-030911_3.9.11-030911.201307202035_all.deb"
+KERNELS="$KERNELS ${KPATH}/v3.10.5-saucy/linux-headers-3.10.5-031005_3.10.5-031005.201308040618_all.deb"
+KERNELS="$KERNELS ${KPATH}/v3.11-rc4-saucy/linux-headers-3.11.0-031100rc4_3.11.0-031100rc4.201308041735_all.deb"
 
 # Number of kernels
 NUM_KERNELS=$(echo $KERNELS | wc -w)
-- 
1.7.10.4

