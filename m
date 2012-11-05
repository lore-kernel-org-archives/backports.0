Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 4/8] compat-drviers: remove CONFIG_IWM from config.mk
Date: Tue,  6 Nov 2012 00:11:51 +0100
Message-Id: <1352157115-13469-5-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1352157115-13469-1-git-send-email-hauke@hauke-m.de>
References: <1352157115-13469-1-git-send-email-hauke@hauke-m.de>
List-ID: <backports@vger.kernel.org>

The device driver was removed from the kernel some time ago.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 config.mk |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/config.mk b/config.mk
index b7a468c..0ea2059 100644
--- a/config.mk
+++ b/config.mk
@@ -609,10 +609,6 @@ export CONFIG_COMPAT_LIBERTAS_SDIO=m
 NEED_LIBERTAS=y
 endif #CONFIG_COMPAT_KERNEL_2_6_32
 
-export CONFIG_IWM=m
-# export CONFIG_IWM_DEBUG=y
-# export CONFIG_IWM_TRACING=y
-
 export CONFIG_BT_HCIBTSDIO=m
 export CONFIG_BT_MRVL_SDIO=m
 
-- 
1.7.10.4
