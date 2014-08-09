Return-path: <backports-owner@vger.kernel.org>
Received: from test.hauke-m.de ([5.39.93.123]:44939 "EHLO test.hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751670AbaHIOrs (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 9 Aug 2014 10:47:48 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 6/6] backports: update test kernel versions
Date: Sat,  9 Aug 2014 16:47:39 +0200
Message-Id: <1407595659-10396-7-git-send-email-hauke@hauke-m.de> (sfid-20140809_164753_675660_912DF5FB)
In-Reply-To: <1407595659-10396-1-git-send-email-hauke@hauke-m.de>
References: <1407595659-10396-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This updates the kernel versions to test against to the most recent
versions.
Do not use 3.15.9, but 3.15.7 because there are some problems with the
define UTS_UBUNTU_RELEASE_ABI in the more recent kernel version, see:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1347879

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 devel/backports-update-manager | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/devel/backports-update-manager b/devel/backports-update-manager
index 373a621..b584ca0 100755
--- a/devel/backports-update-manager
+++ b/devel/backports-update-manager
@@ -25,21 +25,21 @@ SPACE_PER_KERNEL_DEB=13
 KERNEL_URLS = [
     KPATH + "v3.0.101-oneiric/linux-headers-3.0.101-0300101_3.0.101-0300101.201310220446_all.deb",
     KPATH + "v3.1.10-precise/linux-headers-3.1.10-030110_3.1.10-030110.201201181135_all.deb",
-    KPATH + "v3.2.60-precise/linux-headers-3.2.60-030260_3.2.60-030260.201406091035_all.deb",
+    KPATH + "v3.2.62-precise/linux-headers-3.2.62-030262_3.2.62-030262.201408061435_all.deb",
     KPATH + "v3.3.8-quantal/linux-headers-3.3.8-030308_3.3.8-030308.201206041356_all.deb",
-    KPATH + "v3.4.93-quantal/linux-headers-3.4.93-030493_3.4.93-030493.201406111735_all.deb",
+    KPATH + "v3.4.102-quantal/linux-headers-3.4.102-0304102_3.4.102-0304102.201408071853_all.deb",
     KPATH + "v3.5.7.12-quantal/linux-headers-3.5.7-03050712_3.5.7-03050712.201305111435_all.deb",
     KPATH + "v3.6.11-raring/linux-headers-3.6.11-030611_3.6.11-030611.201212171335_all.deb",
     KPATH + "v3.7.10-raring/linux-headers-3.7.10-030710_3.7.10-030710.201302271235_all.deb",
     KPATH + "v3.8.13-raring/linux-headers-3.8.13-030813_3.8.13-030813.201305111843_all.deb",
     KPATH + "v3.9.11-saucy/linux-headers-3.9.11-030911_3.9.11-030911.201307202035_all.deb",
-    KPATH + "v3.10.43-saucy/linux-headers-3.10.43-031043_3.10.43-031043.201406111535_all.deb",
+    KPATH + "v3.10.52-saucy/linux-headers-3.10.52-031052_3.10.52-031052.201408071835_all.deb",
     KPATH + "v3.11.10-saucy/linux-headers-3.11.10-031110_3.11.10-031110.201311291453_all.deb",
-    KPATH + "v3.12.22-trusty/linux-headers-3.12.22-031222_3.12.22-031222.201406111135_all.deb",
+    KPATH + "v3.12.26-trusty/linux-headers-3.12.26-031226_3.12.26-031226.201408011335_all.deb",
     KPATH + "v3.13.11-trusty/linux-headers-3.13.11-031311_3.13.11-031311.201404222035_all.deb",
-    KPATH + "v3.14.7-utopic/linux-headers-3.14.7-031407_3.14.7-031407.201406111644_all.deb",
-    KPATH + "v3.15-utopic/linux-headers-3.15.0-031500_3.15.0-031500.201406131105_all.deb",
-    KPATH + "v3.16-rc1-utopic/linux-headers-3.16.0-031600rc1_3.16.0-031600rc1.201406160035_all.deb"
+    KPATH + "v3.14.16-utopic/linux-headers-3.14.16-031416_3.14.16-031416.201408072035_all.deb",
+    KPATH + "v3.15.7-utopic/linux-headers-3.15.7-031507_3.15.7-031507.201407281235_all.deb",
+    KPATH + "v3.16-utopic/linux-headers-3.16.0-031600_3.16.0-031600.201408031935_all.deb"
 ]
 
 NUM_KERNELS=len(KERNEL_URLS)
-- 
1.9.1

