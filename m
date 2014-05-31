Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:56005 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751578AbaEaRQr (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 31 May 2014 13:16:47 -0400
Received: from localhost (localhost [127.0.0.1])
	by hauke-m.de (Postfix) with ESMTP id 1165A7E52
	for <backports@vger.kernel.org>; Sat, 31 May 2014 19:16:46 +0200 (CEST)
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 06/13] backports: only add net_get_random_once() when not available
Date: Sat, 31 May 2014 19:16:03 +0200
Message-Id: <1401556570-3363-7-git-send-email-hauke@hauke-m.de> (sfid-20140531_191648_264226_6A147AC7)
In-Reply-To: <1401556570-3363-1-git-send-email-hauke@hauke-m.de>
References: <1401556570-3363-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

net_get_random_once() was added unconditionally also when the kernel we
are compiling against already provided this function, this patch checks
that first.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/net.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/backport/backport-include/linux/net.h b/backport/backport-include/linux/net.h
index 385f807..0e436d4 100644
--- a/backport/backport-include/linux/net.h
+++ b/backport/backport-include/linux/net.h
@@ -64,7 +64,7 @@ do {								\
  * may affect tracing. My recommendation is that if you have a need for
  * static keys you just require at least 3.5 to remain sane.
  */
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0) && !defined(net_get_random_once)
 #define __BACKPORT_NET_GET_RANDOM_ONCE 1
 #endif
 #endif /* ___NET_RANDOM_STATIC_KEY_INIT */
-- 
1.9.1

