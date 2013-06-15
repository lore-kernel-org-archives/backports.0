Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:39391 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751048Ab3FOPiq (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 15 Jun 2013 11:38:46 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 8/8] backports: add ieee802154
Date: Sat, 15 Jun 2013 17:37:58 +0200
Message-Id: <1371310678-26491-9-git-send-email-hauke@hauke-m.de> (sfid-20130615_173847_843695_7B5F83D6)
In-Reply-To: <1371310678-26491-1-git-send-email-hauke@hauke-m.de>
References: <1371310678-26491-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This adds the ieee802154 subsystem.

== ckmake-report.log ==

1   2.6.24              [  OK  ]
2   2.6.25              [  OK  ]
3   2.6.26              [  OK  ]
4   2.6.27              [  OK  ]
5   2.6.28              [  OK  ]
6   2.6.29              [  OK  ]
7   2.6.30              [  OK  ]
8   2.6.31              [  OK  ]
9   2.6.32              [  OK  ]
10  2.6.33              [  OK  ]
11  2.6.34              [  OK  ]
12  2.6.35              [  OK  ]
13  2.6.36              [  OK  ]
14  2.6.37              [  OK  ]
15  2.6.38              [  OK  ]
16  2.6.39              [  OK  ]
17  3.0.79              [  OK  ]
18  3.1.10              [  OK  ]
19  3.10-rc1            [  OK  ]
20  3.2.45              [  OK  ]
21  3.3.8               [  OK  ]
22  3.4.46              [  OK  ]
23  3.5.7               [  OK  ]
24  3.6.11              [  OK  ]
25  3.7.10              [  OK  ]
26  3.8.13              [  OK  ]
27  3.9.3               [  OK  ]

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/Kconfig                                   |    4 ++
 backport/Makefile.kernel                           |    4 ++
 backport/backport-include/linux/if_arp.h           |   10 +++++
 backport/defconfigs/ieee802154                     |    8 ++++
 copy-list                                          |   11 ++++++
 dependencies                                       |    3 ++
 .../0001-netlink-portid/ieee802154.patch           |   40 ++++++++++++++++++++
 7 files changed, 80 insertions(+)
 create mode 100644 backport/backport-include/linux/if_arp.h
 create mode 100644 backport/defconfigs/ieee802154
 create mode 100644 patches/collateral-evolutions/ieee802154/0001-netlink-portid/ieee802154.patch

diff --git a/backport/Kconfig b/backport/Kconfig
index c465ad1..845b233 100644
--- a/backport/Kconfig
+++ b/backport/Kconfig
@@ -44,3 +44,7 @@ source drivers/regulator/Kconfig
 source drivers/media/Kconfig
 
 source drivers/platform/x86/Kconfig
+
+source net/ieee802154/Kconfig
+source net/mac802154/Kconfig
+source drivers/net/ieee802154/Kconfig
diff --git a/backport/Makefile.kernel b/backport/Makefile.kernel
index c697e44..ac29dea 100644
--- a/backport/Makefile.kernel
+++ b/backport/Makefile.kernel
@@ -36,3 +36,7 @@ obj-$(CPTCFG_NFC) += drivers/nfc/
 obj-$(CPTCFG_REGULATOR) += drivers/regulator/
 obj-$(CPTCFG_MEDIA_SUPPORT) += drivers/media/
 obj-$(CPTCFG_INTEL_IPS) += drivers/platform/x86/
+
+obj-$(CPTCFG_IEEE802154) += net/ieee802154/
+obj-$(CPTCFG_MAC802154) += net/mac802154/
+obj-$(CPTCFG_IEEE802154) += drivers/net/ieee802154/
diff --git a/backport/backport-include/linux/if_arp.h b/backport/backport-include/linux/if_arp.h
new file mode 100644
index 0000000..dbbea2d
--- /dev/null
+++ b/backport/backport-include/linux/if_arp.h
@@ -0,0 +1,10 @@
+#ifndef _BACKPORTS_LINUX_AF_ARP_H
+#define _BACKPORTS_LINUX_AF_ARP_H 1
+
+#include_next <linux/if_arp.h>
+
+#ifndef ARPHRD_IEEE802154_MONITOR
+#define ARPHRD_IEEE802154_MONITOR 805	/* IEEE 802.15.4 network monitor */
+#endif
+
+#endif /* _BACKPORTS_LINUX_AF_ARP_H */
diff --git a/backport/defconfigs/ieee802154 b/backport/defconfigs/ieee802154
new file mode 100644
index 0000000..2c6730a
--- /dev/null
+++ b/backport/defconfigs/ieee802154
@@ -0,0 +1,8 @@
+CPTCFG_IEEE802154_DRIVERS=m
+CPTCFG_IEEE802154_FAKEHARD=m
+CPTCFG_IEEE802154_FAKELB=m
+CPTCFG_IEEE802154_AT86RF230=m
+CPTCFG_IEEE802154_MRF24J40=m
+CPTCFG_IEEE802154=m
+CPTCFG_IEEE802154_6LOWPAN=m
+CPTCFG_MAC802154=m
diff --git a/copy-list b/copy-list
index 01b5e2b..5d7acd9 100644
--- a/copy-list
+++ b/copy-list
@@ -171,3 +171,14 @@ drivers/platform/x86/Makefile
 drivers/platform/x86/intel_ips.c
 drivers/platform/x86/intel_ips.h
 include/asm-generic/io-64-nonatomic-lo-hi.h
+
+include/net/nl802154.h
+include/net/mac802154.h
+include/net/ieee802154.h
+include/linux/nl802154.h
+include/net/ieee802154_netdev.h
+include/net/wpan-phy.h
+include/linux/spi/at86rf230.h
+net/ieee802154/
+net/mac802154/
+drivers/net/ieee802154/
diff --git a/dependencies b/dependencies
index e3b4ed2..9d6122d 100644
--- a/dependencies
+++ b/dependencies
@@ -207,3 +207,6 @@ NFC 3.1
 INTEL_IPS 3.2
 
 NFC_MEI_PHY 3.10
+
+IEEE802154_MRF24J40 3.5
+IEEE802154 2.6.38
diff --git a/patches/collateral-evolutions/ieee802154/0001-netlink-portid/ieee802154.patch b/patches/collateral-evolutions/ieee802154/0001-netlink-portid/ieee802154.patch
new file mode 100644
index 0000000..e1c12ed
--- /dev/null
+++ b/patches/collateral-evolutions/ieee802154/0001-netlink-portid/ieee802154.patch
@@ -0,0 +1,40 @@
+--- a/net/ieee802154/nl-mac.c
++++ b/net/ieee802154/nl-mac.c
+@@ -549,7 +549,7 @@ static int ieee802154_list_iface(struct
+ 	if (!msg)
+ 		goto out_dev;
+ 
+-	rc = ieee802154_nl_fill_iface(msg, info->snd_portid, info->snd_seq,
++	rc = ieee802154_nl_fill_iface(msg, genl_info_snd_portid(info), info->snd_seq,
+ 			0, dev);
+ 	if (rc < 0)
+ 		goto out_free;
+@@ -580,7 +580,7 @@ static int ieee802154_dump_iface(struct
+ 		if (idx < s_idx || (dev->type != ARPHRD_IEEE802154))
+ 			goto cont;
+ 
+-		if (ieee802154_nl_fill_iface(skb, NETLINK_CB(cb->skb).portid,
++		if (ieee802154_nl_fill_iface(skb, NETLINK_CB_PORTID(cb->skb),
+ 			cb->nlh->nlmsg_seq, NLM_F_MULTI, dev) < 0)
+ 			break;
+ cont:
+--- a/net/ieee802154/nl-phy.c
++++ b/net/ieee802154/nl-phy.c
+@@ -105,7 +105,7 @@ static int ieee802154_list_phy(struct sk
+ 	if (!msg)
+ 		goto out_dev;
+ 
+-	rc = ieee802154_nl_fill_phy(msg, info->snd_portid, info->snd_seq,
++	rc = ieee802154_nl_fill_phy(msg, genl_info_snd_portid(info), info->snd_seq,
+ 			0, phy);
+ 	if (rc < 0)
+ 		goto out_free;
+@@ -138,7 +138,7 @@ static int ieee802154_dump_phy_iter(stru
+ 		return 0;
+ 
+ 	rc = ieee802154_nl_fill_phy(data->skb,
+-			NETLINK_CB(data->cb->skb).portid,
++			NETLINK_CB_PORTID(data->cb->skb),
+ 			data->cb->nlh->nlmsg_seq,
+ 			NLM_F_MULTI,
+ 			phy);
-- 
1.7.10.4

