Return-path: <backports-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:40888 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754465Ab3EKA10 (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 10 May 2013 20:27:26 -0400
Received: by mail-ie0-f182.google.com with SMTP id a14so9203490iee.13
        for <backports@vger.kernel.org>; Fri, 10 May 2013 17:27:26 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 03/12] compat: backport radix-tree bit optimized iterator
Date: Fri, 10 May 2013 17:26:54 -0700
Message-Id: <1368232023-23817-4-git-send-email-mcgrof@do-not-panic.com> (sfid-20130511_022729_087316_AB440CDC)
In-Reply-To: <1368232023-23817-1-git-send-email-mcgrof@do-not-panic.com>
References: <1368232023-23817-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

This backport's Konstantin's radix-tree bit optimized
iterator, 78c1d7848, added on v3.4. This is used by a new
drivers in the future. The new bit optimized iterator relies
on the stack optimization introduced via e2bdb933 added as of
v3.3. Backporting the bit optimized iterator requires
adjusting it to the old v3.2 radix_tree_node which is not
implemented here. For kernels v3.3 - v3.3 we can backport
the bit optimized iterator given that the radix_tree_node
did not changed between v3.3 - v3.4, in fact it hasn't
changed even up to v3.10. The backport relies on the same
helpers and inlines present on v3.3-v3.10 to implement
radix_tree_next_chunk().

This was tested as of next-20130410.

Throw the helper into compat config build option
CPTCFG_BACKPORT_BUILD_RADIX_HELPERS only to be built
on v3.3 right now unless someone really wants to
backport 78c1d7848 support onto v3.2.

mcgrof@frijol ~/linux-stable (git::master)$ git describe --contains 78c1d7848
v3.4-rc2~15^2~26

mcgrof@frijol ~/linux-stable (git::master)$ git describe --contains e2bdb933
v3.3-rc1~81^2~8

ckmake below, and then the commit log references above.

== ckmake-report.log ==

1   2.6.24              [  OK  ]
2   2.6.25              [  OK  ]
3   2.6.26              [  OK  ]
4   2.6.27              [  OK  ]
5   2.6.28              [  OK  ]
6   2.6.29              [  OK  ]
7   2.6.30              [  OK  ]
8   2.6.31              [  OK  ]
9   2.6.32              [  OK  ]
10  2.6.33              [  OK  ]
11  2.6.34              [  OK  ]
12  2.6.35              [  OK  ]
13  2.6.36              [  OK  ]
14  2.6.37              [  OK  ]
15  2.6.38              [  OK  ]
16  2.6.39              [  OK  ]
17  3.0.76              [  OK  ]
18  3.1.10              [  OK  ]
19  3.2.44              [  OK  ]
20  3.3.8               [  OK  ]
21  3.4.43              [  OK  ]
22  3.5.7               [  OK  ]
23  3.6.11              [  OK  ]
24  3.7.10              [  OK  ]
25  3.8.11              [  OK  ]
26  3.9.0               [  OK  ]

real    30m37.773s
user    809m37.644s
sys     126m30.806s

commit 78c1d78488a3c45685d993130c9f17102dc79a54
Author: Konstantin Khlebnikov <khlebnikov@openvz.org>
Date:   Wed Mar 28 14:42:53 2012 -0700

    radix-tree: introduce bit-optimized iterator

    A series of radix tree cleanups, and usage of them in the core pagecache
    code.

    Micro-benchmark:

    lookup 14 slots (typical page-vector size)
    in radix-tree there earch <step> slot filled and tagged
    before/after - nsec per full scan through tree

    * Intel Sandy Bridge i7-2620M 4Mb L3
    New code always faster

    * AMD Athlon 6000+ 2x1Mb L2, without L3
    New code generally faster,
    Minor degradation (marked with "*") for huge sparse trees

    * i386 on Sandy Bridge
    New code faster for common cases: tagged and dense trees.
    Some degradations for non-tagged lookup on sparse trees.

    Ideally, there might help __ffs() analog for searching first non-zero
    long element in array, gcc sometimes cannot optimize this loop corretly.

    Numbers:

    CPU: Intel Sandy Bridge i7-2620M 4Mb L3

    radix-tree with 1024 slots:

    tagged lookup

    step  1      before  7156        after  3613
    step  2      before  5399        after  2696
    step  3      before  4779        after  1928
    step  4      before  4456        after  1429
    step  5      before  4292        after  1213
    step  6      before  4183        after  1052
    step  7      before  4157        after  951
    step  8      before  4016        after  812
    step  9      before  3952        after  851
    step  10     before  3937        after  732
    step  11     before  4023        after  709
    step  12     before  3872        after  657
    step  13     before  3892        after  633
    step  14     before  3720        after  591
    step  15     before  3879        after  578
    step  16     before  3561        after  513

    normal lookup

    step  1      before  4266       after  3301
    step  2      before  2695       after  2129
    step  3      before  2083       after  1712
    step  4      before  1801       after  1534
    step  5      before  1628       after  1313
    step  6      before  1551       after  1263
    step  7      before  1475       after  1185
    step  8      before  1432       after  1167
    step  9      before  1373       after  1092
    step  10     before  1339       after  1134
    step  11     before  1292       after  1056
    step  12     before  1319       after  1030
    step  13     before  1276       after  1004
    step  14     before  1256       after  987
    step  15     before  1228       after  992
    step  16     before  1247       after  999

    radix-tree with 1024*1024*128 slots:

    tagged lookup

commit e2bdb933ab8b7db71c318a4ddcf78a9fffd61ecb
Author: Hugh Dickins <hughd@google.com>
Date:   Thu Jan 12 17:20:41 2012 -0800

    radix_tree: take radix_tree_path off stack

    Down, down in the deepest depths of GFP_NOIO page reclaim, we have
    shrink_page_list() calling __remove_mapping() calling __delete_from_
    swap_cache() or __delete_from_page_cache().

    You would not expect those to need much stack, but in fact they call
    radix_tree_delete(): which declares a 192-byte radix_tree_path array on
    its stack (to record the node,offsets it visits when descending, in case
    it needs to ascend to update them).  And if any tag is still set [1],
    that calls radix_tree_tag_clear(), which declares a further such
    192-byte radix_tree_path array on the stack.  (At least we have
    interrupts disabled here, so won't then be pushing registers too.)

    That was probably a good choice when most users were 32-bit (array of
    half the size), and adding fields to radix_tree_node would have bloated
    it unnecessarily.  But nowadays many are 64-bit, and each
    radix_tree_node contains a struct rcu_head, which is only used when
    freeing; whereas the radix_tree_path info is only used for updating the
    tree (deleting, clearing tags or setting tags if tagged) when a lock
    must be held, of no interest when accessing the tree locklessly.

    So add a parent pointer to the radix_tree_node, in union with the
    rcu_head, and remove all uses of the radix_tree_path.  There would be
    space in that union to save the offset when descending as before (we can
    argue that a lock must already be held to exclude other users), but
    recalculating it when ascending is both easy (a constant shift and a
    constant mask) and uncommon, so it seems better just to do that.

    Two little optimizations: no need to decrement height when descending,
    adjusting shift is enough; and once radix_tree_tag_if_tagged() has set
    tag on a node and its ancestors, it need not ascend from that node
    again.

    perf on the radix tree test harness reports radix_tree_insert() as 2%
    slower (now having to set parent), but radix_tree_delete() 24% faster.
    Surely that's an exaggeration from rtth's artificially low map shift 3,
    but forcing it back to 6 still rates radix_tree_delete() 8% faster.

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 backport/backport-include/linux/radix-tree.h |  218 +++++++++++++++++++++
 backport/compat/Kconfig                      |    7 +
 backport/compat/Makefile                     |    1 +
 backport/compat/lib-radix-tree-helpers.c     |  266 ++++++++++++++++++++++++++
 4 files changed, 492 insertions(+)
 create mode 100644 backport/backport-include/linux/radix-tree.h
 create mode 100644 backport/compat/lib-radix-tree-helpers.c

diff --git a/backport/backport-include/linux/radix-tree.h b/backport/backport-include/linux/radix-tree.h
new file mode 100644
index 0000000..6ca7c05
--- /dev/null
+++ b/backport/backport-include/linux/radix-tree.h
@@ -0,0 +1,218 @@
+/*
+ * Copyright (C) 2013 Konstantin Khlebnikov
+ * Copyright (C) 2013 Luis R. Rodriguez <mcgrof@do-not-panic.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2, or (at
+ * your option) any later version.
+ *
+ */
+#ifndef BACKPORT_LINUX_RADIX_TREE_H
+#define BACKPORT_LINUX_RADIX_TREE_H
+
+#include_next <linux/radix-tree.h>
+
+#ifdef CPTCFG_BACKPORT_BUILD_RADIX_HELPERS
+
+/**
+ * struct radix_tree_iter - radix tree iterator state
+ *
+ * @index:	index of current slot
+ * @next_index:	next-to-last index for this chunk
+ * @tags:	bit-mask for tag-iterating
+ *
+ * This radix tree iterator works in terms of "chunks" of slots.  A chunk is a
+ * subinterval of slots contained within one radix tree leaf node.  It is
+ * described by a pointer to its first slot and a struct radix_tree_iter
+ * which holds the chunk's position in the tree and its size.  For tagged
+ * iteration radix_tree_iter also holds the slots' bit-mask for one chosen
+ * radix tree tag.
+ */
+struct radix_tree_iter {
+	unsigned long	index;
+	unsigned long	next_index;
+	unsigned long	tags;
+};
+
+#define RADIX_TREE_ITER_TAG_MASK	0x00FF	/* tag index in lower byte */
+#define RADIX_TREE_ITER_TAGGED		0x0100	/* lookup tagged slots */
+#define RADIX_TREE_ITER_CONTIG		0x0200	/* stop at first hole */
+
+/**
+ * radix_tree_iter_init - initialize radix tree iterator
+ *
+ * @iter:	pointer to iterator state
+ * @start:	iteration starting index
+ * Returns:	NULL
+ */
+static __always_inline void **
+radix_tree_iter_init(struct radix_tree_iter *iter, unsigned long start)
+{
+	/*
+	 * Leave iter->tags uninitialized. radix_tree_next_chunk() will fill it
+	 * in the case of a successful tagged chunk lookup.  If the lookup was
+	 * unsuccessful or non-tagged then nobody cares about ->tags.
+	 *
+	 * Set index to zero to bypass next_index overflow protection.
+	 * See the comment in radix_tree_next_chunk() for details.
+	 */
+	iter->index = 0;
+	iter->next_index = start;
+	return NULL;
+}
+
+/**
+ * radix_tree_next_chunk - find next chunk of slots for iteration
+ *
+ * @root:	radix tree root
+ * @iter:	iterator state
+ * @flags:	RADIX_TREE_ITER_* flags and tag index
+ * Returns:	pointer to chunk first slot, or NULL if there no more left
+ *
+ * This function looks up the next chunk in the radix tree starting from
+ * @iter->next_index.  It returns a pointer to the chunk's first slot.
+ * Also it fills @iter with data about chunk: position in the tree (index),
+ * its end (next_index), and constructs a bit mask for tagged iterating (tags).
+ */
+void **radix_tree_next_chunk(struct radix_tree_root *root,
+			     struct radix_tree_iter *iter, unsigned flags);
+
+/**
+ * radix_tree_chunk_size - get current chunk size
+ *
+ * @iter:	pointer to radix tree iterator
+ * Returns:	current chunk size
+ */
+static __always_inline unsigned
+radix_tree_chunk_size(struct radix_tree_iter *iter)
+{
+	return iter->next_index - iter->index;
+}
+
+/**
+ * radix_tree_next_slot - find next slot in chunk
+ *
+ * @slot:	pointer to current slot
+ * @iter:	pointer to interator state
+ * @flags:	RADIX_TREE_ITER_*, should be constant
+ * Returns:	pointer to next slot, or NULL if there no more left
+ *
+ * This function updates @iter->index in the case of a successful lookup.
+ * For tagged lookup it also eats @iter->tags.
+ */
+static __always_inline void **
+radix_tree_next_slot(void **slot, struct radix_tree_iter *iter, unsigned flags)
+{
+	if (flags & RADIX_TREE_ITER_TAGGED) {
+		iter->tags >>= 1;
+		if (likely(iter->tags & 1ul)) {
+			iter->index++;
+			return slot + 1;
+		}
+		if (!(flags & RADIX_TREE_ITER_CONTIG) && likely(iter->tags)) {
+			unsigned offset = __ffs(iter->tags);
+
+			iter->tags >>= offset;
+			iter->index += offset + 1;
+			return slot + offset + 1;
+		}
+	} else {
+		unsigned size = radix_tree_chunk_size(iter) - 1;
+
+		while (size--) {
+			slot++;
+			iter->index++;
+			if (likely(*slot))
+				return slot;
+			if (flags & RADIX_TREE_ITER_CONTIG) {
+				/* forbid switching to the next chunk */
+				iter->next_index = 0;
+				break;
+			}
+		}
+	}
+	return NULL;
+}
+
+/**
+ * radix_tree_for_each_chunk - iterate over chunks
+ *
+ * @slot:	the void** variable for pointer to chunk first slot
+ * @root:	the struct radix_tree_root pointer
+ * @iter:	the struct radix_tree_iter pointer
+ * @start:	iteration starting index
+ * @flags:	RADIX_TREE_ITER_* and tag index
+ *
+ * Locks can be released and reacquired between iterations.
+ */
+#define radix_tree_for_each_chunk(slot, root, iter, start, flags)	\
+	for (slot = radix_tree_iter_init(iter, start) ;			\
+	      (slot = radix_tree_next_chunk(root, iter, flags)) ;)
+
+/**
+ * radix_tree_for_each_chunk_slot - iterate over slots in one chunk
+ *
+ * @slot:	the void** variable, at the beginning points to chunk first slot
+ * @iter:	the struct radix_tree_iter pointer
+ * @flags:	RADIX_TREE_ITER_*, should be constant
+ *
+ * This macro is designed to be nested inside radix_tree_for_each_chunk().
+ * @slot points to the radix tree slot, @iter->index contains its index.
+ */
+#define radix_tree_for_each_chunk_slot(slot, iter, flags)		\
+	for (; slot ; slot = radix_tree_next_slot(slot, iter, flags))
+
+/**
+ * radix_tree_for_each_slot - iterate over non-empty slots
+ *
+ * @slot:	the void** variable for pointer to slot
+ * @root:	the struct radix_tree_root pointer
+ * @iter:	the struct radix_tree_iter pointer
+ * @start:	iteration starting index
+ *
+ * @slot points to radix tree slot, @iter->index contains its index.
+ */
+#define radix_tree_for_each_slot(slot, root, iter, start)		\
+	for (slot = radix_tree_iter_init(iter, start) ;			\
+	     slot || (slot = radix_tree_next_chunk(root, iter, 0)) ;	\
+	     slot = radix_tree_next_slot(slot, iter, 0))
+
+/**
+ * radix_tree_for_each_contig - iterate over contiguous slots
+ *
+ * @slot:	the void** variable for pointer to slot
+ * @root:	the struct radix_tree_root pointer
+ * @iter:	the struct radix_tree_iter pointer
+ * @start:	iteration starting index
+ *
+ * @slot points to radix tree slot, @iter->index contains its index.
+ */
+#define radix_tree_for_each_contig(slot, root, iter, start)		\
+	for (slot = radix_tree_iter_init(iter, start) ;			\
+	     slot || (slot = radix_tree_next_chunk(root, iter,		\
+				RADIX_TREE_ITER_CONTIG)) ;		\
+	     slot = radix_tree_next_slot(slot, iter,			\
+				RADIX_TREE_ITER_CONTIG))
+
+/**
+ * radix_tree_for_each_tagged - iterate over tagged slots
+ *
+ * @slot:	the void** variable for pointer to slot
+ * @root:	the struct radix_tree_root pointer
+ * @iter:	the struct radix_tree_iter pointer
+ * @start:	iteration starting index
+ * @tag:	tag index
+ *
+ * @slot points to radix tree slot, @iter->index contains its index.
+ */
+#define radix_tree_for_each_tagged(slot, root, iter, start, tag)	\
+	for (slot = radix_tree_iter_init(iter, start) ;			\
+	     slot || (slot = radix_tree_next_chunk(root, iter,		\
+			      RADIX_TREE_ITER_TAGGED | tag)) ;		\
+	     slot = radix_tree_next_slot(slot, iter,			\
+				RADIX_TREE_ITER_TAGGED))
+
+#endif /* CPTCFG_BACKPORT_BUILD_RADIX_HELPERS */
+
+#endif /* BACKPORT_LINUX_RADIX_TREE_H */
diff --git a/backport/compat/Kconfig b/backport/compat/Kconfig
index 215de8e..e2f0cdd 100644
--- a/backport/compat/Kconfig
+++ b/backport/compat/Kconfig
@@ -185,6 +185,13 @@ config BACKPORT_LEDS_CLASS
 config BACKPORT_LEDS_TRIGGERS
 	bool
 
+config BACKPORT_BUILD_RADIX_HELPERS
+	bool
+	# You have selected to build backported DRM drivers
+	# Build only if on < 3.4
+	depends on DRM && BACKPORT_KERNEL_3_4
+	default y if BACKPORT_USERSEL_BUILD_ALL
+
 config BACKPORT_USERSEL_BUILD_ALL
 	bool "Build all compat code"
 	help
diff --git a/backport/compat/Makefile b/backport/compat/Makefile
index 19d4d2d..2ab3169 100644
--- a/backport/compat/Makefile
+++ b/backport/compat/Makefile
@@ -38,3 +38,4 @@ compat-$(CPTCFG_BACKPORT_KERNEL_3_9) += compat-3.9.o
 compat-$(CPTCFG_BACKPORT_BUILD_KFIFO) += kfifo.o
 compat-$(CPTCFG_BACKPORT_BUILD_GENERIC_ATOMIC64) += compat_atomic.o
 compat-$(CPTCFG_BACKPORT_BUILD_DMA_SHARED_HELPERS) += dma-shared-helpers.o
+compat-$(CPTCFG_BACKPORT_BUILD_RADIX_HELPERS) += lib-radix-tree-helpers.o
diff --git a/backport/compat/lib-radix-tree-helpers.c b/backport/compat/lib-radix-tree-helpers.c
new file mode 100644
index 0000000..837de04
--- /dev/null
+++ b/backport/compat/lib-radix-tree-helpers.c
@@ -0,0 +1,266 @@
+/*
+ * Copyright (C) 2013 Konstantin Khlebnikov
+ * Copyright (c) 2013 Luis R. Rodriguez <mcgrof@do-not-panic.com>
+ *
+ * Backports radix_tree_next_chunk()
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2, or (at
+ * your option) any later version.
+ */
+
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/export.h>
+#include <linux/radix-tree.h>
+#include <linux/percpu.h>
+#include <linux/slab.h>
+#include <linux/notifier.h>
+#include <linux/cpu.h>
+#include <linux/string.h>
+#include <linux/bitops.h>
+#include <linux/rcupdate.h>
+
+#ifdef __KERNEL__
+#define RADIX_TREE_MAP_SHIFT	(CONFIG_BASE_SMALL ? 4 : 6)
+#else
+#define RADIX_TREE_MAP_SHIFT	3	/* For more stressful testing */
+#endif
+
+#define RADIX_TREE_MAP_SIZE	(1UL << RADIX_TREE_MAP_SHIFT)
+#define RADIX_TREE_MAP_MASK	(RADIX_TREE_MAP_SIZE-1)
+
+#define RADIX_TREE_TAG_LONGS	\
+	((RADIX_TREE_MAP_SIZE + BITS_PER_LONG - 1) / BITS_PER_LONG)
+
+struct radix_tree_node {
+	unsigned int	height;		/* Height from the bottom */
+	unsigned int	count;
+	union {
+		struct radix_tree_node *parent;	/* Used when ascending tree */
+		struct rcu_head	rcu_head;	/* Used when freeing node */
+	};
+	void __rcu	*slots[RADIX_TREE_MAP_SIZE];
+	unsigned long	tags[RADIX_TREE_MAX_TAGS][RADIX_TREE_TAG_LONGS];
+};
+
+static inline void *ptr_to_indirect(void *ptr)
+{
+	return (void *)((unsigned long)ptr | RADIX_TREE_INDIRECT_PTR);
+}
+
+static inline void *indirect_to_ptr(void *ptr)
+{
+	return (void *)((unsigned long)ptr & ~RADIX_TREE_INDIRECT_PTR);
+}
+
+static inline gfp_t root_gfp_mask(struct radix_tree_root *root)
+{
+	return root->gfp_mask & __GFP_BITS_MASK;
+}
+
+static inline void tag_set(struct radix_tree_node *node, unsigned int tag,
+		int offset)
+{
+	__set_bit(offset, node->tags[tag]);
+}
+
+static inline void tag_clear(struct radix_tree_node *node, unsigned int tag,
+		int offset)
+{
+	__clear_bit(offset, node->tags[tag]);
+}
+
+static inline int tag_get(struct radix_tree_node *node, unsigned int tag,
+		int offset)
+{
+	return test_bit(offset, node->tags[tag]);
+}
+
+static inline void root_tag_set(struct radix_tree_root *root, unsigned int tag)
+{
+	root->gfp_mask |= (__force gfp_t)(1 << (tag + __GFP_BITS_SHIFT));
+}
+
+static inline void root_tag_clear(struct radix_tree_root *root, unsigned int tag)
+{
+	root->gfp_mask &= (__force gfp_t)~(1 << (tag + __GFP_BITS_SHIFT));
+}
+
+static inline void root_tag_clear_all(struct radix_tree_root *root)
+{
+	root->gfp_mask &= __GFP_BITS_MASK;
+}
+
+static inline int root_tag_get(struct radix_tree_root *root, unsigned int tag)
+{
+	return (__force unsigned)root->gfp_mask & (1 << (tag + __GFP_BITS_SHIFT));
+}
+
+/*
+ * Returns 1 if any slot in the node has this tag set.
+ * Otherwise returns 0.
+ */
+static inline int any_tag_set(struct radix_tree_node *node, unsigned int tag)
+{
+	int idx;
+	for (idx = 0; idx < RADIX_TREE_TAG_LONGS; idx++) {
+		if (node->tags[tag][idx])
+			return 1;
+	}
+	return 0;
+}
+
+/**
+ * radix_tree_find_next_bit - find the next set bit in a memory region
+ *
+ * @addr: The address to base the search on
+ * @size: The bitmap size in bits
+ * @offset: The bitnumber to start searching at
+ *
+ * Unrollable variant of find_next_bit() for constant size arrays.
+ * Tail bits starting from size to roundup(size, BITS_PER_LONG) must be zero.
+ * Returns next bit offset, or size if nothing found.
+ */
+static __always_inline unsigned long
+radix_tree_find_next_bit(const unsigned long *addr,
+			 unsigned long size, unsigned long offset)
+{
+	if (!__builtin_constant_p(size))
+		return find_next_bit(addr, size, offset);
+
+	if (offset < size) {
+		unsigned long tmp;
+
+		addr += offset / BITS_PER_LONG;
+		tmp = *addr >> (offset % BITS_PER_LONG);
+		if (tmp)
+			return __ffs(tmp) + offset;
+		offset = (offset + BITS_PER_LONG) & ~(BITS_PER_LONG - 1);
+		while (offset < size) {
+			tmp = *++addr;
+			if (tmp)
+				return __ffs(tmp) + offset;
+			offset += BITS_PER_LONG;
+		}
+	}
+	return size;
+}
+
+/**
+ * radix_tree_next_chunk - find next chunk of slots for iteration
+ *
+ * @root:	radix tree root
+ * @iter:	iterator state
+ * @flags:	RADIX_TREE_ITER_* flags and tag index
+ * Returns:	pointer to chunk first slot, or NULL if iteration is over
+ */
+void **radix_tree_next_chunk(struct radix_tree_root *root,
+			     struct radix_tree_iter *iter, unsigned flags)
+{
+	unsigned shift, tag = flags & RADIX_TREE_ITER_TAG_MASK;
+	struct radix_tree_node *rnode, *node;
+	unsigned long index, offset;
+
+	if ((flags & RADIX_TREE_ITER_TAGGED) && !root_tag_get(root, tag))
+		return NULL;
+
+	/*
+	 * Catch next_index overflow after ~0UL. iter->index never overflows
+	 * during iterating; it can be zero only at the beginning.
+	 * And we cannot overflow iter->next_index in a single step,
+	 * because RADIX_TREE_MAP_SHIFT < BITS_PER_LONG.
+	 *
+	 * This condition also used by radix_tree_next_slot() to stop
+	 * contiguous iterating, and forbid swithing to the next chunk.
+	 */
+	index = iter->next_index;
+	if (!index && iter->index)
+		return NULL;
+
+	rnode = rcu_dereference_raw(root->rnode);
+	if (radix_tree_is_indirect_ptr(rnode)) {
+		rnode = indirect_to_ptr(rnode);
+	} else if (rnode && !index) {
+		/* Single-slot tree */
+		iter->index = 0;
+		iter->next_index = 1;
+		iter->tags = 1;
+		return (void **)&root->rnode;
+	} else
+		return NULL;
+
+restart:
+	shift = (rnode->height - 1) * RADIX_TREE_MAP_SHIFT;
+	offset = index >> shift;
+
+	/* Index outside of the tree */
+	if (offset >= RADIX_TREE_MAP_SIZE)
+		return NULL;
+
+	node = rnode;
+	while (1) {
+		if ((flags & RADIX_TREE_ITER_TAGGED) ?
+				!test_bit(offset, node->tags[tag]) :
+				!node->slots[offset]) {
+			/* Hole detected */
+			if (flags & RADIX_TREE_ITER_CONTIG)
+				return NULL;
+
+			if (flags & RADIX_TREE_ITER_TAGGED)
+				offset = radix_tree_find_next_bit(
+						node->tags[tag],
+						RADIX_TREE_MAP_SIZE,
+						offset + 1);
+			else
+				while (++offset	< RADIX_TREE_MAP_SIZE) {
+					if (node->slots[offset])
+						break;
+				}
+			index &= ~((RADIX_TREE_MAP_SIZE << shift) - 1);
+			index += offset << shift;
+			/* Overflow after ~0UL */
+			if (!index)
+				return NULL;
+			if (offset == RADIX_TREE_MAP_SIZE)
+				goto restart;
+		}
+
+		/* This is leaf-node */
+		if (!shift)
+			break;
+
+		node = rcu_dereference_raw(node->slots[offset]);
+		if (node == NULL)
+			goto restart;
+		shift -= RADIX_TREE_MAP_SHIFT;
+		offset = (index >> shift) & RADIX_TREE_MAP_MASK;
+	}
+
+	/* Update the iterator state */
+	iter->index = index;
+	iter->next_index = (index | RADIX_TREE_MAP_MASK) + 1;
+
+	/* Construct iter->tags bit-mask from node->tags[tag] array */
+	if (flags & RADIX_TREE_ITER_TAGGED) {
+		unsigned tag_long, tag_bit;
+
+		tag_long = offset / BITS_PER_LONG;
+		tag_bit  = offset % BITS_PER_LONG;
+		iter->tags = node->tags[tag][tag_long] >> tag_bit;
+		/* This never happens if RADIX_TREE_TAG_LONGS == 1 */
+		if (tag_long < RADIX_TREE_TAG_LONGS - 1) {
+			/* Pick tags from next element */
+			if (tag_bit)
+				iter->tags |= node->tags[tag][tag_long + 1] <<
+						(BITS_PER_LONG - tag_bit);
+			/* Clip chunk size, here only BITS_PER_LONG tags */
+			iter->next_index = index + BITS_PER_LONG;
+		}
+	}
+
+	return node->slots + offset;
+}
+EXPORT_SYMBOL_GPL(radix_tree_next_chunk);
-- 
1.7.10.4

