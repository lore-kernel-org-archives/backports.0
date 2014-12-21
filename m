Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:36595 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753050AbaLURgm (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 21 Dec 2014 12:36:42 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH v2 05/16] header: backport drain_workqueue() by calling flush_workqueue()
Date: Sun, 21 Dec 2014 18:36:19 +0100
Message-Id: <1419183390-22169-6-git-send-email-hauke@hauke-m.de> (sfid-20141221_183646_580926_73004F63)
In-Reply-To: <1419183390-22169-1-git-send-email-hauke@hauke-m.de>
References: <1419183390-22169-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This backport is only needed for kernel < 3.1.
Backporting drain_workqueue() is too hard so we just flush the
workqueue which should work in most cases. This could still cause
problems in some situation.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/workqueue.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/backport/backport-include/linux/workqueue.h b/backport/backport-include/linux/workqueue.h
index ec5c230..078ed59 100644
--- a/backport/backport-include/linux/workqueue.h
+++ b/backport/backport-include/linux/workqueue.h
@@ -60,4 +60,8 @@ void backport_destroy_workqueue(struct workqueue_struct *wq);
 #define system_freezable_power_efficient_wq system_freezable_wq
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,1,0)
+#define drain_workqueue(wq) flush_workqueue(wq)
+#endif
+
 #endif /* __BACKPORT_LINUX_WORKQUEUE_H */
-- 
1.9.1

