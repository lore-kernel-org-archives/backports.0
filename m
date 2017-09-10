Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.mailbox.org ([80.241.60.212]:58416 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751661AbdIJWKr (ORCPT <rfc822;backports@vger.kernel.org>);
        Sun, 10 Sep 2017 18:10:47 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 2/8] patches: brcmfmac: Fix netdev_set_priv_destructor
Date: Mon, 11 Sep 2017 00:10:14 +0200
Message-Id: <20170910221020.13067-3-hauke@hauke-m.de> (sfid-20170911_001050_263336_E9A3B21C)
In-Reply-To: <20170910221020.13067-1-hauke@hauke-m.de>
References: <20170910221020.13067-1-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On kernel > 4.11.9 the new member priv_destructor should be set in
netdev_set_priv_destructor() and not the old destructor member any more,
it was removed.

This fixes the build on >= 4.11.9.

Fixes: 7c827d5ac9c1 ("patches: brcmfmac: fix netdev destructor")
Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/netdevice.h   |  3 +--
 patches/0079-netdev-destructor/brcmfmac.patch | 13 ++++++++-----
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/backport/backport-include/linux/netdevice.h b/backport/backport-include/linux/netdevice.h
index 112bcf2b..9c912285 100644
--- a/backport/backport-include/linux/netdevice.h
+++ b/backport/backport-include/linux/netdevice.h
@@ -320,8 +320,7 @@ static inline void netif_trans_update(struct net_device *dev)
 }
 #endif
 
-#if LINUX_VERSION_IS_LESS(4,12,0) &&		\
-	!LINUX_VERSION_IN_RANGE(4,11,9, 4,12,0)
+#if LINUX_VERSION_IS_LESS(4,11,9)
 #define netdev_set_priv_destructor(_dev, _destructor) \
 	(_dev)->destructor = __ ## _destructor
 #define netdev_set_def_destructor(_dev) \
diff --git a/patches/0079-netdev-destructor/brcmfmac.patch b/patches/0079-netdev-destructor/brcmfmac.patch
index 3f328b26..6dae7a7a 100644
--- a/patches/0079-netdev-destructor/brcmfmac.patch
+++ b/patches/0079-netdev-destructor/brcmfmac.patch
@@ -1,14 +1,17 @@
-diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
-index b5a561b..6f5466f 100644
 --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
 +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
-@@ -462,6 +462,18 @@ static const struct net_device_ops brcmf_netdev_ops_pri = {
+@@ -462,6 +462,23 @@ static const struct net_device_ops brcmf
  	.ndo_set_rx_mode = brcmf_netdev_set_multicast_list
  };
  
 +#undef netdev_set_priv_destructor
++#if LINUX_VERSION_IS_LESS(4,11,9)
 +#define netdev_set_priv_destructor(_dev, _destructor) \
-+	(_dev)->destructor = _destructor
++	(_dev)->destructor = (_destructor)
++#else
++#define netdev_set_priv_destructor(_dev, _destructor) \
++	(_dev)->priv_destructor = (_destructor)
++#endif
 +
 +#if LINUX_VERSION_IS_LESS(4,12,0)
 +static void __brcmf_cfg80211_free_netdev(struct net_device *ndev)
@@ -21,7 +24,7 @@ index b5a561b..6f5466f 100644
  int brcmf_net_attach(struct brcmf_if *ifp, bool rtnl_locked)
  {
  	struct brcmf_pub *drvr = ifp->drvr;
-@@ -634,7 +646,11 @@ struct brcmf_if *brcmf_add_if(struct brcmf_pub *drvr, s32 bsscfgidx, s32 ifidx,
+@@ -634,7 +651,11 @@ struct brcmf_if *brcmf_add_if(struct brc
  		if (!ndev)
  			return ERR_PTR(-ENOMEM);
  
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
