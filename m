Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:46749 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754342AbaAHAfr (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 7 Jan 2014 19:35:47 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 16/17] backports: update kernel versions
Date: Wed,  8 Jan 2014 01:34:33 +0100
Message-Id: <1389141274-2002-17-git-send-email-hauke@hauke-m.de> (sfid-20140108_013549_308956_71475FD3)
In-Reply-To: <1389141274-2002-1-git-send-email-hauke@hauke-m.de>
References: <1389141274-2002-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Update to current versions.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 devel/backports-update-manager |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/devel/backports-update-manager b/devel/backports-update-manager
index c0365cc..7c2a59b 100755
--- a/devel/backports-update-manager
+++ b/devel/backports-update-manager
@@ -39,18 +39,18 @@ KERNEL_URLS = [
     KPATH + "v2.6.39.4-oneiric/linux-headers-2.6.39-02063904_2.6.39-02063904.201108040905_all.deb",
     KPATH + "v3.0.101-oneiric/linux-headers-3.0.101-0300101_3.0.101-0300101.201310220446_all.deb",
     KPATH + "v3.1.10-precise/linux-headers-3.1.10-030110_3.1.10-030110.201201181135_all.deb",
-    KPATH + "v3.2.52-precise/linux-headers-3.2.52-030252_3.2.52-030252.201310262335_all.deb",
+    KPATH + "v3.2.54-precise/linux-headers-3.2.54-030254_3.2.54-030254.201401030035_all.deb",
     KPATH + "v3.3.8-quantal/linux-headers-3.3.8-030308_3.3.8-030308.201206041356_all.deb",
-    KPATH + "v3.4.70-quantal/linux-headers-3.4.70-030470_3.4.70-030470.201311201436_all.deb",
+    KPATH + "v3.4.75-quantal/linux-headers-3.4.75-030475_3.4.75-030475.201312201255_all.deb",
     KPATH + "v3.5.7.12-quantal/linux-headers-3.5.7-03050712_3.5.7-03050712.201305111435_all.deb",
     KPATH + "v3.6.11-raring/linux-headers-3.6.11-030611_3.6.11-030611.201212171335_all.deb",
     KPATH + "v3.7.10-raring/linux-headers-3.7.10-030710_3.7.10-030710.201302271235_all.deb",
     KPATH + "v3.8.13-raring/linux-headers-3.8.13-030813_3.8.13-030813.201305111843_all.deb",
     KPATH + "v3.9.11-saucy/linux-headers-3.9.11-030911_3.9.11-030911.201307202035_all.deb",
-    KPATH + "v3.10.20-saucy/linux-headers-3.10.20-031020_3.10.20-031020.201311201536_all.deb",
-    KPATH + "v3.11.9-saucy/linux-headers-3.11.9-031109_3.11.9-031109.201311201635_all.deb",
-    KPATH + "v3.12.1-trusty/linux-headers-3.12.1-031201_3.12.1-031201.201311201654_all.deb",
-    KPATH + "v3.13-rc1-trusty/linux-headers-3.13.0-031300rc1_3.13.0-031300rc1.201311221535_all.deb",
+    KPATH + "v3.10.25-saucy/linux-headers-3.10.25-031025_3.10.25-031025.201312201135_all.deb",
+    KPATH + "v3.11.10-saucy/linux-headers-3.11.10-031110_3.11.10-031110.201311291453_all.deb",
+    KPATH + "v3.12.6-trusty/linux-headers-3.12.6-031206_3.12.6-031206.201312201218_all.deb",
+    KPATH + "v3.13-rc7-trusty/linux-headers-3.13.0-031300rc7_3.13.0-031300rc7.201401041835_all.deb",
 ]
 
 NUM_KERNELS=len(KERNEL_URLS)
-- 
1.7.10.4

