Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:56149 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757207AbcGJVO7 (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 10 Jul 2016 17:14:59 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 05/19] header: remove vid parameter from ndo_dflt_fdb_add()
Date: Sun, 10 Jul 2016 23:14:31 +0200
Message-Id: <1468185285-28265-6-git-send-email-hauke@hauke-m.de> (sfid-20160710_231504_120972_835691B6)
In-Reply-To: <1468185285-28265-1-git-send-email-hauke@hauke-m.de>
References: <1468185285-28265-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The signature was changed in Linux kernel commit f6f6424ba "net: make
vid as a parameter for ndo_fdb_add/ndo_fdb_del".

In addition the signature of the callback ndo_fdb_add was also changed.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/rtnetlink.h              |  6 ++++++
 .../network/0072-netdevice-ndo_fdb_add/igb.patch         | 16 ++++++++++++++++
 2 files changed, 22 insertions(+)
 create mode 100644 patches/collateral-evolutions/network/0072-netdevice-ndo_fdb_add/igb.patch

diff --git a/backport/backport-include/linux/rtnetlink.h b/backport/backport-include/linux/rtnetlink.h
index 6dea700..806f212 100644
--- a/backport/backport-include/linux/rtnetlink.h
+++ b/backport/backport-include/linux/rtnetlink.h
@@ -13,4 +13,10 @@
 				 lockdep_rtnl_is_held())
 #endif
 
+#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,19,0))
+#define ndo_dflt_fdb_add(ndm, tb, dev, addr, vid, flags) \
+	ndo_dflt_fdb_add(ndm, tb, dev, addr, flags)
+#endif
+
+			    
 #endif /* __BACKPORT_LINUX_RTNETLINK_H */
diff --git a/patches/collateral-evolutions/network/0072-netdevice-ndo_fdb_add/igb.patch b/patches/collateral-evolutions/network/0072-netdevice-ndo_fdb_add/igb.patch
new file mode 100644
index 0000000..c50fe51
--- /dev/null
+++ b/patches/collateral-evolutions/network/0072-netdevice-ndo_fdb_add/igb.patch
@@ -0,0 +1,16 @@
+diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
+index 55a1405c..31edad7 100644
+--- a/drivers/net/ethernet/intel/igb/igb_main.c
++++ b/drivers/net/ethernet/intel/igb/igb_main.c
+@@ -2077,7 +2077,11 @@ static int igb_set_features(struct net_d
+ 
+ static int igb_ndo_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
+ 			   struct net_device *dev,
++#if LINUX_VERSION_CODE < KERNEL_VERSION(3,19,0)
++			   const unsigned char *addr,
++#else
+ 			   const unsigned char *addr, u16 vid,
++#endif
+ 			   u16 flags)
+ {
+ 	/* guarantee we can provide a unique filter for the unicast address */
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
