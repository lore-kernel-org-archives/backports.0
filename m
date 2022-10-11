Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32DBAC4332F
	for <backports@archiver.kernel.org>; Tue, 11 Oct 2022 21:05:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiJKVFC (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 11 Oct 2022 17:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiJKVE7 (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 11 Oct 2022 17:04:59 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8D820366
        for <backports@vger.kernel.org>; Tue, 11 Oct 2022 14:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=HTojVczOqNpdUuO6HihcRRSuLa1fJio1fhA6mEj3t/4=;
        t=1665522295; x=1666731895; b=Aa1Zt0a01GGjvTwq6e1NDsq/tR4/lw9Hz1Cr6SAfcUjLKTN
        5vFTl2F2to8/E8tiPRDJ6SzlTAp/qYFsISbqk/Gcmf1JbOZa9buXK6XbFC1K2dQv2MuioQF9nhsg3
        PWQM9qcDoJPYMTfWp3c/xedHWhVlJr/5nOyXxp46kHE528g1Q/uRAA1uZaVcNkE8msG0zkoEqde8x
        aL31nZJGL8+aFNF2vBknKgrAgPcg9KYDxpZftOjJQyTVVNXdxszdXEDdcItEYK8MyUiqYPzwbfrU5
        g5A+S4fT3qkBrO6NZ7F044g+iyvauDM4P6n8Tgp7yYrqvXQYeZS0td12SJEzah1A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oiMQl-0045LP-3C;
        Tue, 11 Oct 2022 23:04:52 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     backports@vger.kernel.org
Cc:     nbd@nbd.name, Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 12/38] backports: add memset_after/memset_startat
Date:   Tue, 11 Oct 2022 23:04:20 +0200
Message-Id: <20221011230356.04e4d975f11d.I22eae0fdc7b78cf10a7dee6fe477fbf0c9a5e807@changeid>
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
 backport/backport-include/linux/string.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/backport/backport-include/linux/string.h b/backport/backport-include/linux/string.h
index 39257e5f66ab..dc29dcf72b24 100644
--- a/backport/backport-include/linux/string.h
+++ b/backport/backport-include/linux/string.h
@@ -12,4 +12,24 @@ extern void *memdup_user_nul(const void __user *, size_t);
 int match_string(const char * const *array, size_t n, const char *string);
 #endif /* LINUX_VERSION_IS_LESS(4,5,0) */
 
+#ifndef memset_after
+#define memset_after(obj, v, member)					\
+({									\
+	u8 *__ptr = (u8 *)(obj);					\
+	typeof(v) __val = (v);						\
+	memset(__ptr + offsetofend(typeof(*(obj)), member), __val,	\
+	       sizeof(*(obj)) - offsetofend(typeof(*(obj)), member));	\
+})
+#endif
+
+#ifndef memset_startat
+#define memset_startat(obj, v, member)					\
+({									\
+	u8 *__ptr = (u8 *)(obj);					\
+	typeof(v) __val = (v);						\
+	memset(__ptr + offsetof(typeof(*(obj)), member), __val,		\
+	       sizeof(*(obj)) - offsetof(typeof(*(obj)), member));	\
+})
+#endif
+
 #endif /* __BACKPORT_LINUX_STRING_H */
-- 
2.37.3

--
To unsubscribe from this list: send the line "unsubscribe backports" in
