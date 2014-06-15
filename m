Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:44900 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752309AbaFOVWh (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 15 Jun 2014 17:22:37 -0400
Received: from localhost (localhost [127.0.0.1])
	by hauke-m.de (Postfix) with ESMTP id 227877E61
	for <backports@vger.kernel.org>; Sun, 15 Jun 2014 23:22:36 +0200 (CEST)
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 17/19] backports: activate NFC_TRF7970A on kernel 3.4
Date: Sun, 15 Jun 2014 23:21:45 +0200
Message-Id: <1402867307-31337-18-git-send-email-hauke@hauke-m.de> (sfid-20140615_233456_669353_71769970)
In-Reply-To: <1402867307-31337-1-git-send-email-hauke@hauke-m.de>
References: <1402867307-31337-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The function devm_gpio_request_one() was backported some time ago.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 dependencies | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/dependencies b/dependencies
index b4b68bd..2888bec 100644
--- a/dependencies
+++ b/dependencies
@@ -122,10 +122,7 @@ REGULATOR_AB3100 3.9
 # only introduced in kernel 3.1
 NFC 3.1
 
-# requires devm_gpio_request_one() added but since
-# gpio infrastructure has been strongly shuffled around
-# we require drivers to use the in-kernel gptio infrastructure
-NFC_TRF7970A 3.5
+NFC_TRF7970A 3.4
 
 INTEL_IPS 3.2
 
-- 
1.9.1

