Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:55247 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750965Ab3K3Ty4 (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 30 Nov 2013 14:54:56 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 3/5] backports: remove duplicate allyesconfig from help
Date: Sat, 30 Nov 2013 20:54:41 +0100
Message-Id: <1385841283-10277-3-git-send-email-hauke@hauke-m.de> (sfid-20131130_205501_389985_AF55D045)
In-Reply-To: <1385841283-10277-1-git-send-email-hauke@hauke-m.de>
References: <1385841283-10277-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

allyesconfig was mentioned in the help dialog twice.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/Makefile |    1 -
 1 file changed, 1 deletion(-)

diff --git a/backport/Makefile b/backport/Makefile
index ca69f41..ea3982b 100644
--- a/backport/Makefile
+++ b/backport/Makefile
@@ -138,7 +138,6 @@ help: defconfig-help
 	@echo ""
 	@echo "Configuration targets:"
 	@echo "  menuconfig      - Update current config utilising a menu based program"
-	@echo "  allyesconfig    - New config where all options are accepted with yes"
 	@echo "  oldconfig       - Update current config utilising a provided .config as base"
 	@echo "  oldaskconfig    - ??"
 	@echo "  silentoldconfig - Same as oldconfig, but quietly, additionally update deps"
-- 
1.7.10.4

