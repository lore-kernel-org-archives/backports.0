Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:35751 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753363AbbINHtB (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 14 Sep 2015 03:49:01 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 07/10] dependencies: deactivate mwifiex SDIO part in kernel < 3.2
Date: Mon, 14 Sep 2015 09:48:39 +0200
Message-Id: <1442216922-3318-8-git-send-email-hauke@hauke-m.de> (sfid-20150914_094905_920817_48C97511)
In-Reply-To: <1442216922-3318-1-git-send-email-hauke@hauke-m.de>
References: <1442216922-3318-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The mwifiex SDIO driver needs mmc_hw_reset() which was added in kernel 3.2.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 dependencies | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/dependencies b/dependencies
index e0b69bf..4f4c922 100644
--- a/dependencies
+++ b/dependencies
@@ -174,3 +174,6 @@ ATH_TRACEPOINTS 3.1
 # to backport that only down to 3.5. For full details refer to backports
 # commit 8cb8816d
 IGB 3.5
+
+# This driver needs mmc_hw_reset() which was added in kernel version 3.2
+MWIFIEX_SDIO 3.2
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe backports" in
