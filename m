Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:49586 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752231Ab3JENYt (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 5 Oct 2013 09:24:49 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 5/8] backports: add tty_port_tty_hangup()
Date: Sat,  5 Oct 2013 15:23:52 +0200
Message-Id: <1380979435-5430-6-git-send-email-hauke@hauke-m.de> (sfid-20131005_152450_465966_2EE4423E)
In-Reply-To: <1380979435-5430-1-git-send-email-hauke@hauke-m.de>
References: <1380979435-5430-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This is needed by ./net/bluetooth/rfcomm/tty.c

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/tty.h |    1 +
 backport/compat/backport-3.10.c       |   16 ++++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/backport/backport-include/linux/tty.h b/backport/backport-include/linux/tty.h
index 7b57ca1..88fbfd0 100644
--- a/backport/backport-include/linux/tty.h
+++ b/backport/backport-include/linux/tty.h
@@ -50,6 +50,7 @@ extern int n_tty_ioctl_helper(struct tty_struct *tty, struct file *file,
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3,10,0)
 extern void tty_port_tty_wakeup(struct tty_port *port);
+extern void tty_port_tty_hangup(struct tty_port *port, bool check_clocal);
 #endif
 
 #endif /* __BACKPORT_LINUX_TTY_H */
diff --git a/backport/compat/backport-3.10.c b/backport/compat/backport-3.10.c
index d8b3bc6..4d44960 100644
--- a/backport/compat/backport-3.10.c
+++ b/backport/compat/backport-3.10.c
@@ -108,4 +108,20 @@ void tty_port_tty_wakeup(struct tty_port *port)
 	}
 }
 EXPORT_SYMBOL_GPL(tty_port_tty_wakeup);
+
+/**
+ * tty_port_tty_hangup - helper to hang up a tty
+ *
+ * @port: tty port
+ * @check_clocal: hang only ttys with CLOCAL unset?
+ */
+void tty_port_tty_hangup(struct tty_port *port, bool check_clocal)
+{
+	struct tty_struct *tty = tty_port_tty_get(port);
+
+	if (tty && (!check_clocal || !C_CLOCAL(tty)))
+		tty_hangup(tty);
+	tty_kref_put(tty);
+}
+EXPORT_SYMBOL_GPL(tty_port_tty_hangup);
 #endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,28)) */
-- 
1.7.10.4

