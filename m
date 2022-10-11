Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 576ECC433FE
	for <backports@archiver.kernel.org>; Tue, 11 Oct 2022 21:05:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiJKVFT (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 11 Oct 2022 17:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiJKVFB (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 11 Oct 2022 17:05:01 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A681B32B94
        for <backports@vger.kernel.org>; Tue, 11 Oct 2022 14:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=mo6diquA8xcfcBVUmpdy7XLkyER8j5p1rjYnAj82o/o=;
        t=1665522298; x=1666731898; b=P8bdGi5rIkzf3dS2qzfx+W6o9X4+vxjpj6iKteIit1xvH8J
        KiPykSzBexUgAzBgK09SnDeBnv1x81b622V4YF3tCI5jPbp4f4S4Rt6iE/mqrN5v8uHCmsYfRhxyO
        F2/qMUhLiZDRQWR6yOxzcMcQrnYsuPuHgjhTlA0vLPMW3nRyZh3y9EGbg78nYCAFybw11hF3NyeB8
        JSfBrdrkdS5RR6WalnZU2OO7k+JIWJLmfucOXavr8BJT0GSO2H4svfwvvwIyq8rAagHzhYZzdyCb9
        LroMp8nNMueFlyIwFdyNHcPB6cXaZ3sgR7tSzG/NKxO2uf+ef79EEd4EzBjdTgpg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oiMQq-0045LP-0F;
        Tue, 11 Oct 2022 23:04:56 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     backports@vger.kernel.org
Cc:     nbd@nbd.name, Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 26/38] backports: add skb_postpush_rcsum()
Date:   Tue, 11 Oct 2022 23:04:34 +0200
Message-Id: <20221011230356.a46baa44bd00.Iac7dddba17673fed03773ee928383cdf59718f5f@changeid>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221011210446.144768-1-johannes@sipsolutions.net>
References: <20221011210446.144768-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/skbuff.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/backport/backport-include/linux/skbuff.h b/backport/backport-include/linux/skbuff.h
index c5015e9def24..79cff7afd73a 100644
--- a/backport/backport-include/linux/skbuff.h
+++ b/backport/backport-include/linux/skbuff.h
@@ -4,6 +4,23 @@
 #include <linux/version.h>
 
 
+#if LINUX_VERSION_IS_LESS(4,4,10)
+static __always_inline void
+__skb_postpush_rcsum(struct sk_buff *skb, const void *start, unsigned int len,
+		     unsigned int off)
+{
+	if (skb->ip_summed == CHECKSUM_COMPLETE)
+		skb->csum = csum_block_add(skb->csum,
+					   csum_partial(start, len, 0), off);
+}
+
+static inline void skb_postpush_rcsum(struct sk_buff *skb,
+				      const void *start, unsigned int len)
+{
+	__skb_postpush_rcsum(skb, start, len, 0);
+}
+#endif /* LINUX_VERSION_IS_LESS(4,4,10) */
+
 #if LINUX_VERSION_IS_LESS(4,13,0)
 static inline void *backport_skb_put(struct sk_buff *skb, unsigned int len)
 {
-- 
2.37.3

--
To unsubscribe from this list: send the line "unsubscribe backports" in
