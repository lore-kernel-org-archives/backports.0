Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.mailbox.org ([80.241.60.212]:48969 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754408AbdHUW2s (ORCPT <rfc822;backports@vger.kernel.org>);
        Mon, 21 Aug 2017 18:28:48 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 16/21] patches: brcmfmac: fix netdev destructor
Date: Tue, 22 Aug 2017 00:28:12 +0200
Message-Id: <20170821222817.17376-17-hauke@hauke-m.de> (sfid-20170822_002850_383975_3743917C)
In-Reply-To: <20170821222817.17376-1-hauke@hauke-m.de>
References: <20170821222817.17376-1-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

brcmfmac uses a complicated netdev destructor handling. The
brcmf_net_attach() function just adds a normal destructor and later the
brcmf_add_if() function sets the needs_free_netdev callback.

The normal spatch was not applied correctly to this file, add a patch
before to try to fx this problem manually.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 patches/0079-netdev-destructor/brcmfmac.patch | 35 +++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 patches/0079-netdev-destructor/brcmfmac.patch

diff --git a/patches/0079-netdev-destructor/brcmfmac.patch b/patches/0079-netdev-destructor/brcmfmac.patch
new file mode 100644
index 00000000..3f328b26
--- /dev/null
+++ b/patches/0079-netdev-destructor/brcmfmac.patch
@@ -0,0 +1,35 @@
+diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
+index b5a561b..6f5466f 100644
+--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
++++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
+@@ -462,6 +462,18 @@ static const struct net_device_ops brcmf_netdev_ops_pri = {
+ 	.ndo_set_rx_mode = brcmf_netdev_set_multicast_list
+ };
+ 
++#undef netdev_set_priv_destructor
++#define netdev_set_priv_destructor(_dev, _destructor) \
++	(_dev)->destructor = _destructor
++
++#if LINUX_VERSION_IS_LESS(4,12,0)
++static void __brcmf_cfg80211_free_netdev(struct net_device *ndev)
++{
++	brcmf_cfg80211_free_netdev(ndev);
++	free_netdev(ndev);
++}
++#endif
++
+ int brcmf_net_attach(struct brcmf_if *ifp, bool rtnl_locked)
+ {
+ 	struct brcmf_pub *drvr = ifp->drvr;
+@@ -634,7 +646,11 @@ struct brcmf_if *brcmf_add_if(struct brcmf_pub *drvr, s32 bsscfgidx, s32 ifidx,
+ 		if (!ndev)
+ 			return ERR_PTR(-ENOMEM);
+ 
++#if LINUX_VERSION_IS_LESS(4,12,0)
++		ndev->priv_destructor = __brcmf_cfg80211_free_netdev;
++#else
+ 		ndev->needs_free_netdev = true;
++#endif
+ 		ifp = netdev_priv(ndev);
+ 		ifp->ndev = ndev;
+ 		/* store mapping ifidx to bsscfgidx */
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
