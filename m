Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.63.242]:48810 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751086AbdJKObu (ORCPT
        <rfc822;backports@vger.kernel.org>); Wed, 11 Oct 2017 10:31:50 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 2/5] backports: backport from_timer() and timer_setup()
Date: Wed, 11 Oct 2017 16:31:44 +0200
Message-Id: <20171011143147.3337-2-johannes@sipsolutions.net> (sfid-20171011_163300_411719_1DA39D88)
In-Reply-To: <20171011143147.3337-1-johannes@sipsolutions.net>
References: <20171011143147.3337-1-johannes@sipsolutions.net>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

These are needed for Kees's new timer API, and luckily
he already provided them for conversion purposes :-)

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/timer.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/backport/backport-include/linux/timer.h b/backport/backport-include/linux/timer.h
index df560a26f77f..85f74d40deda 100644
--- a/backport/backport-include/linux/timer.h
+++ b/backport/backport-include/linux/timer.h
@@ -32,4 +32,20 @@ static inline void setup_deferrable_timer_key(struct timer_list *timer,
 
 #endif
 
+#ifndef from_timer
+#define TIMER_DATA_TYPE          unsigned long
+#define TIMER_FUNC_TYPE          void (*)(TIMER_DATA_TYPE)
+
+static inline void timer_setup(struct timer_list *timer,
+			       void (*callback) (struct timer_list *),
+			       unsigned int flags)
+{
+	__setup_timer(timer, (TIMER_FUNC_TYPE) callback,
+		      (TIMER_DATA_TYPE) timer, flags);
+}
+
+#define from_timer(var, callback_timer, timer_fieldname) \
+	container_of(callback_timer, typeof(*var), timer_fieldname)
+#endif
+
 #endif /* _BACKPORT_TIMER_H */
-- 
2.14.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
