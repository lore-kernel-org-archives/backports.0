Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:35753 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753386AbbINHtB (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 14 Sep 2015 03:49:01 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 09/10] devel: update test kernel versions
Date: Mon, 14 Sep 2015 09:48:41 +0200
Message-Id: <1442216922-3318-10-git-send-email-hauke@hauke-m.de> (sfid-20150914_094907_117017_E2BE2C6A)
In-Reply-To: <1442216922-3318-1-git-send-email-hauke@hauke-m.de>
References: <1442216922-3318-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 devel/backports-update-manager | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/devel/backports-update-manager b/devel/backports-update-manager
index 9e171ab..f7f6b81 100755
--- a/devel/backports-update-manager
+++ b/devel/backports-update-manager
@@ -26,7 +26,7 @@ SPACE_PER_KERNEL_DEB=13
 KERNEL_URLS = [
     KPATH + "v3.0.101-oneiric/linux-headers-3.0.101-0300101_3.0.101-0300101.201310220446_all.deb",
     KPATH + "v3.1.10-precise/linux-headers-3.1.10-030110_3.1.10-030110.201201181135_all.deb",
-    KPATH + "v3.2.69-precise/linux-headers-3.2.69-030269_3.2.69-030269.201505100136_all.deb",
+    KPATH + "v3.2.71-precise/linux-headers-3.2.71-030271_3.2.71-030271.201508141530_all.deb",
     KPATH + "v3.3.8-quantal/linux-headers-3.3.8-030308_3.3.8-030308.201206041356_all.deb",
     KPATH + "v3.4.108-quantal/linux-headers-3.4.108-0304108_3.4.108-0304108.201506191442_all.deb",
     KPATH + "v3.5.7.12-quantal/linux-headers-3.5.7-03050712_3.5.7-03050712.201305111435_all.deb",
@@ -34,19 +34,19 @@ KERNEL_URLS = [
     KPATH + "v3.7.10-raring/linux-headers-3.7.10-030710_3.7.10-030710.201302271235_all.deb",
     KPATH + "v3.8.13-raring/linux-headers-3.8.13-030813_3.8.13-030813.201305111843_all.deb",
     KPATH + "v3.9.11-saucy/linux-headers-3.9.11-030911_3.9.11-030911.201307202035_all.deb",
-    KPATH + "v3.10.84-saucy/linux-headers-3.10.84-031084_3.10.84-031084.201507101935_all.deb",
+    KPATH + "v3.10.88-saucy/linux-headers-3.10.88-031088_3.10.88-031088.201509131337_all.deb",
     KPATH + "v3.11.10-saucy/linux-headers-3.11.10-031110_3.11.10-031110.201311291453_all.deb",
-    KPATH + "v3.12.44-trusty/linux-headers-3.12.44-031244_3.12.44-031244.201506151235_all.deb",
+    KPATH + "v3.12.47-trusty/linux-headers-3.12.47-031247_3.12.47-031247.201508281031_all.deb",
     KPATH + "v3.13.11-trusty/linux-headers-3.13.11-031311_3.13.11-031311.201404222035_all.deb",
-    KPATH + "v3.14.48-utopic/linux-headers-3.14.48-031448_3.14.48-031448.201507101835_all.deb",
+    KPATH + "v3.14.52-utopic/linux-headers-3.14.52-031452_3.14.52-031452.201509131726_all.deb",
     KPATH + "v3.15.10-utopic/linux-headers-3.15.10-031510_3.15.10-031510.201408132333_all.deb",
     KPATH + "v3.16.7-utopic/linux-headers-3.16.7-031607_3.16.7-031607.201410301735_all.deb",
     KPATH + "v3.17.8-vivid/linux-headers-3.17.8-031708_3.17.8-031708.201501081837_all.deb",
-    KPATH + "v3.18.19-vivid/linux-headers-3.18.19-031819_3.18.19-031819.201507220230_all.deb",
+    KPATH + "v3.18.21-vivid/linux-headers-3.18.21-031821_3.18.21-031821.201509020527_all.deb",
     KPATH + "v3.19.8-vivid/linux-headers-3.19.8-031908_3.19.8-031908.201505110938_all.deb",
     KPATH + "v4.0.9-wily/linux-headers-4.0.9-040009_4.0.9-040009.201507212131_all.deb",
-    KPATH + "v4.1.3-unstable/linux-headers-4.1.3-040103_4.1.3-040103.201507220129_all.deb",
-    KPATH + "v4.2-rc3-unstable/linux-headers-4.2.0-040200rc3_4.2.0-040200rc3.201507192329_all.deb"
+    KPATH + "v4.1.7-unstable/linux-headers-4.1.7-040107_4.1.7-040107.201509131330_all.deb",
+    KPATH + "v4.2-unstable/linux-headers-4.2.0-040200_4.2.0-040200.201508301530_all.deb"
 ]
 
 NUM_KERNELS=len(KERNEL_URLS)
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe backports" in
