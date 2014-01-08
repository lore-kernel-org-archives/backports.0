Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:46835 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754370AbaAHAhT (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 7 Jan 2014 19:37:19 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 03/17] backports: add ARPHRD_6LOWPAN
Date: Wed,  8 Jan 2014 01:34:20 +0100
Message-Id: <1389141274-2002-4-git-send-email-hauke@hauke-m.de> (sfid-20140108_013722_431544_E1492ADC)
In-Reply-To: <1389141274-2002-1-git-send-email-hauke@hauke-m.de>
References: <1389141274-2002-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This adds ARPHRD_6LOWPAN to if_arp.h

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/if_arp.h |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/backport/backport-include/linux/if_arp.h b/backport/backport-include/linux/if_arp.h
index dbbea2d..b542423 100644
--- a/backport/backport-include/linux/if_arp.h
+++ b/backport/backport-include/linux/if_arp.h
@@ -7,4 +7,8 @@
 #define ARPHRD_IEEE802154_MONITOR 805	/* IEEE 802.15.4 network monitor */
 #endif
 
+#ifndef ARPHRD_6LOWPAN
+#define ARPHRD_6LOWPAN	825		/* IPv6 over LoWPAN             */
+#endif
+
 #endif /* _BACKPORTS_LINUX_AF_ARP_H */
-- 
1.7.10.4

