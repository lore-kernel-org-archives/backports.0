Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:52135 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932590AbaFPWcW (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 16 Jun 2014 18:32:22 -0400
Received: from localhost (localhost [127.0.0.1])
	by hauke-m.de (Postfix) with ESMTP id 16C037E32
	for <backports@vger.kernel.org>; Tue, 17 Jun 2014 00:32:21 +0200 (CEST)
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 3/5] backports: do not include net_ieee802154_lowpan in kernel >= 3.16
Date: Tue, 17 Jun 2014 00:31:57 +0200
Message-Id: <1402957919-31374-4-git-send-email-hauke@hauke-m.de> (sfid-20140617_003234_099939_0FA9DED5)
In-Reply-To: <1402957919-31374-1-git-send-email-hauke@hauke-m.de>
References: <1402957919-31374-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

In kernel >= 3.16 this backport is not needed at all. When
CPTCFG_IEEE802154_6LOWPAN is not set it should not get build, we do not
have to check if we are kernel > 3.5, because in an other case
ieee802.15.4 will not get build. Kernel version 3.15 needs a different
backport than the older versions.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/net/net_namespace.h | 6 ++----
 backport/compat/backport-3.15.c               | 2 +-
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/backport/backport-include/net/net_namespace.h b/backport/backport-include/net/net_namespace.h
index 17c9d55..e83b103 100644
--- a/backport/backport-include/net/net_namespace.h
+++ b/backport/backport-include/net/net_namespace.h
@@ -7,16 +7,14 @@
 #include <linux/version.h>
 #include <net/netns/ieee802154_6lowpan.h>
 
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,15,0))
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0))
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,15,0)
 /*
  * we provide backport for 6lowpan as per the dependencies file
  * down to 3.5 only.
  */
 extern struct netns_ieee802154_lowpan ieee802154_lowpan;
 struct netns_ieee802154_lowpan *net_ieee802154_lowpan(struct net *net);
-#endif
-#else /* < 3.5..3.14 */
+#elif LINUX_VERSION_CODE < KERNEL_VERSION(3,16,0)
 /* This can be removed once and if this gets upstream */
 static inline struct netns_ieee802154_lowpan *
 net_ieee802154_lowpan(struct net *net)
diff --git a/backport/compat/backport-3.15.c b/backport/compat/backport-3.15.c
index 5732fa9..75216eb 100644
--- a/backport/compat/backport-3.15.c
+++ b/backport/compat/backport-3.15.c
@@ -16,7 +16,7 @@
 #include <net/net_namespace.h>
 
 #if IS_ENABLED(CPTCFG_IEEE802154_6LOWPAN)
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0))
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,15,0)
 /* the above kernel dependency is set to match the dependencies file */
 struct netns_ieee802154_lowpan ieee802154_lowpan;
 EXPORT_SYMBOL_GPL(ieee802154_lowpan);
-- 
1.9.1

