Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH] compat: update list of kernel headers
Date: Thu,  1 Nov 2012 20:05:31 +0100
Message-Id: <1351796731-15788-1-git-send-email-hauke@hauke-m.de>
List-ID: <backports@vger.kernel.org>

With this patch get-compat-kernels fetches the most recent minor
versions of the kernel headers from the Ubuntu mainline repository.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 bin/get-compat-kernels |   20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/bin/get-compat-kernels b/bin/get-compat-kernels
index 30f5dfe..55974f7 100755
--- a/bin/get-compat-kernels
+++ b/bin/get-compat-kernels
@@ -43,21 +43,21 @@ KERNELS="$KERNELS ${KPATH}/v2.6.28.10/linux-headers-2.6.28-02062810_2.6.28-02062
 KERNELS="$KERNELS ${KPATH}/v2.6.29.6/linux-headers-2.6.29-02062906_2.6.29-02062906_all.deb"
 KERNELS="$KERNELS ${KPATH}/v2.6.30.10/linux-headers-2.6.30-02063010_2.6.30-02063010_all.deb"
 KERNELS="$KERNELS ${KPATH}/v2.6.31.13-karmic/linux-headers-2.6.31-02063113_2.6.31-02063113_all.deb"
-KERNELS="$KERNELS ${KPATH}/v2.6.32.55-lucid/linux-headers-2.6.32-02063255_2.6.32-02063255.201201251735_all.deb"
-KERNELS="$KERNELS ${KPATH}/v2.6.33.5-lucid/linux-headers-2.6.33-02063305_2.6.33-02063305_all.deb"
-KERNELS="$KERNELS ${KPATH}/v2.6.34.10-maverick/linux-headers-2.6.34-02063410_2.6.34-02063410.201111101535_all.deb"
-KERNELS="$KERNELS ${KPATH}/v2.6.35.13-maverick/linux-headers-2.6.35-02063512_2.6.35-02063512.201111232118_all.deb"
+KERNELS="$KERNELS ${KPATH}/v2.6.32.60-lucid/linux-headers-2.6.32-02063260_2.6.32-02063260.201210082135_all.deb"
+KERNELS="$KERNELS ${KPATH}/v2.6.33.20-maverick/linux-headers-2.6.33-02063320_2.6.33-02063320.201111071735_all.deb"
+KERNELS="$KERNELS ${KPATH}/v2.6.34.13-maverick/linux-headers-2.6.34-02063413_2.6.34-02063413.201208201835_all.deb"
+KERNELS="$KERNELS ${KPATH}/v2.6.35.13-original-maverick/linux-headers-2.6.35-02063513_2.6.35-02063513.201107261012_all.deb"
 KERNELS="$KERNELS ${KPATH}/v2.6.36.4-natty/linux-headers-2.6.36-02063604_2.6.36-02063604.201102180911_all.deb"
 KERNELS="$KERNELS ${KPATH}/v2.6.37.6-natty/linux-headers-2.6.37-02063706_2.6.37-02063706.201103281005_all.deb"
 KERNELS="$KERNELS ${KPATH}/v2.6.38.8-natty/linux-headers-2.6.38-02063808_2.6.38-02063808.201106040910_all.deb"
 KERNELS="$KERNELS ${KPATH}/v2.6.39.4-oneiric/linux-headers-2.6.39-02063904_2.6.39-02063904.201108040905_all.deb"
-KERNELS="$KERNELS ${KPATH}/v3.0.18-oneiric/linux-headers-3.0.18-030018_3.0.18-030018.201201252135_all.deb"
+KERNELS="$KERNELS ${KPATH}/v3.0.50-oneiric/linux-headers-3.0.50-030050_3.0.50-030050.201210311335_all.deb"
 KERNELS="$KERNELS ${KPATH}/v3.1.10-precise/linux-headers-3.1.10-030110_3.1.10-030110.201201181135_all.deb"
-KERNELS="$KERNELS ${KPATH}/v3.2.2-precise/linux-headers-3.2.2-030202_3.2.2-030202.201201252035_all.deb"
-KERNELS="$KERNELS ${KPATH}/v3.3.7-precise/linux-headers-3.3.7-030307_3.3.7-030307.201205211535_all.deb"
-KERNELS="$KERNELS ${KPATH}/v3.4.4-quantal/linux-headers-3.4.4-030404_3.4.4-030404.201206221555_all.deb"
-KERNELS="$KERNELS ${KPATH}/v3.5-quantal/linux-headers-3.5.0-030500_3.5.0-030500.201207211835_all.deb"
-KERNELS="$KERNELS ${KPATH}/v3.6.2-quantal/linux-headers-3.6.2-030602_3.6.2-030602.201210121823_all.deb"
+KERNELS="$KERNELS ${KPATH}/v3.2.33-precise/linux-headers-3.2.33-030233_3.2.33-030233.201210310701_all.deb"
+KERNELS="$KERNELS ${KPATH}/v3.3.8-quantal/linux-headers-3.3.8-030308_3.3.8-030308.201206041356_all.deb"
+KERNELS="$KERNELS ${KPATH}/v3.4.17-quantal/linux-headers-3.4.17-030417_3.4.17-030417.201210311354_all.deb"
+KERNELS="$KERNELS ${KPATH}/v3.5.7-quantal/linux-headers-3.5.7-030507_3.5.7-030507.201210130556_all.deb"
+KERNELS="$KERNELS ${KPATH}/v3.6.5-raring/linux-headers-3.6.5-030605_3.6.5-030605.201211011211_all.deb"
 
 # Number of kernels
 NUM_KERNELS=$(echo $KERNELS | wc -w)
-- 
1.7.10.4
