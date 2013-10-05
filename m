Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:49583 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752222Ab3JENYr (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 5 Oct 2013 09:24:47 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 4/8] backports: add tty_port_tty_wakeup()
Date: Sat,  5 Oct 2013 15:23:51 +0200
Message-Id: <1380979435-5430-5-git-send-email-hauke@hauke-m.de> (sfid-20131005_152449_159401_3F0C52CC)
In-Reply-To: <1380979435-5430-1-git-send-email-hauke@hauke-m.de>
References: <1380979435-5430-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This is needed by ./net/bluetooth/rfcomm/tty.c

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/tty.h |    4 ++++
 backport/compat/backport-3.10.c       |   19 +++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/backport/backport-include/linux/tty.h b/backport/backport-include/linux/tty.h
index b102645..7b57ca1 100644
--- a/backport/backport-include/linux/tty.h
+++ b/backport/backport-include/linux/tty.h
@@ -48,4 +48,8 @@ extern int n_tty_ioctl_helper(struct tty_struct *tty, struct file *file,
 	tty_register_device(driver, index, device)
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,10,0)
+extern void tty_port_tty_wakeup(struct tty_port *port);
+#endif
+
 #endif /* __BACKPORT_LINUX_TTY_H */
diff --git a/backport/compat/backport-3.10.c b/backport/compat/backport-3.10.c
index 5273758..d8b3bc6 100644
--- a/backport/compat/backport-3.10.c
+++ b/backport/compat/backport-3.10.c
@@ -13,6 +13,7 @@
 #include <linux/err.h>
 #include <linux/proc_fs.h>
 #include <linux/random.h>
+#include <linux/tty.h>
 
 #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0))
 #include <linux/init.h>
@@ -90,3 +91,21 @@ unsigned int get_random_int(void)
 	return r;
 }
 EXPORT_SYMBOL_GPL(get_random_int);
+
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,28))
+/**
+ * tty_port_tty_wakeup - helper to wake up a tty
+ *
+ * @port: tty port
+ */
+void tty_port_tty_wakeup(struct tty_port *port)
+{
+	struct tty_struct *tty = tty_port_tty_get(port);
+
+	if (tty) {
+		tty_wakeup(tty);
+		tty_kref_put(tty);
+	}
+}
+EXPORT_SYMBOL_GPL(tty_port_tty_wakeup);
+#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,28)) */
-- 
1.7.10.4

