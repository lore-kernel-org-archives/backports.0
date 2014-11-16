Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:37687 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750943AbaKPUtl (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 16 Nov 2014 15:49:41 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 16/20] patches: disable qdisc_tx_busylock in bluetooth
Date: Sun, 16 Nov 2014 21:49:16 +0100
Message-Id: <1416170960-12868-17-git-send-email-hauke@hauke-m.de> (sfid-20141116_221347_584476_4E65E9F4)
In-Reply-To: <1416170960-12868-1-git-send-email-hauke@hauke-m.de>
References: <1416170960-12868-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The qdisc_tx_busylock member in struct net_device is not available in
kernel < 3.7.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../network/0030-qdisc_tx_busylock/bluetooth.patch           | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 patches/collateral-evolutions/network/0030-qdisc_tx_busylock/bluetooth.patch

diff --git a/patches/collateral-evolutions/network/0030-qdisc_tx_busylock/bluetooth.patch b/patches/collateral-evolutions/network/0030-qdisc_tx_busylock/bluetooth.patch
new file mode 100644
index 0000000..0c63a67
--- /dev/null
+++ b/patches/collateral-evolutions/network/0030-qdisc_tx_busylock/bluetooth.patch
@@ -0,0 +1,12 @@
+--- a/net/bluetooth/6lowpan.c
++++ b/net/bluetooth/6lowpan.c
+@@ -663,7 +663,9 @@ static void bt_set_lockdep_class_one(str
+ static int bt_dev_init(struct net_device *dev)
+ {
+ 	netdev_for_each_tx_queue(dev, bt_set_lockdep_class_one, NULL);
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,7,0)
+ 	dev->qdisc_tx_busylock = &bt_tx_busylock;
++#endif
+ 
+ 	return 0;
+ }
-- 
1.9.1

