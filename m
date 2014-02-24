Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:35012 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750871AbaBXAqW (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 23 Feb 2014 19:46:22 -0500
Received: from localhost (localhost [127.0.0.1])
	by hauke-m.de (Postfix) with ESMTP id D95057E57
	for <backports@vger.kernel.org>; Mon, 24 Feb 2014 01:46:21 +0100 (CET)
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 02/12] backports: add atomic64_set()
Date: Mon, 24 Feb 2014 01:45:44 +0100
Message-Id: <1393202754-12919-3-git-send-email-hauke@hauke-m.de> (sfid-20140224_014623_758457_A65123D5)
In-Reply-To: <1393202754-12919-1-git-send-email-hauke@hauke-m.de>
References: <1393202754-12919-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

atomic64_set() is now used by mac80211 and it is not available on some
old arm kernels.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/compat/compat_atomic.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/backport/compat/compat_atomic.c b/backport/compat/compat_atomic.c
index f91ae75..5ced5a4 100644
--- a/backport/compat/compat_atomic.c
+++ b/backport/compat/compat_atomic.c
@@ -17,6 +17,16 @@ long long atomic64_read(const atomic64_t *v)
 }
 EXPORT_SYMBOL_GPL(atomic64_read);
 
+void atomic64_set(atomic64_t *v, long long i)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&lock, flags);
+	v->counter = i;
+	spin_unlock_irqrestore(&lock, flags);
+}
+EXPORT_SYMBOL_GPL(atomic64_set);
+
 long long atomic64_add_return(long long a, atomic64_t *v)
 {
 	unsigned long flags;
-- 
1.7.10.4

