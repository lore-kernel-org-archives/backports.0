Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:51921 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752900Ab3G1BQv (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 27 Jul 2013 21:16:51 -0400
Received: by mail-pa0-f43.google.com with SMTP id hz10so3593425pad.16
        for <backports@vger.kernel.org>; Sat, 27 Jul 2013 18:16:51 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [RFC 2/9] backports: fix wq_name_list initialization
Date: Sat, 27 Jul 2013 18:16:23 -0700
Message-Id: <1374974190-31561-3-git-send-email-mcgrof@do-not-panic.com> (sfid-20130728_031653_052098_E7F1180A)
In-Reply-To: <1374974190-31561-1-git-send-email-mcgrof@do-not-panic.com>
References: <1374974190-31561-1-git-send-email-mcgrof@do-not-panic.com>
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

