Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 15/23] compat: add kernel 3.8-rc7 and update others
Date: Tue, 26 Feb 2013 21:59:06 +0100
Message-Id: <1361912354-29498-16-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1361912354-29498-1-git-send-email-hauke@hauke-m.de>
References: <1361912354-29498-1-git-send-email-hauke@hauke-m.de>
List-ID: <backports@vger.kernel.org>

This adds 3.8-rc7 to the get.compat-kernels fetch script and updates
some kernel versions to the last minor version.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 bin/get-compat-kernels |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/bin/get-compat-kernels b/bin/get-compat-kernels
index 2a81934..e6171d2 100755
--- a/bin/get-compat-kernels
+++ b/bin/get-compat-kernels
@@ -55,14 +55,15 @@ KERNELS="$KERNELS ${KPATH}/v2.6.36.4-natty/linux-headers-2.6.36-02063604_2.6.36-
 KERNELS="$KERNELS ${KPATH}/v2.6.37.6-natty/linux-headers-2.6.37-02063706_2.6.37-02063706.201103281005_all.deb"
 KERNELS="$KERNELS ${KPATH}/v2.6.38.8-natty/linux-headers-2.6.38-02063808_2.6.38-02063808.201106040910_all.deb"
 KERNELS="$KERNELS ${KPATH}/v2.6.39.4-oneiric/linux-headers-2.6.39-02063904_2.6.39-02063904.201108040905_all.deb"
-KERNELS="$KERNELS ${KPATH}/v3.0.60-oneiric/linux-headers-3.0.60-030060_3.0.60-030060.201301211535_all.deb"
+KERNELS="$KERNELS ${KPATH}/v3.0.62-oneiric/linux-headers-3.0.62-030062_3.0.62-030062.201302032235_all.deb"
 KERNELS="$KERNELS ${KPATH}/v3.1.10-precise/linux-headers-3.1.10-030110_3.1.10-030110.201201181135_all.deb"
-KERNELS="$KERNELS ${KPATH}/v3.2.37-precise/linux-headers-3.2.37-030237_3.2.37-030237.201301152335_all.deb"
+KERNELS="$KERNELS ${KPATH}/v3.2.38-precise/linux-headers-3.2.38-030238_3.2.38-030238.201302060135_all.deb"
 KERNELS="$KERNELS ${KPATH}/v3.3.8-quantal/linux-headers-3.3.8-030308_3.3.8-030308.201206041356_all.deb"
-KERNELS="$KERNELS ${KPATH}/v3.4.27-quantal/linux-headers-3.4.27-030427_3.4.27-030427.201301211631_all.deb"
+KERNELS="$KERNELS ${KPATH}/v3.4.29-quantal/linux-headers-3.4.29-030429_3.4.29-030429.201302032331_all.deb"
 KERNELS="$KERNELS ${KPATH}/v3.5.7-quantal/linux-headers-3.5.7-030507_3.5.7-030507.201210130556_all.deb"
 KERNELS="$KERNELS ${KPATH}/v3.6.11-raring/linux-headers-3.6.11-030611_3.6.11-030611.201212171335_all.deb"
-KERNELS="$KERNELS ${KPATH}/v3.7.4-raring/linux-headers-3.7.4-030704_3.7.4-030704.201301211706_all.deb"
+KERNELS="$KERNELS ${KPATH}/v3.7.6-raring/linux-headers-3.7.6-030706_3.7.6-030706.201302040006_all.deb"
+KERNELS="$KERNELS ${KPATH}/v3.8-rc7-raring/linux-headers-3.8.0-030800rc7_3.8.0-030800rc7.201302081635_all.deb"
 
 # Number of kernels
 NUM_KERNELS=$(echo $KERNELS | wc -w)
-- 
1.7.10.4
