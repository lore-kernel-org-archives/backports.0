Return-path: <backports-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:46482 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754465Ab3EKAeB (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 10 May 2013 20:34:01 -0400
Received: by mail-ie0-f174.google.com with SMTP id 10so8894029ied.5
        for <backports@vger.kernel.org>; Fri, 10 May 2013 17:34:01 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [RFC 3/5] backports: backport vlan ethernet changes
Date: Fri, 10 May 2013 17:33:39 -0700
Message-Id: <1368232421-24123-4-git-send-email-mcgrof@do-not-panic.com> (sfid-20130511_023404_065327_9B3FE719)
In-Reply-To: <1368232421-24123-1-git-send-email-mcgrof@do-not-panic.com>
References: <1368232421-24123-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

This backports 9356b8fc d314774c and f646968f8f
all added in next-20130423. Soome driver changes are
still required and will be addressed separately.

commit 9356b8fc07dc126cd91d2b12f314d760ab48996e
Author: Eric Dumazet <dada1@cosmosbay.com>
Date:   Tue Sep 27 15:23:16 2005 -0700

    [NET]: Reorder some hot fields of struct net_device

    Place them on separate cache lines in SMP to lower memory bouncing
    between multiple CPU accessing the device.

         - One part is mostly used on receive path (including
           eth_type_trans()) (poll_list, poll, quota, weight, last_rx,
           dev_addr, broadcast)

         - One part is mostly used on queue transmit path (qdisc)
          (queue_lock, qdisc, qdisc_sleeping, qdisc_list, tx_queue_len)

         - One part is mostly used on xmit path (device)
          (xmit_lock, xmit_lock_owner, priv, hard_start_xmit, trans_start)

    'features' is placed outside of these hot points, in a location that
    may be shared by all cpus (because mostly read)

    name_hlist is moved close to name[IFNAMSIZ] to speedup __dev_get_by_name()

    Signed-off-by: Eric Dumazet <dada1@cosmosbay.com>
    Signed-off-by: David S. Miller <davem@davemloft.net>

commit d314774cf2cd5dfeb39a00d37deee65d4c627927
Author: Stephen Hemminger <shemminger@vyatta.com>
Date:   Wed Nov 19 21:32:24 2008 -0800

    netdev: network device operations infrastructure

    This patch changes the network device internal API to move adminstrative
    operations out of the network device structure and into a separate structure.

    This patch involves some hackery to maintain compatablity between the
    new and old model, so all 300+ drivers don't have to be changed at once.
    For drivers that aren't converted yet, the netdevice_ops virt function list
    still resides in the net_device structure. For old protocols, the new
    net_device_ops are copied out to the old net_device pointers.

    After the transistion is completed the nag message can be changed to
    an WARN_ON, and the compatiablity code can be made configurable.

    Some function pointers aren't moved:
    * destructor can't be in net_device_ops because
      it may need to be referenced after the module is unloaded.
    * neighbor setup is manipulated in a couple of places that need special
      consideration
    * hard_start_xmit is in the fast path for transmit.

    Signed-off-by: Stephen Hemminger <shemminger@vyatta.com>
    Signed-off-by: David S. Miller <davem@davemloft.net>

commit f646968f8f7c624587de729115d802372b9063dd
Author: Patrick McHardy <kaber@trash.net>
Date:   Fri Apr 19 02:04:27 2013 +0000

    net: vlan: rename NETIF_F_HW_VLAN_* feature flags to NETIF_F_HW_VLAN_CTAG_*

    Rename the hardware VLAN acceleration features to include "CTAG" to indicate
    that they only support CTAGs. Follow up patches will introduce 802.1ad
    server provider tagging (STAGs) and require the distinction for hardware not
    supporting acclerating both.

    Signed-off-by: Patrick McHardy <kaber@trash.net>
    Signed-off-by: David S. Miller <davem@davemloft.net>

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 backport/backport-include/linux/if_vlan.h         |   18 ++++++++++++++++
 backport/backport-include/linux/netdev_features.h |   23 +++++++++++++++++++++
 2 files changed, 41 insertions(+)
 create mode 100644 backport/backport-include/linux/if_vlan.h

diff --git a/backport/backport-include/linux/if_vlan.h b/backport/backport-include/linux/if_vlan.h
new file mode 100644
index 0000000..a5839e8
--- /dev/null
+++ b/backport/backport-include/linux/if_vlan.h
@@ -0,0 +1,18 @@
+#ifndef __BACKPORT_LINUX_IF_VLAN_H_
+#define __BACKPORT_LINUX_IF_VLAN_H_
+#include_next <linux/if_vlan.h>
+
+#define vlan_insert_tag(__skb, __vlan_proto, __vlan_tci)	vlan_insert_tag(__skb, __vlan_tci)
+#define __vlan_put_tag(__skb, __vlan_proto, __vlan_tci)		__vlan_put_tag(__skb, __vlan_tci)
+#define vlan_put_tag(__skb, __vlan_proto, __vlan_tci)		vlan_put_tag(__skb, __vlan_tci)
+#define __vlan_hwaccel_put_tag(__skb, __vlan_proto, __vlan_tag)	__vlan_hwaccel_put_tag(__skb, __vlan_tag)
+
+static inline bool vlan_hw_offload_capable(netdev_features_t features,
+					   __be16 proto)
+{
+	if (proto == htons(ETH_P_8021Q) && features & NETIF_F_HW_VLAN_CTAG_TX)
+		return true;
+	return false;
+}
+
+#endif /* __BACKPORT_LINUX_IF_VLAN_H_ */
diff --git a/backport/backport-include/linux/netdev_features.h b/backport/backport-include/linux/netdev_features.h
index bac3a3e..3826e55 100644
--- a/backport/backport-include/linux/netdev_features.h
+++ b/backport/backport-include/linux/netdev_features.h
@@ -7,9 +7,32 @@
 #include <linux/netdevice.h>
 #include <linux/types.h>
 
+/* added via 9356b8fc */
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,14)
+#define NETIF_F_HW_VLAN_CTAG_RX			NETIF_F_HW_VLAN_RX
+#define NETIF_F_HW_VLAN_CTAG_TX			NETIF_F_HW_VLAN_TX
+#endif
+
+/* added via d314774c */
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,29)
+#define NETIF_F_HW_VLAN_CTAG_FILTER		NETIF_F_HW_VLAN_FILTER
+#endif
+
 typedef u32 netdev_features_t;
 #else
 #include_next <linux/netdev_features.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,10,0)
+/* See commit f646968f8f on next-20130423 */
+#define NETIF_F_HW_VLAN_CTAG_TX_BIT		NETIF_F_HW_VLAN_TX_BIT
+#define NETIF_F_HW_VLAN_CTAG_RX_BIT		NETIF_F_HW_VLAN_RX_BIT
+#define NETIF_F_HW_VLAN_CTAG_FILTER_BIT		NETIF_F_HW_VLAN_FILTER_BIT
+
+#define NETIF_F_HW_VLAN_CTAG_FILTER		NETIF_F_HW_VLAN_FILTER
+#define NETIF_F_HW_VLAN_CTAG_RX			NETIF_F_HW_VLAN_RX
+#define NETIF_F_HW_VLAN_CTAG_TX			NETIF_F_HW_VLAN_TX
+#endif
+
 #endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,3,0) */
 
 #if !defined(NETIF_F_RXCSUM)
-- 
1.7.10.4

