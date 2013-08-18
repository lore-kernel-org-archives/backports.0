Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:60899 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755548Ab3HRXkH (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 18 Aug 2013 19:40:07 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH v2 17/19] backports: Atheros atl1c needs build_skb(), do not build on < 3.5
Date: Mon, 19 Aug 2013 01:38:02 +0200
Message-Id: <1376869084-16513-18-git-send-email-hauke@hauke-m.de> (sfid-20130819_020909_834290_B5C3E16E)
In-Reply-To: <1376869084-16513-1-git-send-email-hauke@hauke-m.de>
References: <1376869084-16513-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The Atheros atl1c driver now uses build_skb() which was added in 3.5.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 dependencies |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dependencies b/dependencies
index 66807ae..8a3b0f6 100644
--- a/dependencies
+++ b/dependencies
@@ -15,7 +15,7 @@ ATH6KL 2.6.27
 WIL6210 2.6.31
 ATH10K 2.6.30
 
-ATL1C 2.6.28
+ATL1C 3.5
 ATL1E 2.6.26
 ALX 2.6.31
 
-- 
1.7.10.4

