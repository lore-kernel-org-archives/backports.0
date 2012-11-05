Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 1/8] compat-drivers: remove CONFIG_ATH9K_PKTLOG form config.mk
Date: Tue,  6 Nov 2012 00:11:48 +0100
Message-Id: <1352157115-13469-2-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1352157115-13469-1-git-send-email-hauke@hauke-m.de>
References: <1352157115-13469-1-git-send-email-hauke@hauke-m.de>
List-ID: <backports@vger.kernel.org>

This option is not available any more.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 config.mk |    1 -
 1 file changed, 1 deletion(-)

diff --git a/config.mk b/config.mk
index 18e91b4..e6edca5 100644
--- a/config.mk
+++ b/config.mk
@@ -260,7 +260,6 @@ export CONFIG_ATH9K_HW=m
 export CONFIG_ATH9K_COMMON=m
 # export CONFIG_ATH9K_DEBUGFS=y
 # export CONFIG_ATH9K_AHB=y
-# export CONFIG_ATH9K_PKTLOG=y
 
 # Disable this to get minstrel as default, we leave the ath9k
 # rate control algorithm as the default for now as that is also
-- 
1.7.10.4
