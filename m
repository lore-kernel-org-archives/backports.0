Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:40637 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932139AbaEEMqP (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 5 May 2014 08:46:15 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] backports: provide net_ieee802154_lowpan only when needed
Date: Mon,  5 May 2014 14:46:11 +0200
Message-Id: <1399293971-8037-1-git-send-email-johannes@sipsolutions.net> (sfid-20140505_144619_709539_92A43EE0)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

If 802.15.4 isn't configured, there's no need to provide the
network namespace support for it, so don't.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/net/net_namespace.h | 5 ++++-
 backport/compat/backport-3.15.c               | 2 ++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/backport/backport-include/net/net_namespace.h b/backport/backport-include/net/net_namespace.h
index 3ea5d4662c27..ad0f03096361 100644
--- a/backport/backport-include/net/net_namespace.h
+++ b/backport/backport-include/net/net_namespace.h
@@ -1,9 +1,11 @@
 #ifndef _COMPAT_NET_NET_NAMESPACE_H
 #define _COMPAT_NET_NET_NAMESPACE_H 1
 
+#include_next <net/net_namespace.h>
+
+#ifdef CPTCFG_IEEE802154_6LOWPAN
 #include <linux/version.h>
 #include <net/netns/ieee802154_6lowpan.h>
-#include_next <net/net_namespace.h>
 
 #if (LINUX_VERSION_CODE < KERNEL_VERSION(3,15,0))
 #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0))
@@ -22,5 +24,6 @@ net_ieee802154_lowpan(struct net *net)
 	return &net->ieee802154_lowpan;
 }
 #endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,15,0) */
+#endif /* CPTCFG_IEEE802154_6LOWPAN */
 
 #endif	/* _COMPAT_NET_NET_NAMESPACE_H */
diff --git a/backport/compat/backport-3.15.c b/backport/compat/backport-3.15.c
index 545e0c297ea6..767722e8ac6d 100644
--- a/backport/compat/backport-3.15.c
+++ b/backport/compat/backport-3.15.c
@@ -14,6 +14,7 @@
 #include <linux/of.h>
 #include <net/net_namespace.h>
 
+#ifdef CPTCFG_IEEE802154_6LOWPAN
 #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0))
 /* the above kernel dependency is set to match the dependencies file */
 struct netns_ieee802154_lowpan ieee802154_lowpan;
@@ -25,6 +26,7 @@ struct netns_ieee802154_lowpan *net_ieee802154_lowpan(struct net *net)
 }
 EXPORT_SYMBOL_GPL(net_ieee802154_lowpan);
 #endif
+#endif /* CPTCFG_IEEE802154_6LOWPAN */
 
 /**
  * devm_kstrdup - Allocate resource managed space and
-- 
2.0.0.rc0

