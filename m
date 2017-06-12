Return-path: <backports-owner@vger.kernel.org>
Received: from lpdvrndsmtp01.broadcom.com ([192.19.229.170]:59983 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750730AbdFLJGf (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 12 Jun 2017 05:06:35 -0400
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: backports@vger.kernel.org,
        Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [PATCH] backport: handle change in netdevice destructor usage
Date: Mon, 12 Jun 2017 10:06:25 +0100
Message-Id: <1497258385-5116-1-git-send-email-arend.vanspriel@broadcom.com> (sfid-20170612_110637_487182_292F64A6)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This patch deals with changes made in struct net_device by commit
cf124db566e6 ("net: Fix inconsistent teardown and release of private
netdev state."). This only looks for instances that need free_netdev()
call, ie. struct net_device::needs_free_netdev == true.

Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
 backport/backport-include/linux/netdevice.h | 12 +++++++++++
 patches/0079-netdev-destructor.cocci        | 33 +++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)
 create mode 100644 patches/0079-netdev-destructor.cocci

diff --git a/backport/backport-include/linux/netdevice.h b/backport/backport-include/linux/netdevice.h
index 06230b5..4e30383 100644
--- a/backport/backport-include/linux/netdevice.h
+++ b/backport/backport-include/linux/netdevice.h
@@ -320,4 +320,16 @@ static inline void netif_trans_update(struct net_device *dev)
 }
 #endif
 
+static inline
+void netdev_set_priv_destructor(struct net_device *dev,
+				void (*destructor)(struct net_device *dev))
+{
+#if LINUX_VERSION_IS_LESS(4,12,0)
+	dev->destructor = destructor;
+#else
+	dev->needs_free_netdev = true;
+	dev->priv_destructor = destructor;
+#endif
+}
+
 #endif /* __BACKPORT_NETDEVICE_H */
diff --git a/patches/0079-netdev-destructor.cocci b/patches/0079-netdev-destructor.cocci
new file mode 100644
index 0000000..d8a439d
--- /dev/null
+++ b/patches/0079-netdev-destructor.cocci
@@ -0,0 +1,33 @@
+@r1@
+struct net_device *ndev;
+identifier D, C;
+@@
+C(...)
+{
+	<...
+-	ndev->needs_free_netdev = true;
+-	ndev->priv_destructor = D;
++	netdev_set_priv_destructor(ndev, D);
+	...>
+}
+
+@r2 depends on r1@
+struct net_device *NDEV;
+identifier r1.D;
+identifier r1.C;
+fresh identifier E2 = "__" ## D;
+@@
+
++static void E2(struct net_device *dev)
++{
++	D(dev);
++	free_netdev(dev);
++}
++
+C(...)
+{
+	<...
+-	netdev_set_priv_destructor(NDEV, D);
++	netdev_set_priv_destructor(NDEV, E2);
+	...>
+}
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
