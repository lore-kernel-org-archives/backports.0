Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pb0-f47.google.com ([209.85.160.47]:47530 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752528AbaDEMmq (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 5 Apr 2014 08:42:46 -0400
Received: by mail-pb0-f47.google.com with SMTP id up15so4671088pbc.20
        for <backports@vger.kernel.org>; Sat, 05 Apr 2014 05:42:46 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	Ingo Molnar <mingo@elte.hu>, Jason Baron <jbaron@redhat.com>,
	Hannes Frederic Sowa <hannes@stressinduktion.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Alexander Smirnov <alex.bluesman.smirnov@gmail.com>,
	Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
	linux-zigbee-devel@lists.sourceforge.net
Subject: [PATCH 20/27] backports: address jump label and static key support
Date: Sat,  5 Apr 2014 05:40:54 -0700
Message-Id: <1396701662-15165-21-git-send-email-mcgrof@do-not-panic.com> (sfid-20140405_144450_705310_00884BD1)
In-Reply-To: <1396701662-15165-1-git-send-email-mcgrof@do-not-panic.com>
References: <1396701662-15165-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The ieee802154 subsystem, which we backport, makes use of
net_get_random_once() through net/ieee802154/reassembly.c
and this in turn makes use of the static keys. Static keys
were split out from the jump label support via commit c5905afb
by Ingo through kernel v3.3 -- note that git describe --contains
will disagree and say its v3.5. Jump label support was added by
Jason via commit bf5438fc through kernel v2.6.37 but later
Jason provided static branch optimizations via commit d430d3d7e
added through v3.0. static_key_initialized and STATIC_KEY_CHECK_USE()
were last added by Hannes through kernel v3.13 throughy c4b2c0c5f.

In order to backport static keys and jump label we need to
provide name mapping for kernels that only had jump label support,
but due to the static branch optimizations and since these are
architecture specific we cannot backport them unless we start carrying
around architecture replacement code -- or do some other trickery.
For kernels that lacked jump label support and that don't have the
static branch optimizations we simply carry in the kernel implmentation
that assumes you have no architecture support for jump label which
treats the labels as simply atomic drivers for branches. For older
kernels then we don't backport usage of static_key_initialized and
usage of STATIC_KEY_CHECK_USE().

This does leave a gap of kernels without static key / jump label
support, I tried backporting it but ran into issues quickly. Those
daring to continue to embark on this journey can pick up where
I left off:

[0] drvbp1.linux-foundation.org/~mcgrof/examples/2014/04/01/backport-static-keys.patch

I will note that properly backporting this can have implications on how
we backport tracing support as that is the main usage for jump labels.
Real enthusiasts can go ahead an extend this with architecture / kernel
revision specific changes -- but be warned -- we will have hard litmus
test for compilation on backports using ckmake --allyesconfig on all
supported kernels we carry.

This is a long way of saying -- we require at least 3.5 for static
key support, we also support kernels older than 2.6.37 but this goes
untested.

mcgrof@ergon ~/linux (git::master)$ git describe --contains bf5438fc
v2.6.37-rc1~214^2~33^2~8

mcgrof@ergon ~/linux (git::master)$ git describe --contains d430d3d7e
v3.0-rc1~404^2~18^2~2

mcgrof@ergon ~/linux (git::master)$ git describe --contains c5905afb
v3.5-rc1~120^3~76^2 -- wrong! Its actually v3.3 try:
  git checkout -b static-changes c5905afb; git describe

mcgrof@ergon ~/linux (git::master)$ git describe --contains c4b2c0c5f
v3.13-rc1~105^2~157^2~6

Cc: Ingo Molnar <mingo@elte.hu>
Cc: Jason Baron <jbaron@redhat.com>
CC: Jason Baron <jbaron@redhat.com>
Cc: Hannes Frederic Sowa <hannes@stressinduktion.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Alexander Smirnov <alex.bluesman.smirnov@gmail.com>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: linux-zigbee-devel@lists.sourceforge.net
Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 backport/backport-include/linux/static_key.h | 186 +++++++++++++++++++++++++++
 backport/backport-include/linux/tracepoint.h |   7 +
 2 files changed, 193 insertions(+)
 create mode 100644 backport/backport-include/linux/static_key.h

diff --git a/backport/backport-include/linux/static_key.h b/backport/backport-include/linux/static_key.h
new file mode 100644
index 0000000..0bbb61e
--- /dev/null
+++ b/backport/backport-include/linux/static_key.h
@@ -0,0 +1,186 @@
+#ifndef _BACKPORTS_LINUX_STATIC_KEY_H
+#define _BACKPORTS_LINUX_STATIC_KEY_H 1
+
+#include <linux/version.h>
+
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0) /* kernels >= 3.3 */
+/*
+ * XXX: NOTE!
+ *
+ * Some 3.3 kernels carry <linux/static.h> but some don't even though its
+ * its including <linux/jump_label.h>. What makes it more confusing is that
+ * later all this got shuffled. The safe thing to do then is to just assume
+ * kernels 3.3..3.4 don't have it and include <linux/jump_label.h> instead,
+ * and for newer kernels include <linux/static_key.h>.
+ */
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
+#include_next <linux/static_key.h>
+#else
+#include <linux/jump_label.h>
+#endif
+
+#else /* kernels < 3.3 */
+/*
+ * in between 2.6.37 - 3.5 there's a slew of changes that make
+ * it hard to backport this properly. If you are interested in
+ * trying you can use this as reference:
+ *
+ * http://drvbp1.linux-foundation.org/~mcgrof/examples/2014/04/01/backport-static-keys.patch
+ *
+ * And these notes:
+ *
+ *           < v2.6.37 - No tracing support
+ * bf5438fc  - v2.6.37 - Jump label support added primarily for tracing but
+ *                       tracing was broken, later kernels started sporting
+ *                       functional tracing.
+ * d430d3d7e - v3.0    - Static branch optimizations for jump labels
+ * c5905afb  - v3.3    - Static keys split out, note on the below issue
+ * c5905afb  - v3.5    - git describe --contains c5905afb claims but not true!
+ * c4b2c0c5f - v3.13   - Adds static_key_initialized(), STATIC_KEY_CHECK_USE()
+ *
+ * Because all of this we skip 2.6.37 - 3.3 but and adding support for older
+ * can be done by of carrying over the non-architecture optimized code.
+ * Carrying new changes into this file is a burden though so if we really
+ * find use for this we could just split the non optimized versions upstream
+ * and copy that through an automatic process.
+ */
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,37)
+/*
+ * For kernels older than 2.6.37 we just take on the
+ * implementation in the kernel that assumes you have
+ * either no toolchain or architecture kernel support
+ * for the jump labels. Daring folks who wish to embark
+ * on a nutty journey may wish to see if they can backport
+ * architectural specific changes here.
+ *
+ * Jump label support was added via commit
+ * bf5438fca2950b03c21ad868090cc1a8fcd49536 through kernel
+ * v2.6.37-rc1~214^2~33^2~8
+ */
+
+/*
+ * Jump label support
+ *
+ * Copyright (C) 2009-2012 Jason Baron <jbaron@redhat.com>
+ * Copyright (C) 2011-2012 Peter Zijlstra <pzijlstr@redhat.com>
+ *
+ * Jump labels provide an interface to generate dynamic branches using
+ * self-modifying code. Assuming toolchain and architecture support the result
+ * of a "if (static_key_false(&key))" statement is a unconditional branch (which
+ * defaults to false - and the true block is placed out of line).
+ *
+ * However at runtime we can change the branch target using
+ * static_key_slow_{inc,dec}(). These function as a 'reference' count on the key
+ * object and for as long as there are references all branches referring to
+ * that particular key will point to the (out of line) true block.
+ *
+ * Since this relies on modifying code the static_key_slow_{inc,dec}() functions
+ * must be considered absolute slow paths (machine wide synchronization etc.).
+ * OTOH, since the affected branches are unconditional their runtime overhead
+ * will be absolutely minimal, esp. in the default (off) case where the total
+ * effect is a single NOP of appropriate size. The on case will patch in a jump
+ * to the out-of-line block.
+ *
+ * When the control is directly exposed to userspace it is prudent to delay the
+ * decrement to avoid high frequency code modifications which can (and do)
+ * cause significant performance degradation. Struct static_key_deferred and
+ * static_key_slow_dec_deferred() provide for this.
+ *
+ * Lacking toolchain and or architecture support, it falls back to a simple
+ * conditional branch.
+ *
+ * struct static_key my_key = STATIC_KEY_INIT_TRUE;
+ *
+ *   if (static_key_true(&my_key)) {
+ *   }
+ *
+ * will result in the true case being in-line and starts the key with a single
+ * reference. Mixing static_key_true() and static_key_false() on the same key is not
+ * allowed.
+ *
+ * Not initializing the key (static data is initialized to 0s anyway) is the
+ * same as using STATIC_KEY_INIT_FALSE.
+ *
+*/
+
+#include <linux/types.h>
+#include <linux/compiler.h>
+#include <linux/bug.h>
+
+/*
+ * For the backport we leave out static_key_initialized as
+ * no architecture code is provided to support jump labels, so
+ * we treat jump labels as simply atomic values which drive
+ * branches. Since we don't backport static_key_initialized
+ * we leave out all STATIC_KEY_CHECK_USE() uses.
+ */
+
+enum jump_label_type {
+	JUMP_LABEL_DISABLE = 0,
+	JUMP_LABEL_ENABLE,
+};
+
+struct module;
+
+#include <linux/atomic.h>
+
+struct static_key {
+	atomic_t enabled;
+};
+
+static __always_inline bool static_key_false(struct static_key *key)
+{
+	if (unlikely(atomic_read(&key->enabled) > 0))
+		return true;
+	return false;
+}
+
+static __always_inline bool static_key_true(struct static_key *key)
+{
+	if (likely(atomic_read(&key->enabled) > 0))
+		return true;
+	return false;
+}
+
+static inline void static_key_slow_inc(struct static_key *key)
+{
+	atomic_inc(&key->enabled);
+}
+
+static inline void static_key_slow_dec(struct static_key *key)
+{
+	atomic_dec(&key->enabled);
+}
+
+static inline int jump_label_text_reserved(void *start, void *end)
+{
+	return 0;
+}
+
+static inline void jump_label_lock(void) {}
+static inline void jump_label_unlock(void) {}
+
+static inline int jump_label_apply_nops(struct module *mod)
+{
+	return 0;
+}
+
+#define STATIC_KEY_INIT_TRUE ((struct static_key) \
+		{ .enabled = ATOMIC_INIT(1) })
+#define STATIC_KEY_INIT_FALSE ((struct static_key) \
+		{ .enabled = ATOMIC_INIT(0) })
+
+
+#define STATIC_KEY_INIT STATIC_KEY_INIT_FALSE
+#define jump_label_enabled static_key_enabled
+
+static inline bool static_key_enabled(struct static_key *key)
+{
+	return (atomic_read(&key->enabled) > 0);
+}
+
+#endif /* kernels older than 2.6.37  */
+#endif /* kernels < 3.3 */
+
+#endif /* _BACKPORTS_LINUX_STATIC_KEY_H */
diff --git a/backport/backport-include/linux/tracepoint.h b/backport/backport-include/linux/tracepoint.h
index f67d8d3..0ed65b7 100644
--- a/backport/backport-include/linux/tracepoint.h
+++ b/backport/backport-include/linux/tracepoint.h
@@ -10,6 +10,13 @@
  * 2.6.27		had broken tracing
  * 2.6.28-2.6.32	didn't have anything like DECLARE_EVENT_CLASS
  *			and faking it would be extremely difficult
+ * 2.6.37		moved to using jump labels
+ * 3.0			static branch optimiziations through d430d3d7e
+ * 3.3			Ingo splits up static key from jump labels,
+ *                      Note that git sees this as in v3.5 though!
+ * 3.5                  We can start relying on the static_key.h file
+ * 3.13			static_key_initialized() STATIC_KEY_CHECK_USE()
+ * 			added via commit c4b2c0c5f
  */
 #if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,28))
 /*
-- 
1.8.5.3

