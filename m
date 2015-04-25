Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:49625 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756754AbbDYNvU (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 25 Apr 2015 09:51:20 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 4/9] patches: do not access name_assign_type
Date: Sat, 25 Apr 2015 15:50:59 +0200
Message-Id: <1429969864-16831-5-git-send-email-hauke@hauke-m.de> (sfid-20150425_155125_634610_020B2356)
In-Reply-To: <1429969864-16831-1-git-send-email-hauke@hauke-m.de>
References: <1429969864-16831-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

struct net_device now has a new member name_assign_type which contains
the type of the mac address. It is currently only used to be shown in
sysfs. It should be save to just ignore it on older kernel versions.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../network/0055-name_assign_type/brcmfmac.patch             | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 patches/collateral-evolutions/network/0055-name_assign_type/brcmfmac.patch

diff --git a/patches/collateral-evolutions/network/0055-name_assign_type/brcmfmac.patch b/patches/collateral-evolutions/network/0055-name_assign_type/brcmfmac.patch
new file mode 100644
index 0000000..e9b1f05
--- /dev/null
+++ b/patches/collateral-evolutions/network/0055-name_assign_type/brcmfmac.patch
@@ -0,0 +1,12 @@
+--- a/drivers/net/wireless/brcm80211/brcmfmac/p2p.c
++++ b/drivers/net/wireless/brcm80211/brcmfmac/p2p.c
+@@ -2312,7 +2312,9 @@ struct wireless_dev *brcmf_p2p_add_vif(s
+ 	}
+ 
+ 	strncpy(ifp->ndev->name, name, sizeof(ifp->ndev->name) - 1);
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,17,0)
+ 	ifp->ndev->name_assign_type = name_assign_type;
++#endif /* >= 3.17.0 */
+ 	err = brcmf_net_attach(ifp, true);
+ 	if (err) {
+ 		brcmf_err("Registering netdevice failed\n");
-- 
1.9.1

