Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:48246 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752753Ab3KXVXe (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 24 Nov 2013 16:23:34 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 01/15] backports: remove mdio driver code
Date: Sun, 24 Nov 2013 22:23:04 +0100
Message-Id: <1385328198-28520-2-git-send-email-hauke@hauke-m.de> (sfid-20131124_222336_724352_E97C3162)
In-Reply-To: <1385328198-28520-1-git-send-email-hauke@hauke-m.de>
References: <1385328198-28520-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

There is some code for the mdio driver in backports, but it does not
get build on any kernel, just remove it till someone wants to make it
work.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/mdio.h |   17 -----------------
 copy-list                              |    3 ---
 2 files changed, 20 deletions(-)
 delete mode 100644 backport/backport-include/linux/mdio.h

diff --git a/backport/backport-include/linux/mdio.h b/backport/backport-include/linux/mdio.h
deleted file mode 100644
index 888bfee..0000000
--- a/backport/backport-include/linux/mdio.h
+++ /dev/null
@@ -1,17 +0,0 @@
-#ifndef __BACKPORT_LINUX_MDIO_H
-#define __BACKPORT_LINUX_MDIO_H
-#include_next <linux/mdio.h>
-#include <linux/version.h>
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,31)
-#define mdio45_probe LINUX_BACKPORT(mdio45_probe)
-#define mdio_set_flag LINUX_BACKPORT(mdio_set_flag)
-#define mdio45_links_ok LINUX_BACKPORT(mdio45_links_ok)
-#define mdio45_nway_restart LINUX_BACKPORT(mdio45_nway_restart)
-
-#define mdio45_ethtool_gset_npage LINUX_BACKPORT(mdio45_ethtool_gset_npage)
-#define mdio45_ethtool_spauseparam_an LINUX_BACKPORT(mdio45_ethtool_spauseparam_an)
-#define mdio_mii_ioctl LINUX_BACKPORT(mdio_mii_ioctl)
-#endif
-
-#endif /* __BACKPORT_LINUX_MDIO_H */
diff --git a/copy-list b/copy-list
index 5b9ad1e..4a1afeb 100644
--- a/copy-list
+++ b/copy-list
@@ -90,9 +90,6 @@ drivers/bluetooth/
 # Ethernet drivers
 drivers/net/ethernet/Kconfig
 drivers/net/ethernet/Makefile
-drivers/net/mdio.c
-include/linux/mdio.h
-include/uapi/linux/mdio.h
 
 drivers/net/ethernet/atheros/
 
-- 
1.7.10.4

