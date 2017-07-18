Return-path: <backports-owner@vger.kernel.org>
Received: from paleale.coelho.fi ([176.9.41.70]:39270 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751396AbdGRNds (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 18 Jul 2017 09:33:48 -0400
From: Luca Coelho <luca@coelho.fi>
To: egrumbach@gmail.com, arend.vanspriel@broadcom.com
Cc: johannes@sipsolutions.net, backports@vger.kernel.org,
        Luca Coelho <luciano.coelho@intel.com>
Date: Tue, 18 Jul 2017 16:33:38 +0300
Message-Id: <20170718133338.16475-1-luca@coelho.fi> (sfid-20170718_153349_627060_09B31316)
Subject: [PATCH] backport: fix netdev destructor backport
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Luca Coelho <luciano.coelho@intel.com>

The commit that changed the netdev destructor was also applied in
v4.12-rc6, so we need to update the backport.

Another issue was that when the default free_netdev() destructor was supposed to be used, we would get compilation errors, such as this one in hwsim:

In file included from ./include/net/dst.h:12:0,
                 from /home/luca/iwlwifi/stack-dev/drivers/net/wireless/mac80211_hwsim.c:22:
/home/luca/iwlwifi/stack-dev/drivers/net/wireless/mac80211_hwsim.c: In function hwsim_mon_setup':
/home/luca/iwlwifi/stack-dev/backport-include/linux/netdevice.h:325:23: error: '__free_netdev' undeclared (first use in this function)
  (_dev)->destructor = __ ## _destructor
                       ^
/home/luca/iwlwifi/stack-dev/drivers/net/wireless/mac80211_hwsim.c:2977:2: note: in expansion of macro 'netdev_set_priv_destructor'
  netdev_set_priv_destructor(dev, free_netdev);
  ^~~~~~~~~~~~~~~~~~~~~~~~~~
/home/luca/iwlwifi/stack-dev/backport-include/linux/netdevice.h:325:23: note: each undeclared identifier is reported only once for each function it appears in
  (_dev)->destructor = __ ## _destructor
                       ^
/home/luca/iwlwifi/stack-dev/drivers/net/wireless/mac80211_hwsim.c:2977:2: note: in expansion of macro 'netdev_set_priv_destructor'
  netdev_set_priv_destructor(dev, free_netdev);
  ^~~~~~~~~~~~~~~~~~~~~~~~~~
scripts/Makefile.build:300: recipe for target '/home/luca/iwlwifi/stack-dev/drivers/net/wireless/mac80211_hwsim.o' failed

To fix this, add a new macro, netdev_set_def_destructor(), that
handles this special case.

Fixes: 721ae78f9355 ("backport: handle change in netdevice destructor usage")
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 backport/backport-include/linux/netdevice.h | 9 ++++++---
 patches/0079-netdev-destructor.cocci        | 8 ++++----
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/backport/backport-include/linux/netdevice.h b/backport/backport-include/linux/netdevice.h
index 98e781eeb740..d22eec2d3113 100644
--- a/backport/backport-include/linux/netdevice.h
+++ b/backport/backport-include/linux/netdevice.h
@@ -320,14 +320,17 @@ static inline void netif_trans_update(struct net_device *dev)
 }
 #endif
 
-#if LINUX_VERSION_IS_LESS(4,13,0)
+#if LINUX_VERSION_IS_LESS(4,12,0)
 #define netdev_set_priv_destructor(_dev, _destructor) \
 	(_dev)->destructor = __ ## _destructor
+#define netdev_set_def_destructor(_dev) \
+	(_dev)->destructor = free_netdev
 #else
 #define netdev_set_priv_destructor(_dev, _destructor) \
 	(_dev)->needs_free_netdev = true; \
-	if ((_destructor) != free_netdev) \
-		(_dev)->priv_destructor = (_destructor);
+	(_dev)->priv_destructor = (_destructor);
+#define netdev_set_def_destructor(_dev) \
+	(_dev)->needs_free_netdev = true;
 #endif
 
 #endif /* __BACKPORT_NETDEVICE_H */
diff --git a/patches/0079-netdev-destructor.cocci b/patches/0079-netdev-destructor.cocci
index fab8af192aac..199aacf29032 100644
--- a/patches/0079-netdev-destructor.cocci
+++ b/patches/0079-netdev-destructor.cocci
@@ -17,7 +17,7 @@ identifier r1.D, r1.C;
 fresh identifier E = "__" ## D;
 @@
 
-+#if LINUX_VERSION_IS_LESS(4,13,0)
++#if LINUX_VERSION_IS_LESS(4,12,0)
 +static void E(struct net_device *ndev)
 +{
 +	D(ndev);
@@ -40,7 +40,7 @@ T RET;
 RET = \(register_netdevice\|register_ndev\)(NDEV);
 if (<+... RET ...+>) {
 	<...
-+#if LINUX_VERSION_IS_LESS(4,13,0)
++#if LINUX_VERSION_IS_LESS(4,12,0)
 +	D(NDEV);
 +#endif
 	free_netdev(NDEV);
@@ -60,7 +60,7 @@ else
 	RET = register_netdev(NDEV);
 if (<+... RET ...+>) {
 	<...
-+#if LINUX_VERSION_IS_LESS(4,13,0)
++#if LINUX_VERSION_IS_LESS(4,12,0)
 +	D(NDEV);
 +#endif
 	free_netdev(NDEV);
@@ -73,7 +73,7 @@ identifier TRUE =~ "true";
 @@
 
 -NDEV->needs_free_netdev = TRUE;
-+netdev_set_priv_destructor(NDEV, free_netdev);
++netdev_set_def_destructor(NDEV);
 
 @r6@
 struct net_device *NDEV;
-- 
2.13.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
