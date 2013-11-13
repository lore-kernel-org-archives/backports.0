Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:57406 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755987Ab3KMQIq (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 13 Nov 2013 11:08:46 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 1/2] backports: add replace_fops()
Date: Wed, 13 Nov 2013 17:08:37 +0100
Message-Id: <1384358918-20477-1-git-send-email-hauke@hauke-m.de> (sfid-20131113_170848_768504_CFD84AAF)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This is needed by drivers/media/dvb-core/dvbdev.c and was added in:
commit e84f9e57b90ca89664d733a7cef19aa7ccd832f3
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Sun Sep 22 14:17:15 2013 -0400

    consolidate the reassignments of ->f_op in ->open() instances

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/fs.h |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/backport/backport-include/linux/fs.h b/backport/backport-include/linux/fs.h
index 9de5109..9874f81 100644
--- a/backport/backport-include/linux/fs.h
+++ b/backport/backport-include/linux/fs.h
@@ -38,4 +38,18 @@ extern ssize_t simple_write_to_buffer(void *to, size_t available, loff_t *ppos,
 		const void __user *from, size_t count);
 #endif
 
+#ifndef replace_fops
+/*
+ * This one is to be used *ONLY* from ->open() instances.
+ * fops must be non-NULL, pinned down *and* module dependencies
+ * should be sufficient to pin the caller down as well.
+ */
+#define replace_fops(f, fops) \
+	do {	\
+		struct file *__file = (f); \
+		fops_put(__file->f_op); \
+		BUG_ON(!(__file->f_op = (fops))); \
+	} while(0)
+#endif /* replace_fops */
+
 #endif	/* _COMPAT_LINUX_FS_H */
-- 
1.7.10.4

