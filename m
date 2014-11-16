Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:37689 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750934AbaKPUtm (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 16 Nov 2014 15:49:42 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 20/20] backports: do not use in kernel version of rt6_nexthop()
Date: Sun, 16 Nov 2014 21:49:20 +0100
Message-Id: <1416170960-12868-21-git-send-email-hauke@hauke-m.de> (sfid-20141116_221346_944485_C5FCB499)
In-Reply-To: <1416170960-12868-1-git-send-email-hauke@hauke-m.de>
References: <1416170960-12868-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Kernel 3.9 ships with a version of rt6_nexthop() with two parameters.
We want to replace this version with our current version which only
takes one parameter. include/net/ip6_route.h includes include/net
/ip6_fib.h so we can not place our code behind the code in include/net
/ip6_route.h. If we include ip6_fib.h before ip6_route.h we can place
our code at the position we need it.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../network/0013-fix-makefile-includes/bluetooth.patch         | 10 ++++++++++
 .../network/0030-qdisc_tx_busylock/bluetooth.patch             |  2 +-
 2 files changed, 11 insertions(+), 1 deletion(-)
 create mode 100644 patches/collateral-evolutions/network/0013-fix-makefile-includes/bluetooth.patch

diff --git a/patches/collateral-evolutions/network/0013-fix-makefile-includes/bluetooth.patch b/patches/collateral-evolutions/network/0013-fix-makefile-includes/bluetooth.patch
new file mode 100644
index 0000000..db73299
--- /dev/null
+++ b/patches/collateral-evolutions/network/0013-fix-makefile-includes/bluetooth.patch
@@ -0,0 +1,10 @@
+--- a/net/bluetooth/6lowpan.c
++++ b/net/bluetooth/6lowpan.c
+@@ -18,6 +18,7 @@
+ #include <linux/debugfs.h>
+ 
+ #include <net/ipv6.h>
++#include <net/ip6_fib.h>
+ #include <net/ip6_route.h>
+ #include <net/addrconf.h>
+ 
diff --git a/patches/collateral-evolutions/network/0030-qdisc_tx_busylock/bluetooth.patch b/patches/collateral-evolutions/network/0030-qdisc_tx_busylock/bluetooth.patch
index 0c63a67..8626c3b 100644
--- a/patches/collateral-evolutions/network/0030-qdisc_tx_busylock/bluetooth.patch
+++ b/patches/collateral-evolutions/network/0030-qdisc_tx_busylock/bluetooth.patch
@@ -1,6 +1,6 @@
 --- a/net/bluetooth/6lowpan.c
 +++ b/net/bluetooth/6lowpan.c
-@@ -663,7 +663,9 @@ static void bt_set_lockdep_class_one(str
+@@ -664,7 +664,9 @@ static void bt_set_lockdep_class_one(str
  static int bt_dev_init(struct net_device *dev)
  {
  	netdev_for_each_tx_queue(dev, bt_set_lockdep_class_one, NULL);
-- 
1.9.1

