Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:56141 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752095AbbGKVeR (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 11 Jul 2015 17:34:17 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 3/3] devel: update the test kernel versions
Date: Sat, 11 Jul 2015 23:34:10 +0200
Message-Id: <1436650450-2696-4-git-send-email-hauke@hauke-m.de> (sfid-20150711_233420_821592_4A889649)
In-Reply-To: <1436650450-2696-1-git-send-email-hauke@hauke-m.de>
References: <1436650450-2696-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 devel/backports-update-manager | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/devel/backports-update-manager b/devel/backports-update-manager
index 228916d..1c3567d 100755
--- a/devel/backports-update-manager
+++ b/devel/backports-update-manager
@@ -26,26 +26,27 @@ SPACE_PER_KERNEL_DEB=13
 KERNEL_URLS = [
     KPATH + "v3.0.101-oneiric/linux-headers-3.0.101-0300101_3.0.101-0300101.201310220446_all.deb",
     KPATH + "v3.1.10-precise/linux-headers-3.1.10-030110_3.1.10-030110.201201181135_all.deb",
-    KPATH + "v3.2.68-precise/linux-headers-3.2.68-030268_3.2.68-030268.201503061936_all.deb",
+    KPATH + "v3.2.69-precise/linux-headers-3.2.69-030269_3.2.69-030269.201505100136_all.deb",
     KPATH + "v3.3.8-quantal/linux-headers-3.3.8-030308_3.3.8-030308.201206041356_all.deb",
-    KPATH + "v3.4.107-quantal/linux-headers-3.4.107-0304107_3.4.107-0304107.201504210712_all.deb",
+    KPATH + "v3.4.108-quantal/linux-headers-3.4.108-0304108_3.4.108-0304108.201506191442_all.deb",
     KPATH + "v3.5.7.12-quantal/linux-headers-3.5.7-03050712_3.5.7-03050712.201305111435_all.deb",
     KPATH + "v3.6.11-raring/linux-headers-3.6.11-030611_3.6.11-030611.201212171335_all.deb",
     KPATH + "v3.7.10-raring/linux-headers-3.7.10-030710_3.7.10-030710.201302271235_all.deb",
     KPATH + "v3.8.13-raring/linux-headers-3.8.13-030813_3.8.13-030813.201305111843_all.deb",
     KPATH + "v3.9.11-saucy/linux-headers-3.9.11-030911_3.9.11-030911.201307202035_all.deb",
-    KPATH + "v3.10.75-saucy/linux-headers-3.10.75-031075_3.10.75-031075.201504211105_all.deb",
+    KPATH + "v3.10.84-saucy/linux-headers-3.10.84-031084_3.10.84-031084.201507101935_all.deb",
     KPATH + "v3.11.10-saucy/linux-headers-3.11.10-031110_3.11.10-031110.201311291453_all.deb",
-    KPATH + "v3.12.40-trusty/linux-headers-3.12.40-031240_3.12.40-031240.201504091735_all.deb",
+    KPATH + "v3.12.44-trusty/linux-headers-3.12.44-031244_3.12.44-031244.201506151235_all.deb",
     KPATH + "v3.13.11-trusty/linux-headers-3.13.11-031311_3.13.11-031311.201404222035_all.deb",
-    KPATH + "v3.14.39-utopic/linux-headers-3.14.39-031439_3.14.39-031439.201504211206_all.deb",
+    KPATH + "v3.14.48-utopic/linux-headers-3.14.48-031448_3.14.48-031448.201507101835_all.deb",
     KPATH + "v3.15.10-utopic/linux-headers-3.15.10-031510_3.15.10-031510.201408132333_all.deb",
     KPATH + "v3.16.7-utopic/linux-headers-3.16.7-031607_3.16.7-031607.201410301735_all.deb",
     KPATH + "v3.17.8-vivid/linux-headers-3.17.8-031708_3.17.8-031708.201501081837_all.deb",
-    KPATH + "v3.18.12-vivid/linux-headers-3.18.12-031812_3.18.12-031812.201504221338_all.deb",
-    KPATH + "v3.19.5-vivid/linux-headers-3.19.5-031905_3.19.5-031905.201504211114_all.deb",
-    KPATH + "v4.0-vivid/linux-headers-4.0.0-040000_4.0.0-040000.201504121935_all.deb",
-    KPATH + "v4.1-rc8-unstable/linux-headers-4.1.0-040100rc8_4.1.0-040100rc8.201506150335_all.deb"
+    KPATH + "v3.18.18-vivid/linux-headers-3.18.18-031818_3.18.18-031818.201507101433_all.deb",
+    KPATH + "v3.19.8-vivid/linux-headers-3.19.8-031908_3.19.8-031908.201505110938_all.deb",
+    KPATH + "v4.0.8-wily/linux-headers-4.0.8-040008_4.0.8-040008.201507101735_all.deb",
+    KPATH + "v4.1.2-unstable/linux-headers-4.1.2-040102_4.1.2-040102.201507101335_all.deb",
+    KPATH + "v4.2-rc1-unstable/linux-headers-4.2.0-040200rc1_4.2.0-040200rc1.201507051635_all.deb"
 ]
 
 NUM_KERNELS=len(KERNEL_URLS)
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe backports" in
