Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:47354 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755010Ab3EZTxC (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 26 May 2013 15:53:02 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 5/5] backports: BCMA and SSB MIPS drivers are depending on kernel >= 3.3
Date: Sun, 26 May 2013 21:52:30 +0200
Message-Id: <1369597950-2926-5-git-send-email-hauke@hauke-m.de> (sfid-20130526_215304_916888_7E40FF8C)
In-Reply-To: <1369597950-2926-1-git-send-email-hauke@hauke-m.de>
References: <1369597950-2926-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The bcma and ssb mips driver are depending on kernel 3.3.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 dependencies |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/dependencies b/dependencies
index ab18807..ea75be8 100644
--- a/dependencies
+++ b/dependencies
@@ -175,6 +175,9 @@ BT 2.6.29
 # this is easier.
 BCMA_DRIVER_GPIO 3.0
 
+BCMA_DRIVER_MIPS 3.3
+SSB_DRIVER_MIPS 3.3
+
 # rfkill-regulator uses a kernel header file
 # (rfkill-regulator.h) that we don't backport
 # right now, so make it depend on 3.0
-- 
1.7.10.4

