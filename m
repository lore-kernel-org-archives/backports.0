Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:60013 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754820Ab3ETL3R (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 20 May 2013 07:29:17 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 2/2] backports: add kernel 3.10 and update others
Date: Mon, 20 May 2013 13:29:05 +0200
Message-Id: <1369049345-13966-2-git-send-email-hauke@hauke-m.de> (sfid-20130520_132919_719474_547F9CBF)
In-Reply-To: <1369049345-13966-1-git-send-email-hauke@hauke-m.de>
References: <1369049345-13966-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Add kernel 3.10 to the script fetching the kernels for compile testing.

This also fixes the header rebuild for kernel versions >= 3.10.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 devel/get-compat-kernels |   15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/devel/get-compat-kernels b/devel/get-compat-kernels
index e649d8e..4fd4486 100755
--- a/devel/get-compat-kernels
+++ b/devel/get-compat-kernels
@@ -55,16 +55,17 @@ KERNELS="$KERNELS ${KPATH}/v2.6.36.4-natty/linux-headers-2.6.36-02063604_2.6.36-
 KERNELS="$KERNELS ${KPATH}/v2.6.37.6-natty/linux-headers-2.6.37-02063706_2.6.37-02063706.201103281005_all.deb"
 KERNELS="$KERNELS ${KPATH}/v2.6.38.8-natty/linux-headers-2.6.38-02063808_2.6.38-02063808.201106040910_all.deb"
 KERNELS="$KERNELS ${KPATH}/v2.6.39.4-oneiric/linux-headers-2.6.39-02063904_2.6.39-02063904.201108040905_all.deb"
-KERNELS="$KERNELS ${KPATH}/v3.0.76-oneiric/linux-headers-3.0.76-030076_3.0.76-030076.201305011235_all.deb"
+KERNELS="$KERNELS ${KPATH}/v3.0.79-oneiric/linux-headers-3.0.79-030079_3.0.79-030079.201305191335_all.deb"
 KERNELS="$KERNELS ${KPATH}/v3.1.10-precise/linux-headers-3.1.10-030110_3.1.10-030110.201201181135_all.deb"
-KERNELS="$KERNELS ${KPATH}/v3.2.44-precise/linux-headers-3.2.44-030244_3.2.44-030244.201304260219_all.deb"
+KERNELS="$KERNELS ${KPATH}/v3.2.45-precise/linux-headers-3.2.45-030245_3.2.45-030245.201305140735_all.deb"
 KERNELS="$KERNELS ${KPATH}/v3.3.8-quantal/linux-headers-3.3.8-030308_3.3.8-030308.201206041356_all.deb"
-KERNELS="$KERNELS ${KPATH}/v3.4.43-quantal/linux-headers-3.4.43-030443_3.4.43-030443.201305011335_all.deb"
-KERNELS="$KERNELS ${KPATH}/v3.5.7.11-quantal/linux-headers-3.5.7-03050711_3.5.7-03050711.201304220635_all.deb"
+KERNELS="$KERNELS ${KPATH}/v3.4.46-quantal/linux-headers-3.4.46-030446_3.4.46-030446.201305191435_all.deb"
+KERNELS="$KERNELS ${KPATH}/v3.5.7.12-quantal/linux-headers-3.5.7-03050712_3.5.7-03050712.201305111435_all.deb"
 KERNELS="$KERNELS ${KPATH}/v3.6.11-raring/linux-headers-3.6.11-030611_3.6.11-030611.201212171335_all.deb"
 KERNELS="$KERNELS ${KPATH}/v3.7.10-raring/linux-headers-3.7.10-030710_3.7.10-030710.201302271235_all.deb"
-KERNELS="$KERNELS ${KPATH}/v3.8.11-raring/linux-headers-3.8.11-030811_3.8.11-030811.201305011408_all.deb"
-KERNELS="$KERNELS ${KPATH}/v3.9-raring/linux-headers-3.9.0-030900_3.9.0-030900.201304291257_all.deb"
+KERNELS="$KERNELS ${KPATH}/v3.8.13-raring/linux-headers-3.8.13-030813_3.8.13-030813.201305111843_all.deb"
+KERNELS="$KERNELS ${KPATH}/v3.9.3-saucy/linux-headers-3.9.3-030903_3.9.3-030903.201305191535_all.deb"
+KERNELS="$KERNELS ${KPATH}/v3.10-rc1-saucy/linux-headers-3.10.0-031000rc1_3.10.0-031000rc1.201305130510_all.deb"
 
 # Number of kernels
 NUM_KERNELS=$(echo $KERNELS | wc -w)
@@ -171,7 +172,7 @@ function rebuild_header_binary_deps() {
 		exit 1
 	fi
 
-	for kernel in $(ls -d ${KSRC_PREFIX}/lib/modules/*generic | grep -E "/3.[2-9]|/[4-9]"); do
+	for kernel in $(ls -d ${KSRC_PREFIX}/lib/modules/*generic | grep -E "/3\.[2-9]\.|/3\.[1-9][0-9]\.|/[4-9]\."); do
 		echo $kernel
 
 		count=0
-- 
1.7.10.4

