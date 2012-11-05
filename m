Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 2/8] compat-drivers: activate CONFIG_BT_HCIUART_3WIRE in config.mk
Date: Tue,  6 Nov 2012 00:11:49 +0100
Message-Id: <1352157115-13469-3-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1352157115-13469-1-git-send-email-hauke@hauke-m.de>
References: <1352157115-13469-1-git-send-email-hauke@hauke-m.de>
List-ID: <backports@vger.kernel.org>


Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 config.mk |    1 +
 1 file changed, 1 insertion(+)

diff --git a/config.mk b/config.mk
index e6edca5..458f0c1 100644
--- a/config.mk
+++ b/config.mk
@@ -218,6 +218,7 @@ export CONFIG_BT_HCIUART_H4=y
 export CONFIG_BT_HCIUART_BCSP=y
 export CONFIG_BT_HCIUART_ATH3K=y
 export CONFIG_BT_HCIUART_LL=y
+export CONFIG_BT_HCIUART_3WIRE=y
 
 export CONFIG_BT_HCIVHCI=m
 export CONFIG_BT_MRVL=m
-- 
1.7.10.4
