Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:36144 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751790Ab3JWVhM (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 23 Oct 2013 17:37:12 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 4/8] backports: struct tty_port was added with kernel 2.6.28
Date: Wed, 23 Oct 2013 23:36:46 +0200
Message-Id: <1382564210-15230-5-git-send-email-hauke@hauke-m.de> (sfid-20131023_233714_294339_0049A405)
In-Reply-To: <1382564210-15230-1-git-send-email-hauke@hauke-m.de>
References: <1382564210-15230-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The functions will only build for kernel version < 3.10 and >= 2.6.28,
so the same with the prototype.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/tty.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/backport/backport-include/linux/tty.h b/backport/backport-include/linux/tty.h
index 88fbfd0..2f79ac5 100644
--- a/backport/backport-include/linux/tty.h
+++ b/backport/backport-include/linux/tty.h
@@ -48,7 +48,7 @@ extern int n_tty_ioctl_helper(struct tty_struct *tty, struct file *file,
 	tty_register_device(driver, index, device)
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,10,0)
+#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,10,0)) && (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,28))
 extern void tty_port_tty_wakeup(struct tty_port *port);
 extern void tty_port_tty_hangup(struct tty_port *port, bool check_clocal);
 #endif
-- 
1.7.10.4

