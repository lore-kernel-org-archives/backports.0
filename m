Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:49115 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751743Ab3JaWCP (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 31 Oct 2013 18:02:15 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH] backports: update test kernel versions
Date: Thu, 31 Oct 2013 23:02:09 +0100
Message-Id: <1383256929-32291-1-git-send-email-hauke@hauke-m.de> (sfid-20131031_230217_156918_02EE1EA8)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This brings the kernels test test against to the latest versions.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 devel/get-compat-kernels |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/devel/get-compat-kernels b/devel/get-compat-kernels
index dc8de90..31f5e9c 100755
--- a/devel/get-compat-kernels
+++ b/devel/get-compat-kernels
@@ -54,19 +54,19 @@ KERNELS="$KERNELS ${KPATH}/v2.6.36.4-natty/linux-headers-2.6.36-02063604_2.6.36-
 KERNELS="$KERNELS ${KPATH}/v2.6.37.6-natty/linux-headers-2.6.37-02063706_2.6.37-02063706.201103281005_all.deb"
 KERNELS="$KERNELS ${KPATH}/v2.6.38.8-natty/linux-headers-2.6.38-02063808_2.6.38-02063808.201106040910_all.deb"
 KERNELS="$KERNELS ${KPATH}/v2.6.39.4-oneiric/linux-headers-2.6.39-02063904_2.6.39-02063904.201108040905_all.deb"
-KERNELS="$KERNELS ${KPATH}/v3.0.98-oneiric/linux-headers-3.0.98-030098_3.0.98-030098.201310011235_all.deb"
+KERNELS="$KERNELS ${KPATH}/v3.0.101-oneiric/linux-headers-3.0.101-0300101_3.0.101-0300101.201310220446_all.deb"
 KERNELS="$KERNELS ${KPATH}/v3.1.10-precise/linux-headers-3.1.10-030110_3.1.10-030110.201201181135_all.deb"
-KERNELS="$KERNELS ${KPATH}/v3.2.51-precise/linux-headers-3.2.51-030251_3.2.51-030251.201309101035_all.deb"
+KERNELS="$KERNELS ${KPATH}/v3.2.52-precise/linux-headers-3.2.52-030252_3.2.52-030252.201310262335_all.deb"
 KERNELS="$KERNELS ${KPATH}/v3.3.8-quantal/linux-headers-3.3.8-030308_3.3.8-030308.201206041356_all.deb"
-KERNELS="$KERNELS ${KPATH}/v3.4.64-quantal/linux-headers-3.4.64-030464_3.4.64-030464.201310011353_all.deb"
+KERNELS="$KERNELS ${KPATH}/v3.4.67-quantal/linux-headers-3.4.67-030467_3.4.67-030467.201310220531_all.deb"
 KERNELS="$KERNELS ${KPATH}/v3.5.7.12-quantal/linux-headers-3.5.7-03050712_3.5.7-03050712.201305111435_all.deb"
 KERNELS="$KERNELS ${KPATH}/v3.6.11-raring/linux-headers-3.6.11-030611_3.6.11-030611.201212171335_all.deb"
 KERNELS="$KERNELS ${KPATH}/v3.7.10-raring/linux-headers-3.7.10-030710_3.7.10-030710.201302271235_all.deb"
 KERNELS="$KERNELS ${KPATH}/v3.8.13-raring/linux-headers-3.8.13-030813_3.8.13-030813.201305111843_all.deb"
 KERNELS="$KERNELS ${KPATH}/v3.9.11-saucy/linux-headers-3.9.11-030911_3.9.11-030911.201307202035_all.deb"
-KERNELS="$KERNELS ${KPATH}/v3.10.14-saucy/linux-headers-3.10.14-031014_3.10.14-031014.201310011335_all.deb"
-KERNELS="$KERNELS ${KPATH}/v3.11.3-saucy/linux-headers-3.11.3-031103_3.11.3-031103.201310011421_all.deb"
-KERNELS="$KERNELS ${KPATH}/v3.12-rc3-saucy/linux-headers-3.12.0-031200rc3_3.12.0-031200rc3.201309291835_all.deb"
+KERNELS="$KERNELS ${KPATH}/v3.10.17-saucy/linux-headers-3.10.17-031017_3.10.17-031017.201310181435_all.deb"
+KERNELS="$KERNELS ${KPATH}/v3.11.6-saucy/linux-headers-3.11.6-031106_3.11.6-031106.201310181453_all.deb"
+KERNELS="$KERNELS ${KPATH}/v3.12-rc7-saucy/linux-headers-3.12.0-031200rc7_3.12.0-031200rc7.201310271935_all.deb"
 
 # Number of kernels
 NUM_KERNELS=$(echo $KERNELS | wc -w)
-- 
1.7.10.4

