Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:54767 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754970Ab3HPR1D (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 16 Aug 2013 13:27:03 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>,
	Solomon Peachy <pizza@shaftnet.org>
Subject: [PATCH 01/13] backports: cw1200 needs get_random_int() exported
Date: Fri, 16 Aug 2013 19:26:31 +0200
Message-Id: <1376674003-5801-1-git-send-email-hauke@hauke-m.de> (sfid-20130816_192736_502660_AFE81F7C)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

get_random_int() does not get exported in kernel < 3.10 and cw1200
needs it.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
Cc: Solomon Peachy <pizza@shaftnet.org>
---
 dependencies |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/dependencies b/dependencies
index f1e514b..1ad08ac 100644
--- a/dependencies
+++ b/dependencies
@@ -45,6 +45,8 @@ WL1251 3.0
 
 MWIFIEX 2.6.27
 
+CW1200 3.10
+
 # DRM stuff
 HDMI 3.2
 DRM 3.2
-- 
1.7.10.4

