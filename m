Return-Path: <mcgrof+caf_=mcgrof=gmail.com@frijolero.org>
Return-Path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:40582 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752139Ab3C1TNO (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 28 Mar 2013 15:13:14 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 2/8] compat-drivers: add config option CONFIG_WILINK_PLATFORM_DATA
Date: Thu, 28 Mar 2013 20:12:12 +0100
Message-Id: <1364497938-10646-2-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1364497938-10646-1-git-send-email-hauke@hauke-m.de>
References: <1364497938-10646-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 config.mk |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/config.mk b/config.mk
index b2e3d2d..8377278 100644
--- a/config.mk
+++ b/config.mk
@@ -608,14 +608,12 @@ export CONFIG_SSB_SDIOHOST=y
 export CONFIG_B43_SDIO=y
 
 ifdef CONFIG_CRC7
-ifdef CONFIG_WL12XX_PLATFORM_DATA
 ifndef CONFIG_COMPAT_KERNEL_2_6_37
 export CONFIG_COMPAT_WL1251_SDIO=m
 endif #CONFIG_COMPAT_KERNEL_2_6_37
 ifndef CONFIG_COMPAT_KERNEL_2_6_38
 export CONFIG_WLCORE_SDIO=m
 endif #CONFIG_COMPAT_KERNEL_2_6_38
-endif #CONFIG_WL12XX_PLATFORM_DATA
 endif #CONFIG_CRC7
 
 export CONFIG_MWIFIEX_SDIO=m
@@ -677,6 +675,7 @@ endif #CONFIG_COMPAT_KERNEL_2_6_29
 ifndef CONFIG_COMPAT_KERNEL_2_6_30
 
 export CONFIG_WL_TI=y
+# export CONFIG_WILINK_PLATFORM_DATA=y
 export CONFIG_WLCORE=m
 
 ifdef CONFIG_CRC7
-- 
1.7.10.4

