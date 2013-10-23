Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:35144 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753203Ab3JWSZD (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 23 Oct 2013 14:25:03 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 05/18] backports: remove BACKPORT_BUILD_RADIX_HELPERS
Date: Wed, 23 Oct 2013 20:24:12 +0200
Message-Id: <1382552665-15678-6-git-send-email-hauke@hauke-m.de> (sfid-20131023_202507_418738_BC25D549)
In-Reply-To: <1382552665-15678-1-git-send-email-hauke@hauke-m.de>
References: <1382552665-15678-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This was only needed for some of the DRM drivers, remove it.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/radix-tree.h |  218 ---------------------
 backport/compat/Kconfig                      |    7 -
 backport/compat/Makefile                     |    1 -
 backport/compat/lib-radix-tree-helpers.c     |  266 --------------------------
 4 files changed, 492 deletions(-)
 delete mode 100644 backport/backport-include/linux/radix-tree.h
 delete mode 100644 backport/compat/lib-radix-tree-helpers.c

diff --git a/backport/backport-include/linux/radix-tree.h b/backport/backport-include/linux/radix-tree.h
deleted file mode 100644
index 6ca7c05..0000000
--- a/backport/backport-include/linux/radix-tree.h
+++ /dev/null
@@ -1,218 +0,0 @@
-/*
- * Copyright (C) 2013 Konstantin Khlebnikov
- * Copyright (C) 2013 Luis R. Rodriguez <mcgrof@do-not-panic.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2, or (at
- * your option) any later version.
- *
- */
-#ifndef BACKPORT_LINUX_RADIX_TREE_H
-#define BACKPORT_LINUX_RADIX_TREE_H
-
-#include_next <linux/radix-tree.h>
-
-#ifdef CPTCFG_BACKPORT_BUILD_RADIX_HELPERS
-
-/**
- * struct radix_tree_iter - radix tree iterator state
- *
- * @index:	index of current slot
- * @next_index:	next-to-last index for this chunk
- * @tags:	bit-mask for tag-iterating
- *
- * This radix tree iterator works in terms of "chunks" of slots.  A chunk is a
- * subinterval of slots contained within one radix tree leaf node.  It is
- * described by a pointer to its first slot and a struct radix_tree_iter
- * which holds the chunk's position in the tree and its size.  For tagged
- * iteration radix_tree_iter also holds the slots' bit-mask for one chosen
- * radix tree tag.
- */
-struct radix_tree_iter {
-	unsigned long	index;
-	unsigned long	next_index;
-	unsigned long	tags;
-};
-
-#define RADIX_TREE_ITER_TAG_MASK	0x00FF	/* tag index in lower byte */
-#define RADIX_TREE_ITER_TAGGED		0x0100	/* lookup tagged slots */
-#define RADIX_TREE_ITER_CONTIG		0x0200	/* stop at first hole */
-
-/**
- * radix_tree_iter_init - initialize radix tree iterator
- *
- * @iter:	pointer to iterator state
- * @start:	iteration starting index
- * Returns:	NULL
- */
-static __always_inline void **
-radix_tree_iter_init(struct radix_tree_iter *iter, unsigned long start)
-{
-	/*
-	 * Leave iter->tags uninitialized. radix_tree_next_chunk() will fill it
-	 * in the case of a successful tagged chunk lookup.  If the lookup was
-	 * unsuccessful or non-tagged then nobody cares about ->tags.
-	 *
-	 * Set index to zero to bypass next_index overflow protection.
-	 * See the comment in radix_tree_next_chunk() for details.
-	 */
-	iter->index = 0;
-	iter->next_index = start;
-	return NULL;
-}
-
-/**
- * radix_tree_next_chunk - find next chunk of slots for iteration
- *
- * @root:	radix tree root
- * @iter:	iterator state
- * @flags:	RADIX_TREE_ITER_* flags and tag index
- * Returns:	pointer to chunk first slot, or NULL if there no more left
- *
- * This function looks up the next chunk in the radix tree starting from
- * @iter->next_index.  It returns a pointer to the chunk's first slot.
- * Also it fills @iter with data about chunk: position in the tree (index),
- * its end (next_index), and constructs a bit mask for tagged iterating (tags).
- */
-void **radix_tree_next_chunk(struct radix_tree_root *root,
-			     struct radix_tree_iter *iter, unsigned flags);
-
-/**
- * radix_tree_chunk_size - get current chunk size
- *
- * @iter:	pointer to radix tree iterator
- * Returns:	current chunk size
- */
-static __always_inline unsigned
-radix_tree_chunk_size(struct radix_tree_iter *iter)
-{
-	return iter->next_index - iter->index;
-}
-
-/**
- * radix_tree_next_slot - find next slot in chunk
- *
- * @slot:	pointer to current slot
- * @iter:	pointer to interator state
- * @flags:	RADIX_TREE_ITER_*, should be constant
- * Returns:	pointer to next slot, or NULL if there no more left
- *
- * This function updates @iter->index in the case of a successful lookup.
- * For tagged lookup it also eats @iter->tags.
- */
-static __always_inline void **
-radix_tree_next_slot(void **slot, struct radix_tree_iter *iter, unsigned flags)
-{
-	if (flags & RADIX_TREE_ITER_TAGGED) {
-		iter->tags >>= 1;
-		if (likely(iter->tags & 1ul)) {
-			iter->index++;
-			return slot + 1;
-		}
-		if (!(flags & RADIX_TREE_ITER_CONTIG) && likely(iter->tags)) {
-			unsigned offset = __ffs(iter->tags);
-
-			iter->tags >>= offset;
-			iter->index += offset + 1;
-			return slot + offset + 1;
-		}
-	} else {
-		unsigned size = radix_tree_chunk_size(iter) - 1;
-
-		while (size--) {
-			slot++;
-			iter->index++;
-			if (likely(*slot))
-				return slot;
-			if (flags & RADIX_TREE_ITER_CONTIG) {
-				/* forbid switching to the next chunk */
-				iter->next_index = 0;
-				break;
-			}
-		}
-	}
-	return NULL;
-}
-
-/**
- * radix_tree_for_each_chunk - iterate over chunks
- *
- * @slot:	the void** variable for pointer to chunk first slot
- * @root:	the struct radix_tree_root pointer
- * @iter:	the struct radix_tree_iter pointer
- * @start:	iteration starting index
- * @flags:	RADIX_TREE_ITER_* and tag index
- *
- * Locks can be released and reacquired between iterations.
- */
-#define radix_tree_for_each_chunk(slot, root, iter, start, flags)	\
-	for (slot = radix_tree_iter_init(iter, start) ;			\
-	      (slot = radix_tree_next_chunk(root, iter, flags)) ;)
-
-/**
- * radix_tree_for_each_chunk_slot - iterate over slots in one chunk
- *
- * @slot:	the void** variable, at the beginning points to chunk first slot
- * @iter:	the struct radix_tree_iter pointer
- * @flags:	RADIX_TREE_ITER_*, should be constant
- *
- * This macro is designed to be nested inside radix_tree_for_each_chunk().
- * @slot points to the radix tree slot, @iter->index contains its index.
- */
-#define radix_tree_for_each_chunk_slot(slot, iter, flags)		\
-	for (; slot ; slot = radix_tree_next_slot(slot, iter, flags))
-
-/**
- * radix_tree_for_each_slot - iterate over non-empty slots
- *
- * @slot:	the void** variable for pointer to slot
- * @root:	the struct radix_tree_root pointer
- * @iter:	the struct radix_tree_iter pointer
- * @start:	iteration starting index
- *
- * @slot points to radix tree slot, @iter->index contains its index.
- */
-#define radix_tree_for_each_slot(slot, root, iter, start)		\
-	for (slot = radix_tree_iter_init(iter, start) ;			\
-	     slot || (slot = radix_tree_next_chunk(root, iter, 0)) ;	\
-	     slot = radix_tree_next_slot(slot, iter, 0))
-
-/**
- * radix_tree_for_each_contig - iterate over contiguous slots
- *
- * @slot:	the void** variable for pointer to slot
- * @root:	the struct radix_tree_root pointer
- * @iter:	the struct radix_tree_iter pointer
- * @start:	iteration starting index
- *
- * @slot points to radix tree slot, @iter->index contains its index.
- */
-#define radix_tree_for_each_contig(slot, root, iter, start)		\
-	for (slot = radix_tree_iter_init(iter, start) ;			\
-	     slot || (slot = radix_tree_next_chunk(root, iter,		\
-				RADIX_TREE_ITER_CONTIG)) ;		\
-	     slot = radix_tree_next_slot(slot, iter,			\
-				RADIX_TREE_ITER_CONTIG))
-
-/**
- * radix_tree_for_each_tagged - iterate over tagged slots
- *
- * @slot:	the void** variable for pointer to slot
- * @root:	the struct radix_tree_root pointer
- * @iter:	the struct radix_tree_iter pointer
- * @start:	iteration starting index
- * @tag:	tag index
- *
- * @slot points to radix tree slot, @iter->index contains its index.
- */
-#define radix_tree_for_each_tagged(slot, root, iter, start, tag)	\
-	for (slot = radix_tree_iter_init(iter, start) ;			\
-	     slot || (slot = radix_tree_next_chunk(root, iter,		\
-			      RADIX_TREE_ITER_TAGGED | tag)) ;		\
-	     slot = radix_tree_next_slot(slot, iter,			\
-				RADIX_TREE_ITER_TAGGED))
-
-#endif /* CPTCFG_BACKPORT_BUILD_RADIX_HELPERS */
-
-#endif /* BACKPORT_LINUX_RADIX_TREE_H */
diff --git a/backport/compat/Kconfig b/backport/compat/Kconfig
index e2f0cdd..215de8e 100644
--- a/backport/compat/Kconfig
+++ b/backport/compat/Kconfig
@@ -185,13 +185,6 @@ config BACKPORT_LEDS_CLASS
 config BACKPORT_LEDS_TRIGGERS
 	bool
 
-config BACKPORT_BUILD_RADIX_HELPERS
-	bool
-	# You have selected to build backported DRM drivers
-	# Build only if on < 3.4
-	depends on DRM && BACKPORT_KERNEL_3_4
-	default y if BACKPORT_USERSEL_BUILD_ALL
-
 config BACKPORT_USERSEL_BUILD_ALL
 	bool "Build all compat code"
 	help
diff --git a/backport/compat/Makefile b/backport/compat/Makefile
index a74507e..2d4928c 100644
--- a/backport/compat/Makefile
+++ b/backport/compat/Makefile
@@ -40,4 +40,3 @@ compat-$(CPTCFG_BACKPORT_KERNEL_3_12) += backport-3.12.o
 compat-$(CPTCFG_BACKPORT_BUILD_KFIFO) += kfifo.o
 compat-$(CPTCFG_BACKPORT_BUILD_GENERIC_ATOMIC64) += compat_atomic.o
 compat-$(CPTCFG_BACKPORT_BUILD_DMA_SHARED_HELPERS) += dma-shared-helpers.o
-compat-$(CPTCFG_BACKPORT_BUILD_RADIX_HELPERS) += lib-radix-tree-helpers.o
diff --git a/backport/compat/lib-radix-tree-helpers.c b/backport/compat/lib-radix-tree-helpers.c
deleted file mode 100644
index 837de04..0000000
--- a/backport/compat/lib-radix-tree-helpers.c
+++ /dev/null
@@ -1,266 +0,0 @@
-/*
- * Copyright (C) 2013 Konstantin Khlebnikov
- * Copyright (c) 2013 Luis R. Rodriguez <mcgrof@do-not-panic.com>
- *
- * Backports radix_tree_next_chunk()
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2, or (at
- * your option) any later version.
- */
-
-#include <linux/errno.h>
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/export.h>
-#include <linux/radix-tree.h>
-#include <linux/percpu.h>
-#include <linux/slab.h>
-#include <linux/notifier.h>
-#include <linux/cpu.h>
-#include <linux/string.h>
-#include <linux/bitops.h>
-#include <linux/rcupdate.h>
-
-#ifdef __KERNEL__
-#define RADIX_TREE_MAP_SHIFT	(CONFIG_BASE_SMALL ? 4 : 6)
-#else
-#define RADIX_TREE_MAP_SHIFT	3	/* For more stressful testing */
-#endif
-
-#define RADIX_TREE_MAP_SIZE	(1UL << RADIX_TREE_MAP_SHIFT)
-#define RADIX_TREE_MAP_MASK	(RADIX_TREE_MAP_SIZE-1)
-
-#define RADIX_TREE_TAG_LONGS	\
-	((RADIX_TREE_MAP_SIZE + BITS_PER_LONG - 1) / BITS_PER_LONG)
-
-struct radix_tree_node {
-	unsigned int	height;		/* Height from the bottom */
-	unsigned int	count;
-	union {
-		struct radix_tree_node *parent;	/* Used when ascending tree */
-		struct rcu_head	rcu_head;	/* Used when freeing node */
-	};
-	void __rcu	*slots[RADIX_TREE_MAP_SIZE];
-	unsigned long	tags[RADIX_TREE_MAX_TAGS][RADIX_TREE_TAG_LONGS];
-};
-
-static inline void *ptr_to_indirect(void *ptr)
-{
-	return (void *)((unsigned long)ptr | RADIX_TREE_INDIRECT_PTR);
-}
-
-static inline void *indirect_to_ptr(void *ptr)
-{
-	return (void *)((unsigned long)ptr & ~RADIX_TREE_INDIRECT_PTR);
-}
-
-static inline gfp_t root_gfp_mask(struct radix_tree_root *root)
-{
-	return root->gfp_mask & __GFP_BITS_MASK;
-}
-
-static inline void tag_set(struct radix_tree_node *node, unsigned int tag,
-		int offset)
-{
-	__set_bit(offset, node->tags[tag]);
-}
-
-static inline void tag_clear(struct radix_tree_node *node, unsigned int tag,
-		int offset)
-{
-	__clear_bit(offset, node->tags[tag]);
-}
-
-static inline int tag_get(struct radix_tree_node *node, unsigned int tag,
-		int offset)
-{
-	return test_bit(offset, node->tags[tag]);
-}
-
-static inline void root_tag_set(struct radix_tree_root *root, unsigned int tag)
-{
-	root->gfp_mask |= (__force gfp_t)(1 << (tag + __GFP_BITS_SHIFT));
-}
-
-static inline void root_tag_clear(struct radix_tree_root *root, unsigned int tag)
-{
-	root->gfp_mask &= (__force gfp_t)~(1 << (tag + __GFP_BITS_SHIFT));
-}
-
-static inline void root_tag_clear_all(struct radix_tree_root *root)
-{
-	root->gfp_mask &= __GFP_BITS_MASK;
-}
-
-static inline int root_tag_get(struct radix_tree_root *root, unsigned int tag)
-{
-	return (__force unsigned)root->gfp_mask & (1 << (tag + __GFP_BITS_SHIFT));
-}
-
-/*
- * Returns 1 if any slot in the node has this tag set.
- * Otherwise returns 0.
- */
-static inline int any_tag_set(struct radix_tree_node *node, unsigned int tag)
-{
-	int idx;
-	for (idx = 0; idx < RADIX_TREE_TAG_LONGS; idx++) {
-		if (node->tags[tag][idx])
-			return 1;
-	}
-	return 0;
-}
-
-/**
- * radix_tree_find_next_bit - find the next set bit in a memory region
- *
- * @addr: The address to base the search on
- * @size: The bitmap size in bits
- * @offset: The bitnumber to start searching at
- *
- * Unrollable variant of find_next_bit() for constant size arrays.
- * Tail bits starting from size to roundup(size, BITS_PER_LONG) must be zero.
- * Returns next bit offset, or size if nothing found.
- */
-static __always_inline unsigned long
-radix_tree_find_next_bit(const unsigned long *addr,
-			 unsigned long size, unsigned long offset)
-{
-	if (!__builtin_constant_p(size))
-		return find_next_bit(addr, size, offset);
-
-	if (offset < size) {
-		unsigned long tmp;
-
-		addr += offset / BITS_PER_LONG;
-		tmp = *addr >> (offset % BITS_PER_LONG);
-		if (tmp)
-			return __ffs(tmp) + offset;
-		offset = (offset + BITS_PER_LONG) & ~(BITS_PER_LONG - 1);
-		while (offset < size) {
-			tmp = *++addr;
-			if (tmp)
-				return __ffs(tmp) + offset;
-			offset += BITS_PER_LONG;
-		}
-	}
-	return size;
-}
-
-/**
- * radix_tree_next_chunk - find next chunk of slots for iteration
- *
- * @root:	radix tree root
- * @iter:	iterator state
- * @flags:	RADIX_TREE_ITER_* flags and tag index
- * Returns:	pointer to chunk first slot, or NULL if iteration is over
- */
-void **radix_tree_next_chunk(struct radix_tree_root *root,
-			     struct radix_tree_iter *iter, unsigned flags)
-{
-	unsigned shift, tag = flags & RADIX_TREE_ITER_TAG_MASK;
-	struct radix_tree_node *rnode, *node;
-	unsigned long index, offset;
-
-	if ((flags & RADIX_TREE_ITER_TAGGED) && !root_tag_get(root, tag))
-		return NULL;
-
-	/*
-	 * Catch next_index overflow after ~0UL. iter->index never overflows
-	 * during iterating; it can be zero only at the beginning.
-	 * And we cannot overflow iter->next_index in a single step,
-	 * because RADIX_TREE_MAP_SHIFT < BITS_PER_LONG.
-	 *
-	 * This condition also used by radix_tree_next_slot() to stop
-	 * contiguous iterating, and forbid swithing to the next chunk.
-	 */
-	index = iter->next_index;
-	if (!index && iter->index)
-		return NULL;
-
-	rnode = rcu_dereference_raw(root->rnode);
-	if (radix_tree_is_indirect_ptr(rnode)) {
-		rnode = indirect_to_ptr(rnode);
-	} else if (rnode && !index) {
-		/* Single-slot tree */
-		iter->index = 0;
-		iter->next_index = 1;
-		iter->tags = 1;
-		return (void **)&root->rnode;
-	} else
-		return NULL;
-
-restart:
-	shift = (rnode->height - 1) * RADIX_TREE_MAP_SHIFT;
-	offset = index >> shift;
-
-	/* Index outside of the tree */
-	if (offset >= RADIX_TREE_MAP_SIZE)
-		return NULL;
-
-	node = rnode;
-	while (1) {
-		if ((flags & RADIX_TREE_ITER_TAGGED) ?
-				!test_bit(offset, node->tags[tag]) :
-				!node->slots[offset]) {
-			/* Hole detected */
-			if (flags & RADIX_TREE_ITER_CONTIG)
-				return NULL;
-
-			if (flags & RADIX_TREE_ITER_TAGGED)
-				offset = radix_tree_find_next_bit(
-						node->tags[tag],
-						RADIX_TREE_MAP_SIZE,
-						offset + 1);
-			else
-				while (++offset	< RADIX_TREE_MAP_SIZE) {
-					if (node->slots[offset])
-						break;
-				}
-			index &= ~((RADIX_TREE_MAP_SIZE << shift) - 1);
-			index += offset << shift;
-			/* Overflow after ~0UL */
-			if (!index)
-				return NULL;
-			if (offset == RADIX_TREE_MAP_SIZE)
-				goto restart;
-		}
-
-		/* This is leaf-node */
-		if (!shift)
-			break;
-
-		node = rcu_dereference_raw(node->slots[offset]);
-		if (node == NULL)
-			goto restart;
-		shift -= RADIX_TREE_MAP_SHIFT;
-		offset = (index >> shift) & RADIX_TREE_MAP_MASK;
-	}
-
-	/* Update the iterator state */
-	iter->index = index;
-	iter->next_index = (index | RADIX_TREE_MAP_MASK) + 1;
-
-	/* Construct iter->tags bit-mask from node->tags[tag] array */
-	if (flags & RADIX_TREE_ITER_TAGGED) {
-		unsigned tag_long, tag_bit;
-
-		tag_long = offset / BITS_PER_LONG;
-		tag_bit  = offset % BITS_PER_LONG;
-		iter->tags = node->tags[tag][tag_long] >> tag_bit;
-		/* This never happens if RADIX_TREE_TAG_LONGS == 1 */
-		if (tag_long < RADIX_TREE_TAG_LONGS - 1) {
-			/* Pick tags from next element */
-			if (tag_bit)
-				iter->tags |= node->tags[tag][tag_long + 1] <<
-						(BITS_PER_LONG - tag_bit);
-			/* Clip chunk size, here only BITS_PER_LONG tags */
-			iter->next_index = index + BITS_PER_LONG;
-		}
-	}
-
-	return node->slots + offset;
-}
-EXPORT_SYMBOL_GPL(radix_tree_next_chunk);
-- 
1.7.10.4

