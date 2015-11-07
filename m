Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:52907 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753738AbbKGQzV (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 7 Nov 2015 11:55:21 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 02/10] patches: add missing header in 6lowpan/core.h
Date: Sat,  7 Nov 2015 17:55:02 +0100
Message-Id: <1446915310-8278-3-git-send-email-hauke@hauke-m.de> (sfid-20151107_175523_975544_B3F54F00)
In-Reply-To: <1446915310-8278-1-git-send-email-hauke@hauke-m.de>
References: <1446915310-8278-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This include is missing in kernel version <= 3.5.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../network/0013-fix-makefile-includes/6lowpan.patch           | 10 ++++++++++
 1 file changed, 10 insertions(+)
 create mode 100644 patches/collateral-evolutions/network/0013-fix-makefile-includes/6lowpan.patch

diff --git a/patches/collateral-evolutions/network/0013-fix-makefile-includes/6lowpan.patch b/patches/collateral-evolutions/network/0013-fix-makefile-includes/6lowpan.patch
new file mode 100644
index 0000000..b337bdb
--- /dev/null
+++ b/patches/collateral-evolutions/network/0013-fix-makefile-includes/6lowpan.patch
@@ -0,0 +1,10 @@
+--- a/net/6lowpan/core.c
++++ b/net/6lowpan/core.c
+@@ -14,6 +14,7 @@
+ #include <linux/module.h>
+ 
+ #include <net/6lowpan.h>
++#include <linux/if_arp.h>
+ 
+ void lowpan_netdev_setup(struct net_device *dev, enum lowpan_lltypes lltype)
+ {
-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
