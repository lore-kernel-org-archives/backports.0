Return-path: <backports-owner@vger.kernel.org>
Received: from mx2.mailbox.org ([80.241.60.215]:52102 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932492AbeCDW5r (ORCPT <rfc822;backports@vger.kernel.org>);
        Sun, 4 Mar 2018 17:57:47 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: johannes@sipsolutions.net, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 04/14] backport: poll.h: add include linux/eventpoll.h
Date: Sun,  4 Mar 2018 23:57:07 +0100
Message-Id: <20180304225717.20890-5-hauke@hauke-m.de> (sfid-20180304_235800_233017_FA521C7D)
In-Reply-To: <20180304225717.20890-1-hauke@hauke-m.de>
References: <20180304225717.20890-1-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The POLL constants are getting replaced with the EPOLL constants. In
this process commit e78cd95bebd9 ("preparation to switching ->poll() to
returning EPOLL...") added an additional include to linux/poll.h. Some
drivers make use of this indirect include now and fail to compile
without it.

Older kernel versions do not define all the EPON constants so add them
if they are not available.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/eventpoll.h | 49 +++++++++++++++++++++++++++++
 backport/backport-include/linux/poll.h      |  1 +
 2 files changed, 50 insertions(+)
 create mode 100644 backport/backport-include/linux/eventpoll.h

diff --git a/backport/backport-include/linux/eventpoll.h b/backport/backport-include/linux/eventpoll.h
new file mode 100644
index 00000000..7cc87aa0
--- /dev/null
+++ b/backport/backport-include/linux/eventpoll.h
@@ -0,0 +1,49 @@
+#ifndef __BACKPORT_LINUX_EVENTPOLL_H
+#define __BACKPORT_LINUX_EVENTPOLL_H
+#include_next <linux/eventpoll.h>
+
+#ifndef EPOLLIN
+#define EPOLLIN		0x00000001
+#endif
+
+#ifndef EPOLLPRI
+#define EPOLLPRI	0x00000002
+#endif
+
+#ifndef EPOLLOUT
+#define EPOLLOUT	0x00000004
+#endif
+
+#ifndef EPOLLERR
+#define EPOLLERR	0x00000008
+#endif
+
+#ifndef EPOLLHUP
+#define EPOLLHUP	0x00000010
+#endif
+
+#ifndef EPOLLRDNORM
+#define EPOLLRDNORM	0x00000040
+#endif
+
+#ifndef EPOLLRDBAND
+#define EPOLLRDBAND	0x00000080
+#endif
+
+#ifndef EPOLLWRNORM
+#define EPOLLWRNORM	0x00000100
+#endif
+
+#ifndef EPOLLWRBAND
+#define EPOLLWRBAND	0x00000200
+#endif
+
+#ifndef EPOLLMSG
+#define EPOLLMSG	0x00000400
+#endif
+
+#ifndef EPOLLRDHUP
+#define EPOLLRDHUP	0x00002000
+#endif
+
+#endif /* __BACKPORT_LINUX_EVENTPOLL_H */
diff --git a/backport/backport-include/linux/poll.h b/backport/backport-include/linux/poll.h
index 3eecd81f..aea64048 100644
--- a/backport/backport-include/linux/poll.h
+++ b/backport/backport-include/linux/poll.h
@@ -2,6 +2,7 @@
 #define __BACKPORT_LINUX_POLL_H
 #include_next <linux/poll.h>
 #include <linux/version.h>
+#include <linux/eventpoll.h>
 
 #if  LINUX_VERSION_IS_LESS(3,4,0)
 #define poll_does_not_wait LINUX_BACKPORT(poll_does_not_wait)
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
