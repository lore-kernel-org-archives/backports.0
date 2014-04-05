Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pb0-f43.google.com ([209.85.160.43]:57438 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752375AbaDEMl6 (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 5 Apr 2014 08:41:58 -0400
Received: by mail-pb0-f43.google.com with SMTP id um1so4671671pbc.2
        for <backports@vger.kernel.org>; Sat, 05 Apr 2014 05:41:58 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	Pravin B Shelar <pshelar@nicira.com>
Subject: [PATCH 10/27] backports: backport skb_unclone()
Date: Sat,  5 Apr 2014 05:40:44 -0700
Message-Id: <1396701662-15165-11-git-send-email-mcgrof@do-not-panic.com> (sfid-20140405_144450_452383_5666FCF2)
In-Reply-To: <1396701662-15165-1-git-send-email-mcgrof@do-not-panic.com>
References: <1396701662-15165-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Pravin added this via commit 14bbd6a565 through v3.9. This is
a straight forward backport using the LINUX_BACKPORT() namespace.

mcgrof@ergon ~/linux-next (git::master)$ git describe --contains 14bbd6a565
v3.9-rc1~139^2~56

commit 14bbd6a565e1bcdc240d44687edb93f721cfdf99
Author: Pravin B Shelar <pshelar@nicira.com>
Date:   Thu Feb 14 09:44:49 2013 +0000

    net: Add skb_unclone() helper function.

    This function will be used in next GRE_GSO patch. This patch does
    not change any functionality.

    Signed-off-by: Pravin B Shelar <pshelar@nicira.com>
    Acked-by: Eric Dumazet <edumazet@google.com>

Cc: Pravin B Shelar <pshelar@nicira.com>
Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 backport/backport-include/linux/skbuff.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/backport/backport-include/linux/skbuff.h b/backport/backport-include/linux/skbuff.h
index 7ea44f5..2a63e95 100644
--- a/backport/backport-include/linux/skbuff.h
+++ b/backport/backport-include/linux/skbuff.h
@@ -300,4 +300,15 @@ static inline struct page *__skb_alloc_page(gfp_t gfp_mask,
 #endif
 #endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0) */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0)
+#define skb_unclone LINUX_BACKPORT(skb_unclone)
+static inline int skb_unclone(struct sk_buff *skb, gfp_t pri)
+{
+	might_sleep_if(pri & __GFP_WAIT);
+	if (skb_cloned(skb))
+		return pskb_expand_head(skb, 0, 0, pri);
+       return 0;
+}
+#endif
+
 #endif /* __BACKPORT_SKBUFF_H */
-- 
1.8.5.3

