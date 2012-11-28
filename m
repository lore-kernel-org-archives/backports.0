Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 2/6] compat-drivers: remove option for alx driver
Date: Thu, 29 Nov 2012 00:07:45 +0100
Message-Id: <1354144069-28611-3-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1354144069-28611-1-git-send-email-hauke@hauke-m.de>
References: <1354144069-28611-1-git-send-email-hauke@hauke-m.de>
List-ID: <backports@vger.kernel.org>

The alx driver was removed from crap and also remove the config option.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 config.mk |    1 -
 1 file changed, 1 deletion(-)

diff --git a/config.mk b/config.mk
index fb55812..ae515bc 100644
--- a/config.mk
+++ b/config.mk
@@ -412,7 +412,6 @@ export CONFIG_ATL2=m
 export CONFIG_ATL1E=m
 ifndef CONFIG_COMPAT_KERNEL_2_6_28
 export CONFIG_ATL1C=m
-export CONFIG_ALX=m
 endif #CONFIG_COMPAT_KERNEL_2_6_28
 
 ifdef CONFIG_WIRELESS_EXT
-- 
1.7.10.4
