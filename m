Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:56007 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751578AbaEaRQs (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 31 May 2014 13:16:48 -0400
Received: from localhost (localhost [127.0.0.1])
	by hauke-m.de (Postfix) with ESMTP id ADB067E5A
	for <backports@vger.kernel.org>; Sat, 31 May 2014 19:16:47 +0200 (CEST)
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 07/13] backports: move net_device_priv_flags
Date: Sat, 31 May 2014 19:16:04 +0200
Message-Id: <1401556570-3363-8-git-send-email-hauke@hauke-m.de> (sfid-20140531_191650_043955_EA45F4B3)
In-Reply-To: <1401556570-3363-1-git-send-email-hauke@hauke-m.de>
References: <1401556570-3363-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

These flags are now defined in linux/netdevice.h and not in linux/if.h
any more. This patch also removed some defined in all kernel versions
since 3.0.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/if.h        | 27 ---------------------------
 backport/backport-include/linux/netdevice.h | 12 ++++++++++++
 2 files changed, 12 insertions(+), 27 deletions(-)
 delete mode 100644 backport/backport-include/linux/if.h

diff --git a/backport/backport-include/linux/if.h b/backport/backport-include/linux/if.h
deleted file mode 100644
index 1045466..0000000
--- a/backport/backport-include/linux/if.h
+++ /dev/null
@@ -1,27 +0,0 @@
-#ifndef _BACKPORT_LINUX_IF_H
-#define _BACKPORT_LINUX_IF_H
-#include_next <linux/if.h>
-#include <linux/version.h>
-
-/* mask IFF_DONT_BRIDGE as RHEL6 backports this */
-#if !defined(IFF_DONT_BRIDGE)
-#define IFF_DONT_BRIDGE 0x800		/* disallow bridging this ether dev */
-#endif
-
-#ifndef  IFF_TX_SKB_SHARING
-#define IFF_TX_SKB_SHARING	0x10000
-#endif
-
-#ifndef IFF_LIVE_ADDR_CHANGE
-#define IFF_LIVE_ADDR_CHANGE 0x100000
-#endif
-
-#ifndef IFF_SUPP_NOFCS
-#define IFF_SUPP_NOFCS	0x80000		/* device supports sending custom FCS */
-#endif
-
-#ifndef IFF_UNICAST_FLT
-#define IFF_UNICAST_FLT	0x20000		/* Supports unicast filtering	*/
-#endif
-
-#endif	/* _BACKPORT_LINUX_IF_H */
diff --git a/backport/backport-include/linux/netdevice.h b/backport/backport-include/linux/netdevice.h
index 2abb47d..6979758 100644
--- a/backport/backport-include/linux/netdevice.h
+++ b/backport/backport-include/linux/netdevice.h
@@ -145,4 +145,16 @@ static inline void netdev_reset_queue(struct net_device *dev_queue)
 #define napi_gro_flush(napi, old) napi_gro_flush(napi)
 #endif
 
+#ifndef IFF_LIVE_ADDR_CHANGE
+#define IFF_LIVE_ADDR_CHANGE 0x100000
+#endif
+
+#ifndef IFF_SUPP_NOFCS
+#define IFF_SUPP_NOFCS	0x80000		/* device supports sending custom FCS */
+#endif
+
+#ifndef IFF_UNICAST_FLT
+#define IFF_UNICAST_FLT	0x20000		/* Supports unicast filtering	*/
+#endif
+
 #endif /* __BACKPORT_NETDEVICE_H */
-- 
1.9.1

