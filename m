Return-path: <backports-owner@vger.kernel.org>
Received: from paleale.coelho.fi ([176.9.41.70]:51040 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727029AbeITRMH (ORCPT
        <rfc822;backports@vger.kernel.org>); Thu, 20 Sep 2018 13:12:07 -0400
From: Luca Coelho <luca@coelho.fi>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>
Date: Thu, 20 Sep 2018 14:28:39 +0300
Message-Id: <20180920112842.27198-12-luca@coelho.fi> (sfid-20180920_132906_182119_A098F443)
In-Reply-To: <20180920112842.27198-1-luca@coelho.fi>
References: <20180920112842.27198-1-luca@coelho.fi>
Subject: [PATCH 11/14] backports: improve skb->xmit_more handling
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

Replace the existing skb->xmit_more semantic patch rule with a more
generic one that uses a helper inline function.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 backport/backport-include/linux/skbuff.h          |  9 +++++++++
 patches/0059-skb_xmit_more/skb_no_xmit_more.cocci | 10 +++-------
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/backport/backport-include/linux/skbuff.h b/backport/backport-include/linux/skbuff.h
index 034206b6649d..61133c4277cc 100644
--- a/backport/backport-include/linux/skbuff.h
+++ b/backport/backport-include/linux/skbuff.h
@@ -200,6 +200,15 @@ static inline struct sk_buff *__pskb_copy_fclone(struct sk_buff *skb,
 struct sk_buff *skb_clone_sk(struct sk_buff *skb);
 #endif
 
+static inline bool skb_xmit_more(struct sk_buff *skb)
+{
+#if LINUX_VERSION_IS_LESS(3,18,0)
+	return false;
+#else
+	return skb->xmit_more;
+#endif
+}
+
 #if LINUX_VERSION_IS_LESS(3,19,0)
 /**
  * __dev_alloc_pages - allocate page for network Rx
diff --git a/patches/0059-skb_xmit_more/skb_no_xmit_more.cocci b/patches/0059-skb_xmit_more/skb_no_xmit_more.cocci
index ab20c833af40..bf7f22e267a3 100644
--- a/patches/0059-skb_xmit_more/skb_no_xmit_more.cocci
+++ b/patches/0059-skb_xmit_more/skb_no_xmit_more.cocci
@@ -1,9 +1,5 @@
-@r1@
+@@
 struct sk_buff *skb;
-expression E1;
 @@
- if (E1
-+#if LINUX_VERSION_IS_GEQ(3,18,0)
- || !skb->xmit_more
-+#endif /* if LINUX_VERSION_IS_GEQ(3,18,0) */
- ) {...}
+-skb->xmit_more
++skb_xmit_more(skb)
-- 
2.18.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
