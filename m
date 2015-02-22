Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:58773 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751897AbbBVBmW (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 21 Feb 2015 20:42:22 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 5/6] devel: update the test kernels
Date: Sun, 22 Feb 2015 02:42:07 +0100
Message-Id: <1424569328-12514-6-git-send-email-hauke@hauke-m.de> (sfid-20150222_024226_016266_A46CC5AC)
In-Reply-To: <1424569328-12514-1-git-send-email-hauke@hauke-m.de>
References: <1424569328-12514-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 devel/backports-update-manager | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/devel/backports-update-manager b/devel/backports-update-manager
index d7f1379..20cc0ba 100755
--- a/devel/backports-update-manager
+++ b/devel/backports-update-manager
@@ -25,24 +25,24 @@ SPACE_PER_KERNEL_DEB=13
 KERNEL_URLS = [
     KPATH + "v3.0.101-oneiric/linux-headers-3.0.101-0300101_3.0.101-0300101.201310220446_all.deb",
     KPATH + "v3.1.10-precise/linux-headers-3.1.10-030110_3.1.10-030110.201201181135_all.deb",
-    KPATH + "v3.2.65-precise/linux-headers-3.2.65-030265_3.2.65-030265.201412141435_all.deb",
+    KPATH + "v3.2.67-precise/linux-headers-3.2.67-030267_3.2.67-030267.201502200641_all.deb",
     KPATH + "v3.3.8-quantal/linux-headers-3.3.8-030308_3.3.8-030308.201206041356_all.deb",
-    KPATH + "v3.4.105-quantal/linux-headers-3.4.105-0304105_3.4.105-0304105.201412012335_all.deb",
+    KPATH + "v3.4.106-quantal/linux-headers-3.4.106-0304106_3.4.106-0304106.201502031340_all.deb",
     KPATH + "v3.5.7.12-quantal/linux-headers-3.5.7-03050712_3.5.7-03050712.201305111435_all.deb",
     KPATH + "v3.6.11-raring/linux-headers-3.6.11-030611_3.6.11-030611.201212171335_all.deb",
     KPATH + "v3.7.10-raring/linux-headers-3.7.10-030710_3.7.10-030710.201302271235_all.deb",
     KPATH + "v3.8.13-raring/linux-headers-3.8.13-030813_3.8.13-030813.201305111843_all.deb",
     KPATH + "v3.9.11-saucy/linux-headers-3.9.11-030911_3.9.11-030911.201307202035_all.deb",
-    KPATH + "v3.10.63-saucy/linux-headers-3.10.63-031063_3.10.63-031063.201412170822_all.deb",
+    KPATH + "v3.10.69-saucy/linux-headers-3.10.69-031069_3.10.69-031069.201502110743_all.deb",
     KPATH + "v3.11.10-saucy/linux-headers-3.11.10-031110_3.11.10-031110.201311291453_all.deb",
-    KPATH + "v3.12.35-trusty/linux-headers-3.12.35-031235_3.12.35-031235.201412101835_all.deb",
+    KPATH + "v3.12.38-trusty/linux-headers-3.12.38-031238_3.12.38-031238.201502200135_all.deb",
     KPATH + "v3.13.11-trusty/linux-headers-3.13.11-031311_3.13.11-031311.201404222035_all.deb",
-    KPATH + "v3.14.27-utopic/linux-headers-3.14.27-031427_3.14.27-031427.201412170558_all.deb",
+    KPATH + "v3.14.33-utopic/linux-headers-3.14.33-031433_3.14.33-031433.201502110235_all.deb",
     KPATH + "v3.15.10-utopic/linux-headers-3.15.10-031510_3.15.10-031510.201408132333_all.deb",
-    KPATH + "v3.16.6-utopic/linux-headers-3.16.6-031606_3.16.6-031606.201410150635_all.deb",
-    KPATH + "v3.17.7-vivid/linux-headers-3.17.7-031707_3.17.7-031707.201412170731_all.deb",
-    KPATH + "v3.18.1-vivid/linux-headers-3.18.1-031801_3.18.1-031801.201412170637_all.deb",
-    KPATH + "v3.19-rc1-vivid/linux-headers-3.19.0-031900rc1_3.19.0-031900rc1.201412210135_all.deb"
+    KPATH + "v3.16.7-utopic/linux-headers-3.16.7-031607_3.16.7-031607.201410301735_all.deb",
+    KPATH + "v3.17.8-vivid/linux-headers-3.17.8-031708_3.17.8-031708.201501081837_all.deb",
+    KPATH + "v3.18.7-vivid/linux-headers-3.18.7-031807_3.18.7-031807.201502110759_all.deb",
+    KPATH + "v3.19-vivid/linux-headers-3.19.0-031900_3.19.0-031900.201502091451_all.deb"
 ]
 
 NUM_KERNELS=len(KERNEL_URLS)
-- 
1.9.1

