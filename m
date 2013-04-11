Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:37182 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750803Ab3DKXm7 (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 11 Apr 2013 19:42:59 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [RFC/WIP 03/24] backports: move IFF_DONT_BRIDGE
Date: Fri, 12 Apr 2013 01:42:30 +0200
Message-Id: <1365723771-10660-4-git-send-email-johannes@sipsolutions.net> (sfid-20130412_014302_453860_7E42B2B5)
In-Reply-To: <1365723771-10660-1-git-send-email-johannes@sipsolutions.net>
References: <1365723771-10660-1-git-send-email-johannes@sipsolutions.net>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/compat-2.6.33.h | 6 ------
 backport/backport-include/linux/if.h            | 5 +++++
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/backport/backport-include/linux/compat-2.6.33.h b/backport/backport-include/linux/compat-2.6.33.h
index b03fe40..485072a 100644
--- a/backport/backport-include/linux/compat-2.6.33.h
+++ b/backport/backport-include/linux/compat-2.6.33.h
@@ -52,12 +52,6 @@ void release_firmware(const struct firmware *fw);
 #define KEY_RFKILL		247	/* Key that controls all radios */
 #endif
 
-/* mask IFF_DONT_BRIDGE as RHEL6 backports this */
-#if !defined(IFF_DONT_BRIDGE)
-#define IFF_DONT_BRIDGE 0x800		/* disallow bridging this ether dev */
-/* source: include/linux/if.h */
-#endif
-
 /* mask NETDEV_POST_INIT as RHEL6 backports this */
 /* this will never happen on older kernels */
 #if !defined(NETDEV_POST_INIT)
diff --git a/backport/backport-include/linux/if.h b/backport/backport-include/linux/if.h
index 63fef8a..7147711 100644
--- a/backport/backport-include/linux/if.h
+++ b/backport/backport-include/linux/if.h
@@ -5,6 +5,11 @@
 
 #include <linux/version.h>
 
+/* mask IFF_DONT_BRIDGE as RHEL6 backports this */
+#if !defined(IFF_DONT_BRIDGE)
+#define IFF_DONT_BRIDGE 0x800		/* disallow bridging this ether dev */
+#endif
+
 #if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,36))
 
 #define br_port_exists(dev)	(dev->br_port)
-- 
1.8.0

