Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:55825 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753032Ab3KGU2N (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 7 Nov 2013 15:28:13 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 02/11] backports: do not build tty backport if it is not in the kernel
Date: Thu,  7 Nov 2013 21:27:49 +0100
Message-Id: <1383856078-19823-3-git-send-email-hauke@hauke-m.de> (sfid-20131107_212814_990753_4B1B06BF)
In-Reply-To: <1383856078-19823-1-git-send-email-hauke@hauke-m.de>
References: <1383856078-19823-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The backported parts of tty are depending on tty being build into the
kernel, deactivate them if tty was not activated in the kernel config.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/compat/backport-3.10.c |    2 ++
 backport/compat/compat-2.6.28.c |    2 ++
 backport/compat/compat-2.6.39.c |    2 ++
 3 files changed, 6 insertions(+)

diff --git a/backport/compat/backport-3.10.c b/backport/compat/backport-3.10.c
index f445250..07a8dac 100644
--- a/backport/compat/backport-3.10.c
+++ b/backport/compat/backport-3.10.c
@@ -95,6 +95,7 @@ unsigned int get_random_int(void)
 EXPORT_SYMBOL_GPL(get_random_int);
 
 #if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,28))
+#ifdef CONFIG_TTY
 /**
  * tty_port_tty_wakeup - helper to wake up a tty
  *
@@ -126,4 +127,5 @@ void tty_port_tty_hangup(struct tty_port *port, bool check_clocal)
 	tty_kref_put(tty);
 }
 EXPORT_SYMBOL_GPL(tty_port_tty_hangup);
+#endif /* CONFIG_TTY */
 #endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,28)) */
diff --git a/backport/compat/compat-2.6.28.c b/backport/compat/compat-2.6.28.c
index e38004f..1a4b01d 100644
--- a/backport/compat/compat-2.6.28.c
+++ b/backport/compat/compat-2.6.28.c
@@ -318,6 +318,7 @@ void v2_6_28_skb_add_rx_frag(struct sk_buff *skb, int i, struct page *page, int
 }
 EXPORT_SYMBOL_GPL(v2_6_28_skb_add_rx_frag);
 
+#ifdef CONFIG_TTY
 void tty_write_unlock(struct tty_struct *tty)
 {
 	mutex_unlock(&tty->atomic_write_lock);
@@ -443,6 +444,7 @@ int n_tty_ioctl_helper(struct tty_struct *tty, struct file *file,
 	}
 }
 EXPORT_SYMBOL_GPL(n_tty_ioctl_helper);
+#endif /* CONFIG_TTY */
 
 #ifdef CONFIG_PCI
 /**
diff --git a/backport/compat/compat-2.6.39.c b/backport/compat/compat-2.6.39.c
index 62d8a66..44796da 100644
--- a/backport/compat/compat-2.6.39.c
+++ b/backport/compat/compat-2.6.39.c
@@ -14,6 +14,7 @@
 #include <linux/module.h>
 
 #if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,27))
+#ifdef CONFIG_TTY
 /*
  *		Termios Helper Methods
  */
@@ -111,5 +112,6 @@ int tty_set_termios(struct tty_struct *tty, struct ktermios *new_termios)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(tty_set_termios);
+#endif /* CONFIG_TTY */
 #endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,27)) */
 
-- 
1.7.10.4

