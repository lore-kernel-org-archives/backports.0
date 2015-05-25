Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:57959 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750973AbbEYVoP (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 25 May 2015 17:44:15 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: mcgrof@kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 1/4] header: do not backport wait functions on kernel >= 3.18.12
Date: Mon, 25 May 2015 23:44:01 +0200
Message-Id: <1432590244-4101-1-git-send-email-hauke@hauke-m.de> (sfid-20150525_234418_354049_6B09C254)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This feature was backported to kernel 3.18.12 and we should not
activate it on these kernel versions any more.

Reported-by: Jonas Gorski <jogo@openwrt.org>
Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/wait.h | 2 +-
 backport/compat/backport-3.19.c        | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/backport/backport-include/linux/wait.h b/backport/backport-include/linux/wait.h
index 86ad2b0..4b02f52 100644
--- a/backport/backport-include/linux/wait.h
+++ b/backport/backport-include/linux/wait.h
@@ -23,7 +23,7 @@ backport_wait_on_bit_io(void *word, int bit, unsigned mode)
 
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,19,0)
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,18,12)
 #define WQ_FLAG_WOKEN		0x02
 
 #define wait_woken LINUX_BACKPORT(wait_woken)
diff --git a/backport/compat/backport-3.19.c b/backport/compat/backport-3.19.c
index 0b59bef..8a241b7 100644
--- a/backport/compat/backport-3.19.c
+++ b/backport/compat/backport-3.19.c
@@ -15,6 +15,7 @@
 #include <linux/netdevice.h>
 #include <linux/debugfs.h>
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,18,12)
 static inline bool is_kthread_should_stop(void)
 {
 	return (current->flags & PF_KTHREAD) && kthread_should_stop();
@@ -79,6 +80,7 @@ int woken_wake_function(wait_queue_t *wait, unsigned mode, int sync, void *key)
 	return default_wake_function(wait, mode, sync, key);
 }
 EXPORT_SYMBOL(woken_wake_function);
+#endif
 
 #ifdef __BACKPORT_NETDEV_RSS_KEY_FILL
 u8 netdev_rss_key[NETDEV_RSS_KEY_LEN];
-- 
2.1.4

