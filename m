Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:39192 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752284AbbDCRY2 (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 3 Apr 2015 13:24:28 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 11/11] devel: update the test kernels
Date: Fri,  3 Apr 2015 19:15:42 +0200
Message-Id: <1428081342-5933-12-git-send-email-hauke@hauke-m.de> (sfid-20150403_192433_794348_FB276950)
In-Reply-To: <1428081342-5933-1-git-send-email-hauke@hauke-m.de>
References: <1428081342-5933-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 devel/backports-update-manager | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/devel/backports-update-manager b/devel/backports-update-manager
index 20cc0ba..8485875 100755
--- a/devel/backports-update-manager
+++ b/devel/backports-update-manager
@@ -25,7 +25,7 @@ SPACE_PER_KERNEL_DEB=13
 KERNEL_URLS = [
     KPATH + "v3.0.101-oneiric/linux-headers-3.0.101-0300101_3.0.101-0300101.201310220446_all.deb",
     KPATH + "v3.1.10-precise/linux-headers-3.1.10-030110_3.1.10-030110.201201181135_all.deb",
-    KPATH + "v3.2.67-precise/linux-headers-3.2.67-030267_3.2.67-030267.201502200641_all.deb",
+    KPATH + "v3.2.68-precise/linux-headers-3.2.68-030268_3.2.68-030268.201503061936_all.deb",
     KPATH + "v3.3.8-quantal/linux-headers-3.3.8-030308_3.3.8-030308.201206041356_all.deb",
     KPATH + "v3.4.106-quantal/linux-headers-3.4.106-0304106_3.4.106-0304106.201502031340_all.deb",
     KPATH + "v3.5.7.12-quantal/linux-headers-3.5.7-03050712_3.5.7-03050712.201305111435_all.deb",
@@ -33,16 +33,17 @@ KERNEL_URLS = [
     KPATH + "v3.7.10-raring/linux-headers-3.7.10-030710_3.7.10-030710.201302271235_all.deb",
     KPATH + "v3.8.13-raring/linux-headers-3.8.13-030813_3.8.13-030813.201305111843_all.deb",
     KPATH + "v3.9.11-saucy/linux-headers-3.9.11-030911_3.9.11-030911.201307202035_all.deb",
-    KPATH + "v3.10.69-saucy/linux-headers-3.10.69-031069_3.10.69-031069.201502110743_all.deb",
+    KPATH + "v3.10.73-saucy/linux-headers-3.10.73-031073_3.10.73-031073.201503261540_all.deb",
     KPATH + "v3.11.10-saucy/linux-headers-3.11.10-031110_3.11.10-031110.201311291453_all.deb",
-    KPATH + "v3.12.38-trusty/linux-headers-3.12.38-031238_3.12.38-031238.201502200135_all.deb",
+    KPATH + "v3.12.39-trusty/linux-headers-3.12.39-031239_3.12.39-031239.201503190941_all.deb",
     KPATH + "v3.13.11-trusty/linux-headers-3.13.11-031311_3.13.11-031311.201404222035_all.deb",
-    KPATH + "v3.14.33-utopic/linux-headers-3.14.33-031433_3.14.33-031433.201502110235_all.deb",
+    KPATH + "v3.14.37-utopic/linux-headers-3.14.37-031437_3.14.37-031437.201503261136_all.deb",
     KPATH + "v3.15.10-utopic/linux-headers-3.15.10-031510_3.15.10-031510.201408132333_all.deb",
     KPATH + "v3.16.7-utopic/linux-headers-3.16.7-031607_3.16.7-031607.201410301735_all.deb",
     KPATH + "v3.17.8-vivid/linux-headers-3.17.8-031708_3.17.8-031708.201501081837_all.deb",
-    KPATH + "v3.18.7-vivid/linux-headers-3.18.7-031807_3.18.7-031807.201502110759_all.deb",
-    KPATH + "v3.19-vivid/linux-headers-3.19.0-031900_3.19.0-031900.201502091451_all.deb"
+    KPATH + "v3.18.10-vivid/linux-headers-3.18.10-031810_3.18.10-031810.201503241436_all.deb",
+    KPATH + "v3.19.3-vivid/linux-headers-3.19.3-031903_3.19.3-031903.201503261036_all.deb",
+    KPATH + "v4.0-rc6-vivid/linux-headers-4.0.0-040000rc6_4.0.0-040000rc6.201503291935_all.deb"
 ]
 
 NUM_KERNELS=len(KERNEL_URLS)
-- 
1.9.1

