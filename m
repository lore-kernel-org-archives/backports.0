Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:34692 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752528AbaDEMmm (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 5 Apr 2014 08:42:42 -0400
Received: by mail-pa0-f49.google.com with SMTP id lj1so4652279pab.36
        for <backports@vger.kernel.org>; Sat, 05 Apr 2014 05:42:42 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	Alexander Aring <alex.aring@gmail.com>,
	Alexander Smirnov <alex.bluesman.smirnov@gmail.com>,
	Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
	linux-zigbee-devel@lists.sourceforge.net
Subject: [PATCH 19/27] backports: address move of 6lowpan.c to 6lowpan_rtnl.c
Date: Sat,  5 Apr 2014 05:40:53 -0700
Message-Id: <1396701662-15165-20-git-send-email-mcgrof@do-not-panic.com> (sfid-20140405_144448_446776_B816C887)
In-Reply-To: <1396701662-15165-1-git-send-email-mcgrof@do-not-panic.com>
References: <1396701662-15165-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Commit 01348b3448 moved 6lowpan.c to 6lowpan_rtnl.c
which means we have to adjust the respective backport
patches.

commit 01348b34485eceace5d9ca9756ba40679cf22ac6
Author: Alexander Aring <alex.aring@gmail.com>
Date:   Fri Feb 28 07:32:47 2014 +0100

    6lowpan: move 6lowpan.c to 6lowpan_rtnl.c

    We have a 6lowpan.c file and 6lowpan.ko file. To avoid confusing we
    should move 6lowpan.c to 6lowpan_rtnl.c. Then we can support multiple
    source files for 6lowpan module.

    Signed-off-by: Alexander Aring <alex.aring@gmail.com>
    Signed-off-by: David S. Miller <davem@davemloft.net>

Cc: Alexander Aring <alex.aring@gmail.com>
Cc: Alexander Smirnov <alex.bluesman.smirnov@gmail.com>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: linux-zigbee-devel@lists.sourceforge.net
Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 .../network/86-qdisc_tx_busylock/ieee802154.patch              | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/patches/collateral-evolutions/network/86-qdisc_tx_busylock/ieee802154.patch b/patches/collateral-evolutions/network/86-qdisc_tx_busylock/ieee802154.patch
index d685b3c..b4f319d 100644
--- a/patches/collateral-evolutions/network/86-qdisc_tx_busylock/ieee802154.patch
+++ b/patches/collateral-evolutions/network/86-qdisc_tx_busylock/ieee802154.patch
@@ -1,8 +1,6 @@
-diff --git a/net/ieee802154/6lowpan.c b/net/ieee802154/6lowpan.c
-index 8edfea5..04f18ab 100644
---- a/net/ieee802154/6lowpan.c
-+++ b/net/ieee802154/6lowpan.c
-@@ -530,7 +530,9 @@ static struct header_ops lowpan_header_o
+--- a/net/ieee802154/6lowpan_rtnl.c
++++ b/net/ieee802154/6lowpan_rtnl.c
+@@ -374,7 +374,9 @@ static struct header_ops lowpan_header_o
  	.create	= lowpan_header_create,
  };
  
@@ -12,7 +10,7 @@ index 8edfea5..04f18ab 100644
  static struct lock_class_key lowpan_netdev_xmit_lock_key;
  
  static void lowpan_set_lockdep_class_one(struct net_device *dev,
-@@ -545,7 +547,9 @@ static void lowpan_set_lockdep_class_one
+@@ -389,7 +391,9 @@ static void lowpan_set_lockdep_class_one
  static int lowpan_dev_init(struct net_device *dev)
  {
  	netdev_for_each_tx_queue(dev, lowpan_set_lockdep_class_one, NULL);
-- 
1.8.5.3

