Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:39108 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751876AbbHBWh4 (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 2 Aug 2015 18:37:56 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@kernel.org
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 1/8] backports: do not add debugfs_create_devm_seqfile() on recent kernel versions
Date: Mon,  3 Aug 2015 00:37:40 +0200
Message-Id: <1438555067-15301-2-git-send-email-hauke@hauke-m.de> (sfid-20150803_003801_857971_22B96247)
In-Reply-To: <1438555067-15301-1-git-send-email-hauke@hauke-m.de>
References: <1438555067-15301-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

An ifdef for the kernel version was missing around the header of
debugfs_create_devm_seqfile() and the LINUX_BACKPORT() was also not
added.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/debugfs.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/backport/backport-include/linux/debugfs.h b/backport/backport-include/linux/debugfs.h
index ef9b6e4..a684353 100644
--- a/backport/backport-include/linux/debugfs.h
+++ b/backport/backport-include/linux/debugfs.h
@@ -5,6 +5,8 @@
 #include <linux/device.h>
 #include <generated/utsrelease.h>
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,19,0)
+#define debugfs_create_devm_seqfile LINUX_BACKPORT(debugfs_create_devm_seqfile)
 #if defined(CONFIG_DEBUG_FS)
 struct dentry *debugfs_create_devm_seqfile(struct device *dev, const char *name,
 					   struct dentry *parent,
@@ -20,5 +22,6 @@ static inline struct dentry *debugfs_create_devm_seqfile(struct device *dev,
 	return ERR_PTR(-ENODEV);
 }
 #endif /* CONFIG_DEBUG_FS */
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,19,0) */
 
 #endif /* __BACKPORT_DEBUGFS_H_ */
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe backports" in
