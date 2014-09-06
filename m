Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:48076 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751930AbaIFTog (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 6 Sep 2014 15:44:36 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 3/5] backports: update test kernel versions
Date: Sat,  6 Sep 2014 21:44:17 +0200
Message-Id: <1410032659-30404-4-git-send-email-hauke@hauke-m.de> (sfid-20140906_214439_915468_32BAF6D2)
In-Reply-To: <1410032659-30404-1-git-send-email-hauke@hauke-m.de>
References: <1410032659-30404-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 devel/backports-update-manager | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/devel/backports-update-manager b/devel/backports-update-manager
index b584ca0..50f8005 100755
--- a/devel/backports-update-manager
+++ b/devel/backports-update-manager
@@ -27,19 +27,20 @@ KERNEL_URLS = [
     KPATH + "v3.1.10-precise/linux-headers-3.1.10-030110_3.1.10-030110.201201181135_all.deb",
     KPATH + "v3.2.62-precise/linux-headers-3.2.62-030262_3.2.62-030262.201408061435_all.deb",
     KPATH + "v3.3.8-quantal/linux-headers-3.3.8-030308_3.3.8-030308.201206041356_all.deb",
-    KPATH + "v3.4.102-quantal/linux-headers-3.4.102-0304102_3.4.102-0304102.201408071853_all.deb",
+    KPATH + "v3.4.103-quantal/linux-headers-3.4.103-0304103_3.4.103-0304103.201408132135_all.deb",
     KPATH + "v3.5.7.12-quantal/linux-headers-3.5.7-03050712_3.5.7-03050712.201305111435_all.deb",
     KPATH + "v3.6.11-raring/linux-headers-3.6.11-030611_3.6.11-030611.201212171335_all.deb",
     KPATH + "v3.7.10-raring/linux-headers-3.7.10-030710_3.7.10-030710.201302271235_all.deb",
     KPATH + "v3.8.13-raring/linux-headers-3.8.13-030813_3.8.13-030813.201305111843_all.deb",
     KPATH + "v3.9.11-saucy/linux-headers-3.9.11-030911_3.9.11-030911.201307202035_all.deb",
-    KPATH + "v3.10.52-saucy/linux-headers-3.10.52-031052_3.10.52-031052.201408071835_all.deb",
+    KPATH + "v3.10.54-saucy/linux-headers-3.10.54-031054_3.10.54-031054.201409060145_all.deb",
     KPATH + "v3.11.10-saucy/linux-headers-3.11.10-031110_3.11.10-031110.201311291453_all.deb",
-    KPATH + "v3.12.26-trusty/linux-headers-3.12.26-031226_3.12.26-031226.201408011335_all.deb",
+    KPATH + "v3.12.27-trusty/linux-headers-3.12.27-031227_3.12.27-031227.201408271535_all.deb",
     KPATH + "v3.13.11-trusty/linux-headers-3.13.11-031311_3.13.11-031311.201404222035_all.deb",
-    KPATH + "v3.14.16-utopic/linux-headers-3.14.16-031416_3.14.16-031416.201408072035_all.deb",
-    KPATH + "v3.15.7-utopic/linux-headers-3.15.7-031507_3.15.7-031507.201407281235_all.deb",
-    KPATH + "v3.16-utopic/linux-headers-3.16.0-031600_3.16.0-031600.201408031935_all.deb"
+    KPATH + "v3.14.18-utopic/linux-headers-3.14.18-031418_3.14.18-031418.201409060201_all.deb",
+    KPATH + "v3.15.10-utopic/linux-headers-3.15.10-031510_3.15.10-031510.201408132333_all.deb",
+    KPATH + "v3.16.2-utopic/linux-headers-3.16.2-031602_3.16.2-031602.201409052035_all.deb",
+    KPATH + "v3.17-rc3-utopic/linux-headers-3.17.0-031700rc3_3.17.0-031700rc3.201409031132_all.deb"
 ]
 
 NUM_KERNELS=len(KERNEL_URLS)
-- 
1.9.1

