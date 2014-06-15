Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:44870 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752220AbaFOVWV (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 15 Jun 2014 17:22:21 -0400
Received: from localhost (localhost [127.0.0.1])
	by hauke-m.de (Postfix) with ESMTP id 6B6837E5A
	for <backports@vger.kernel.org>; Sun, 15 Jun 2014 23:22:20 +0200 (CEST)
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 10/19] backports: copy include/linux/platform_data/st21nfca.h
Date: Sun, 15 Jun 2014 23:21:38 +0200
Message-Id: <1402867307-31337-11-git-send-email-hauke@hauke-m.de> (sfid-20140615_232222_833161_0CDDAA8C)
In-Reply-To: <1402867307-31337-1-git-send-email-hauke@hauke-m.de>
References: <1402867307-31337-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This is needed by the st21nfca nfc driver.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 copy-list | 1 +
 1 file changed, 1 insertion(+)

diff --git a/copy-list b/copy-list
index d3d4147..c95ea8e 100644
--- a/copy-list
+++ b/copy-list
@@ -128,6 +128,7 @@ include/uapi/linux/nfc.h
 # NFC drivers
 drivers/nfc/
 include/linux/platform_data/pn544.h
+include/linux/platform_data/st21nfca.h
 
 # Regulator
 # we don't include the whole directory as we need
-- 
1.9.1

