Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:54946 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752528AbaDEMmw (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 5 Apr 2014 08:42:52 -0400
Received: by mail-pd0-f180.google.com with SMTP id v10so4535930pde.11
        for <backports@vger.kernel.org>; Sat, 05 Apr 2014 05:42:51 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	Hannes Frederic Sowa <hannes@stressinduktion.org>,
	Alexander Smirnov <alex.bluesman.smirnov@gmail.com>,
	Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
	linux-zigbee-devel@lists.sourceforge.net
Subject: [PATCH 21/27] backports: backport net_get_random_once()
Date: Sat,  5 Apr 2014 05:40:55 -0700
Message-Id: <1396701662-15165-22-git-send-email-mcgrof@do-not-panic.com> (sfid-20140405_144450_320432_4F9F3300)
In-Reply-To: <1396701662-15165-1-git-send-email-mcgrof@do-not-panic.com>
References: <1396701662-15165-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Commit a48e4292 introduced as of v3.13 is used by 6lowpan which
we backport. We carry this over for older kernels that don't
define it -- but we remain sane by requiring at least 3.5 which is
where tons of the jump label / static key stuff seems to have last
settled. Backporting this to any older kernel than 3.5 has a huge
string of dependencies which although I was able to resovle the
other depdendencies on 6lowpan on new net core re-architecture on
skb fragment reassembly makes it pointless to carry. Mark my words:

  !! do not try to backport this to kernels older than 3.5 !!

mcgrof@ergon ~/linux (git::master)$ git describe --contains a48e4292
v3.13-rc1~105^2~157^2~4

commit a48e42920ff38bc90bbf75143fff4555723d4540
Author: Hannes Frederic Sowa <hannes@stressinduktion.org>
Date:   Sat Oct 19 21:48:55 2013 +0200

    net: introduce new macro net_get_random_once

Cc: Hannes Frederic Sowa <hannes@stressinduktion.org>
Cc: Alexander Smirnov <alex.bluesman.smirnov@gmail.com>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: linux-zigbee-devel@lists.sourceforge.net
Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 backport/backport-include/linux/net.h | 52 +++++++++++++++++++++++++++++++++
 backport/compat/backport-3.13.c       | 54 +++++++++++++++++++++++++++++++++++
 2 files changed, 106 insertions(+)

diff --git a/backport/backport-include/linux/net.h b/backport/backport-include/linux/net.h
index 07981da..192f7b8 100644
--- a/backport/backport-include/linux/net.h
+++ b/backport/backport-include/linux/net.h
@@ -1,6 +1,7 @@
 #ifndef __BACKPORT_LINUX_NET_H
 #define __BACKPORT_LINUX_NET_H
 #include_next <linux/net.h>
+#include <linux/static_key.h>
 
 /* This backports:
  *
@@ -46,4 +47,55 @@ do {								\
 	type dst = ({ __sockaddr_check_size(sizeof(*dst)); (type) src; })
 #endif
 
+/*
+ * Avoid backporting this if a distro did the work already, this
+ * takes the check a bit further than just using LINUX_BACKPORT()
+ * namespace, curious if any distro will hit a wall with this.
+ * Also curious if any distro will be daring enough to even try
+ * to backport this to a release older than 3.5.
+ */
+#ifndef ___NET_RANDOM_STATIC_KEY_INIT
+/*
+ * Backporting this before 3.5 is extremely tricky -- I tried, due
+ * to the fact that it relies on static keys, which were refactored
+ * and optimized through a series of generation of patches from jump
+ * labels. These in turn have also been optimized through kernel revisions
+ * and have architecture specific code, which if you commit to backporting
+ * may affect tracing. My recommendation is that if you have a need for
+ * static keys you just require at least 3.5 to remain sane.
+ */
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
+#define __BACKPORT_NET_GET_RANDOM_ONCE 1
+#endif
+#endif /* ___NET_RANDOM_STATIC_KEY_INIT */
+
+#ifdef __BACKPORT_NET_GET_RANDOM_ONCE
+#define __net_get_random_once LINUX_BACKPORT(__net_get_random_once)
+bool __net_get_random_once(void *buf, int nbytes, bool *done,
+			   struct static_key *done_key);
+
+#ifdef HAVE_JUMP_LABEL
+#define ___NET_RANDOM_STATIC_KEY_INIT ((struct static_key) \
+		{ .enabled = ATOMIC_INIT(0), .entries = (void *)1 })
+#else /* !HAVE_JUMP_LABEL */
+#define ___NET_RANDOM_STATIC_KEY_INIT STATIC_KEY_INIT_FALSE
+#endif /* HAVE_JUMP_LABEL */
+
+#define net_get_random_once LINUX_BACKPORT(net_get_random_once)
+#define net_get_random_once(buf, nbytes)				\
+	({								\
+		bool ___ret = false;					\
+		static bool ___done = false;				\
+		static struct static_key ___done_key =			\
+			___NET_RANDOM_STATIC_KEY_INIT;			\
+		if (!static_key_true(&___done_key))			\
+			___ret = __net_get_random_once(buf,		\
+						       nbytes,		\
+						       &___done,	\
+						       &___done_key);	\
+		___ret;							\
+	})
+
+#endif /* __BACKPORT_NET_GET_RANDOM_ONCE */
+
 #endif /* __BACKPORT_LINUX_NET_H */
diff --git a/backport/compat/backport-3.13.c b/backport/compat/backport-3.13.c
index d5b7029..a761088 100644
--- a/backport/compat/backport-3.13.c
+++ b/backport/compat/backport-3.13.c
@@ -1,5 +1,7 @@
 /*
  * Copyright (c) 2013  Hauke Mehrtens <hauke@hauke-m.de>
+ * Copyright (c) 2013  Hannes Frederic Sowa <hannes@stressinduktion.org>
+ * Copyright (c) 2014  Luis R. Rodriguez <mcgrof@do-not-panic.com>
  *
  * Backport functionality introduced in Linux 3.13.
  *
@@ -16,6 +18,7 @@
 #include <linux/module.h>
 #include <linux/regulator/driver.h>
 #include <linux/device.h>
+#include <linux/static_key.h>
 
 static void devm_rdev_release(struct device *dev, void *res)
 {
@@ -225,3 +228,54 @@ int backport_genl_unregister_family(struct genl_family *family)
 	return err;
 }
 EXPORT_SYMBOL_GPL(backport_genl_unregister_family);
+
+#ifdef __BACKPORT_NET_GET_RANDOM_ONCE
+struct __net_random_once_work {
+	struct work_struct work;
+	struct static_key *key;
+};
+
+static void __net_random_once_deferred(struct work_struct *w)
+{
+	struct __net_random_once_work *work =
+		container_of(w, struct __net_random_once_work, work);
+	if (!static_key_enabled(work->key))
+		static_key_slow_inc(work->key);
+	kfree(work);
+}
+
+static void __net_random_once_disable_jump(struct static_key *key)
+{
+	struct __net_random_once_work *w;
+
+	w = kmalloc(sizeof(*w), GFP_ATOMIC);
+	if (!w)
+		return;
+
+	INIT_WORK(&w->work, __net_random_once_deferred);
+	w->key = key;
+	schedule_work(&w->work);
+}
+
+bool __net_get_random_once(void *buf, int nbytes, bool *done,
+			   struct static_key *done_key)
+{
+	static DEFINE_SPINLOCK(lock);
+	unsigned long flags;
+
+	spin_lock_irqsave(&lock, flags);
+	if (*done) {
+		spin_unlock_irqrestore(&lock, flags);
+		return false;
+	}
+
+	get_random_bytes(buf, nbytes);
+	*done = true;
+	spin_unlock_irqrestore(&lock, flags);
+
+	__net_random_once_disable_jump(done_key);
+
+	return true;
+}
+EXPORT_SYMBOL_GPL(__net_get_random_once);
+#endif /* __BACKPORT_NET_GET_RANDOM_ONCE */
-- 
1.8.5.3

