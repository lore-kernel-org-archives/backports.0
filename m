Return-path: <backports-owner@vger.kernel.org>
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:45732 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751565AbeD3LQE (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 30 Apr 2018 07:16:04 -0400
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: backports@vger.kernel.org
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [PATCH 2/3] backport-include: add ETH_P_PREAUTH definition in if_ether.h
Date: Mon, 30 Apr 2018 13:15:45 +0200
Message-Id: <1525086946-6352-3-git-send-email-arend.vanspriel@broadcom.com> (sfid-20180430_131606_030789_8AAEA1BF)
In-Reply-To: <1525086946-6352-1-git-send-email-arend.vanspriel@broadcom.com>
References: <1525086946-6352-1-git-send-email-arend.vanspriel@broadcom.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This macro definition was added in 4.17-rc1 and used by mac80211
so add it to backport.

Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
 backport/backport-include/linux/if_ether.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/backport/backport-include/linux/if_ether.h b/backport/backport-include/linux/if_ether.h
index 55862ce..344480a 100644
--- a/backport/backport-include/linux/if_ether.h
+++ b/backport/backport-include/linux/if_ether.h
@@ -39,6 +39,10 @@
 #define ETH_P_8021AD	0x88A8          /* 802.1ad Service VLAN		*/
 #endif
 
+#ifndef ETH_P_PREAUTH
+#define ETH_P_PREAUTH   0x88C7          /* 802.11 Preauthentication */
+#endif
+
 #ifndef ETH_MIN_MTU
 #define ETH_MIN_MTU	68
 #endif
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
