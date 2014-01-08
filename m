Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:46693 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753751AbaAHAfB (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 7 Jan 2014 19:35:01 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 05/17] backports: fix number of arguments of phy_connect()
Date: Wed,  8 Jan 2014 01:34:22 +0100
Message-Id: <1389141274-2002-6-git-send-email-hauke@hauke-m.de> (sfid-20140108_013503_864592_DE8FCFD1)
In-Reply-To: <1389141274-2002-1-git-send-email-hauke@hauke-m.de>
References: <1389141274-2002-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The flags argument was removed from phy_connect in this commit:

commit f9a8f83b04e0c362a2fc660dbad980d24af209fc
Author: Florian Fainelli <florian@openwrt.org>
Date:   Mon Jan 14 00:52:52 2013 +0000

    net: phy: remove flags argument from phy_{attach, connect, connect_direct}

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/phy.h |   11 +++++++++++
 1 file changed, 11 insertions(+)
 create mode 100644 backport/backport-include/linux/phy.h

diff --git a/backport/backport-include/linux/phy.h b/backport/backport-include/linux/phy.h
new file mode 100644
index 0000000..4473e4e
--- /dev/null
+++ b/backport/backport-include/linux/phy.h
@@ -0,0 +1,11 @@
+#ifndef __BACKPORT_LINUX_PHY_H
+#define __BACKPORT_LINUX_PHY_H
+#include_next <linux/phy.h>
+#include <linux/version.h>
+
+#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0))
+#define phy_connect(dev, bus_id, handler, interface) \
+	phy_connect(dev, bus_id, handler, 0, interface)
+#endif
+
+#endif /* __BACKPORT_LINUX_PHY_H */
-- 
1.7.10.4

