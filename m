Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:56000 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751578AbaEaRQp (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 31 May 2014 13:16:45 -0400
Received: from localhost (localhost [127.0.0.1])
	by hauke-m.de (Postfix) with ESMTP id 811027E52
	for <backports@vger.kernel.org>; Sat, 31 May 2014 19:16:44 +0200 (CEST)
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 05/13] backports: fix build when CONFIG_PTP_1588_CLOCK=m
Date: Sat, 31 May 2014 19:16:02 +0200
Message-Id: <1401556570-3363-6-git-send-email-hauke@hauke-m.de> (sfid-20140531_191646_725641_54B38016)
In-Reply-To: <1401556570-3363-1-git-send-email-hauke@hauke-m.de>
References: <1401556570-3363-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

ifdef just checked if this was build into the kernel and not if it was
build as a module.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/compat/compat-3.5.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/backport/compat/compat-3.5.c b/backport/compat/compat-3.5.c
index f9590d7..2727eb3 100644
--- a/backport/compat/compat-3.5.c
+++ b/backport/compat/compat-3.5.c
@@ -66,7 +66,7 @@ EXPORT_SYMBOL_GPL(overflowuid);
 EXPORT_SYMBOL_GPL(overflowgid);
 #endif
 
-#ifdef CONFIG_PTP_1588_CLOCK
+#if IS_ENABLED(CONFIG_PTP_1588_CLOCK)
 int ptp_clock_index(struct ptp_clock *ptp)
 {
 	return ptp->index;
-- 
1.9.1

