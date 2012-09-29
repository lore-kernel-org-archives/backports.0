Return-Path: <mcgrof@gmail.com>
Sender: "Luis R. Rodriguez" <mcgrof@gmail.com>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 4/5] compat-drivers: backport usage of shmem_truncate_range() on i915
Date: Fri, 28 Sep 2012 23:54:45 -0700
Message-Id: <1348901686-15036-5-git-send-email-mcgrof@do-not-panic.com>
In-Reply-To: <1348901686-15036-1-git-send-email-mcgrof@do-not-panic.com>
References: <1348901686-15036-1-git-send-email-mcgrof@do-not-panic.com>
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

Backport e2377fe0b -- this could likely be implemented
on compat.git but I'd much prefer a better review of that.
For now this stays as a patch.

commit e2377fe0b65e3c7577ff6df1701c56ef477d336f
Author: Hugh Dickins <hughd@google.com>
Date:   Mon Jun 27 16:18:19 2011 -0700

    drm/i915: use shmem_truncate_range

    The interface to ->truncate_range is changing very slightly: once "tmpfs:
    take control of its truncate_range" has been applied, this can be applied.
     For now there is only a slight inefficiency while this remains unapplied,
    but it will soon become essential for managing shmem's use of swap.

    Change i915_gem_object_truncate() to use shmem_truncate_range() directly:
    which should also spare i915 later change if we switch from
    inode_operations->truncate_range to file_operations->fallocate.

    Signed-off-by: Hugh Dickins <hughd@google.com>
    Cc: Christoph Hellwig <hch@infradead.org>
    Cc: Chris Wilson <chris@chris-wilson.co.uk>
    Cc: Keith Packard <keithp@keithp.com>
    Cc: Dave Airlie <airlied@redhat.com>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 patches/drm/08-shmem_truncate_range.patch |   44 +++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 patches/drm/08-shmem_truncate_range.patch

diff --git a/patches/drm/08-shmem_truncate_range.patch b/patches/drm/08-shmem_truncate_range.patch
new file mode 100644
index 0000000..71ad03b
--- /dev/null
+++ b/patches/drm/08-shmem_truncate_range.patch
@@ -0,0 +1,44 @@
+Backport e2377fe0b -- this could likely be implemented
+on compat.git but I'd much prefer a better review of that.
+For now this stays as a patch.
+
+commit e2377fe0b65e3c7577ff6df1701c56ef477d336f
+Author: Hugh Dickins <hughd@google.com>
+Date:   Mon Jun 27 16:18:19 2011 -0700
+
+    drm/i915: use shmem_truncate_range
+    
+    The interface to ->truncate_range is changing very slightly: once "tmpfs:
+    take control of its truncate_range" has been applied, this can be applied.
+     For now there is only a slight inefficiency while this remains unapplied,
+    but it will soon become essential for managing shmem's use of swap.
+    
+    Change i915_gem_object_truncate() to use shmem_truncate_range() directly:
+    which should also spare i915 later change if we switch from
+    inode_operations->truncate_range to file_operations->fallocate.
+    
+    Signed-off-by: Hugh Dickins <hughd@google.com>
+    Cc: Christoph Hellwig <hch@infradead.org>
+    Cc: Chris Wilson <chris@chris-wilson.co.uk>
+    Cc: Keith Packard <keithp@keithp.com>
+    Cc: Dave Airlie <airlied@redhat.com>
+    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
+    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
+
+--- a/drivers/gpu/drm/i915/i915_gem.c
++++ b/drivers/gpu/drm/i915/i915_gem.c
+@@ -1648,7 +1648,14 @@ i915_gem_object_truncate(struct drm_i915
+ 	 * backing pages, *now*.
+ 	 */
+ 	inode = obj->base.filp->f_path.dentry->d_inode;
++#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,0,0))
+ 	shmem_truncate_range(inode, 0, (loff_t)-1);
++#else
++	truncate_inode_pages(inode->i_mapping, 0);
++	if (inode->i_op->truncate_range)
++		inode->i_op->truncate_range(inode, 0, (loff_t)-1);
++#endif
++
+ 
+ 	obj->madv = __I915_MADV_PURGED;
+ }
-- 
1.7.10.4
