Return-path: <backports-owner@vger.kernel.org>
Received: from lpdvrndsmtp01.broadcom.com ([192.19.229.170]:45303 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933511AbdCJKBU (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 10 Mar 2017 05:01:20 -0500
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: backports@vger.kernel.org,
        Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [PATCH] backports: provide backport for setup_deferrable_timer()
Date: Fri, 10 Mar 2017 10:01:10 +0000
Message-Id: <1489140070-29878-1-git-send-email-arend.vanspriel@broadcom.com> (sfid-20170310_110147_921141_BC86D9EB)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Since commit f8f118ceaa56 ("mac80211: Use setup_timer instead of
init_timer") mac80211 needs setup_deferrable_timer() which is not
available in older kernels. Provide a backport in linux/timer.h.
Really need two flavors of backport to support up to 3.0 kernel.

Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
Hit another one last night so here it is.

Regards,
Arend
---
 backport/backport-include/linux/timer.h | 35 +++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 backport/backport-include/linux/timer.h

diff --git a/backport/backport-include/linux/timer.h b/backport/backport-include/linux/timer.h
new file mode 100644
index 0000000..df560a2
--- /dev/null
+++ b/backport/backport-include/linux/timer.h
@@ -0,0 +1,35 @@
+#ifndef _BACKPORT_TIMER_H
+#define _BACKPORT_TIMER_H
+
+#include_next <linux/timer.h>
+
+#ifndef setup_deferrable_timer
+/*
+ * The TIMER_DEFERRABLE flag has not been around since 3.0 so
+ * two different backports are needed here.
+ */
+#ifdef TIMER_DEFERRABLE
+#define setup_deferrable_timer(timer, fn, data)                         \
+        __setup_timer((timer), (fn), (data), TIMER_DEFERRABLE)
+#else
+static inline void setup_deferrable_timer_key(struct timer_list *timer,
+					      const char *name,
+					      struct lock_class_key *key,
+					      void (*func)(unsigned long),
+					      unsigned long data)
+{
+	timer->function = func;
+	timer->data = data;
+	init_timer_deferrable_key(timer, name, key);
+}
+#define setup_deferrable_timer(timer, fn, data)				\
+	do {								\
+		static struct lock_class_key __key;			\
+		setup_deferrable_timer_key((timer), #timer, &__key,	\
+					   (fn), (data));		\
+	} while (0)
+#endif
+
+#endif
+
+#endif /* _BACKPORT_TIMER_H */
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
