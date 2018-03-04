Return-path: <backports-owner@vger.kernel.org>
Received: from mx2.mailbox.org ([80.241.60.215]:52122 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932497AbeCDW5t (ORCPT <rfc822;backports@vger.kernel.org>);
        Sun, 4 Mar 2018 17:57:49 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: johannes@sipsolutions.net, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 07/14] header: debugfs.h: add DEFINE_DEBUGFS_ATTRIBUTE
Date: Sun,  4 Mar 2018 23:57:10 +0100
Message-Id: <20180304225717.20890-8-hauke@hauke-m.de> (sfid-20180304_235756_422708_EB0C79BF)
In-Reply-To: <20180304225717.20890-1-hauke@hauke-m.de>
References: <20180304225717.20890-1-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

DEFINE_DEBUGFS_ATTRIBUTE and debugfs_create_file_unsafe() were
introduced in mainline commit c6468808149 ("debugfs: add support for
self-protecting attribute file fops"), but on older kernel versions
where we do not have this extra security in debugfs we can use the older
functions instead.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/debugfs.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/backport/backport-include/linux/debugfs.h b/backport/backport-include/linux/debugfs.h
index 11670388..fb50c4f5 100644
--- a/backport/backport-include/linux/debugfs.h
+++ b/backport/backport-include/linux/debugfs.h
@@ -53,4 +53,11 @@ debugfs_real_fops(const struct file *filp)
 }
 #endif /* <4.9.0 but not >= 4.8.4, 4.7.10 */
 
+#ifndef DEFINE_DEBUGFS_ATTRIBUTE
+#define DEFINE_DEBUGFS_ATTRIBUTE(__fops, __get, __set, __fmt) \
+	DEFINE_SIMPLE_ATTRIBUTE(__fops, __get, __set, __fmt)
+#define debugfs_create_file_unsafe(name, mode, parent, data, fops) \
+	debugfs_create_file(name, mode, parent, data, fops)
+#endif
+
 #endif /* __BACKPORT_DEBUGFS_H_ */
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
