Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 09/23] compat: adapt signature change of tty_flip_buffer_push() and tty_insert_flip_string()
Date: Tue, 26 Feb 2013 21:59:00 +0100
Message-Id: <1361912354-29498-10-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1361912354-29498-1-git-send-email-hauke@hauke-m.de>
References: <1361912354-29498-1-git-send-email-hauke@hauke-m.de>
List-ID: <backports@vger.kernel.org>

The method signature of tty_flip_buffer_push() and
tty_insert_flip_string() was changed in these commits and this converts
it to the old behavior.

commit 2e124b4a390ca85325fae75764bef92f0547fa25
Author: Jiri Slaby <jslaby@suse.cz>
Date:   Thu Jan 3 15:53:06 2013 +0100

    TTY: switch tty_flip_buffer_push

commit 05c7cd39907184328f48d3e7899f9cdd653ad336
Author: Jiri Slaby <jslaby@suse.cz>
Date:   Thu Jan 3 15:53:04 2013 +0100

    TTY: switch tty_insert_flip_string

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 include/linux/compat-3.7.h |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/compat-3.7.h b/include/linux/compat-3.7.h
index 6b1d2cf..03c5ce4 100644
--- a/include/linux/compat-3.7.h
+++ b/include/linux/compat-3.7.h
@@ -13,6 +13,7 @@
 #include <linux/user_namespace.h>
 #include <linux/file.h>
 #include <linux/seq_file.h>
+#include <linux/tty_flip.h>
 #include <net/netlink.h>
 
 #define VM_DONTDUMP    VM_NODUMP
@@ -197,6 +198,9 @@ static inline s64 nla_get_s64(struct nlattr *nla)
 	return tmp;
 }
 
+#define tty_flip_buffer_push(port) tty_flip_buffer_push((port)->tty)
+#define tty_insert_flip_string(port, chars, size) tty_insert_flip_string((port)->tty, chars, size)
+
 #else /* (LINUX_VERSION_CODE > KERNEL_VERSION(3,7,0)) */
 #define netlink_notify_portid(__notify) (__notify->portid)
 #define genl_info_snd_portid(__genl_info) (__genl_info->snd_portid)
-- 
1.7.10.4
