Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:49904 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752466AbcBLN7x (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 12 Feb 2016 08:59:53 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 5/5] devel: update test kernel versions
Date: Fri, 12 Feb 2016 14:58:39 +0100
Message-Id: <1455285519-16163-6-git-send-email-hauke@hauke-m.de> (sfid-20160212_145957_684697_2FA27024)
In-Reply-To: <1455285519-16163-1-git-send-email-hauke@hauke-m.de>
References: <1455285519-16163-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 devel/backports-update-manager | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/devel/backports-update-manager b/devel/backports-update-manager
index 99a4c6c..39f5e31 100755
--- a/devel/backports-update-manager
+++ b/devel/backports-update-manager
@@ -26,7 +26,7 @@ SPACE_PER_KERNEL_DEB=13
 KERNEL_URLS = [
     KPATH + "v3.0.101-oneiric/linux-headers-3.0.101-0300101_3.0.101-0300101.201310220446_all.deb",
     KPATH + "v3.1.10-precise/linux-headers-3.1.10-030110_3.1.10-030110.201201181135_all.deb",
-    KPATH + "v3.2.74-precise/linux-headers-3.2.74-030274_3.2.74-030274.201511272234_all.deb",
+    KPATH + "v3.2.76-precise/linux-headers-3.2.76-030276_3.2.76-030276.201601230132_all.deb",
     KPATH + "v3.3.8-quantal/linux-headers-3.3.8-030308_3.3.8-030308.201206041356_all.deb",
     KPATH + "v3.4.110-quantal/linux-headers-3.4.110-0304110_3.4.110-0304110.201510220333_all.deb",
     KPATH + "v3.5.7.12-quantal/linux-headers-3.5.7-03050712_3.5.7-03050712.201305111435_all.deb",
@@ -34,21 +34,22 @@ KERNEL_URLS = [
     KPATH + "v3.7.10-raring/linux-headers-3.7.10-030710_3.7.10-030710.201302271235_all.deb",
     KPATH + "v3.8.13-raring/linux-headers-3.8.13-030813_3.8.13-030813.201305111843_all.deb",
     KPATH + "v3.9.11-saucy/linux-headers-3.9.11-030911_3.9.11-030911.201307202035_all.deb",
-    KPATH + "v3.10.93-precise/linux-headers-3.10.93-031093_3.10.93-031093.201511092122_all.deb",
+    KPATH + "v3.10.96-precise/linux-headers-3.10.96-031096_3.10.96-031096.201601290140_all.deb",
     KPATH + "v3.11.10-saucy/linux-headers-3.11.10-031110_3.11.10-031110.201311291453_all.deb",
-    KPATH + "v3.12.51-trusty/linux-headers-3.12.51-031251_3.12.51-031251.201511272233_all.deb",
+    KPATH + "v3.12.53-trusty/linux-headers-3.12.53-031253_3.12.53-031253.201601271331_all.deb",
     KPATH + "v3.13.11-trusty/linux-headers-3.13.11-031311_3.13.11-031311.201404222035_all.deb",
-    KPATH + "v3.14.57-trusty/linux-headers-3.14.57-031457_3.14.57-031457.201511091731_all.deb",
+    KPATH + "v3.14.60-trusty/linux-headers-3.14.60-031460_3.14.60-031460.201601290231_all.deb",
     KPATH + "v3.15.10-utopic/linux-headers-3.15.10-031510_3.15.10-031510.201408132333_all.deb",
     KPATH + "v3.16.7-utopic/linux-headers-3.16.7-031607_3.16.7-031607.201410301735_all.deb",
     KPATH + "v3.17.8-vivid/linux-headers-3.17.8-031708_3.17.8-031708.201501081837_all.deb",
-    KPATH + "v3.18.24-vivid/linux-headers-3.18.24-031824_3.18.24-031824.201511031331_all.deb",
+    KPATH + "v3.18.26-vivid/linux-headers-3.18.26-031826_3.18.26-031826.201601251330_all.deb",
     KPATH + "v3.19.8-vivid/linux-headers-3.19.8-031908_3.19.8-031908.201505110938_all.deb",
     KPATH + "v4.0.9-wily/linux-headers-4.0.9-040009_4.0.9-040009.201507212131_all.deb",
-    KPATH + "v4.1.13-wily/linux-headers-4.1.13-040113_4.1.13-040113.201511092325_all.deb",
-    KPATH + "v4.2.6-wily/linux-headers-4.2.6-040206_4.2.6-040206.201511091832_all.deb",
-    KPATH + "v4.3-wily/linux-headers-4.3.0-040300_4.3.0-040300.201511020949_all.deb",
-    KPATH + "v4.4-rc3-wily/linux-headers-4.4.0-040400rc3_4.4.0-040400rc3.201511300321_all.deb"
+    KPATH + "v4.1.17-wily/linux-headers-4.1.17-040117_4.1.17-040117.201601311534_all.deb",
+    KPATH + "v4.2.8-wily/linux-headers-4.2.8-040208_4.2.8-040208.201512150620_all.deb",
+    KPATH + "v4.3.5-wily/linux-headers-4.3.5-040305_4.3.5-040305.201601311533_all.deb",
+    KPATH + "v4.4.1-wily/linux-headers-4.4.1-040401_4.4.1-040401.201601311534_all.deb",
+    KPATH + "v4.5-rc3-wily/linux-headers-4.5.0-040500rc3_4.5.0-040500rc3.201602071930_all.deb"
 ]
 
 NUM_KERNELS=len(KERNEL_URLS)
-- 
2.7.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
