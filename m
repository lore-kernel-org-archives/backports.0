Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:47210 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752223AbaBJWst (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 10 Feb 2014 17:48:49 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 3/6] backports: add ETH_P_TEB and ETH_P_8021AD
Date: Mon, 10 Feb 2014 23:47:31 +0100
Message-Id: <1392072454-18538-4-git-send-email-hauke@hauke-m.de> (sfid-20140210_234850_358965_1B3F327B)
In-Reply-To: <1392072454-18538-1-git-send-email-hauke@hauke-m.de>
References: <1392072454-18538-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This is needed by net-core-flow_dissector.c.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/if_ether.h |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/backport/backport-include/linux/if_ether.h b/backport/backport-include/linux/if_ether.h
index 8581283..d9a1464 100644
--- a/backport/backport-include/linux/if_ether.h
+++ b/backport/backport-include/linux/if_ether.h
@@ -31,4 +31,12 @@ int mac_pton(const char *s, u8 *mac);
 #define ETH_P_PAE 0x888E      /* Port Access Entity (IEEE 802.1X) */
 #endif
 
+#ifndef ETH_P_TEB
+#define ETH_P_TEB	0x6558		/* Trans Ether Bridging		*/
+#endif
+
+#ifndef ETH_P_8021AD
+#define ETH_P_8021AD	0x88A8          /* 802.1ad Service VLAN		*/
+#endif
+
 #endif /* __BACKPORT_IF_ETHER_H */
-- 
1.7.10.4

