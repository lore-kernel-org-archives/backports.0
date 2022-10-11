Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83CF4C43219
	for <backports@archiver.kernel.org>; Tue, 11 Oct 2022 21:05:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbiJKVFL (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 11 Oct 2022 17:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiJKVFA (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 11 Oct 2022 17:05:00 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FFF224098
        for <backports@vger.kernel.org>; Tue, 11 Oct 2022 14:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=dVIZglvVy9w3Ogon4HgeSzfVKYM8w3oZJ7EPIyz4ago=;
        t=1665522295; x=1666731895; b=tnNZC/cuUmQoGehiWVOsWgtSRhvgv2oZD977loLRI6X9Ttu
        mFdypsn4wCzwsd7M76BQUfT7FTlyIejnMwwdTPuc7T4xK5q09o+qvVteJCYpr6Gedc3pLSnXAN9F+
        KHDcUYyJZMdq76RNeXmJfJw7oPCd071ioRI4RRz8E/4XVwQGvQ31+a2hRFEgThxiyUWgmdl3KDWWK
        OzzjIMM7I1D3OUwG7Mep4g5rdO/AXnbI+SCmaL/hEFg95wQtf61jGKh62HrVRY/n2JZbdZ/qRh5w1
        xpYFfuskA2HCMlih7vC9GVRiMrLA4v/gWV3gYceJYF1KLuBkgt5NvB8Gt4n+A5aQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oiMQm-0045LP-0s;
        Tue, 11 Oct 2022 23:04:52 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     backports@vger.kernel.org
Cc:     nbd@nbd.name, Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 13/38] backports: add ktime_get_coarse_boottime_ns
Date:   Tue, 11 Oct 2022 23:04:21 +0200
Message-Id: <20221011230356.b622d5835831.Id1c6b53e4c57d92eb838e4c09ef8042cd42f150f@changeid>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221011210446.144768-1-johannes@sipsolutions.net>
References: <20221011210446.144768-1-johannes@sipsolutions.net>
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
2.37.3

--
To unsubscribe from this list: send the line "unsubscribe backports" in
