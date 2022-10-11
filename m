Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C77FEC43217
	for <backports@archiver.kernel.org>; Tue, 11 Oct 2022 21:05:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbiJKVFZ (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 11 Oct 2022 17:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiJKVFB (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 11 Oct 2022 17:05:01 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF89F2A408
        for <backports@vger.kernel.org>; Tue, 11 Oct 2022 14:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=+spowWmJGP7Tb6jler2ZD0aHFj4mTyVoxPCkn70LkN0=;
        t=1665522297; x=1666731897; b=EimImU8kRlGCyN0Bxumv3DRj7BD59kdejnkBmRIZc0GNhCe
        e3kXJ87lw92UvFI+ClBrkRm6RjjJqTyjOrgJOz6ZhVAZTYtkLBW78reXspS0h/dwsTjcQq8I6Aq7J
        rh67C9f9NuVwOTiVjtSq3LczckVQGm17x2bVUkk7a83J5lO036+WqRl7eKguPcTMUhGONLnORHcZJ
        7MJHUoavxAxXY62SFC7drAigZllloQ0DH/pjS5RZqSOUmILQQinvcmm7aeJlrgMI+Z8uR2UgkcgKQ
        WN1+q2FD/lX+zuA8L0NdRJ0RxCvfS8oZGyQ/jIx3o9PtI/nZsTEj6WyWEDm55lSw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oiMQp-0045LP-0n;
        Tue, 11 Oct 2022 23:04:55 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     backports@vger.kernel.org
Cc:     nbd@nbd.name, Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 23/38] backports: add lockdep_is_held() when needed
Date:   Tue, 11 Oct 2022 23:04:31 +0200
Message-Id: <20221011230356.d88d290ba089.I013e3ab4f0cfe836d7ff96ae3d68508e55987333@changeid>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221011210446.144768-1-johannes@sipsolutions.net>
References: <20221011210446.144768-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

If lockdep is not enabled and lockdep_is_held() not already defined
as a macro, declare it as an inline just like upstream does now.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/lockdep.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/backport/backport-include/linux/lockdep.h b/backport/backport-include/linux/lockdep.h
index 842e24b7ff8f..8295b0d49184 100644
--- a/backport/backport-include/linux/lockdep.h
+++ b/backport/backport-include/linux/lockdep.h
@@ -9,6 +9,13 @@ struct lockdep_map { };
 #endif /* CONFIG_LOCKDEP */
 #endif /* LINUX_VERSION_IS_LESS(4,15,0) */
 
+#if LINUX_VERSION_IS_LESS(5,11,0)
+#if !defined(CONFIG_LOCKDEP) && !defined(lockdep_is_held)
+/* upstream since 5.11 in this exact same way - calls compile away */
+int lockdep_is_held(const void *);
+#endif
+#endif
+
 #ifndef lockdep_assert_not_held
 #ifdef CONFIG_LOCKDEP
 #ifndef LOCK_STATE_HELD
-- 
2.37.3

--
To unsubscribe from this list: send the line "unsubscribe backports" in
