Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45001C43219
	for <backports@archiver.kernel.org>; Tue, 11 Oct 2022 21:05:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiJKVFR (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 11 Oct 2022 17:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiJKVFB (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 11 Oct 2022 17:05:01 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66D032A9E
        for <backports@vger.kernel.org>; Tue, 11 Oct 2022 14:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=1qm4Q4hZsIKhC+waxw1XWpA1i96j+fFCAz6bLQpvues=;
        t=1665522298; x=1666731898; b=dgM+g7CdB9gyFLyn3rkXLI9hZDXJVhqL1QWd/3GQgWqUnxm
        fgnxHKhoVGqLAox8SwuKHeVM+Xxng5zk0RMforVimUVBkH28S2UotnHSrUOuflWPp9/6VSZVZ1cpj
        VjnCh9v0RH2cRZh1Fhxd2q6h4nKrul8VvJMGUelCMl+PfbIWZHcka0gVju+DdDU3hDJwFytfiE9ph
        1KJBQKB7KgS//2Ko5M/qgLOnz1JASTMrIhLeohXVh7yO4yRAtacNpiI6KrcEJE1xQ7Bp2hRuvl4e4
        ShZ7SA+9onj35PVBaqum3fSvpTc2/muzHpaJYsOUGFS9fwD19Wb7O8cdscUdWesQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oiMQp-0045LP-2g;
        Tue, 11 Oct 2022 23:04:55 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     backports@vger.kernel.org
Cc:     nbd@nbd.name, Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 25/38] backports: add rfkill_soft_blocked()
Date:   Tue, 11 Oct 2022 23:04:33 +0200
Message-Id: <20221011230356.878fe3b6f86d.Icd550ec514b6d1c90cb113b564c3897aab987d00@changeid>
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
 backport/backport-include/linux/rfkill.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/backport/backport-include/linux/rfkill.h b/backport/backport-include/linux/rfkill.h
index c0b99d58f9c0..d130c9b70c47 100644
--- a/backport/backport-include/linux/rfkill.h
+++ b/backport/backport-include/linux/rfkill.h
@@ -21,4 +21,13 @@ static inline bool rfkill_set_hw_state_reason(struct rfkill *rfkill,
 
 #endif /* 5.11 */
 
+#if LINUX_VERSION_IS_LESS(5,17,0) && !defined(CONFIG_WLAN_VENDOR_INTEL_MEI)
+
+static inline bool rfkill_soft_blocked(struct rfkill *rfkill)
+{
+	return rfkill_blocked(rfkill);
+}
+
+#endif /* 5.17 */
+
 #endif /* __BACKPORT_UAPI__RFKILL_H */
-- 
2.37.3

--
To unsubscribe from this list: send the line "unsubscribe backports" in
