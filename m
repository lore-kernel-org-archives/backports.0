Return-Path: <SRS0=cdpY=BY=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C20C433E1
	for <backports@archiver.kernel.org>; Fri, 14 Aug 2020 14:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 241EE206B2
	for <backports@archiver.kernel.org>; Fri, 14 Aug 2020 14:17:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="oTVuW3jG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728332AbgHNORJ (ORCPT <rfc822;backports@archiver.kernel.org>);
        Fri, 14 Aug 2020 10:17:09 -0400
Received: from nbd.name ([46.4.11.11]:60386 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728072AbgHNORJ (ORCPT <rfc822;backports@vger.kernel.org>);
        Fri, 14 Aug 2020 10:17:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=3YyjcVIAj1+fiNkcdhKb5jeX++/WMHi673KmyN2LbZo=; b=oTVuW3jGLzDUbqOSjcahTydsNs
        qCF7UuYUHwsR1dXUszjUJnxCBBXhKKird+d1aI3rd6qzw2RCqasRWKNL8uP7TIvUWYkd3+AlyWmGo
        sJARal1g6xk66hsp9Z6UzwP+8k34d51rzMeh4PWLm7RCPlz8zMPYE8N4kiB/dSskdam4=;
Received: from p54ae996c.dip0.t-ipconnect.de ([84.174.153.108] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1k6aVv-0002Bj-Ue
        for backports@vger.kernel.org; Fri, 14 Aug 2020 16:17:00 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     backports@vger.kernel.org
Subject: [PATCH 2/2] backports: add skb_list_del_init
Date:   Fri, 14 Aug 2020 16:16:58 +0200
Message-Id: <20200814141658.5384-2-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200814141658.5384-1-nbd@nbd.name>
References: <20200814141658.5384-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

It will be needed by pending mac80211 changes

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 backport/backport-include/linux/skbuff.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/backport/backport-include/linux/skbuff.h b/backport/backport-include/linux/skbuff.h
index 3ed990d0d2ef..893df783a263 100644
--- a/backport/backport-include/linux/skbuff.h
+++ b/backport/backport-include/linux/skbuff.h
@@ -385,6 +385,12 @@ static inline void skb_mark_not_on_list(struct sk_buff *skb)
 	skb->next = NULL;
 }
 #endif /* 4.19.10 <= x < 4.20 */
+
+static inline void skb_list_del_init(struct sk_buff *skb)
+{
+	__list_del_entry(&skb->list);
+	skb_mark_not_on_list(skb);
+}
 #endif
 
 #if LINUX_VERSION_IS_LESS(4,11,0)
-- 
2.28.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
