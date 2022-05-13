Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E673C43219
	for <backports@archiver.kernel.org>; Fri, 13 May 2022 16:06:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382315AbiEMQGK (ORCPT <rfc822;backports@archiver.kernel.org>);
        Fri, 13 May 2022 12:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382321AbiEMQGJ (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 13 May 2022 12:06:09 -0400
Received: from web.adapt-ip.com (mail.adapt-ip.com [107.194.246.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B33F2E92
        for <backports@vger.kernel.org>; Fri, 13 May 2022 09:06:07 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id 854416E3A74;
        Fri, 13 May 2022 16:06:07 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id 29YSJ0UwyDCD; Fri, 13 May 2022 16:06:05 +0000 (UTC)
Received: from atlas.campbell.adapt-ip.com (c-73-162-155-239.hsd1.ca.comcast.net [73.162.155.239])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id 40D246E3A76;
        Fri, 13 May 2022 16:05:31 +0000 (UTC)
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     backports <backports@vger.kernel.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Thomas Pedersen <thomas@adapt-ip.com>
Subject: [PATCH v2 15/15] patches: fixup skb list patch
Date:   Fri, 13 May 2022 09:05:23 -0700
Message-Id: <20220513160523.2944694-16-thomas@adapt-ip.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220513160523.2944694-1-thomas@adapt-ip.com>
References: <20220513160523.2944694-1-thomas@adapt-ip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

4.19 does indeed add skb->list, but skb_list_del_init()
was not added until 4.20. This patch fixes builds against
4.19. Tested with backported v5.15.33.

Signed-off-by: Thomas Pedersen <thomas@adapt-ip.com>
---
 patches/0097-skb-list/mac80211-rx.patch | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/patches/0097-skb-list/mac80211-rx.patch b/patches/0097-skb-list/mac80211-rx.patch
index 65189dd94e52..1cad4f8ac30b 100644
--- a/patches/0097-skb-list/mac80211-rx.patch
+++ b/patches/0097-skb-list/mac80211-rx.patch
@@ -99,14 +99,19 @@ the older kernel instead. The list attributes where also backported to
  
  
  	/*
-@@ -5005,8 +5027,13 @@ void ieee80211_rx_napi(struct ieee80211_
+@@ -5005,8 +5027,18 @@ void ieee80211_rx_napi(struct ieee80211_
  		return;
  	}
  
 +#if LINUX_VERSION_IS_GEQ(4,19,0)
  	list_for_each_entry_safe(skb, tmp, &list, list) {
++#if LINUX_VERSION_IS_GEQ(4,20,0)
  		skb_list_del_init(skb);
 +#else
++		__list_del_entry(&skb->list);
++		skb_mark_not_on_list(skb);
++#endif
++#else
 +	skb_queue_walk_safe(&list, skb, tmp) {
 +		__skb_unlink(skb, &list);
 +#endif
-- 
2.30.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
