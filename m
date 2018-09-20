Return-path: <backports-owner@vger.kernel.org>
Received: from paleale.coelho.fi ([176.9.41.70]:50954 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727986AbeITRLw (ORCPT
        <rfc822;backports@vger.kernel.org>); Thu, 20 Sep 2018 13:11:52 -0400
From: Luca Coelho <luca@coelho.fi>
To: backports@vger.kernel.org
Cc: Shahar S Matityahu <shahar.s.matityahu@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>
Date: Thu, 20 Sep 2018 14:28:30 +0300
Message-Id: <20180920112842.27198-3-luca@coelho.fi> (sfid-20180920_132854_134368_F0D5DB43)
In-Reply-To: <20180920112842.27198-1-luca@coelho.fi>
References: <20180920112842.27198-1-luca@coelho.fi>
Subject: [PATCH 02/14] backports: add wait_event_killable_timeout backport support
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Shahar S Matityahu <shahar.s.matityahu@intel.com>

Allow using wait_event_killable_timeout function in kernel
older then 4.13

Signed-off-by: Shahar S Matityahu <shahar.s.matityahu@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 backport/backport-include/linux/wait.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/backport/backport-include/linux/wait.h b/backport/backport-include/linux/wait.h
index c4b1114e05ed..15a674cfe019 100644
--- a/backport/backport-include/linux/wait.h
+++ b/backport/backport-include/linux/wait.h
@@ -78,6 +78,21 @@ wait_on_bit_timeout(void *word, int bit, unsigned mode, unsigned long timeout)
 
 #if LINUX_VERSION_IS_LESS(4,13,0)
 #define wait_queue_entry_t wait_queue_t
+
+#define wait_event_killable_timeout(wq_head, condition, timeout)	\
+({									\
+	long __ret = timeout;						\
+	might_sleep();							\
+	if (!___wait_cond_timeout(condition))				\
+		__ret = __wait_event_killable_timeout(wq_head,		\
+						condition, timeout);	\
+	__ret;								\
+})
+
+#define __wait_event_killable_timeout(wq_head, condition, timeout)	\
+	___wait_event(wq_head, ___wait_cond_timeout(condition),		\
+		      TASK_KILLABLE, 0, timeout,			\
+		      __ret = schedule_timeout(__ret))
 #endif
 
 #endif /* __BACKPORT_LINUX_WAIT_H */
-- 
2.18.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
