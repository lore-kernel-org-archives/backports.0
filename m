Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 022BAC4332F
	for <backports@archiver.kernel.org>; Tue, 11 Oct 2022 21:05:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbiJKVFR (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 11 Oct 2022 17:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiJKVFC (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 11 Oct 2022 17:05:02 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C83633362
        for <backports@vger.kernel.org>; Tue, 11 Oct 2022 14:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=3LH2ZhFqiCbhKAI4rzfUcE6yjIBBp1kR8qSrkW96hYc=;
        t=1665522299; x=1666731899; b=rdNcx/GU8vq8PnvsmstUeGbN7PpxmMhAQmwkLPj+T6UZngQ
        TazaytnI0vSnvHwJ7VvQyML8kcmEq+PdD7qRarcE6CKJzGEfVubHopiS6VJs1LPQ40SnRxivr766C
        lj1pbl7iGQM4nNDpmmO+ZgNpJfkIw5nDScMf/bn9dGIX4CR9mpvEPS53KcIuPN7bTkN/FcgjHv/SI
        Wd39CnRxfgYCO5iigmPzvvYhsK9Dy4DT/bU82wiXoB8SJifklmCGpEgrUWDgA/Z4Lkw9SxCNoLk8Y
        O3Vin+q2BX4I0mj2jJqBiC0IyIaBSqVznLRxu/DS51VwsLqWY/De2z3eBTrMIYlg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oiMQq-0045LP-1W;
        Tue, 11 Oct 2022 23:04:56 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     backports@vger.kernel.org
Cc:     nbd@nbd.name, Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 27/38] backports: add skb_list_del_init()
Date:   Tue, 11 Oct 2022 23:04:35 +0200
Message-Id: <20221011230356.d6110fa27c22.I5a46230bc9c575b716597267e0b7b455600e05b6@changeid>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221011210446.144768-1-johannes@sipsolutions.net>
References: <20221011210446.144768-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

This got backported to 4.19.10, but we use it for >= 4.19.0,
so provide a backported version for < 4.19.10.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/skbuff.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/backport/backport-include/linux/skbuff.h b/backport/backport-include/linux/skbuff.h
index 79cff7afd73a..fc99b5bb7513 100644
--- a/backport/backport-include/linux/skbuff.h
+++ b/backport/backport-include/linux/skbuff.h
@@ -85,8 +85,16 @@ static inline void skb_mark_not_on_list(struct sk_buff *skb)
 {
 	skb->next = NULL;
 }
+#endif /* 4.19.10 <= x < 4.20 || 4.14.217 <= x < 4.15 */
+
+#if !LINUX_VERSION_IN_RANGE(4,19,10, 4,20,0)
+static inline void skb_list_del_init(struct sk_buff *skb)
+{
+	__list_del_entry((struct list_head *)&skb->next);
+	skb_mark_not_on_list(skb);
+}
 #endif /* 4.19.10 <= x < 4.20 */
-#endif
+#endif /* < 4.20 */
 
 #if LINUX_VERSION_IS_LESS(4,11,0)
 #define skb_mac_offset LINUX_BACKPORT(skb_mac_offset)
-- 
2.37.3

--
To unsubscribe from this list: send the line "unsubscribe backports" in
