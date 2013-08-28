Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pb0-f44.google.com ([209.85.160.44]:44405 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753114Ab3H1A4Y (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 27 Aug 2013 20:56:24 -0400
Received: by mail-pb0-f44.google.com with SMTP id xa7so5543527pbc.31
        for <backports@vger.kernel.org>; Tue, 27 Aug 2013 17:56:24 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH] backports: add missing returns on ww_mutex backpots
Date: Tue, 27 Aug 2013 18:05:44 -0700
Message-Id: <1377651944-1258-1-git-send-email-mcgrof@do-not-panic.com> (sfid-20130828_025625_911541_75825707)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

Two returns were missing on the ww_mutex backport, add these.
The enhancements are not supported on older kernels so just
bail out early.

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 backport/compat/kernel/ww_mutex.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/backport/compat/kernel/ww_mutex.c b/backport/compat/kernel/ww_mutex.c
index 257c2a4..204ac8f 100644
--- a/backport/compat/kernel/ww_mutex.c
+++ b/backport/compat/kernel/ww_mutex.c
@@ -206,10 +206,12 @@ static void mspin_unlock(struct mspin_node **lock, struct mspin_node *node)
 
 static inline bool owner_running(struct mutex *lock, struct task_struct *owner)
 {
+	return false;
 }
 
 int mutex_spin_on_owner(struct mutex *lock, struct task_struct *owner)
 {
+	return 1;
 }
 
 static inline int mutex_can_spin_on_owner(struct mutex *lock)
-- 
1.7.10.4

