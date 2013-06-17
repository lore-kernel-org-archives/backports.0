Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:44928 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933042Ab3FQNV3 (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 17 Jun 2013 09:21:29 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 6/7] backprots: ath10k needs at least kernel version 2.6.30
Date: Mon, 17 Jun 2013 15:21:06 +0200
Message-Id: <1371475267-27179-6-git-send-email-hauke@hauke-m.de> (sfid-20130617_152146_182429_1643746C)
In-Reply-To: <1371475267-27179-1-git-send-email-hauke@hauke-m.de>
References: <1371475267-27179-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 dependencies |    1 +
 1 file changed, 1 insertion(+)

diff --git a/dependencies b/dependencies
index 0200ba8..e226b7a 100644
--- a/dependencies
+++ b/dependencies
@@ -13,6 +13,7 @@ MAC80211_HWSIM 2.6.31
 ATH6KL 2.6.27
 
 WIL6210 2.6.31
+ATH10K 2.6.30
 
 ATL1C 2.6.28
 ATL1E 2.6.26
-- 
1.7.10.4

