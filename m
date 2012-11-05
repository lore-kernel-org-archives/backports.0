Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 5/8] compat-drivers: remove CONFIG_WIL6210 from config.mk
Date: Tue,  6 Nov 2012 00:11:52 +0100
Message-Id: <1352157115-13469-6-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1352157115-13469-1-git-send-email-hauke@hauke-m.de>
References: <1352157115-13469-1-git-send-email-hauke@hauke-m.de>
List-ID: <backports@vger.kernel.org>

The device driver was removed from crap some time ago.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 config.mk |    5 -----
 1 file changed, 5 deletions(-)

diff --git a/config.mk b/config.mk
index 0ea2059..ec9c8ca 100644
--- a/config.mk
+++ b/config.mk
@@ -275,11 +275,6 @@ export CONFIG_COMPAT_ATH9K_RATE_CONTROL=y
 
 export CONFIG_ATH9K_BTCOEX_SUPPORT=y
 
-# WIL6210 requires MSI only available >= 2.6.30
-ifndef CONFIG_COMPAT_KERNEL_2_6_30
-export CONFIG_WIL6210=m
-endif #CONFIG_COMPAT_KERNEL_2_6_30
-
 ifndef CONFIG_COMPAT_KERNEL_2_6_27
 export CONFIG_ATH6KL=m
 # export CONFIG_ATH6KL_DEBUG=y
-- 
1.7.10.4
