Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:58345 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752388AbaASQsQ (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 19 Jan 2014 11:48:16 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 07/16] backports: fix header of phy_mii_ioctl()
Date: Sun, 19 Jan 2014 17:47:28 +0100
Message-Id: <1390150057-11652-8-git-send-email-hauke@hauke-m.de> (sfid-20140119_174818_034475_F28A8630)
In-Reply-To: <1390150057-11652-1-git-send-email-hauke@hauke-m.de>
References: <1390150057-11652-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On kernel versions < 2.6.36 phy_mii_ioctl() gets struct mii_ioctl_data
as second parameter and on more recent kernel versions it takes struct
ifreq. This patch converts one version to the other.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/phy.h |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/backport/backport-include/linux/phy.h b/backport/backport-include/linux/phy.h
index 4473e4e..ff2aacf 100644
--- a/backport/backport-include/linux/phy.h
+++ b/backport/backport-include/linux/phy.h
@@ -8,4 +8,14 @@
 	phy_connect(dev, bus_id, handler, 0, interface)
 #endif
 
+#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,36))
+#include <linux/mii.h>
+static inline int backport_phy_mii_ioctl(struct phy_device *phydev,
+					 struct ifreq *ifr, int cmd)
+{
+	return phy_mii_ioctl(phydev, if_mii(ifr), cmd);
+}
+#define phy_mii_ioctl LINUX_BACKPORT(phy_mii_ioctl)
+#endif
+
 #endif /* __BACKPORT_LINUX_PHY_H */
-- 
1.7.10.4

