Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:46328 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752027AbbKAXpf (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 1 Nov 2015 18:45:35 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 3/3] devel: update the test kernel versions
Date: Mon,  2 Nov 2015 00:45:22 +0100
Message-Id: <1446421522-27167-3-git-send-email-hauke@hauke-m.de> (sfid-20151102_004538_136717_E0405B12)
In-Reply-To: <1446421522-27167-1-git-send-email-hauke@hauke-m.de>
References: <1446421522-27167-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 devel/backports-update-manager | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/devel/backports-update-manager b/devel/backports-update-manager
index f7f6b81..afe2321 100755
--- a/devel/backports-update-manager
+++ b/devel/backports-update-manager
@@ -26,27 +26,28 @@ SPACE_PER_KERNEL_DEB=13
 KERNEL_URLS = [
     KPATH + "v3.0.101-oneiric/linux-headers-3.0.101-0300101_3.0.101-0300101.201310220446_all.deb",
     KPATH + "v3.1.10-precise/linux-headers-3.1.10-030110_3.1.10-030110.201201181135_all.deb",
-    KPATH + "v3.2.71-precise/linux-headers-3.2.71-030271_3.2.71-030271.201508141530_all.deb",
+    KPATH + "v3.2.72-precise/linux-headers-3.2.72-030272_3.2.72-030272.201510131235_all.deb",
     KPATH + "v3.3.8-quantal/linux-headers-3.3.8-030308_3.3.8-030308.201206041356_all.deb",
-    KPATH + "v3.4.108-quantal/linux-headers-3.4.108-0304108_3.4.108-0304108.201506191442_all.deb",
+    KPATH + "v3.4.110-quantal/linux-headers-3.4.110-0304110_3.4.110-0304110.201510220333_all.deb",
     KPATH + "v3.5.7.12-quantal/linux-headers-3.5.7-03050712_3.5.7-03050712.201305111435_all.deb",
     KPATH + "v3.6.11-raring/linux-headers-3.6.11-030611_3.6.11-030611.201212171335_all.deb",
     KPATH + "v3.7.10-raring/linux-headers-3.7.10-030710_3.7.10-030710.201302271235_all.deb",
     KPATH + "v3.8.13-raring/linux-headers-3.8.13-030813_3.8.13-030813.201305111843_all.deb",
     KPATH + "v3.9.11-saucy/linux-headers-3.9.11-030911_3.9.11-030911.201307202035_all.deb",
-    KPATH + "v3.10.88-saucy/linux-headers-3.10.88-031088_3.10.88-031088.201509131337_all.deb",
+    KPATH + "v3.10.92-saucy/linux-headers-3.10.92-031092_3.10.92-031092.201510262203_all.deb",
     KPATH + "v3.11.10-saucy/linux-headers-3.11.10-031110_3.11.10-031110.201311291453_all.deb",
-    KPATH + "v3.12.47-trusty/linux-headers-3.12.47-031247_3.12.47-031247.201508281031_all.deb",
+    KPATH + "v3.12.49-trusty/linux-headers-3.12.49-031249_3.12.49-031249.201510071331_all.deb",
     KPATH + "v3.13.11-trusty/linux-headers-3.13.11-031311_3.13.11-031311.201404222035_all.deb",
-    KPATH + "v3.14.52-utopic/linux-headers-3.14.52-031452_3.14.52-031452.201509131726_all.deb",
+    KPATH + "v3.14.56-utopic/linux-headers-3.14.56-031456_3.14.56-031456.201510262131_all.deb",
     KPATH + "v3.15.10-utopic/linux-headers-3.15.10-031510_3.15.10-031510.201408132333_all.deb",
     KPATH + "v3.16.7-utopic/linux-headers-3.16.7-031607_3.16.7-031607.201410301735_all.deb",
     KPATH + "v3.17.8-vivid/linux-headers-3.17.8-031708_3.17.8-031708.201501081837_all.deb",
-    KPATH + "v3.18.21-vivid/linux-headers-3.18.21-031821_3.18.21-031821.201509020527_all.deb",
+    KPATH + "v3.18.23-vivid/linux-headers-3.18.23-031823_3.18.23-031823.201510291931_all.deb",
     KPATH + "v3.19.8-vivid/linux-headers-3.19.8-031908_3.19.8-031908.201505110938_all.deb",
     KPATH + "v4.0.9-wily/linux-headers-4.0.9-040009_4.0.9-040009.201507212131_all.deb",
-    KPATH + "v4.1.7-unstable/linux-headers-4.1.7-040107_4.1.7-040107.201509131330_all.deb",
-    KPATH + "v4.2-unstable/linux-headers-4.2.0-040200_4.2.0-040200.201508301530_all.deb"
+    KPATH + "v4.1.12-wily/linux-headers-4.1.12-040112_4.1.12-040112.201510262131_all.deb",
+    KPATH + "v4.2.5-wily/linux-headers-4.2.5-040205_4.2.5-040205.201510270124_all.deb",
+    KPATH + "v4.3-rc7-unstable/linux-headers-4.3.0-040300rc7_4.3.0-040300rc7.201510260712_all.deb"
 ]
 
 NUM_KERNELS=len(KERNEL_URLS)
-- 
2.6.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
