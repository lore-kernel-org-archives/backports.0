Return-Path: <mcgrof+caf_=mcgrof=gmail.com@frijolero.org>
Return-Path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:40598 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752529Ab3C1TNT (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 28 Mar 2013 15:13:19 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 4/8] compat-drivers: add debug config options
Date: Thu, 28 Mar 2013 20:12:14 +0100
Message-Id: <1364497938-10646-4-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1364497938-10646-1-git-send-email-hauke@hauke-m.de>
References: <1364497938-10646-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 config.mk |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/config.mk b/config.mk
index a6017a9..0048e6d 100644
--- a/config.mk
+++ b/config.mk
@@ -285,6 +285,7 @@ export CONFIG_ATH9K_BTCOEX_SUPPORT=y
 ifndef CONFIG_COMPAT_KERNEL_2_6_27
 export CONFIG_ATH6KL=m
 # export CONFIG_ATH6KL_DEBUG=y
+# export CONFIG_ATH6KL_TRACING=y
 endif #CONFIG_COMPAT_KERNEL_2_6_27
 
 # PCI Drivers
@@ -634,6 +635,7 @@ export CONFIG_BRCMFMAC_SDIO=y
 endif #CONFIG_MMC
 
 export CONFIG_RTLWIFI=m
+# export CONFIG_RTLWIFI_DEBUG=y
 export CONFIG_RTL8192C_COMMON=m
 
 # Common rt2x00 requirements
-- 
1.7.10.4

