Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:59692 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752556Ab3EaTPg (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 31 May 2013 15:15:36 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 2/3] backports: add rcu_dereference_rtnl
Date: Fri, 31 May 2013 21:15:23 +0200
Message-Id: <1370027724-22627-2-git-send-email-hauke@hauke-m.de> (sfid-20130531_211538_022786_EE87592C)
In-Reply-To: <1370027724-22627-1-git-send-email-hauke@hauke-m.de>
References: <1370027724-22627-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Add backport for rcu_dereference_rtnl()

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/rtnetlink.h |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/backport/backport-include/linux/rtnetlink.h b/backport/backport-include/linux/rtnetlink.h
index 56ba9f6..81540a3 100644
--- a/backport/backport-include/linux/rtnetlink.h
+++ b/backport/backport-include/linux/rtnetlink.h
@@ -7,6 +7,12 @@
         rcu_dereference_protected(p, lockdep_rtnl_is_held())
 #endif
 
+#ifndef rcu_dereference_rtnl
+#define rcu_dereference_rtnl(p)					\
+	rcu_dereference_check(p, rcu_read_lock_held() ||	\
+				 lockdep_rtnl_is_held())
+#endif
+
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,34)
 #ifdef CONFIG_PROVE_LOCKING
 /*
-- 
1.7.10.4

