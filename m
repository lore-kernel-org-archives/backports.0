Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:54680 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751347AbaARUIk (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 18 Jan 2014 15:08:40 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 4/5] backports: add missing header file
Date: Sat, 18 Jan 2014 21:05:23 +0100
Message-Id: <1390075524-6924-5-git-send-email-hauke@hauke-m.de> (sfid-20140118_210841_730860_32CD1895)
In-Reply-To: <1390075524-6924-1-git-send-email-hauke@hauke-m.de>
References: <1390075524-6924-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The act8865 regulator driver needs this header file.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 copy-list |    1 +
 1 file changed, 1 insertion(+)

diff --git a/copy-list b/copy-list
index 9ec4f4b..307ab00 100644
--- a/copy-list
+++ b/copy-list
@@ -133,6 +133,7 @@ include/linux/platform_data/pn544.h
 # regulator routines are defined via the header file
 # include/linux/regulator/consumer.h and dummy.h
 include/linux/regulator/ab8500.h
+include/linux/regulator/act8865.h
 include/linux/regulator/db8500-prcmu.h
 include/linux/regulator/fan53555.h
 include/linux/regulator/gpio-regulator.h
-- 
1.7.10.4

