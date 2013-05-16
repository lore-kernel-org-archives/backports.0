Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:49766 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751144Ab3EPFsk (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 16 May 2013 01:48:40 -0400
Received: by mail-pa0-f52.google.com with SMTP id bg2so2161166pad.25
        for <backports@vger.kernel.org>; Wed, 15 May 2013 22:48:40 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 2/3] backports: add PDE_DATA() case when CONFIG_PROC_FS is disabled
Date: Wed, 15 May 2013 22:48:25 -0700
Message-Id: <1368683306-21463-3-git-send-email-mcgrof@do-not-panic.com> (sfid-20130516_074841_791411_20471C89)
In-Reply-To: <1368683306-21463-1-git-send-email-mcgrof@do-not-panic.com>
References: <1368683306-21463-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

This was missing.

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 backport/backport-include/linux/proc_fs.h |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/backport/backport-include/linux/proc_fs.h b/backport/backport-include/linux/proc_fs.h
index 5a1bec1..22a7b54 100644
--- a/backport/backport-include/linux/proc_fs.h
+++ b/backport/backport-include/linux/proc_fs.h
@@ -4,6 +4,7 @@
 #include <linux/version.h>
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3,10,0)
+#ifdef CONFIG_PROC_FS
 /*
  * backport of:
  * procfs: new helper - PDE_DATA(inode)
@@ -12,6 +13,8 @@ static inline void *PDE_DATA(const struct inode *inode)
 {
 	return PROC_I(inode)->pde->data;
 }
+#else
+static inline void *PDE_DATA(const struct inode *inode) {BUG(); return NULL;}
 #endif
 
 #endif /* __BACKPORT_PROC_FS_H */
-- 
1.7.10.4

