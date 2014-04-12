Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:63035 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755055AbaDLBev (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 11 Apr 2014 21:34:51 -0400
Received: by mail-pa0-f44.google.com with SMTP id bj1so6071147pad.31
        for <backports@vger.kernel.org>; Fri, 11 Apr 2014 18:34:50 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 02/10] backports: add napi_gro_flush()
Date: Fri, 11 Apr 2014 18:34:27 -0700
Message-Id: <1397266475-14442-3-git-send-email-mcgrof@do-not-panic.com> (sfid-20140412_033453_579113_BC859B7C)
In-Reply-To: <1397266475-14442-1-git-send-email-mcgrof@do-not-panic.com>
References: <1397266475-14442-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

napi_gro_flush() got a second argument in kernel 3.7, but it
can be ignored for prior kernel versions.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 backport/backport-include/linux/netdevice.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/backport/backport-include/linux/netdevice.h b/backport/backport-include/linux/netdevice.h
index f77e3eb..a39bff7 100644
--- a/backport/backport-include/linux/netdevice.h
+++ b/backport/backport-include/linux/netdevice.h
@@ -521,6 +521,7 @@ struct net *dev_net(const struct net_device *dev)
 #define netdev_notify_peers(dev)
 #elif LINUX_VERSION_CODE < KERNEL_VERSION(3,7,0)
 #define netdev_notify_peers(dev) netif_notify_peers(dev)
+#define napi_gro_flush(napi, old) napi_gro_flush(napi)
 #endif
 
 #endif /* __BACKPORT_NETDEVICE_H */
-- 
1.9.1

