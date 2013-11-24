Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:46827 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752373Ab3KXN2I (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 24 Nov 2013 08:28:08 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 1/3] backports: update test kernels
Date: Sun, 24 Nov 2013 14:27:44 +0100
Message-Id: <1385299666-18712-1-git-send-email-hauke@hauke-m.de> (sfid-20131124_142811_167117_30FED007)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Add kernel 3.13-rc1 and update the other kernel versions.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 devel/get-compat-kernels |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/devel/get-compat-kernels b/devel/get-compat-kernels
index 31f5e9c..c2a5066 100755
--- a/devel/get-compat-kernels
+++ b/devel/get-compat-kernels
@@ -58,15 +58,16 @@ KERNELS="$KERNELS ${KPATH}/v3.0.101-oneiric/linux-headers-3.0.101-0300101_3.0.10
 KERNELS="$KERNELS ${KPATH}/v3.1.10-precise/linux-headers-3.1.10-030110_3.1.10-030110.201201181135_all.deb"
 KERNELS="$KERNELS ${KPATH}/v3.2.52-precise/linux-headers-3.2.52-030252_3.2.52-030252.201310262335_all.deb"
 KERNELS="$KERNELS ${KPATH}/v3.3.8-quantal/linux-headers-3.3.8-030308_3.3.8-030308.201206041356_all.deb"
-KERNELS="$KERNELS ${KPATH}/v3.4.67-quantal/linux-headers-3.4.67-030467_3.4.67-030467.201310220531_all.deb"
+KERNELS="$KERNELS ${KPATH}/v3.4.70-quantal/linux-headers-3.4.70-030470_3.4.70-030470.201311201436_all.deb"
 KERNELS="$KERNELS ${KPATH}/v3.5.7.12-quantal/linux-headers-3.5.7-03050712_3.5.7-03050712.201305111435_all.deb"
 KERNELS="$KERNELS ${KPATH}/v3.6.11-raring/linux-headers-3.6.11-030611_3.6.11-030611.201212171335_all.deb"
 KERNELS="$KERNELS ${KPATH}/v3.7.10-raring/linux-headers-3.7.10-030710_3.7.10-030710.201302271235_all.deb"
 KERNELS="$KERNELS ${KPATH}/v3.8.13-raring/linux-headers-3.8.13-030813_3.8.13-030813.201305111843_all.deb"
 KERNELS="$KERNELS ${KPATH}/v3.9.11-saucy/linux-headers-3.9.11-030911_3.9.11-030911.201307202035_all.deb"
-KERNELS="$KERNELS ${KPATH}/v3.10.17-saucy/linux-headers-3.10.17-031017_3.10.17-031017.201310181435_all.deb"
-KERNELS="$KERNELS ${KPATH}/v3.11.6-saucy/linux-headers-3.11.6-031106_3.11.6-031106.201310181453_all.deb"
-KERNELS="$KERNELS ${KPATH}/v3.12-rc7-saucy/linux-headers-3.12.0-031200rc7_3.12.0-031200rc7.201310271935_all.deb"
+KERNELS="$KERNELS ${KPATH}/v3.10.20-saucy/linux-headers-3.10.20-031020_3.10.20-031020.201311201536_all.deb"
+KERNELS="$KERNELS ${KPATH}/v3.11.9-saucy/linux-headers-3.11.9-031109_3.11.9-031109.201311201635_all.deb"
+KERNELS="$KERNELS ${KPATH}/v3.12.1-trusty/linux-headers-3.12.1-031201_3.12.1-031201.201311201654_all.deb"
+KERNELS="$KERNELS ${KPATH}/v3.13-rc1-trusty/linux-headers-3.13.0-031300rc1_3.13.0-031300rc1.201311221535_all.deb"
 
 # Number of kernels
 NUM_KERNELS=$(echo $KERNELS | wc -w)
-- 
1.7.10.4

