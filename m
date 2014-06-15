Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:44894 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752426AbaFOVWe (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 15 Jun 2014 17:22:34 -0400
Received: from localhost (localhost [127.0.0.1])
	by hauke-m.de (Postfix) with ESMTP id E7E8A7E66
	for <backports@vger.kernel.org>; Sun, 15 Jun 2014 23:22:32 +0200 (CEST)
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 15/19] backports: add hashtable.h
Date: Sun, 15 Jun 2014 23:21:43 +0200
Message-Id: <1402867307-31337-16-git-send-email-hauke@hauke-m.de> (sfid-20140615_233457_517019_BCDB1D5F)
In-Reply-To: <1402867307-31337-1-git-send-email-hauke@hauke-m.de>
References: <1402867307-31337-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This header file is used by net/mac802154/llsec.h and does not provide
any function prototype so it is save to copy it.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 copy-list | 1 +
 1 file changed, 1 insertion(+)

diff --git a/copy-list b/copy-list
index c95ea8e..7ad8972 100644
--- a/copy-list
+++ b/copy-list
@@ -13,6 +13,7 @@
 COPYING
 MAINTAINERS
 include/linux/unaligned/
+include/linux/hashtable.h
 
 # 802.11
 drivers/net/wireless/Kconfig
-- 
1.9.1

