Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:35008 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750871AbaBXAqS (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 23 Feb 2014 19:46:18 -0500
Received: from localhost (localhost [127.0.0.1])
	by hauke-m.de (Postfix) with ESMTP id 305287E58
	for <backports@vger.kernel.org>; Mon, 24 Feb 2014 01:46:17 +0100 (CET)
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 01/12] backports: fix indenting
Date: Mon, 24 Feb 2014 01:45:43 +0100
Message-Id: <1393202754-12919-2-git-send-email-hauke@hauke-m.de> (sfid-20140224_014619_618910_364907A7)
In-Reply-To: <1393202754-12919-1-git-send-email-hauke@hauke-m.de>
References: <1393202754-12919-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Replace spaces with tabs.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/compat/compat_atomic.c |   24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/backport/compat/compat_atomic.c b/backport/compat/compat_atomic.c
index b8565aa..f91ae75 100644
--- a/backport/compat/compat_atomic.c
+++ b/backport/compat/compat_atomic.c
@@ -7,25 +7,25 @@ static DEFINE_SPINLOCK(lock);
 
 long long atomic64_read(const atomic64_t *v)
 {
-    unsigned long flags;
-    long long val;
+	unsigned long flags;
+	long long val;
 
-    spin_lock_irqsave(&lock, flags);
-    val = v->counter;
-    spin_unlock_irqrestore(&lock, flags);
-    return val;
+	spin_lock_irqsave(&lock, flags);
+	val = v->counter;
+	spin_unlock_irqrestore(&lock, flags);
+	return val;
 }
 EXPORT_SYMBOL_GPL(atomic64_read);
 
 long long atomic64_add_return(long long a, atomic64_t *v)
 {
-    unsigned long flags;
-    long long val;
+	unsigned long flags;
+	long long val;
 
-    spin_lock_irqsave(&lock, flags);
-    val = v->counter += a;
-    spin_unlock_irqrestore(&lock, flags);
-    return val;
+	spin_lock_irqsave(&lock, flags);
+	val = v->counter += a;
+	spin_unlock_irqrestore(&lock, flags);
+	return val;
 }
 EXPORT_SYMBOL_GPL(atomic64_add_return);
 
-- 
1.7.10.4

