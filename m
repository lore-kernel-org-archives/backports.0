Return-path: <backports-owner@vger.kernel.org>
Received: from lpdvrndsmtp01.broadcom.com ([192.19.229.170]:43452 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754794AbdCINFr (ORCPT
        <rfc822;backports@vger.kernel.org>); Thu, 9 Mar 2017 08:05:47 -0500
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: backports@vger.kernel.org,
        Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [PATCH 4/4] backports: add dummy include/linux/sched/signal.h
Date: Thu,  9 Mar 2017 12:57:33 +0000
Message-Id: <1489064253-3652-5-git-send-email-arend.vanspriel@broadcom.com> (sfid-20170309_140612_271100_D793219E)
In-Reply-To: <1489064253-3652-1-git-send-email-arend.vanspriel@broadcom.com>
References: <1489064253-3652-1-git-send-email-arend.vanspriel@broadcom.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Simply including linux/sched.h for older kernels not carrying this
file. This new include file was introduced by commit 3f07c0144132
("sched/headers: Prepare for new header dependencies before moving
code to <linux/sched/signal.h>").

Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
 backport/backport-include/linux/sched/signal.h | 10 ++++++++++
 1 file changed, 10 insertions(+)
 create mode 100644 backport/backport-include/linux/sched/signal.h

diff --git a/backport/backport-include/linux/sched/signal.h b/backport/backport-include/linux/sched/signal.h
new file mode 100644
index 0000000..ec89925
--- /dev/null
+++ b/backport/backport-include/linux/sched/signal.h
@@ -0,0 +1,10 @@
+#ifndef _BACKPORT_LINUX_SCHED_SIGNAL_H
+#define _BACKPORT_LINUX_SCHED_SIGNAL_H
+
+#if LINUX_VERSION_IS_LESS(4, 11, 0)
+#include <linux/sched.h>
+#else
+#include_next <linux/sched/signal.h>
+#endif
+
+#endif /* _BACKPORT_LINUX_SCHED_SIGNAL_H */
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
