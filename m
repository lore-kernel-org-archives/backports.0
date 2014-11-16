Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:37690 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751278AbaKPUtl (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 16 Nov 2014 15:49:41 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 19/20] headers: fix problem when unloading mac80211 on Ubuntu 14.04
Date: Sun, 16 Nov 2014 21:49:19 +0100
Message-Id: <1416170960-12868-20-git-send-email-hauke@hauke-m.de> (sfid-20141116_221347_703719_94E73CC2)
In-Reply-To: <1416170960-12868-1-git-send-email-hauke@hauke-m.de>
References: <1416170960-12868-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

When unloading mac80211 on the default kernel which is currently
shipped in Ubuntu 14.04 this commit causes a kernel error message. Now
we check if the list was deleted before and only do so if it was not
done before. Ubuntu probably backported this patch in their kernel.

commit 97666f936e0656a1b28c40cc33981a8db65e1a11
Author: Hauke Mehrtens <hauke@hauke-m.de>
Date:   Sun Nov 16 14:23:24 2014 +0100

    headers: delete the list in unregister_netdevice_many()

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/netdevice.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/backport/backport-include/linux/netdevice.h b/backport/backport-include/linux/netdevice.h
index 4eec6c0..b453280 100644
--- a/backport/backport-include/linux/netdevice.h
+++ b/backport/backport-include/linux/netdevice.h
@@ -194,7 +194,8 @@ static inline void backport_unregister_netdevice_many(struct list_head *head)
 {
 	unregister_netdevice_many(head);
 
-	list_del(head);
+	if (!(head->next == LIST_POISON1 && head->prev == LIST_POISON2))
+		list_del(head);
 }
 #define unregister_netdevice_many LINUX_BACKPORT(unregister_netdevice_many)
 #endif
-- 
1.9.1

