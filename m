Return-path: <backports-owner@vger.kernel.org>
Received: from narfation.org ([79.140.41.39]:48238 "EHLO v3-1039.vlinux.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751212AbaKCWpT (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 3 Nov 2014 17:45:19 -0500
From: Sven Eckelmann <sven@narfation.org>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: backports@vger.kernel.org, hauke@hauke-m.de,
	Sven Eckelmann <sven@narfation.org>
Subject: [PATCH] backport: Fix double fetch in hlist_for_each_entry*_rcu
Date: Mon,  3 Nov 2014 23:38:47 +0100
Message-Id: <1415054327-20110-1-git-send-email-sven@narfation.org> (sfid-20141103_234527_679545_78BBDF77)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The backported (<3.9) version of hlist_for_each_entry_rcu and
hlist_for_each_entry_safe uses the new macro hlist_entry_safe. It is called
with an ACCESS_ONCE parameter for the first parameter ptr. This disallows
merging of the two loads which the current version of the macro uses.

This is problematic because this macro must only generate one load. Otherwise
with two contexts (or CPUs) following could happen:

1. context 1 fetches the ptr to the last entry in hlist_entry_safe() and
   accepts this non-NULL ptr

2. context 2 deletes the last entry and terminates the list with NULL

3. context 1 re-fetches the pointer, doesn't check for zero, calculates the
   entry based on a NULL pointer

4. context 1 crashes because it tries to load/write data from/to the invalid
   address

Instead use a single load to a temporary variable and do the NULL-check and
calculation based on that one. This is also the approach used in the current
Linux versions and was introduced by Paul E. McKenney.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 backport/backport-include/linux/list.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/backport/backport-include/linux/list.h b/backport/backport-include/linux/list.h
index 9042830..5ac2615 100644
--- a/backport/backport-include/linux/list.h
+++ b/backport/backport-include/linux/list.h
@@ -17,7 +17,9 @@
 
 #undef hlist_entry_safe
 #define hlist_entry_safe(ptr, type, member) \
-	(ptr) ? hlist_entry(ptr, type, member) : NULL
+	({ typeof(ptr) ____ptr = (ptr); \
+	   ____ptr ? hlist_entry(____ptr, type, member) : NULL; \
+	})
 
 #define hlist_for_each_entry4(tpos, pos, head, member)			\
 	for (pos = (head)->first;					\
-- 
2.1.1

