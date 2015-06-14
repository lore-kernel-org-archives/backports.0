Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:41033 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752049AbbFNO3i (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 14 Jun 2015 10:29:38 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 15/21] backports: add tty_set_termios()
Date: Sun, 14 Jun 2015 16:29:16 +0200
Message-Id: <1434292162-2261-16-git-send-email-hauke@hauke-m.de> (sfid-20150614_163351_374702_CA523BFF)
In-Reply-To: <1434292162-2261-1-git-send-email-hauke@hauke-m.de>
References: <1434292162-2261-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

tty_set_termios() was not exported any more in kernel 4.0-rc1 (commit
632f32e21) and exported again in kernel 4.1-rc2 (commit b00f5c2dc).
This patch adds the backport for kernel 4.0.X, we can not detect kernel
4.1-rc1, which would also need this fix, so bluetooth will have a
compile error on kernel 4.1-rc1, kernel 4.1-rc2 and more recent
versions will work.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/tty.h |  5 +++
 backport/compat/backport-4.1.c        | 65 +++++++++++++++++++++++++++++++++++
 2 files changed, 70 insertions(+)

diff --git a/backport/backport-include/linux/tty.h b/backport/backport-include/linux/tty.h
index 758c549..3b8a0a2 100644
--- a/backport/backport-include/linux/tty.h
+++ b/backport/backport-include/linux/tty.h
@@ -24,4 +24,9 @@ extern void tty_port_tty_wakeup(struct tty_port *port);
 extern void tty_port_tty_hangup(struct tty_port *port, bool check_clocal);
 #endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,10,0) */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0) && \
+    LINUX_VERSION_CODE >= KERNEL_VERSION(4,0,0)
+extern int tty_set_termios(struct tty_struct *tty, struct ktermios *kt);
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0) */
+
 #endif /* __BACKPORT_LINUX_TTY_H */
diff --git a/backport/compat/backport-4.1.c b/backport/compat/backport-4.1.c
index d5027bd..f367e3b 100644
--- a/backport/compat/backport-4.1.c
+++ b/backport/compat/backport-4.1.c
@@ -1,5 +1,6 @@
 /*
  * Copyright (c) 2015  Stefan Assmann <sassmann@kpanic.de>
+ * Copyright (c) 2015  Hauke Mehrtens <hauke@hauke-m.de>
  *
  * Backport functionality introduced in Linux 4.1.
  *
@@ -9,6 +10,7 @@
  */
 
 #include <linux/netdevice.h>
+#include <linux/tty.h>
 
 netdev_features_t passthru_features_check(struct sk_buff *skb,
 					  struct net_device *dev,
@@ -17,3 +19,66 @@ netdev_features_t passthru_features_check(struct sk_buff *skb,
 	return features;
 }
 EXPORT_SYMBOL_GPL(passthru_features_check);
+
+#ifdef CONFIG_TTY
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,0,0)
+static void unset_locked_termios(struct ktermios *termios,
+				 struct ktermios *old,
+				 struct ktermios *locked)
+{
+	int	i;
+
+#define NOSET_MASK(x, y, z) (x = ((x) & ~(z)) | ((y) & (z)))
+
+	if (!locked) {
+		printk(KERN_WARNING "Warning?!? termios_locked is NULL.\n");
+		return;
+	}
+
+	NOSET_MASK(termios->c_iflag, old->c_iflag, locked->c_iflag);
+	NOSET_MASK(termios->c_oflag, old->c_oflag, locked->c_oflag);
+	NOSET_MASK(termios->c_cflag, old->c_cflag, locked->c_cflag);
+	NOSET_MASK(termios->c_lflag, old->c_lflag, locked->c_lflag);
+	termios->c_line = locked->c_line ? old->c_line : termios->c_line;
+	for (i = 0; i < NCCS; i++)
+		termios->c_cc[i] = locked->c_cc[i] ?
+			old->c_cc[i] : termios->c_cc[i];
+	/* FIXME: What should we do for i/ospeed */
+}
+
+int tty_set_termios(struct tty_struct *tty, struct ktermios *new_termios)
+{
+	struct ktermios old_termios;
+	struct tty_ldisc *ld;
+
+	WARN_ON(tty->driver->type == TTY_DRIVER_TYPE_PTY &&
+		tty->driver->subtype == PTY_TYPE_MASTER);
+	/*
+	 *	Perform the actual termios internal changes under lock.
+	 */
+
+
+	/* FIXME: we need to decide on some locking/ordering semantics
+	   for the set_termios notification eventually */
+	down_write(&tty->termios_rwsem);
+	old_termios = tty->termios;
+	tty->termios = *new_termios;
+	unset_locked_termios(&tty->termios, &old_termios, &tty->termios_locked);
+
+	if (tty->ops->set_termios)
+		tty->ops->set_termios(tty, &old_termios);
+	else
+		tty_termios_copy_hw(&tty->termios, &old_termios);
+
+	ld = tty_ldisc_ref(tty);
+	if (ld != NULL) {
+		if (ld->ops->set_termios)
+			ld->ops->set_termios(tty, &old_termios);
+		tty_ldisc_deref(ld);
+	}
+	up_write(&tty->termios_rwsem);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(tty_set_termios);
+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(4,0,0) */
+#endif /* CONFIG_TTY */
-- 
2.1.4

