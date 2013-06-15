Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:39368 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751048Ab3FOPig (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 15 Jun 2013 11:38:36 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 5/8] backports: use the given parameter in NETLINK_CB_PORTID()
Date: Sat, 15 Jun 2013 17:37:55 +0200
Message-Id: <1371310678-26491-6-git-send-email-hauke@hauke-m.de> (sfid-20130615_173837_594274_304C3794)
In-Reply-To: <1371310678-26491-1-git-send-email-hauke@hauke-m.de>
References: <1371310678-26491-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

NETLINK_CB_PORTID() ignored the given parameter, this was wrong.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/netlink.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/backport/backport-include/linux/netlink.h b/backport/backport-include/linux/netlink.h
index 2058a90..521b72e 100644
--- a/backport/backport-include/linux/netlink.h
+++ b/backport/backport-include/linux/netlink.h
@@ -6,10 +6,10 @@
 /* this is for patches we apply */
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3,7,0)
 #define netlink_notify_portid(__notify) (__notify->pid)
-#define NETLINK_CB_PORTID(__skb) NETLINK_CB(cb->skb).pid
+#define NETLINK_CB_PORTID(__skb) NETLINK_CB(__skb).pid
 #else
 #define netlink_notify_portid(__notify) (__notify->portid)
-#define NETLINK_CB_PORTID(__skb) NETLINK_CB(cb->skb).portid
+#define NETLINK_CB_PORTID(__skb) NETLINK_CB(__skb).portid
 #endif
 
 #endif /* __BACKPORT_LINUX_NETLINK_H */
-- 
1.7.10.4

