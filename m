Return-path: <backports-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:36422 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751042AbbHYTgp (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 25 Aug 2015 15:36:45 -0400
From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
To: backports@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH] backports: backport IFF_NO_QUEUE net_device flag
Date: Tue, 25 Aug 2015 22:36:39 +0300
Message-Id: <1440531399-29379-1-git-send-email-emmanuel.grumbach@intel.com> (sfid-20150825_213646_779513_F10D303E)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

commit fa8187c96471c49419c25d4ec3299d17d3f274b2
Author: Phil Sutter <phil@nwl.cc>
Date:   Thu Aug 13 19:01:06 2015 +0200

    net: declare new net_device priv_flag IFF_NO_QUEUE

    This private net_device flag can be set by drivers to inform that a
    device runs fine without a qdisc attached. This was formerly done by
    setting tx_queue_len to zero.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
---
 backport/backport-include/linux/netdevice.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/backport/backport-include/linux/netdevice.h b/backport/backport-include/linux/netdevice.h
index 95189be..94d8613 100644
--- a/backport/backport-include/linux/netdevice.h
+++ b/backport/backport-include/linux/netdevice.h
@@ -292,4 +292,9 @@ netdev_features_t passthru_features_check(struct sk_buff *skb,
 })
 #endif /* netdev_alloc_pcpu_stats */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4,2,0)
+#ifndef IFF_NO_QUEUE
+#define IFF_NO_QUEUE 1<<26
+#endif
+
 #endif /* __BACKPORT_NETDEVICE_H */
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe backports" in
