Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:56145 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757273AbcGJVO6 (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 10 Jul 2016 17:14:58 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 03/19] dependencies: deactivate igb on kernel < 3.11
Date: Sun, 10 Jul 2016 23:14:29 +0200
Message-Id: <1468185285-28265-4-git-send-email-hauke@hauke-m.de> (sfid-20160710_231501_690945_1380A93F)
In-Reply-To: <1468185285-28265-1-git-send-email-hauke@hauke-m.de>
References: <1468185285-28265-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

igb now needs the mpls_features member on skb_buff, which was added
with kernel 3.11, deactivate it till this gets backported.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 dependencies | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/dependencies b/dependencies
index 1af2c0f..2a51bcc 100644
--- a/dependencies
+++ b/dependencies
@@ -136,7 +136,8 @@ ATH9K_HWRNG 3.17
 # and since net_get_random_once() depends on static keys we've decided
 # to backport that only down to 3.5. For full details refer to backports
 # commit 8cb8816d
-IGB 3.5
+# mpls_features was added with kernel 3.11
+IGB 3.11
 
 # This driver needs mmc_hw_reset() which was added in kernel version 3.2
 MWIFIEX_SDIO 3.2
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
