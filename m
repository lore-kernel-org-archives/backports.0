Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 6/8] compat-drivers: add CONFIG_RT2800PCI_RT3290 in config.mk
Date: Tue,  6 Nov 2012 00:11:53 +0100
Message-Id: <1352157115-13469-7-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1352157115-13469-1-git-send-email-hauke@hauke-m.de>
References: <1352157115-13469-1-git-send-email-hauke@hauke-m.de>
List-ID: <backports@vger.kernel.org>


Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 config.mk |    1 +
 1 file changed, 1 insertion(+)

diff --git a/config.mk b/config.mk
index ec9c8ca..985fb6a 100644
--- a/config.mk
+++ b/config.mk
@@ -390,6 +390,7 @@ export CONFIG_RT2400PCI=m
 export CONFIG_RT2500PCI=m
 ifdef CONFIG_CRC_CCITT
 export CONFIG_RT2800PCI=m
+export CONFIG_RT2800PCI_RT3290=y
 export CONFIG_RT2800PCI_RT33XX=y
 export CONFIG_RT2800PCI_RT35XX=y
 export CONFIG_RT2800PCI_RT53XX=y
-- 
1.7.10.4
