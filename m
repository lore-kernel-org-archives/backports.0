Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:58765 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751656AbbBVBmU (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 21 Feb 2015 20:42:20 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 1/6] header: add get_user_pages_unlocked()
Date: Sun, 22 Feb 2015 02:42:03 +0100
Message-Id: <1424569328-12514-2-git-send-email-hauke@hauke-m.de> (sfid-20150222_024223_011610_AB9D90AA)
In-Reply-To: <1424569328-12514-1-git-send-email-hauke@hauke-m.de>
References: <1424569328-12514-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This function is needed by some media driver.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/mm.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/backport/backport-include/linux/mm.h b/backport/backport-include/linux/mm.h
index 8671d29..efb2ca7 100644
--- a/backport/backport-include/linux/mm.h
+++ b/backport/backport-include/linux/mm.h
@@ -25,4 +25,21 @@
 int vm_iomap_memory(struct vm_area_struct *vma, phys_addr_t start, unsigned long len);
 #endif
 
+#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,20,0))
+#define get_user_pages_unlocked LINUX_BACKPORT(get_user_pages_unlocked)
+static inline long
+get_user_pages_unlocked(struct task_struct *tsk, struct mm_struct *mm,
+			unsigned long start, unsigned long nr_pages,
+			int write, int force, struct page **pages)
+{
+	long err;
+
+	down_read(&mm->mmap_sem);
+	err = get_user_pages(tsk, mm, start, nr_pages, write, force, pages,
+			     NULL);
+	up_read(&mm->mmap_sem);
+
+	return err;
+}
+#endif
 #endif /* __BACKPORT_MM_H */
-- 
1.9.1

