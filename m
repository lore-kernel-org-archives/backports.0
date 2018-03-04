Return-path: <backports-owner@vger.kernel.org>
Received: from mx2.mailbox.org ([80.241.60.215]:52086 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932487AbeCDW5q (ORCPT <rfc822;backports@vger.kernel.org>);
        Sun, 4 Mar 2018 17:57:46 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: johannes@sipsolutions.net, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 02/14] compat: timer.h: Remove last parameters from DEFINE_TIMER
Date: Sun,  4 Mar 2018 23:57:05 +0100
Message-Id: <20180304225717.20890-3-hauke@hauke-m.de> (sfid-20180304_235754_206853_2C3AD70F)
In-Reply-To: <20180304225717.20890-1-hauke@hauke-m.de>
References: <20180304225717.20890-1-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

DEFINE_TIMER only has 2 parameters since kernel commit 1d27e3e2252ba
("timer: Remove expires and data arguments from DEFINE_TIMER") which was
added with kernel 4.15. Add a version which translates between the new
and the old API.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/timer.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/backport/backport-include/linux/timer.h b/backport/backport-include/linux/timer.h
index 9824ea6b..69590bb7 100644
--- a/backport/backport-include/linux/timer.h
+++ b/backport/backport-include/linux/timer.h
@@ -60,4 +60,11 @@ static inline void timer_setup(struct timer_list *timer,
 	container_of(callback_timer, typeof(*var), timer_fieldname)
 #endif
 
+#if LINUX_VERSION_IS_LESS(4,15,0)
+#undef DEFINE_TIMER
+#define DEFINE_TIMER(_name, _function)				\
+	struct timer_list _name =				\
+		__TIMER_INITIALIZER(_function, 0, 0, 0)
+#endif
+
 #endif /* _BACKPORT_TIMER_H */
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
