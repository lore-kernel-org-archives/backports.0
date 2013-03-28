Return-Path: <mcgrof+caf_=mcgrof=gmail.com@frijolero.org>
Return-Path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:40581 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751110Ab3C1TNN (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 28 Mar 2013 15:13:13 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 1/8] compat-drivers: add config option IWLWIFI_OPMODE_MODULAR
Date: Thu, 28 Mar 2013 20:12:11 +0100
Message-Id: <1364497938-10646-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This is needed to make the common intel driver module export its
symbols.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 config.mk |    1 +
 1 file changed, 1 insertion(+)

diff --git a/config.mk b/config.mk
index 13b44d4..b2e3d2d 100644
--- a/config.mk
+++ b/config.mk
@@ -301,6 +301,7 @@ endif #CONFIG_COMPAT_KERNEL_2_6_31
 export CONFIG_IWLWIFI=m
 export CONFIG_IWLDVM=m
 export CONFIG_IWLMVM=m
+export CONFIG_IWLWIFI_OPMODE_MODULAR=y
 export CONFIG_IWLWIFI_P2P=y
 # export CONFIG_IWLWIFI_DEBUG=y
 # export CONFIG_IWLWIFI_DEBUGFS=y
-- 
1.7.10.4

