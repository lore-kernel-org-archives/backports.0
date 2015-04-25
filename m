Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:49624 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751975AbbDYNvT (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 25 Apr 2015 09:51:19 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 3/9] copy: add fixp-arith.h
Date: Sat, 25 Apr 2015 15:50:58 +0200
Message-Id: <1429969864-16831-4-git-send-email-hauke@hauke-m.de> (sfid-20150425_155124_471058_309D446A)
In-Reply-To: <1429969864-16831-1-git-send-email-hauke@hauke-m.de>
References: <1429969864-16831-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This file is needed by some media drivers.
It only contains inline functions and macros, so it is save to copy it.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 copy-list | 1 +
 1 file changed, 1 insertion(+)

diff --git a/copy-list b/copy-list
index ed9c26a..25b9ad1 100644
--- a/copy-list
+++ b/copy-list
@@ -14,6 +14,7 @@ COPYING
 MAINTAINERS
 include/linux/unaligned/
 include/linux/hashtable.h
+include/linux/fixp-arith.h
 
 # 802.11
 drivers/net/wireless/Kconfig
-- 
1.9.1

