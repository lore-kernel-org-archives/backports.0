Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH] compat: add tty_port_register_device
Date: Sat, 18 Aug 2012 13:46:54 +0200
Message-Id: <1345290414-20674-1-git-send-email-hauke@hauke-m.de>
List-ID: <backports@vger.kernel.org>

tty_register_device was replaced by tty_port_register_device in this
commit:
commit 734cc1783816ae358cef45673a29bf7af974e147
Author: Jiri Slaby <jslaby@suse.cz>
Date:   Tue Aug 7 21:47:47 2012 +0200

    TTY: use tty_port_register_device

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 include/linux/compat-3.7.h |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/compat-3.7.h b/include/linux/compat-3.7.h
index 9271c2e..22a7f9f 100644
--- a/include/linux/compat-3.7.h
+++ b/include/linux/compat-3.7.h
@@ -15,6 +15,9 @@ bool mod_delayed_work(struct workqueue_struct *wq, struct delayed_work *dwork,
 #define tty_lock(__tty) tty_lock()
 #define tty_unlock(__tty) tty_unlock()
 
+#define tty_port_register_device(port, driver, index, device) \
+	tty_register_device(driver, index, device)
+
 #endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(3,7,0)) */
 
 #endif /* LINUX_3_7_COMPAT_H */
-- 
1.7.9.5
