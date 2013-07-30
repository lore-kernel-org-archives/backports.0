Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pb0-f49.google.com ([209.85.160.49]:46428 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753342Ab3G3J0O (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 30 Jul 2013 05:26:14 -0400
Received: by mail-pb0-f49.google.com with SMTP id xb4so1510234pbc.8
        for <backports@vger.kernel.org>; Tue, 30 Jul 2013 02:26:13 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 02/14] backports: fix wq_name_list initialization
Date: Tue, 30 Jul 2013 02:25:47 -0700
Message-Id: <1375176359-1331-3-git-send-email-mcgrof@do-not-panic.com> (sfid-20130730_112615_447379_90C0F6DF)
In-Reply-To: <1375176359-1331-1-git-send-email-mcgrof@do-not-panic.com>
References: <1375176359-1331-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

As noted by Johannes this wasn't being initialized
without this.

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 backport/compat/compat-3.3.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/backport/compat/compat-3.3.c b/backport/compat/compat-3.3.c
index d86b40e..75bd5e5 100644
--- a/backport/compat/compat-3.3.c
+++ b/backport/compat/compat-3.3.c
@@ -174,7 +174,7 @@ out:
 EXPORT_SYMBOL_GPL(__pskb_copy);
 
 static DEFINE_SPINLOCK(wq_name_lock);
-static struct list_head wq_name_list;
+static LIST_HEAD(wq_name_list);
 
 struct wq_name {
 	struct list_head list;
@@ -204,7 +204,7 @@ backport_alloc_workqueue(const char *fmt, unsigned int flags,
 				    0,
 #endif
 				    key, lock_name);
-#else	                        
+#else
 	wq = __alloc_workqueue_key(n->name, flags, max_active, key, lock_name);
 #endif
 	if (!wq) {
-- 
1.7.10.4

