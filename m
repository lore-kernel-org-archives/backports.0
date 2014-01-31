Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:51551 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751410AbaAaKeA (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 31 Jan 2014 05:34:00 -0500
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] backports: backport power efficient workqueues
Date: Fri, 31 Jan 2014 11:33:52 +0100
Message-Id: <1391164432-8699-1-git-send-email-johannes@sipsolutions.net> (sfid-20140131_113402_405090_F308635E)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

These only exist starting from 3.11, and wireless code will
start using them soon. Backport them as simple defines using
the corresponding non-power-efficient workqueues.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/workqueue.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/backport/backport-include/linux/workqueue.h b/backport/backport-include/linux/workqueue.h
index 1949876..63a3b17 100644
--- a/backport/backport-include/linux/workqueue.h
+++ b/backport/backport-include/linux/workqueue.h
@@ -117,4 +117,10 @@ static inline void flush_delayed_work(struct delayed_work *dwork)
 }
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,11,0)
+/* power efficient workqueues were added in commit 0668106ca386. */
+#define system_power_efficient_wq system_wq
+#define system_freezable_power_efficient_wq system_freezable_wq
+#endif
+
 #endif /* __BACKPORT_LINUX_WORKQUEUE_H */
-- 
1.8.5.2

