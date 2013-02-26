Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 03/23] compat: update kernel versions in bin/get-compat-kernels
Date: Tue, 26 Feb 2013 21:58:54 +0100
Message-Id: <1361912354-29498-4-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1361912354-29498-1-git-send-email-hauke@hauke-m.de>
References: <1361912354-29498-1-git-send-email-hauke@hauke-m.de>
List-ID: <backports@vger.kernel.org>

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 bin/get-compat-kernels |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/bin/get-compat-kernels b/bin/get-compat-kernels
index b8cbb5e..2a81934 100755
--- a/bin/get-compat-kernels
+++ b/bin/get-compat-kernels
@@ -49,20 +49,20 @@ KERNELS="$KERNELS ${KPATH}/v2.6.30.10/linux-headers-2.6.30-02063010_2.6.30-02063
 KERNELS="$KERNELS ${KPATH}/v2.6.31.13-karmic/linux-headers-2.6.31-02063113_2.6.31-02063113_all.deb"
 KERNELS="$KERNELS ${KPATH}/v2.6.32.60-lucid/linux-headers-2.6.32-02063260_2.6.32-02063260.201210082135_all.deb"
 KERNELS="$KERNELS ${KPATH}/v2.6.33.20-maverick/linux-headers-2.6.33-02063320_2.6.33-02063320.201111071735_all.deb"
-KERNELS="$KERNELS ${KPATH}/v2.6.34.13-maverick/linux-headers-2.6.34-02063413_2.6.34-02063413.201208201835_all.deb"
+KERNELS="$KERNELS ${KPATH}/v2.6.34.14-maverick/linux-headers-2.6.34-02063414_2.6.34-02063414.201301162135_all.deb"
 KERNELS="$KERNELS ${KPATH}/v2.6.35.13-original-maverick/linux-headers-2.6.35-02063513_2.6.35-02063513.201107261012_all.deb"
 KERNELS="$KERNELS ${KPATH}/v2.6.36.4-natty/linux-headers-2.6.36-02063604_2.6.36-02063604.201102180911_all.deb"
 KERNELS="$KERNELS ${KPATH}/v2.6.37.6-natty/linux-headers-2.6.37-02063706_2.6.37-02063706.201103281005_all.deb"
 KERNELS="$KERNELS ${KPATH}/v2.6.38.8-natty/linux-headers-2.6.38-02063808_2.6.38-02063808.201106040910_all.deb"
 KERNELS="$KERNELS ${KPATH}/v2.6.39.4-oneiric/linux-headers-2.6.39-02063904_2.6.39-02063904.201108040905_all.deb"
-KERNELS="$KERNELS ${KPATH}/v3.0.50-oneiric/linux-headers-3.0.50-030050_3.0.50-030050.201210311335_all.deb"
+KERNELS="$KERNELS ${KPATH}/v3.0.60-oneiric/linux-headers-3.0.60-030060_3.0.60-030060.201301211535_all.deb"
 KERNELS="$KERNELS ${KPATH}/v3.1.10-precise/linux-headers-3.1.10-030110_3.1.10-030110.201201181135_all.deb"
-KERNELS="$KERNELS ${KPATH}/v3.2.33-precise/linux-headers-3.2.33-030233_3.2.33-030233.201210310701_all.deb"
+KERNELS="$KERNELS ${KPATH}/v3.2.37-precise/linux-headers-3.2.37-030237_3.2.37-030237.201301152335_all.deb"
 KERNELS="$KERNELS ${KPATH}/v3.3.8-quantal/linux-headers-3.3.8-030308_3.3.8-030308.201206041356_all.deb"
-KERNELS="$KERNELS ${KPATH}/v3.4.17-quantal/linux-headers-3.4.17-030417_3.4.17-030417.201210311354_all.deb"
+KERNELS="$KERNELS ${KPATH}/v3.4.27-quantal/linux-headers-3.4.27-030427_3.4.27-030427.201301211631_all.deb"
 KERNELS="$KERNELS ${KPATH}/v3.5.7-quantal/linux-headers-3.5.7-030507_3.5.7-030507.201210130556_all.deb"
-KERNELS="$KERNELS ${KPATH}/v3.6.5-raring/linux-headers-3.6.5-030605_3.6.5-030605.201211011211_all.deb"
-KERNELS="$KERNELS ${KPATH}/v3.7-raring/linux-headers-3.7.0-030700_3.7.0-030700.201212102335_all.deb"
+KERNELS="$KERNELS ${KPATH}/v3.6.11-raring/linux-headers-3.6.11-030611_3.6.11-030611.201212171335_all.deb"
+KERNELS="$KERNELS ${KPATH}/v3.7.4-raring/linux-headers-3.7.4-030704_3.7.4-030704.201301211706_all.deb"
 
 # Number of kernels
 NUM_KERNELS=$(echo $KERNELS | wc -w)
-- 
1.7.10.4
