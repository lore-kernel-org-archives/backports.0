Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:54586 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754372Ab3EGJ6Q (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 7 May 2013 05:58:16 -0400
Received: by mail-pd0-f170.google.com with SMTP id 10so292422pdi.1
        for <backports@vger.kernel.org>; Tue, 07 May 2013 02:58:16 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH] get-compat-kernels: update all kernels
Date: Tue,  7 May 2013 02:52:03 -0700
Message-Id: <1367920323-16727-1-git-send-email-mcgrof@do-not-panic.com> (sfid-20130507_115819_562908_9025A3E8)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

Update to the latest available set. You'll need 3.9 updated
if you want to test against next-20130403 due to fffe01f7.

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 devel/get-compat-kernels |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/devel/get-compat-kernels b/devel/get-compat-kernels
index 84fb9a6..e649d8e 100755
--- a/devel/get-compat-kernels
+++ b/devel/get-compat-kernels
@@ -1,6 +1,6 @@
 #!/bin/bash
 #
-# Copyright (C) 2012, Luis R. Rodriguez <mcgrof@frijolero.org>
+# Copyright (C) 2012, Luis R. Rodriguez <mcgrof@do-not-panic.com>
 #
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
@@ -55,16 +55,16 @@ KERNELS="$KERNELS ${KPATH}/v2.6.36.4-natty/linux-headers-2.6.36-02063604_2.6.36-
 KERNELS="$KERNELS ${KPATH}/v2.6.37.6-natty/linux-headers-2.6.37-02063706_2.6.37-02063706.201103281005_all.deb"
 KERNELS="$KERNELS ${KPATH}/v2.6.38.8-natty/linux-headers-2.6.38-02063808_2.6.38-02063808.201106040910_all.deb"
 KERNELS="$KERNELS ${KPATH}/v2.6.39.4-oneiric/linux-headers-2.6.39-02063904_2.6.39-02063904.201108040905_all.deb"
-KERNELS="$KERNELS ${KPATH}/v3.0.73-oneiric/linux-headers-3.0.73-030073_3.0.73-030073.201304121235_all.deb"
+KERNELS="$KERNELS ${KPATH}/v3.0.76-oneiric/linux-headers-3.0.76-030076_3.0.76-030076.201305011235_all.deb"
 KERNELS="$KERNELS ${KPATH}/v3.1.10-precise/linux-headers-3.1.10-030110_3.1.10-030110.201201181135_all.deb"
-KERNELS="$KERNELS ${KPATH}/v3.2.43-precise/linux-headers-3.2.43-030243_3.2.43-030243.201304092335_all.deb"
+KERNELS="$KERNELS ${KPATH}/v3.2.44-precise/linux-headers-3.2.44-030244_3.2.44-030244.201304260219_all.deb"
 KERNELS="$KERNELS ${KPATH}/v3.3.8-quantal/linux-headers-3.3.8-030308_3.3.8-030308.201206041356_all.deb"
-KERNELS="$KERNELS ${KPATH}/v3.4.40-quantal/linux-headers-3.4.40-030440_3.4.40-030440.201304121354_all.deb"
-KERNELS="$KERNELS ${KPATH}/v3.5.7-quantal/linux-headers-3.5.7-030507_3.5.7-030507.201210130556_all.deb"
+KERNELS="$KERNELS ${KPATH}/v3.4.43-quantal/linux-headers-3.4.43-030443_3.4.43-030443.201305011335_all.deb"
+KERNELS="$KERNELS ${KPATH}/v3.5.7.11-quantal/linux-headers-3.5.7-03050711_3.5.7-03050711.201304220635_all.deb"
 KERNELS="$KERNELS ${KPATH}/v3.6.11-raring/linux-headers-3.6.11-030611_3.6.11-030611.201212171335_all.deb"
 KERNELS="$KERNELS ${KPATH}/v3.7.10-raring/linux-headers-3.7.10-030710_3.7.10-030710.201302271235_all.deb"
-KERNELS="$KERNELS ${KPATH}/v3.8.7-raring/linux-headers-3.8.7-030807_3.8.7-030807.201304121430_all.deb"
-KERNELS="$KERNELS ${KPATH}/v3.9-rc6-raring/linux-headers-3.9.0-030900rc6_3.9.0-030900rc6.201304080035_all.deb"
+KERNELS="$KERNELS ${KPATH}/v3.8.11-raring/linux-headers-3.8.11-030811_3.8.11-030811.201305011408_all.deb"
+KERNELS="$KERNELS ${KPATH}/v3.9-raring/linux-headers-3.9.0-030900_3.9.0-030900.201304291257_all.deb"
 
 # Number of kernels
 NUM_KERNELS=$(echo $KERNELS | wc -w)
-- 
1.7.10.4

