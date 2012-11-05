Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 3/8] compat-drivers: add CONFIG_BT_WILINK in config.mk
Date: Tue,  6 Nov 2012 00:11:50 +0100
Message-Id: <1352157115-13469-4-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1352157115-13469-1-git-send-email-hauke@hauke-m.de>
References: <1352157115-13469-1-git-send-email-hauke@hauke-m.de>
List-ID: <backports@vger.kernel.org>


Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 config.mk |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/config.mk b/config.mk
index 458f0c1..b7a468c 100644
--- a/config.mk
+++ b/config.mk
@@ -222,6 +222,9 @@ export CONFIG_BT_HCIUART_3WIRE=y
 
 export CONFIG_BT_HCIVHCI=m
 export CONFIG_BT_MRVL=m
+ifndef CONFIG_COMPAT_KERNEL_2_6_39
+export CONFIG_BT_WILINK=m
+endif #CONFIG_COMPAT_KERNEL_2_6_39
 
 ifdef CONFIG_PCMCIA
 export CONFIG_BT_HCIDTL1=m
-- 
1.7.10.4
