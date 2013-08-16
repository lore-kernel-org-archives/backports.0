Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:54795 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753647Ab3HPR13 (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 16 Aug 2013 13:27:29 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 07/13] backports: add include/linux/regulator/pfuze100.h
Date: Fri, 16 Aug 2013 19:26:37 +0200
Message-Id: <1376674003-5801-7-git-send-email-hauke@hauke-m.de> (sfid-20130816_192739_487833_B41F6344)
In-Reply-To: <1376674003-5801-1-git-send-email-hauke@hauke-m.de>
References: <1376674003-5801-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This is a new driver which needs a new header file.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 copy-list |    1 +
 1 file changed, 1 insertion(+)

diff --git a/copy-list b/copy-list
index 534f0b4..89147e8 100644
--- a/copy-list
+++ b/copy-list
@@ -151,6 +151,7 @@ include/linux/regulator/max8649.h
 include/linux/regulator/max8660.h
 include/linux/regulator/max8952.h
 include/linux/regulator/max8973-regulator.h
+include/linux/regulator/pfuze100.h
 include/linux/regulator/tps51632-regulator.h
 include/linux/regulator/tps62360.h
 include/linux/regulator/tps6507x.h
-- 
1.7.10.4

