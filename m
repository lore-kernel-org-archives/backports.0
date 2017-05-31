Return-path: <backports-owner@vger.kernel.org>
Received: from paleale.coelho.fi ([176.9.41.70]:60104 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751192AbdEaIa3 (ORCPT
        <rfc822;backports@vger.kernel.org>); Wed, 31 May 2017 04:30:29 -0400
From: Luca Coelho <luca@coelho.fi>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org
Date: Wed, 31 May 2017 11:30:10 +0300
Message-Id: <20170531083010.15135-1-luca@coelho.fi> (sfid-20170531_103045_781505_A7DA3108)
Subject: [PATCH] backports: add lockdep_rtnl_is_held() for < 3.13 without CONFIG_PROVE_LOCKING
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Luca Coelho <luciano.coelho@intel.com>

In kernels earlier than 3.13, lockdep_rtnl_is_held() is only declared
in rtnetlink.h when CONFIG_PROVE_LOCKING is not set.  Backport this
function if that's the case.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 backport/backport-include/linux/rtnetlink.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/backport/backport-include/linux/rtnetlink.h b/backport/backport-include/linux/rtnetlink.h
index 9b68be820049..59beffa8316a 100644
--- a/backport/backport-include/linux/rtnetlink.h
+++ b/backport/backport-include/linux/rtnetlink.h
@@ -18,4 +18,12 @@
 	ndo_dflt_fdb_add(ndm, tb, dev, addr, flags)
 #endif
 
+#if LINUX_VERSION_IS_LESS(3,13,0) &&		\
+	!defined(CONFIG_PROVE_LOCKING)
+static inline bool lockdep_rtnl_is_held(void)
+{
+	return true;
+}
+#endif
+
 #endif /* __BACKPORT_LINUX_RTNETLINK_H */
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
