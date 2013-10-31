Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:49160 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751743Ab3JaWDc (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 31 Oct 2013 18:03:32 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 1/3] backports: do not add debugfs_create_x64() on RHEL 6.4
Date: Thu, 31 Oct 2013 23:03:16 +0100
Message-Id: <1383256998-32371-1-git-send-email-hauke@hauke-m.de> (sfid-20131031_230333_860650_7EBEA355)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

debugfs_create_x64() is provided by the RHEL 6.4 kernel and should not
be added to the build on such a kernel.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/debugfs.h |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/backport/backport-include/linux/debugfs.h b/backport/backport-include/linux/debugfs.h
index 938eac2..d2e6b38 100644
--- a/backport/backport-include/linux/debugfs.h
+++ b/backport/backport-include/linux/debugfs.h
@@ -16,6 +16,7 @@ static inline void debugfs_remove_recursive(struct dentry *dentry)
 #endif /* < 2.6.27 */
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,35)
+#if RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(6,4)
 static inline struct dentry *debugfs_create_x64(const char *name, umode_t mode,
 						struct dentry *parent,
 						u64 *value)
@@ -23,5 +24,6 @@ static inline struct dentry *debugfs_create_x64(const char *name, umode_t mode,
 	return debugfs_create_u64(name, mode, parent, value);
 }
 #endif
+#endif
 
 #endif /* __BACKPORT_LINUX_DEBUGFS_H */
-- 
1.7.10.4

