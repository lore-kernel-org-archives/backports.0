Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:48709 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752818AbbF1V7c (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 28 Jun 2015 17:59:32 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 10/14] backport: add frame vector code
Date: Sun, 28 Jun 2015 23:59:16 +0200
Message-Id: <1435528760-19913-11-git-send-email-hauke@hauke-m.de> (sfid-20150628_235939_714090_B988C6EA)
In-Reply-To: <1435528760-19913-1-git-send-email-hauke@hauke-m.de>
References: <1435528760-19913-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The media framework now uses the frame vector code which is only
available from kernel 4.2 onwards. This backports the code.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/mm.h               | 44 ++++++++++++++++++++++
 backport/compat/Kconfig                            |  9 +++++
 .../0013-fix-makefile-includes/frame_vector.patch  | 10 +++++
 3 files changed, 63 insertions(+)
 create mode 100644 patches/collateral-evolutions/network/0013-fix-makefile-includes/frame_vector.patch

diff --git a/backport/backport-include/linux/mm.h b/backport/backport-include/linux/mm.h
index f9e0ced..96be9e6 100644
--- a/backport/backport-include/linux/mm.h
+++ b/backport/backport-include/linux/mm.h
@@ -51,4 +51,48 @@ long get_user_pages_unlocked(struct task_struct *tsk, struct mm_struct *mm,
 #define FOLL_TRIED	0x800	/* a retry, previous pass started an IO */
 #endif
 
+#ifdef CPTCFG_BPAUTO_BUILD_FRAME_VECTOR
+/* Container for pinned pfns / pages */
+struct frame_vector {
+	unsigned int nr_allocated;	/* Number of frames we have space for */
+	unsigned int nr_frames;	/* Number of frames stored in ptrs array */
+	bool got_ref;		/* Did we pin pages by getting page ref? */
+	bool is_pfns;		/* Does array contain pages or pfns? */
+	void *ptrs[0];		/* Array of pinned pfns / pages. Use
+				 * pfns_vector_pages() or pfns_vector_pfns()
+				 * for access */
+};
+
+struct frame_vector *frame_vector_create(unsigned int nr_frames);
+void frame_vector_destroy(struct frame_vector *vec);
+int get_vaddr_frames(unsigned long start, unsigned int nr_pfns,
+		     bool write, bool force, struct frame_vector *vec);
+void put_vaddr_frames(struct frame_vector *vec);
+int frame_vector_to_pages(struct frame_vector *vec);
+void frame_vector_to_pfns(struct frame_vector *vec);
+
+static inline unsigned int frame_vector_count(struct frame_vector *vec)
+{
+	return vec->nr_frames;
+}
+
+static inline struct page **frame_vector_pages(struct frame_vector *vec)
+{
+	if (vec->is_pfns) {
+		int err = frame_vector_to_pages(vec);
+
+		if (err)
+			return ERR_PTR(err);
+	}
+	return (struct page **)(vec->ptrs);
+}
+
+static inline unsigned long *frame_vector_pfns(struct frame_vector *vec)
+{
+	if (!vec->is_pfns)
+		frame_vector_to_pfns(vec);
+	return (unsigned long *)(vec->ptrs);
+}
+#endif
+
 #endif /* __BACKPORT_MM_H */
diff --git a/backport/compat/Kconfig b/backport/compat/Kconfig
index ca50190..b5bf348 100644
--- a/backport/compat/Kconfig
+++ b/backport/compat/Kconfig
@@ -160,3 +160,12 @@ config BPAUTO_HDMI
 	default y if VIDEO_ADV7511
 	default y if VIDEO_ADV7604
 	default y if VIDEO_ADV7842
+
+config BPAUTO_FRAME_VECTOR
+	bool
+
+config BPAUTO_BUILD_FRAME_VECTOR
+	bool
+	default n if FRAME_VECTOR
+	default y if BPAUTO_FRAME_VECTOR
+	#c-file mm/frame_vector.c
diff --git a/patches/collateral-evolutions/network/0013-fix-makefile-includes/frame_vector.patch b/patches/collateral-evolutions/network/0013-fix-makefile-includes/frame_vector.patch
new file mode 100644
index 0000000..1df2f6d
--- /dev/null
+++ b/patches/collateral-evolutions/network/0013-fix-makefile-includes/frame_vector.patch
@@ -0,0 +1,10 @@
+--- a/compat/mm-frame_vector.c
++++ b/compat/mm-frame_vector.c
+@@ -6,6 +6,7 @@
+ #include <linux/vmalloc.h>
+ #include <linux/pagemap.h>
+ #include <linux/sched.h>
++#include <linux/export.h>
+ 
+ /*
+  * get_vaddr_frames() - map virtual addresses to pfns
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe backports" in
