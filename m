Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:35570 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751502AbbKOP5O (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 15 Nov 2015 10:57:14 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 11/15] patches: add forward declaration of struct wpan_dev to cfg802154.h
Date: Sun, 15 Nov 2015 16:56:55 +0100
Message-Id: <1447603019-11862-12-git-send-email-hauke@hauke-m.de> (sfid-20151115_171409_380961_F45FF70C)
In-Reply-To: <1447603019-11862-1-git-send-email-hauke@hauke-m.de>
References: <1447603019-11862-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Normally this forward declaration is coming from netdevice.h, but it
was only added in more recent kernel versions there. This patch fixes
the build with older kernel versions.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../network/0013-fix-makefile-includes/cfg802154.patch         | 10 ++++++++++
 1 file changed, 10 insertions(+)
 create mode 100644 patches/collateral-evolutions/network/0013-fix-makefile-includes/cfg802154.patch

diff --git a/patches/collateral-evolutions/network/0013-fix-makefile-includes/cfg802154.patch b/patches/collateral-evolutions/network/0013-fix-makefile-includes/cfg802154.patch
new file mode 100644
index 0000000..93caa14
--- /dev/null
+++ b/patches/collateral-evolutions/network/0013-fix-makefile-includes/cfg802154.patch
@@ -0,0 +1,10 @@
+--- a/include/net/cfg802154.h
++++ b/include/net/cfg802154.h
+@@ -26,6 +26,7 @@
+ 
+ struct wpan_phy;
+ struct wpan_phy_cca;
++struct wpan_dev;
+ 
+ #ifdef CONFIG_IEEE802154_NL802154_EXPERIMENTAL
+ struct ieee802154_llsec_device_key;
-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
