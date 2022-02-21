Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA4C6C433EF
	for <backports@archiver.kernel.org>; Mon, 21 Feb 2022 14:11:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240412AbiBUOMT (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 21 Feb 2022 09:12:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354822AbiBUOMQ (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 21 Feb 2022 09:12:16 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079BE1EACE
        for <backports@vger.kernel.org>; Mon, 21 Feb 2022 06:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=hloev+emqP0hev3mO1C+xMNfS5DHp35/7ftJb7wY7Gs=;
        t=1645452713; x=1646662313; b=r8rmkHwF89/vGSzACbF3sdTyLfiWFiYGLSerUnALOnETB4J
        +hq2czNSHysFbhFCW1qhPOzzytjg8U4g4lo+KUmYLTU8W2fUhkGSnL8TBUzOHoOkuVCiewDfE4++Y
        qLemW8kAW0EJEnK4uekA9K9tFai+bvGyK4AsMy43gSjxFHM7uVTZ3rSJnsfHLYghhQ77K+5rzvZco
        c/Q4xEJyoFcBY5jRsTxo82bqrPd42Cd9QLDCAQGuFrL3lrA5PgG3AgWaDSlpL7PIoz+qxG61TSk2G
        aaQXdpedFOVSZ36C5YkifXa+D8N7Vpl0tqQXMzaQLYihBWpiBIzmBXlKiISvX7Hg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nM9Pq-003r4r-Cy;
        Mon, 21 Feb 2022 15:11:50 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     backports@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 2/3] backports: add memset_after/memset_startat
Date:   Mon, 21 Feb 2022 15:11:46 +0100
Message-Id: <20220221151147.a5b2af9ae6e4.I22eae0fdc7b78cf10a7dee6fe477fbf0c9a5e807@changeid>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220221151147.f0ab663b932a.I59271805ee60501a03c50f5ec05240393f1fb4be@changeid>
References: <20220221151147.f0ab663b932a.I59271805ee60501a03c50f5ec05240393f1fb4be@changeid>
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
2.35.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
