Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 16/23] compat: move tty_flip_buffer_push() and tty_insert_flip_string()
Date: Tue, 26 Feb 2013 21:59:07 +0100
Message-Id: <1361912354-29498-17-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1361912354-29498-1-git-send-email-hauke@hauke-m.de>
References: <1361912354-29498-1-git-send-email-hauke@hauke-m.de>
List-ID: <backports@vger.kernel.org>

These backports are also needed for kernel 3.7 and 3.8.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 include/linux/compat-3.7.h |    4 ----
 include/linux/compat-3.9.h |    5 +++++
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/linux/compat-3.7.h b/include/linux/compat-3.7.h
index 03c5ce4..6b1d2cf 100644
--- a/include/linux/compat-3.7.h
+++ b/include/linux/compat-3.7.h
@@ -13,7 +13,6 @@
 #include <linux/user_namespace.h>
 #include <linux/file.h>
 #include <linux/seq_file.h>
-#include <linux/tty_flip.h>
 #include <net/netlink.h>
 
 #define VM_DONTDUMP    VM_NODUMP
@@ -198,9 +197,6 @@ static inline s64 nla_get_s64(struct nlattr *nla)
 	return tmp;
 }
 
-#define tty_flip_buffer_push(port) tty_flip_buffer_push((port)->tty)
-#define tty_insert_flip_string(port, chars, size) tty_insert_flip_string((port)->tty, chars, size)
-
 #else /* (LINUX_VERSION_CODE > KERNEL_VERSION(3,7,0)) */
 #define netlink_notify_portid(__notify) (__notify->portid)
 #define genl_info_snd_portid(__genl_info) (__genl_info->snd_portid)
diff --git a/include/linux/compat-3.9.h b/include/linux/compat-3.9.h
index f472cf8..ff1b386 100644
--- a/include/linux/compat-3.9.h
+++ b/include/linux/compat-3.9.h
@@ -11,6 +11,8 @@
 #include <linux/rculist.h>
 #endif
 #include <net/sock.h>
+#include <linux/tty.h>
+#include <linux/tty_flip.h>
 
 /* include this before changing hlist_for_each_* to use the old versions. */
 #include <net/sch_generic.h>
@@ -116,6 +118,9 @@ static inline void idr_preload_end(void)
 #define sk_for_each(__sk, list) \
 	hlist_for_each_entry(__sk, list, sk_node)
 
+#define tty_flip_buffer_push(port) tty_flip_buffer_push((port)->tty)
+#define tty_insert_flip_string(port, chars, size) tty_insert_flip_string((port)->tty, chars, size)
+
 #endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0)) */
 
 #endif /* LINUX_3_9_COMPAT_H */
-- 
1.7.10.4
