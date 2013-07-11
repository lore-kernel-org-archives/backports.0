Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:44237 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756938Ab3GKWMw (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 11 Jul 2013 18:12:52 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 15/19] backports: remove alx extra patch
Date: Fri, 12 Jul 2013 00:11:38 +0200
Message-Id: <1373580702-24752-17-git-send-email-hauke@hauke-m.de> (sfid-20130712_001257_054227_C6C7F3C2)
In-Reply-To: <1373580702-24752-1-git-send-email-hauke@hauke-m.de>
References: <1373580702-24752-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

Upstream commit e3220f58fc08f986c3b84458d50eee2d3b983690

The alx driver was upstreamed by Johannes, so this is
no longer required. Note that this driver is now GPLv2
or later, BSD folks will have to look at the old unified
tree for a permissive licensed port.

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../network/0002-alx-make-kconfig/alx.patch        |   32 --------------------
 1 file changed, 32 deletions(-)
 delete mode 100644 patches/unified-drivers/network/0002-alx-make-kconfig/alx.patch

diff --git a/patches/unified-drivers/network/0002-alx-make-kconfig/alx.patch b/patches/unified-drivers/network/0002-alx-make-kconfig/alx.patch
deleted file mode 100644
index 465e499..0000000
--- a/patches/unified-drivers/network/0002-alx-make-kconfig/alx.patch
+++ /dev/null
@@ -1,32 +0,0 @@
---- a/drivers/net/ethernet/atheros/Kconfig
-+++ b/drivers/net/ethernet/atheros/Kconfig
-@@ -67,4 +67,22 @@ config ATL1C
- 	  To compile this driver as a module, choose M here.  The module
- 	  will be called atl1c.
- 
-+config ALX
-+	tristate "Qualcomm Atheros L1F Gigabit Ethernet support"
-+	depends on PCI
-+	select CRC32
-+	select NET_CORE
-+	select MII
-+	---help---
-+	  This driver supports the Qualcomm Atheros L1F ethernet adapter.
-+	  This driver supports following chipsets:
-+
-+	  1969:1091 - AR8161 Gigabit Ethernet
-+	  1969:1090 - AR8162 Fast Ethernet
-+	  1969:10A1 - AR8171 Gigabit Ethernet
-+	  1969:10A0 - AR8172 Fast Ethernet
-+
-+	  To compile this driver as a module, choose M here.  The module
-+	  will be called alx.
-+
- endif # NET_VENDOR_ATHEROS
---- a/drivers/net/ethernet/atheros/Makefile
-+++ b/drivers/net/ethernet/atheros/Makefile
-@@ -6,3 +6,4 @@ obj-$(CONFIG_ATL1) += atlx/
- obj-$(CONFIG_ATL2) += atlx/
- obj-$(CONFIG_ATL1E) += atl1e/
- obj-$(CONFIG_ATL1C) += atl1c/
-+obj-$(CONFIG_ALX) += alx/
-- 
1.7.10.4

