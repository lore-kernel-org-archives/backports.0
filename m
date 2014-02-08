Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:60068 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751296AbaBHNow (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 8 Feb 2014 08:44:52 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 5/6] backports: update test kernel versions
Date: Sat,  8 Feb 2014 14:44:29 +0100
Message-Id: <1391867070-20031-6-git-send-email-hauke@hauke-m.de> (sfid-20140208_144454_066349_F53AC1F5)
In-Reply-To: <1391867070-20031-1-git-send-email-hauke@hauke-m.de>
References: <1391867070-20031-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 devel/backports-update-manager |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/devel/backports-update-manager b/devel/backports-update-manager
index 584309b..af54a92 100755
--- a/devel/backports-update-manager
+++ b/devel/backports-update-manager
@@ -41,16 +41,17 @@ KERNEL_URLS = [
     KPATH + "v3.1.10-precise/linux-headers-3.1.10-030110_3.1.10-030110.201201181135_all.deb",
     KPATH + "v3.2.54-precise/linux-headers-3.2.54-030254_3.2.54-030254.201401030035_all.deb",
     KPATH + "v3.3.8-quantal/linux-headers-3.3.8-030308_3.3.8-030308.201206041356_all.deb",
-    KPATH + "v3.4.77-quantal/linux-headers-3.4.77-030477_3.4.77-030477.201401151835_all.deb",
+    KPATH + "v3.4.79-quantal/linux-headers-3.4.79-030479_3.4.79-030479.201402061722_all.deb",
     KPATH + "v3.5.7.12-quantal/linux-headers-3.5.7-03050712_3.5.7-03050712.201305111435_all.deb",
     KPATH + "v3.6.11-raring/linux-headers-3.6.11-030611_3.6.11-030611.201212171335_all.deb",
     KPATH + "v3.7.10-raring/linux-headers-3.7.10-030710_3.7.10-030710.201302271235_all.deb",
     KPATH + "v3.8.13-raring/linux-headers-3.8.13-030813_3.8.13-030813.201305111843_all.deb",
     KPATH + "v3.9.11-saucy/linux-headers-3.9.11-030911_3.9.11-030911.201307202035_all.deb",
-    KPATH + "v3.10.27-saucy/linux-headers-3.10.27-031027_3.10.27-031027.201401151935_all.deb",
+    KPATH + "v3.10.29-saucy/linux-headers-3.10.29-031029_3.10.29-031029.201402061535_all.deb",
     KPATH + "v3.11.10-saucy/linux-headers-3.11.10-031110_3.11.10-031110.201311291453_all.deb",
-    KPATH + "v3.12.8-trusty/linux-headers-3.12.8-031208_3.12.8-031208.201401151952_all.deb",
-    KPATH + "v3.13-rc8-trusty/linux-headers-3.13.0-031300rc8_3.13.0-031300rc8.201401120535_all.deb",
+    KPATH + "v3.12.10-trusty/linux-headers-3.12.10-031210_3.12.10-031210.201402061553_all.deb",
+    KPATH + "v3.13.2-trusty/linux-headers-3.13.2-031302_3.13.2-031302.201402061638_all.deb",
+    KPATH + "v3.14-rc1-trusty/linux-headers-3.14.0-031400rc1_3.14.0-031400rc1.201402022035_all.deb",
 ]
 
 NUM_KERNELS=len(KERNEL_URLS)
-- 
1.7.10.4

