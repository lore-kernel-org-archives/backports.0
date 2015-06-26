Return-path: <backports-owner@vger.kernel.org>
Received: from mail-la0-f45.google.com ([209.85.215.45]:35914 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752439AbbFZSOe (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 26 Jun 2015 14:14:34 -0400
Received: by lacny3 with SMTP id ny3so68272713lac.3
        for <backports@vger.kernel.org>; Fri, 26 Jun 2015 11:14:32 -0700 (PDT)
From: Florian Grandel <fgrandel@gmail.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: backports@vger.kernel.org, Florian Grandel <fgrandel@gmail.com>
Subject: [PATCH] patches: fix compile warning
Date: Fri, 26 Jun 2015 20:14:14 +0200
Message-Id: <1435342454-21239-2-git-send-email-fgrandel@gmail.com> (sfid-20150626_201435_876391_E5D810DA)
In-Reply-To: <1435342454-21239-1-git-send-email-fgrandel@gmail.com>
References: <1435342454-21239-1-git-send-email-fgrandel@gmail.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Usage of the bt_tx_busylock variable was already patched but not the
declaration which caused a compile warning. This patch introduces a
define statement that also excludes the variable declaration.

Signed-off-by: Florian Grandel <fgrandel@gmail.com>
---
 .../network/0030-qdisc_tx_busylock/bluetooth.patch           | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/patches/collateral-evolutions/network/0030-qdisc_tx_busylock/bluetooth.patch b/patches/collateral-evolutions/network/0030-qdisc_tx_busylock/bluetooth.patch
index 4ced79a..62d2fe2 100644
--- a/patches/collateral-evolutions/network/0030-qdisc_tx_busylock/bluetooth.patch
+++ b/patches/collateral-evolutions/network/0030-qdisc_tx_busylock/bluetooth.patch
@@ -1,6 +1,16 @@
 --- a/net/bluetooth/6lowpan.c
 +++ b/net/bluetooth/6lowpan.c
-@@ -659,7 +659,9 @@ static void bt_set_lockdep_class_one(str
+@@ -645,7 +645,9 @@ static netdev_tx_t bt_xmit(struct sk_buff *skb, struct net_device *netdev)
+ 	return err < 0 ? NET_XMIT_DROP : err;
+ }
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,7,0)
+ static struct lock_class_key bt_tx_busylock;
++#endif
+ static struct lock_class_key bt_netdev_xmit_lock_key;
+ 
+ static void bt_set_lockdep_class_one(struct net_device *dev,
+@@ -658,7 +660,9 @@ static void bt_set_lockdep_class_one(struct net_device *dev,
  static int bt_dev_init(struct net_device *dev)
  {
  	netdev_for_each_tx_queue(dev, bt_set_lockdep_class_one, NULL);
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
