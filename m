Return-path: <backports-owner@vger.kernel.org>
Received: from mx2.mailbox.org ([80.241.60.215]:56263 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751677AbdJATiu (ORCPT <rfc822;backports@vger.kernel.org>);
        Sun, 1 Oct 2017 15:38:50 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH] header: fix compile error on PowerPC (PPC_85xx)
Date: Sun,  1 Oct 2017 21:38:23 +0200
Message-Id: <20171001193823.22685-1-hauke@hauke-m.de> (sfid-20171001_213725_971296_CB3FECF9)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Including linux/interrupt.h in linux/hrtimer.h causes this error message
on PowerPC builds on x86, ARM and MIPS it works:

  CC [M]  /backports-4.14-rc2-1/compat/main.o
In file included from /backports-4.14-rc2-1/backport-include/linux/printk.h:5:0,
                 from ./include/linux/kernel.h:13,
                 from /backports-4.14-rc2-1/backport-include/linux/kernel.h:3,
                 from ./include/linux/list.h:8,
                 from /backports-4.14-rc2-1/backport-include/linux/list.h:3,
                 from ./include/linux/module.h:9,
                 from /backports-4.14-rc2-1/backport-include/linux/module.h:3,
                 from /backports-4.14-rc2-1/compat/main.c:1:
./include/linux/ratelimit.h: In function 'ratelimit_state_exit':
./include/linux/ratelimit.h:62:11: error: dereferencing pointer to incomplete type 'struct task_struct'
    current->comm, rs->missed);
           ^
./include/linux/printk.h:279:37: note: in definition of macro 'pr_warning'
  printk(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
                                     ^
./include/linux/ratelimit.h:61:3: note: in expansion of macro 'pr_warn'
   pr_warn("%s: %d output lines suppressed due to ratelimiting\n",
   ^

The backport of the hrtimer_start() functions needs the
linux/interrupt.h because some parts are defined there. Fix this by
moving the hrtimer_start() backport to the linux/interrupt.h backport
header file.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/hrtimer.h   | 17 -----------------
 backport/backport-include/linux/interrupt.h | 17 ++++++++++++++++-
 2 files changed, 16 insertions(+), 18 deletions(-)
 delete mode 100644 backport/backport-include/linux/hrtimer.h

diff --git a/backport/backport-include/linux/hrtimer.h b/backport/backport-include/linux/hrtimer.h
deleted file mode 100644
index bdcf106e..00000000
--- a/backport/backport-include/linux/hrtimer.h
+++ /dev/null
@@ -1,17 +0,0 @@
-#ifndef _BP_HRTIMER_H
-#define _BP_HRTIMER_H
-#include <linux/version.h>
-#include_next <linux/hrtimer.h>
-#include <linux/interrupt.h>
-
-#if LINUX_VERSION_IS_LESS(4,10,0)
-static inline void backport_hrtimer_start(struct hrtimer *timer, s64 time,
-					  const enum hrtimer_mode mode)
-{
-	ktime_t _time = { .tv64 = time };
-	hrtimer_start(timer, _time, mode);
-}
-#define hrtimer_start LINUX_BACKPORT(hrtimer_start)
-#endif
-
-#endif /* _BP_HRTIMER_H */
diff --git a/backport/backport-include/linux/interrupt.h b/backport/backport-include/linux/interrupt.h
index 0e243ba8..ad3cbf66 100644
--- a/backport/backport-include/linux/interrupt.h
+++ b/backport/backport-include/linux/interrupt.h
@@ -1,2 +1,17 @@
-#include <linux/hrtimer.h>
+#ifndef _BP_LINUX_INTERRUPT_H
+#define _BP_LINUX_INTERRUPT_H
+#include <linux/version.h>
 #include_next <linux/interrupt.h>
+#include <linux/ktime.h>
+
+#if LINUX_VERSION_IS_LESS(4,10,0)
+static inline void backport_hrtimer_start(struct hrtimer *timer, s64 time,
+					  const enum hrtimer_mode mode)
+{
+	ktime_t _time = { .tv64 = time };
+	hrtimer_start(timer, _time, mode);
+}
+#define hrtimer_start LINUX_BACKPORT(hrtimer_start)
+#endif
+
+#endif /* _BP_LINUX_INTERRUPT_H */
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
