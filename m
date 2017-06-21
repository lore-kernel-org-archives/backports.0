Return-path: <backports-owner@vger.kernel.org>
Received: from lpdvrndsmtp01.broadcom.com ([192.19.229.170]:43280 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751083AbdFUU62 (ORCPT
        <rfc822;backports@vger.kernel.org>); Wed, 21 Jun 2017 16:58:28 -0400
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: backports@vger.kernel.org,
        Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [PATCH V2] backport: handle change in netdevice destructor usage
Date: Wed, 21 Jun 2017 21:58:19 +0100
Message-Id: <1498078699-27809-1-git-send-email-arend.vanspriel@broadcom.com> (sfid-20170621_225830_268542_FFBDC610)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This patch deals with changes made in struct net_device by commit
cf124db566e6 ("net: Fix inconsistent teardown and release of private
netdev state.").

Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
Hi Johannes,

It took a while for me to be happy with this version. More so because I
found that brcmfmac has a double-free bug if register_netdevice() fails
so I needed to solve that puzzle. Below is the changelog.

Regards,
Arend

 V2:
  - changed netdev_set_priv_destructor() to macro.
  - revised semantic patch covering drivers only needing free_netdev().
  - used some tricks suggested by Julia in semantic patch.
  - added more version checks against 4.13.
---
 backport/backport-include/linux/netdevice.h |  9 ++++
 patches/0079-netdev-destructor.cocci        | 84 +++++++++++++++++++++++++++++
 2 files changed, 93 insertions(+)
 create mode 100644 patches/0079-netdev-destructor.cocci

diff --git a/backport/backport-include/linux/netdevice.h b/backport/backport-include/linux/netdevice.h
index 06230b5..0f5b198 100644
--- a/backport/backport-include/linux/netdevice.h
+++ b/backport/backport-include/linux/netdevice.h
@@ -320,4 +320,13 @@ static inline void netif_trans_update(struct net_device *dev)
 }
 #endif
 
+#if LINUX_VERSION_IS_LESS(4,13,0)
+#define netdev_set_priv_destructor(_dev, _destructor) \
+	(_dev)->destructor = __ ## _destructor
+#else
+	(_dev)->needs_free_netdev = true;
+	if (_destructor != free_netdev)
+		(_dev)->priv_destructor = _destructor;
+#endif
+
 #endif /* __BACKPORT_NETDEVICE_H */
diff --git a/patches/0079-netdev-destructor.cocci b/patches/0079-netdev-destructor.cocci
new file mode 100644
index 0000000..fab8af1
--- /dev/null
+++ b/patches/0079-netdev-destructor.cocci
@@ -0,0 +1,84 @@
+@r1@
+struct net_device *NDEV;
+identifier D, C;
+identifier TRUE =~ "true";
+@@
+C(...)
+{
+	<...
+-	NDEV->needs_free_netdev = TRUE;
+-	NDEV->priv_destructor = D;
++	netdev_set_priv_destructor(NDEV, D);
+	...>
+}
+
+@r2 depends on r1@
+identifier r1.D, r1.C;
+fresh identifier E = "__" ## D;
+@@
+
++#if LINUX_VERSION_IS_LESS(4,13,0)
++static void E(struct net_device *ndev)
++{
++	D(ndev);
++	free_netdev(ndev);
++}
++#endif
++
+C(...)
+{
+	...
+}
+
+@r3 depends on r1@
+type T;
+identifier NDEV;
+identifier r1.D;
+T RET;
+@@
+
+RET = \(register_netdevice\|register_ndev\)(NDEV);
+if (<+... RET ...+>) {
+	<...
++#if LINUX_VERSION_IS_LESS(4,13,0)
++	D(NDEV);
++#endif
+	free_netdev(NDEV);
+	...>
+}
+
+@r4 depends on r1@
+identifier NDEV;
+identifier r1.D;
+type T;
+T RET;
+@@
+
+if (...)
+	RET = register_netdevice(NDEV);
+else
+	RET = register_netdev(NDEV);
+if (<+... RET ...+>) {
+	<...
++#if LINUX_VERSION_IS_LESS(4,13,0)
++	D(NDEV);
++#endif
+	free_netdev(NDEV);
+	...>
+}
+
+@r5@
+struct net_device *NDEV;
+identifier TRUE =~ "true";
+@@
+
+-NDEV->needs_free_netdev = TRUE;
++netdev_set_priv_destructor(NDEV, free_netdev);
+
+@r6@
+struct net_device *NDEV;
+identifier D;
+@@
+
+-NDEV->priv_destructor = D;
++netdev_set_priv_destructor(NDEV, D);
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
