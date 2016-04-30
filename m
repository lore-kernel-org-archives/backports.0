Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:49598 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751615AbcD3VBI (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 30 Apr 2016 17:01:08 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 15/16] devel: update test kernel versions
Date: Sat, 30 Apr 2016 23:00:47 +0200
Message-Id: <1462050048-8953-16-git-send-email-hauke@hauke-m.de> (sfid-20160430_230722_583381_621F1432)
In-Reply-To: <1462050048-8953-1-git-send-email-hauke@hauke-m.de>
References: <1462050048-8953-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 devel/backports-update-manager | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/devel/backports-update-manager b/devel/backports-update-manager
index 39f5e31..6dff50d 100755
--- a/devel/backports-update-manager
+++ b/devel/backports-update-manager
@@ -26,30 +26,31 @@ SPACE_PER_KERNEL_DEB=13
 KERNEL_URLS = [
     KPATH + "v3.0.101-oneiric/linux-headers-3.0.101-0300101_3.0.101-0300101.201310220446_all.deb",
     KPATH + "v3.1.10-precise/linux-headers-3.1.10-030110_3.1.10-030110.201201181135_all.deb",
-    KPATH + "v3.2.76-precise/linux-headers-3.2.76-030276_3.2.76-030276.201601230132_all.deb",
+    KPATH + "v3.2.79-precise/linux-headers-3.2.79-030279_3.2.79-030279.201604010037_all.deb",
     KPATH + "v3.3.8-quantal/linux-headers-3.3.8-030308_3.3.8-030308.201206041356_all.deb",
-    KPATH + "v3.4.110-quantal/linux-headers-3.4.110-0304110_3.4.110-0304110.201510220333_all.deb",
+    KPATH + "v3.4.112-precise/linux-headers-3.4.112-0304112_3.4.112-0304112.201604271231_all.deb",
     KPATH + "v3.5.7.12-quantal/linux-headers-3.5.7-03050712_3.5.7-03050712.201305111435_all.deb",
     KPATH + "v3.6.11-raring/linux-headers-3.6.11-030611_3.6.11-030611.201212171335_all.deb",
     KPATH + "v3.7.10-raring/linux-headers-3.7.10-030710_3.7.10-030710.201302271235_all.deb",
     KPATH + "v3.8.13-raring/linux-headers-3.8.13-030813_3.8.13-030813.201305111843_all.deb",
     KPATH + "v3.9.11-saucy/linux-headers-3.9.11-030911_3.9.11-030911.201307202035_all.deb",
-    KPATH + "v3.10.96-precise/linux-headers-3.10.96-031096_3.10.96-031096.201601290140_all.deb",
+    KPATH + "v3.10.101-precise/linux-headers-3.10.101-0310101_3.10.101-0310101.201603161244_all.deb",
     KPATH + "v3.11.10-saucy/linux-headers-3.11.10-031110_3.11.10-031110.201311291453_all.deb",
-    KPATH + "v3.12.53-trusty/linux-headers-3.12.53-031253_3.12.53-031253.201601271331_all.deb",
+    KPATH + "v3.12.59-trusty/linux-headers-3.12.59-031259_3.12.59-031259.201604271336_all.deb",
     KPATH + "v3.13.11-trusty/linux-headers-3.13.11-031311_3.13.11-031311.201404222035_all.deb",
-    KPATH + "v3.14.60-trusty/linux-headers-3.14.60-031460_3.14.60-031460.201601290231_all.deb",
+    KPATH + "v3.14.67-trusty/linux-headers-3.14.67-031467_3.14.67-031467.201604200427_all.deb",
     KPATH + "v3.15.10-utopic/linux-headers-3.15.10-031510_3.15.10-031510.201408132333_all.deb",
     KPATH + "v3.16.7-utopic/linux-headers-3.16.7-031607_3.16.7-031607.201410301735_all.deb",
     KPATH + "v3.17.8-vivid/linux-headers-3.17.8-031708_3.17.8-031708.201501081837_all.deb",
-    KPATH + "v3.18.26-vivid/linux-headers-3.18.26-031826_3.18.26-031826.201601251330_all.deb",
+    KPATH + "v3.18.32-vivid/linux-headers-3.18.32-031832_3.18.32-031832.201604271335_all.deb",
     KPATH + "v3.19.8-vivid/linux-headers-3.19.8-031908_3.19.8-031908.201505110938_all.deb",
     KPATH + "v4.0.9-wily/linux-headers-4.0.9-040009_4.0.9-040009.201507212131_all.deb",
-    KPATH + "v4.1.17-wily/linux-headers-4.1.17-040117_4.1.17-040117.201601311534_all.deb",
+    KPATH + "v4.1.23-wily/linux-headers-4.1.23-040123_4.1.23-040123.201604281334_all.deb",
     KPATH + "v4.2.8-wily/linux-headers-4.2.8-040208_4.2.8-040208.201512150620_all.deb",
-    KPATH + "v4.3.5-wily/linux-headers-4.3.5-040305_4.3.5-040305.201601311533_all.deb",
-    KPATH + "v4.4.1-wily/linux-headers-4.4.1-040401_4.4.1-040401.201601311534_all.deb",
-    KPATH + "v4.5-rc3-wily/linux-headers-4.5.0-040500rc3_4.5.0-040500rc3.201602071930_all.deb"
+    KPATH + "v4.3.6-wily/linux-headers-4.3.6-040306_4.3.6-040306.201602191831_all.deb",
+    KPATH + "v4.4.8-wily/linux-headers-4.4.8-040408_4.4.8-040408.201604200335_all.deb",
+    KPATH + "v4.5.2-wily/linux-headers-4.5.2-040502_4.5.2-040502.201604200335_all.deb",
+    KPATH + "v4.6-rc5-wily/linux-headers-4.6.0-040600rc5_4.6.0-040600rc5.201604242031_all.deb"
 ]
 
 NUM_KERNELS=len(KERNEL_URLS)
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
