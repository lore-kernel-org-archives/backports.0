Return-path: <backports-owner@vger.kernel.org>
Received: from test.hauke-m.de ([5.39.93.123]:44933 "EHLO test.hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751696AbaHIOrq (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 9 Aug 2014 10:47:46 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 4/6] backports: copy include/linux/platform_data/st21nfcb.h
Date: Sat,  9 Aug 2014 16:47:37 +0200
Message-Id: <1407595659-10396-5-git-send-email-hauke@hauke-m.de> (sfid-20140809_164753_033874_19A2A26B)
In-Reply-To: <1407595659-10396-1-git-send-email-hauke@hauke-m.de>
References: <1407595659-10396-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This is needed by drivers/nfc/st21nfcb/i2c.c

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 copy-list | 1 +
 1 file changed, 1 insertion(+)

diff --git a/copy-list b/copy-list
index 71c4861..fdf02c4 100644
--- a/copy-list
+++ b/copy-list
@@ -130,6 +130,7 @@ include/uapi/linux/nfc.h
 drivers/nfc/
 include/linux/platform_data/pn544.h
 include/linux/platform_data/st21nfca.h
+include/linux/platform_data/st21nfcb.h
 
 # Regulator
 # we don't include the whole directory as we need
-- 
1.9.1

