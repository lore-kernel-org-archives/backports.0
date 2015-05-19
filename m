Return-path: <backports-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:15899 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751532AbbESNmY (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 19 May 2015 09:42:24 -0400
From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
To: backports@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH] backport: allow compilation with Ubuntu's 3.13
Date: Tue, 19 May 2015 16:42:16 +0300
Message-Id: <1432042936-23733-1-git-send-email-emmanuel.grumbach@intel.com> (sfid-20150519_154230_230935_983C6CAB)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Canonical backported:

Author: Or Gerlitz <ogerlitz@mellanox.com>
Date:   Mon Jan 20 13:59:19 2014 +0200

    net: Add GRO support for UDP encapsulating protocols

This is commit 2da204a8f67fbe25816cbce8cc8551f03d5b951a in their
tree.
Cope with that.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
---
Touch compiled only. And I don't really know how the UTS thing goes :)
---
 backport/backport-include/linux/netdevice.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/backport/backport-include/linux/netdevice.h b/backport/backport-include/linux/netdevice.h
index bb3fefb..61ac95c 100644
--- a/backport/backport-include/linux/netdevice.h
+++ b/backport/backport-include/linux/netdevice.h
@@ -81,6 +81,7 @@ static inline void dev_consume_skb_any(struct sk_buff *skb)
 	dev_kfree_skb_any(skb);
 }
 
+#if (LINUX_VERSION_CODE == KERNEL_VERSION(3,13,11) && UTS_UBUNTU_RELEASE_ABI < 24)
 struct pcpu_sw_netstats {
 	u64     rx_packets;
 	u64     rx_bytes;
@@ -88,6 +89,7 @@ struct pcpu_sw_netstats {
 	u64     tx_bytes;
 	struct u64_stats_sync   syncp;
 };
+#endif
 
 #define netdev_tstats(dev)	((struct pcpu_sw_netstats *)dev->ml_priv)
 #define netdev_assign_tstats(dev, e)	dev->ml_priv = (e);
-- 
2.1.4

