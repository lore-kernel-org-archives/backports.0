Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29422C4167D
	for <backports@archiver.kernel.org>; Tue, 11 Oct 2022 21:05:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbiJKVFZ (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 11 Oct 2022 17:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbiJKVFF (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 11 Oct 2022 17:05:05 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C123BC5E
        for <backports@vger.kernel.org>; Tue, 11 Oct 2022 14:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=CX/MeFfjTRrBYQI+rBb829O5OUJ0QSDPKH0WmwdIaWg=;
        t=1665522301; x=1666731901; b=uonHuC8mRYxIFT3ILx/zTzi3HSIWQ31T6SLXgG8Kc4UywvC
        hHvWraRl/AxNUnJVMk3T0pAkL+XYGHOlL4ff1OiNNkji5RfUPJSmSqzeUN/JDMNf3IljfUJpGA53l
        1LdtgIjSNlOsRon4X3LbLhnxSbhbdh4gZpT9TMn/YmVpGUa6hEhCTdo6xKrbP1NNDvKVcgcIi0wiQ
        LQnxYznvm0AcH76YlAK61HIbMNuQZnHXHlnP1qZVW6l5tSYzjMdtKk3oZ9+AycdJ7fKuzhQOWgQZP
        sKr+6C3vc4rh8T2lzdCFLdWNPuOgP0yD4/TZ4lVmedKU7XGUQCURv78Emzv7P19w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oiMQt-0045LP-0V;
        Tue, 11 Oct 2022 23:04:59 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     backports@vger.kernel.org
Cc:     nbd@nbd.name, Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 35/38] backports: don't backport some SKB functions for RHEL 7.6
Date:   Tue, 11 Oct 2022 23:04:43 +0200
Message-Id: <20221011230356.7f90a91853fe.Ife1d5e9e20f120283490bf771f7c71d111c4fef3@changeid>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221011210446.144768-1-johannes@sipsolutions.net>
References: <20221011210446.144768-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

For RHEL 7.6 these were backported, so don't do it again.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/skbuff.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/backport/backport-include/linux/skbuff.h b/backport/backport-include/linux/skbuff.h
index 376dd5942a34..419629e5d962 100644
--- a/backport/backport-include/linux/skbuff.h
+++ b/backport/backport-include/linux/skbuff.h
@@ -21,7 +21,8 @@ static inline void skb_postpush_rcsum(struct sk_buff *skb,
 }
 #endif /* LINUX_VERSION_IS_LESS(4,4,10) */
 
-#if LINUX_VERSION_IS_LESS(4,13,0)
+#if LINUX_VERSION_IS_LESS(4,13,0) && \
+	RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
 static inline void *backport_skb_put(struct sk_buff *skb, unsigned int len)
 {
 	return skb_put(skb, len);
-- 
2.37.3

--
To unsubscribe from this list: send the line "unsubscribe backports" in
