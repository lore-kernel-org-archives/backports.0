Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:40733 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751716Ab3IKMMb (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 11 Sep 2013 08:12:31 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 09/11] backports: add debugfs_create_x64()
Date: Wed, 11 Sep 2013 14:11:53 +0200
Message-Id: <1378901515-14206-10-git-send-email-hauke@hauke-m.de> (sfid-20130911_141232_241575_43FB1F11)
In-Reply-To: <1378901515-14206-1-git-send-email-hauke@hauke-m.de>
References: <1378901515-14206-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This adds debugfs_create_x64() by calling debugfs_create_u64() instead.
The 64 bit number is then not hex, but dec formated in debug fs.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/debugfs.h |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/backport/backport-include/linux/debugfs.h b/backport/backport-include/linux/debugfs.h
index 16604e3..938eac2 100644
--- a/backport/backport-include/linux/debugfs.h
+++ b/backport/backport-include/linux/debugfs.h
@@ -15,4 +15,13 @@ static inline void debugfs_remove_recursive(struct dentry *dentry)
 #endif
 #endif /* < 2.6.27 */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,35)
+static inline struct dentry *debugfs_create_x64(const char *name, umode_t mode,
+						struct dentry *parent,
+						u64 *value)
+{
+	return debugfs_create_u64(name, mode, parent, value);
+}
+#endif
+
 #endif /* __BACKPORT_LINUX_DEBUGFS_H */
-- 
1.7.10.4

