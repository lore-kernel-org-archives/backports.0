Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:37202 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751001Ab3DKXnF (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 11 Apr 2013 19:43:05 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [RFC/WIP 11/24] backports: move netdev_features_t
Date: Fri, 12 Apr 2013 01:42:38 +0200
Message-Id: <1365723771-10660-12-git-send-email-johannes@sipsolutions.net> (sfid-20130412_014345_487134_8A2C65E5)
In-Reply-To: <1365723771-10660-1-git-send-email-johannes@sipsolutions.net>
References: <1365723771-10660-1-git-send-email-johannes@sipsolutions.net>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/compat-3.3.h      |  2 --
 backport/backport-include/linux/netdev_features.h | 15 +++++++++++++++
 backport/backport-include/linux/netdevice.h       |  6 ++++++
 3 files changed, 21 insertions(+), 2 deletions(-)
 create mode 100644 backport/backport-include/linux/netdev_features.h
 create mode 100644 backport/backport-include/linux/netdevice.h

diff --git a/backport/backport-include/linux/compat-3.3.h b/backport/backport-include/linux/compat-3.3.h
index 72686da..7b2ec47 100644
--- a/backport/backport-include/linux/compat-3.3.h
+++ b/backport/backport-include/linux/compat-3.3.h
@@ -307,8 +307,6 @@ static inline void qdisc_cb_private_validate(const struct sk_buff *skb, int sz)
 
 #define NL80211_FEATURE_SK_TX_STATUS 0
 
-typedef u32 netdev_features_t;
-
 /* source include/linux/device.h */
 /**
  * module_driver() - Helper macro for drivers that don't do anything
diff --git a/backport/backport-include/linux/netdev_features.h b/backport/backport-include/linux/netdev_features.h
new file mode 100644
index 0000000..a7394f4
--- /dev/null
+++ b/backport/backport-include/linux/netdev_features.h
@@ -0,0 +1,15 @@
+#ifndef __BACKPORT_NETDEV_FEATURES_H
+#define __BACKPORT_NETDEV_FEATURES_H
+
+#include <linux/version.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,3,0)
+#include <linux/netdevice.h>
+#include <linux/types.h>
+
+typedef u32 netdev_features_t;
+#else
+#include_next <linux/netdev_features.h>
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,3,0) */
+
+#endif /* __BACKPORT_NETDEV_FEATURES_H */
diff --git a/backport/backport-include/linux/netdevice.h b/backport/backport-include/linux/netdevice.h
new file mode 100644
index 0000000..4971239
--- /dev/null
+++ b/backport/backport-include/linux/netdevice.h
@@ -0,0 +1,6 @@
+#ifndef __BACKPORT_NETDEVICE_H
+#define __BACKPORT_NETDEVICE_H
+#include_next <linux/netdevice.h>
+#include <linux/netdev_features.h>
+
+#endif /* __BACKPORT_NETDEVICE_H */
-- 
1.8.0

