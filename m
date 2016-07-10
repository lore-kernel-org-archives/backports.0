Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:56145 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757293AbcGJVPC (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 10 Jul 2016 17:15:02 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 14/19] patch: add include for net/ipv6.h to igb_main.c
Date: Sun, 10 Jul 2016 23:14:40 +0200
Message-Id: <1468185285-28265-15-git-send-email-hauke@hauke-m.de> (sfid-20160711_013913_190431_841CC79B)
In-Reply-To: <1468185285-28265-1-git-send-email-hauke@hauke-m.de>
References: <1468185285-28265-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Without this patch igb was unable to find ipv6_find_hdr() in kernel < 3.14.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../network/0013-fix-makefile-includes/igb.patch             | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 patches/collateral-evolutions/network/0013-fix-makefile-includes/igb.patch

diff --git a/patches/collateral-evolutions/network/0013-fix-makefile-includes/igb.patch b/patches/collateral-evolutions/network/0013-fix-makefile-includes/igb.patch
new file mode 100644
index 0000000..a0804dc
--- /dev/null
+++ b/patches/collateral-evolutions/network/0013-fix-makefile-includes/igb.patch
@@ -0,0 +1,12 @@
+diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
+index 55a1405c..1409e20 100644
+--- a/drivers/net/ethernet/intel/igb/igb_main.c
++++ b/drivers/net/ethernet/intel/igb/igb_main.c
+@@ -34,6 +34,7 @@
+ #include <linux/slab.h>
+ #include <net/checksum.h>
+ #include <net/ip6_checksum.h>
++#include <net/ipv6.h>
+ #include <linux/net_tstamp.h>
+ #include <linux/mii.h>
+ #include <linux/ethtool.h>
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
