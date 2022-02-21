Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F2D4C433FE
	for <backports@archiver.kernel.org>; Mon, 21 Feb 2022 14:12:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357838AbiBUOMV (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 21 Feb 2022 09:12:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377336AbiBUOMS (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 21 Feb 2022 09:12:18 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0DCC1EAD2
        for <backports@vger.kernel.org>; Mon, 21 Feb 2022 06:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=WjbUeLb7BSeI9OfRwZeFvuwMCGt3q3GTV0+XAm3tQQY=;
        t=1645452713; x=1646662313; b=HCNaAKT/n7c7JF7dY6ZjAXNaRAmkgLIH/6p3sQlz4pX5+Ol
        Wt6EkNCRS+539zFZ/mDsJYZVrrW998z9EUIK7yru3yF49SLAQH58/7Li75ROHjf+P7kCJjM4XuZmv
        dvh9ml5f1GU9C18JOwTCvYdi/wqTHqEZM6e0Rgt7KRGVtWWmuic4tzWGZnN+XpuZ2zQ58E6Io1hgb
        l5sN1SiBKiaC+A6+Zhej+HChlZ1QUC6yKsfg86KQUyYVcEmxDtiXMeZGPlyru8hZJf4tTsa9k8Q/H
        UA0PQyvMyzrTJ2e14mr72b55ncBPq+3jat/0nKdYBSYk2TVhIoBH0zqpMO/Q74Dw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nM9Pq-003r4r-LQ;
        Mon, 21 Feb 2022 15:11:50 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     backports@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 3/3] backports: add ktime_get_coarse_boottime_ns
Date:   Mon, 21 Feb 2022 15:11:47 +0100
Message-Id: <20220221151147.3fccada91a71.Id1c6b53e4c57d92eb838e4c09ef8042cd42f150f@changeid>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220221151147.f0ab663b932a.I59271805ee60501a03c50f5ec05240393f1fb4be@changeid>
References: <20220221151147.f0ab663b932a.I59271805ee60501a03c50f5ec05240393f1fb4be@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

... and simplify the code while at it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/timekeeping.h | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/backport/backport-include/linux/timekeeping.h b/backport/backport-include/linux/timekeeping.h
index 80c625569d6e..87744572bce6 100644
--- a/backport/backport-include/linux/timekeeping.h
+++ b/backport/backport-include/linux/timekeeping.h
@@ -6,23 +6,18 @@
 #include_next <linux/timekeeping.h>
 
 #if LINUX_VERSION_IS_LESS(5,3,0)
-#define ktime_get_boottime_ns LINUX_BACKPORT(ktime_get_boottime_ns)
-static inline u64 ktime_get_boottime_ns(void)
-{
-	return ktime_get_boot_ns();
-}
+#define ktime_get_boottime_ns ktime_get_boot_ns
+#define ktime_get_coarse_boottime_ns ktime_get_boot_ns
 #endif /* < 5.3 */
 
 #if LINUX_VERSION_IS_LESS(4,18,0)
 extern time64_t ktime_get_boottime_seconds(void);
-#endif /* < 4.18 */
 
-#if LINUX_VERSION_IS_LESS(4,18,0)
 #define ktime_get_raw_ts64 LINUX_BACKPORT(ktime_get_raw_ts64)
 static inline void ktime_get_raw_ts64(struct timespec64 *ts)
 {
 	return getrawmonotonic64(ts);
 }
-#endif
+#endif /* < 4.18 */
 
 #endif /* __BACKPORT_TIMEKEEPING_H */
-- 
2.35.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
