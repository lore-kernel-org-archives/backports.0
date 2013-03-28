Return-Path: <mcgrof+caf_=mcgrof=gmail.com@frijolero.org>
Return-Path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:40595 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752529Ab3C1TNR (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 28 Mar 2013 15:13:17 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 3/8] compat-drivers: add config option CONFIG_RT2800USB_RT55XX
Date: Thu, 28 Mar 2013 20:12:13 +0100
Message-Id: <1364497938-10646-3-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1364497938-10646-1-git-send-email-hauke@hauke-m.de>
References: <1364497938-10646-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 config.mk |    1 +
 1 file changed, 1 insertion(+)

diff --git a/config.mk b/config.mk
index 8377278..a6017a9 100644
--- a/config.mk
+++ b/config.mk
@@ -547,6 +547,7 @@ export CONFIG_RT2800USB=m
 export CONFIG_RT2800USB_RT33XX=y
 export CONFIG_RT2800USB_RT35XX=y
 export CONFIG_RT2800USB_RT53XX=y
+export CONFIG_RT2800USB_RT55XX=y
 export CONFIG_RT2800USB_UNKNOWN=y
 endif #CONFIG_CRC_CCITT
 export CONFIG_RT2X00_LIB_USB=m
-- 
1.7.10.4

