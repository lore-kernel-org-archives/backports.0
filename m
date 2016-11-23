Return-path: <backports-owner@vger.kernel.org>
Received: from lpdvsmtp01.broadcom.com ([192.19.211.62]:52952 "EHLO
        relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935303AbcKWKdj (ORCPT
        <rfc822;backports@vger.kernel.org>); Wed, 23 Nov 2016 05:33:39 -0500
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: backports@vger.kernel.org,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Julia Lawall <julia.lawall@lip6.fr>
Subject: [PATCH] patches: network: add spatch for mtu range checking
Date: Wed, 23 Nov 2016 10:33:13 +0000
Message-Id: <1479897193-6168-1-git-send-email-arend.vanspriel@broadcom.com> (sfid-20161123_113549_273377_1C1F6F8B)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The mtu range checking was moved into network subsystem resulting in
the addition of min_mtu and max_mtu fields in struct net_device. For
drivers with a .ndo_change_mtu() which took care of range checking this
resulted in removal of the callback. This spatch restores the callback
using the values set in {min,max}_mtu fields for kernels before v4.10.

Signed-off-by: Julia Lawall <julia.lawall@lip6.fr>
Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
 .../network/0073-netdevice-mtu-range.cocci         | 75 ++++++++++++++++++++++
 1 file changed, 75 insertions(+)
 create mode 100644 patches/collateral-evolutions/network/0073-netdevice-mtu-range.cocci

diff --git a/patches/collateral-evolutions/network/0073-netdevice-mtu-range.cocci b/patches/collateral-evolutions/network/0073-netdevice-mtu-range.cocci
new file mode 100644
index 0000000..30276f9
--- /dev/null
+++ b/patches/collateral-evolutions/network/0073-netdevice-mtu-range.cocci
@@ -0,0 +1,75 @@
+@initialize:python@
+@@
+
+first_ops = 0
+
+@r@
+identifier OPS;
+position p;
+@@
+
+struct net_device_ops OPS@p = { ... };
+
+@script:python depends on r@
+@@
+
+first_ops = 0
+
+@script:python@
+p << r.p;
+@@
+
+ln = int(p[0].line)
+if first_ops == 0 or ln < first_ops:
+  first_ops = ln
+
+@script:python@
+p << r.p;
+@@
+
+ln = int(p[0].line)
+if not(first_ops == ln):
+  cocci.include_match(False)
+
+@r1 exists@
+expression ndevexp, e1, e2;
+identifier func;
+@@
+func(...) {
+	<+...
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,10,0)
+	ndevexp->min_mtu = e1;
+	ndevexp->max_mtu = e2;
++#endif
+	...+>
+}
+
+@r2@
+expression r1.e1,r1.e2;
+identifier r.OPS;
+@@
++#if LINUX_VERSION_CODE < KERNEL_VERSION(4,10,0)
++ static int __change_mtu(struct net_device *ndev, int new_mtu)
++ {
++ if (new_mtu < e1 || new_mtu > e2)
++             return -EINVAL;
++             ndev->mtu = new_mtu;
++             return 0;
++ }
++#endif
++
+struct net_device_ops OPS = {
+       ...
+};
+
+@depends on r2@
+identifier OPS;
+@@
+
+struct net_device_ops OPS = {
++#if LINUX_VERSION_CODE < KERNEL_VERSION(4,10,0)
++      .ndo_change_mtu = __change_mtu,
++#endif
+       ...
+};
+
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
