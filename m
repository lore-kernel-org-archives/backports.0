Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66778C43217
	for <backports@archiver.kernel.org>; Tue, 11 Oct 2022 21:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbiJKVFV (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 11 Oct 2022 17:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiJKVFC (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 11 Oct 2022 17:05:02 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE60356EA
        for <backports@vger.kernel.org>; Tue, 11 Oct 2022 14:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=jqtlIJu3rlSxP1Ctg8AsmOPy1o0PYC43Mz/v8BWfJ6Q=;
        t=1665522299; x=1666731899; b=XanfZAsVb1zD3pnmFz5+L+BxD5t2yZ1kNgVk48No2kzp3an
        p9pl6QJX6tu/6dTtq9ToWL0FEUz+qc6meWC26UofkrYGS7T4kOqT9RJbh+akQczqmQfVMzfZ2EWWf
        pdnA/KLBN0bhLzofYQcXW+Ek4HGV5Aak0b/YXJoynGghess/cf0jDLjdTR33Y4nLQ15MQRnIxAUGv
        zxp9sAnQJf7X4xYAFIuhE3eKAyJ4hMRJVxJ2AXoGAMPLFr2Yuu1uvBG4dSGLTy69sBIqWjYodkiqf
        RhxWspdKviAkiK9g+fM7LXi2mmEBNdB28gWKwhyZs2YHt6wkASEv3v7wJnXJXGyQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oiMQq-0045LP-30;
        Tue, 11 Oct 2022 23:04:57 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     backports@vger.kernel.org
Cc:     nbd@nbd.name, Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 28/38] backports: update skb kcov ifdef
Date:   Tue, 11 Oct 2022 23:04:36 +0200
Message-Id: <20221011230356.dfc7c2811ea7.I96fb26c6080e6f75909fafab5de38ccd255ff6f2@changeid>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221011210446.144768-1-johannes@sipsolutions.net>
References: <20221011210446.144768-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

This got backported to 5.10.54 so need to update the ifdef.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/skbuff.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/backport/backport-include/linux/skbuff.h b/backport/backport-include/linux/skbuff.h
index fc99b5bb7513..376dd5942a34 100644
--- a/backport/backport-include/linux/skbuff.h
+++ b/backport/backport-include/linux/skbuff.h
@@ -148,7 +148,7 @@ static inline __u32 skb_queue_len_lockless(const struct sk_buff_head *list_)
 }
 #endif /* < 5.6.0 */
 
-#if LINUX_VERSION_IS_LESS(5,11,0)
+#if LINUX_VERSION_IS_LESS(5,10,54)
 #define skb_get_kcov_handle LINUX_BACKPORT(skb_get_kcov_handle)
 static inline u64 skb_get_kcov_handle(struct sk_buff *skb)
 {
-- 
2.37.3

--
To unsubscribe from this list: send the line "unsubscribe backports" in
