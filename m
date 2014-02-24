Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:35044 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751340AbaBXArS (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 23 Feb 2014 19:47:18 -0500
Received: from localhost (localhost [127.0.0.1])
	by hauke-m.de (Postfix) with ESMTP id 043D87E57
	for <backports@vger.kernel.org>; Mon, 24 Feb 2014 01:47:18 +0100 (CET)
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 11/12] backports: remove usage of net_device member qdisc_tx_busylock
Date: Mon, 24 Feb 2014 01:45:53 +0100
Message-Id: <1393202754-12919-12-git-send-email-hauke@hauke-m.de> (sfid-20140224_014719_822661_BC2C4685)
In-Reply-To: <1393202754-12919-1-git-send-email-hauke@hauke-m.de>
References: <1393202754-12919-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This member was added ion more recent kernel versions.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../network/86-qdisc_tx_busylock/ieee802154.patch  |   24 ++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 patches/collateral-evolutions/network/86-qdisc_tx_busylock/ieee802154.patch

diff --git a/patches/collateral-evolutions/network/86-qdisc_tx_busylock/ieee802154.patch b/patches/collateral-evolutions/network/86-qdisc_tx_busylock/ieee802154.patch
new file mode 100644
index 0000000..d685b3c
--- /dev/null
+++ b/patches/collateral-evolutions/network/86-qdisc_tx_busylock/ieee802154.patch
@@ -0,0 +1,24 @@
+diff --git a/net/ieee802154/6lowpan.c b/net/ieee802154/6lowpan.c
+index 8edfea5..04f18ab 100644
+--- a/net/ieee802154/6lowpan.c
++++ b/net/ieee802154/6lowpan.c
+@@ -530,7 +530,9 @@ static struct header_ops lowpan_header_o
+ 	.create	= lowpan_header_create,
+ };
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,7,0)
+ static struct lock_class_key lowpan_tx_busylock;
++#endif
+ static struct lock_class_key lowpan_netdev_xmit_lock_key;
+ 
+ static void lowpan_set_lockdep_class_one(struct net_device *dev,
+@@ -545,7 +547,9 @@ static void lowpan_set_lockdep_class_one
+ static int lowpan_dev_init(struct net_device *dev)
+ {
+ 	netdev_for_each_tx_queue(dev, lowpan_set_lockdep_class_one, NULL);
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,7,0)
+ 	dev->qdisc_tx_busylock = &lowpan_tx_busylock;
++#endif
+ 	return 0;
+ }
+ 
-- 
1.7.10.4

