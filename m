Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pb0-f54.google.com ([209.85.160.54]:60614 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752375AbaDEMlr (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 5 Apr 2014 08:41:47 -0400
Received: by mail-pb0-f54.google.com with SMTP id ma3so4633886pbc.41
        for <backports@vger.kernel.org>; Sat, 05 Apr 2014 05:41:47 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 08/27] backports: define ETH_P_80221
Date: Sat,  5 Apr 2014 05:40:42 -0700
Message-Id: <1396701662-15165-9-git-send-email-mcgrof@do-not-panic.com> (sfid-20140405_144148_741459_06D9289A)
In-Reply-To: <1396701662-15165-1-git-send-email-mcgrof@do-not-panic.com>
References: <1396701662-15165-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This is used by the bluetooth and ieee802154 subsystems later
and added via commit b62faf3c available on next-20140311.

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 backport/backport-include/linux/if_ether.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/backport/backport-include/linux/if_ether.h b/backport/backport-include/linux/if_ether.h
index d9a1464..e904001 100644
--- a/backport/backport-include/linux/if_ether.h
+++ b/backport/backport-include/linux/if_ether.h
@@ -2,6 +2,11 @@
 #define __BACKPORT_IF_ETHER_H
 #include_next <linux/if_ether.h>
 
+/* See commit b62faf3c in next-20140311 */
+#ifndef ETH_P_80221
+#define ETH_P_80221	0x8917	/* IEEE 802.21 Media Independent Handover Protocol */
+#endif
+
 /*
  * backport of:
  * commit e5c5d22e8dcf7c2d430336cbf8e180bd38e8daf1
-- 
1.8.5.3

