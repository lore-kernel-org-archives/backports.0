Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:56027 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751234AbaEaRRB (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 31 May 2014 13:17:01 -0400
Received: from localhost (localhost [127.0.0.1])
	by hauke-m.de (Postfix) with ESMTP id AACBF7E5F
	for <backports@vger.kernel.org>; Sat, 31 May 2014 19:17:00 +0200 (CEST)
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 13/13] backports: update test kernel versions
Date: Sat, 31 May 2014 19:16:10 +0200
Message-Id: <1401556570-3363-14-git-send-email-hauke@hauke-m.de> (sfid-20140531_192147_839555_1AFFA04C)
In-Reply-To: <1401556570-3363-1-git-send-email-hauke@hauke-m.de>
References: <1401556570-3363-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This updates the kernel versions to test against to the most recent
versions.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 devel/backports-update-manager | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/devel/backports-update-manager b/devel/backports-update-manager
index 0676421..26aa591 100755
--- a/devel/backports-update-manager
+++ b/devel/backports-update-manager
@@ -25,19 +25,20 @@ SPACE_PER_KERNEL_DEB=13
 KERNEL_URLS = [
     KPATH + "v3.0.101-oneiric/linux-headers-3.0.101-0300101_3.0.101-0300101.201310220446_all.deb",
     KPATH + "v3.1.10-precise/linux-headers-3.1.10-030110_3.1.10-030110.201201181135_all.deb",
-    KPATH + "v3.2.54-precise/linux-headers-3.2.54-030254_3.2.54-030254.201401030035_all.deb",
+    KPATH + "v3.2.59-precise/linux-headers-3.2.59-030259_3.2.59-030259.201405181035_all.deb",
     KPATH + "v3.3.8-quantal/linux-headers-3.3.8-030308_3.3.8-030308.201206041356_all.deb",
-    KPATH + "v3.4.79-quantal/linux-headers-3.4.79-030479_3.4.79-030479.201402061722_all.deb",
+    KPATH + "v3.4.91-quantal/linux-headers-3.4.91-030491_3.4.91-030491.201405180835_all.deb",
     KPATH + "v3.5.7.12-quantal/linux-headers-3.5.7-03050712_3.5.7-03050712.201305111435_all.deb",
     KPATH + "v3.6.11-raring/linux-headers-3.6.11-030611_3.6.11-030611.201212171335_all.deb",
     KPATH + "v3.7.10-raring/linux-headers-3.7.10-030710_3.7.10-030710.201302271235_all.deb",
     KPATH + "v3.8.13-raring/linux-headers-3.8.13-030813_3.8.13-030813.201305111843_all.deb",
     KPATH + "v3.9.11-saucy/linux-headers-3.9.11-030911_3.9.11-030911.201307202035_all.deb",
-    KPATH + "v3.10.29-saucy/linux-headers-3.10.29-031029_3.10.29-031029.201402061535_all.deb",
+    KPATH + "v3.10.40-saucy/linux-headers-3.10.40-031040_3.10.40-031040.201405130835_all.deb",
     KPATH + "v3.11.10-saucy/linux-headers-3.11.10-031110_3.11.10-031110.201311291453_all.deb",
-    KPATH + "v3.12.10-trusty/linux-headers-3.12.10-031210_3.12.10-031210.201402061553_all.deb",
-    KPATH + "v3.13.2-trusty/linux-headers-3.13.2-031302_3.13.2-031302.201402061638_all.deb",
-    KPATH + "v3.14-rc1-trusty/linux-headers-3.14.0-031400rc1_3.14.0-031400rc1.201402022035_all.deb",
+    KPATH + "v3.12.20-trusty/linux-headers-3.12.20-031220_3.12.20-031220.201405160935_all.deb",
+    KPATH + "v3.13.11-trusty/linux-headers-3.13.11-031311_3.13.11-031311.201404222035_all.deb",
+    KPATH + "v3.14.4-utopic/linux-headers-3.14.4-031404_3.14.4-031404.201405130853_all.deb",
+    KPATH + "v3.15-rc7-utopic/linux-headers-3.15.0-031500rc7_3.15.0-031500rc7.201405251935_all.deb",
 ]
 
 NUM_KERNELS=len(KERNEL_URLS)
-- 
1.9.1

