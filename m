Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:36606 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753149AbaLURgo (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 21 Dec 2014 12:36:44 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH v2 16/16] devel: update the test kernels
Date: Sun, 21 Dec 2014 18:36:30 +0100
Message-Id: <1419183390-22169-17-git-send-email-hauke@hauke-m.de> (sfid-20141221_184348_291625_1EBB44E4)
In-Reply-To: <1419183390-22169-1-git-send-email-hauke@hauke-m.de>
References: <1419183390-22169-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 devel/backports-update-manager | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/devel/backports-update-manager b/devel/backports-update-manager
index b6c7e07..d7f1379 100755
--- a/devel/backports-update-manager
+++ b/devel/backports-update-manager
@@ -25,23 +25,24 @@ SPACE_PER_KERNEL_DEB=13
 KERNEL_URLS = [
     KPATH + "v3.0.101-oneiric/linux-headers-3.0.101-0300101_3.0.101-0300101.201310220446_all.deb",
     KPATH + "v3.1.10-precise/linux-headers-3.1.10-030110_3.1.10-030110.201201181135_all.deb",
-    KPATH + "v3.2.62-precise/linux-headers-3.2.62-030262_3.2.62-030262.201408061435_all.deb",
+    KPATH + "v3.2.65-precise/linux-headers-3.2.65-030265_3.2.65-030265.201412141435_all.deb",
     KPATH + "v3.3.8-quantal/linux-headers-3.3.8-030308_3.3.8-030308.201206041356_all.deb",
-    KPATH + "v3.4.104-quantal/linux-headers-3.4.104-0304104_3.4.104-0304104.201409250437_all.deb",
+    KPATH + "v3.4.105-quantal/linux-headers-3.4.105-0304105_3.4.105-0304105.201412012335_all.deb",
     KPATH + "v3.5.7.12-quantal/linux-headers-3.5.7-03050712_3.5.7-03050712.201305111435_all.deb",
     KPATH + "v3.6.11-raring/linux-headers-3.6.11-030611_3.6.11-030611.201212171335_all.deb",
     KPATH + "v3.7.10-raring/linux-headers-3.7.10-030710_3.7.10-030710.201302271235_all.deb",
     KPATH + "v3.8.13-raring/linux-headers-3.8.13-030813_3.8.13-030813.201305111843_all.deb",
     KPATH + "v3.9.11-saucy/linux-headers-3.9.11-030911_3.9.11-030911.201307202035_all.deb",
-    KPATH + "v3.10.58-saucy/linux-headers-3.10.58-031058_3.10.58-031058.201410150335_all.deb",
+    KPATH + "v3.10.63-saucy/linux-headers-3.10.63-031063_3.10.63-031063.201412170822_all.deb",
     KPATH + "v3.11.10-saucy/linux-headers-3.11.10-031110_3.11.10-031110.201311291453_all.deb",
-    KPATH + "v3.12.31-trusty/linux-headers-3.12.31-031231_3.12.31-031231.201410240535_all.deb",
+    KPATH + "v3.12.35-trusty/linux-headers-3.12.35-031235_3.12.35-031235.201412101835_all.deb",
     KPATH + "v3.13.11-trusty/linux-headers-3.13.11-031311_3.13.11-031311.201404222035_all.deb",
-    KPATH + "v3.14.22-utopic/linux-headers-3.14.22-031422_3.14.22-031422.201410150835_all.deb",
+    KPATH + "v3.14.27-utopic/linux-headers-3.14.27-031427_3.14.27-031427.201412170558_all.deb",
     KPATH + "v3.15.10-utopic/linux-headers-3.15.10-031510_3.15.10-031510.201408132333_all.deb",
     KPATH + "v3.16.6-utopic/linux-headers-3.16.6-031606_3.16.6-031606.201410150635_all.deb",
-    KPATH + "v3.17.1-utopic/linux-headers-3.17.1-031701_3.17.1-031701.201410150735_all.deb",
-    KPATH + "v3.18-rc1-utopic/linux-headers-3.18.0-031800rc1_3.18.0-031800rc1.201410192135_all.deb"
+    KPATH + "v3.17.7-vivid/linux-headers-3.17.7-031707_3.17.7-031707.201412170731_all.deb",
+    KPATH + "v3.18.1-vivid/linux-headers-3.18.1-031801_3.18.1-031801.201412170637_all.deb",
+    KPATH + "v3.19-rc1-vivid/linux-headers-3.19.0-031900rc1_3.19.0-031900rc1.201412210135_all.deb"
 ]
 
 NUM_KERNELS=len(KERNEL_URLS)
-- 
1.9.1

