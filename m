Return-path: <backports-owner@vger.kernel.org>
Received: from paleale.coelho.fi ([176.9.41.70]:47070 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750704AbdIEGup (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 5 Sep 2017 02:50:45 -0400
From: Luca Coelho <luca@coelho.fi>
To: backports@vger.kernel.org
Cc: Luca Coelho <luciano.coelho@intel.com>
Date: Tue,  5 Sep 2017 09:50:39 +0300
Message-Id: <20170905065039.25808-1-luca@coelho.fi> (sfid-20170905_085047_421946_CCC9B604)
Subject: [PATCH] backport: fix netdev destructor backport for v4.11.9
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Luca Coelho <luciano.coelho@intel.com>

The patch that changed the netdev destructor code was backported to
v4.11.9, so handle that in the backport.

Change-Id: I21a64c84d1c46771d9436341537d946e5ae64c1b
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 backport/backport-include/linux/netdevice.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/backport/backport-include/linux/netdevice.h b/backport/backport-include/linux/netdevice.h
index d22eec2d3113..112bcf2b1c15 100644
--- a/backport/backport-include/linux/netdevice.h
+++ b/backport/backport-include/linux/netdevice.h
@@ -320,7 +320,8 @@ static inline void netif_trans_update(struct net_device *dev)
 }
 #endif
 
-#if LINUX_VERSION_IS_LESS(4,12,0)
+#if LINUX_VERSION_IS_LESS(4,12,0) &&		\
+	!LINUX_VERSION_IN_RANGE(4,11,9, 4,12,0)
 #define netdev_set_priv_destructor(_dev, _destructor) \
 	(_dev)->destructor = __ ## _destructor
 #define netdev_set_def_destructor(_dev) \
-- 
2.14.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
