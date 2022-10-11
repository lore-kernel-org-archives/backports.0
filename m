Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12BD4C43219
	for <backports@archiver.kernel.org>; Tue, 11 Oct 2022 21:05:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiJKVFI (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 11 Oct 2022 17:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiJKVE7 (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 11 Oct 2022 17:04:59 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EAA120BD8
        for <backports@vger.kernel.org>; Tue, 11 Oct 2022 14:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=Nu3TdfvE+J1WstyzbIYdp3nEZ9TMUs7ys2koe7Ycv1U=;
        t=1665522295; x=1666731895; b=fprWYTeqrOynhjKVPK8vP6OmbKYHYtxjnE0x0uX3TymkU+c
        I0mK+0FOI+sivhwPbEiWqS46PwLqrS2ewiSLZl4QmTwxYiZ+2mGCbMY6uQv6l9nYcOc1OmbCbjHl+
        uzIj1GJXDxlnDeeQkzKonYbBraz2lxQ+Ht5M4E+QCm037JZMM1uFajqfMccnBlp7/SZCWXK55VgKH
        8ykQZM7ie3qWdoZrvsseqDqOTyVwQUz1RpqwDrKi/3xleP1VfCaHpJYzU5YOfzBDv/GWyyYsQ8HV9
        By6OBw4rSQ9umCVPrUCcmT4qMU97nMhszZLNXLN7xSG2YpfYDAVOA9G2iOh3InjA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oiMQk-0045LP-0e;
        Tue, 11 Oct 2022 23:04:50 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     backports@vger.kernel.org
Cc:     nbd@nbd.name, Luca Coelho <luciano.coelho@intel.com>
Subject: [PATCH 06/38] backports: increase cfg80211 wiphy padding
Date:   Tue, 11 Oct 2022 23:04:14 +0200
Message-Id: <20221011230356.91df2a084485.Icfb8295a72f19a169bef7ecee762ed693f923e65@changeid>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221011210446.144768-1-johannes@sipsolutions.net>
References: <20221011210446.144768-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

The wiphy structure has grown over the 2048 bytes that we originally
used in the wiphy padding, it's 2080 bytes long as of v5.11.  Increase
the padding to an arbitrary higher round number, 2304.  We will end up
using 2 pages now, so we could go as high as a page's length, but keep
it lower so that when we grow over 2304 again we notice and can reasses
the issue.

type=maint
ticket=none

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Reviewed-on: https://git-ger-8.devtools.intel.com/gerrit/140382
---
 patches/0003-cfg80211-wext-padding/include_net_cfg80211.patch | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/patches/0003-cfg80211-wext-padding/include_net_cfg80211.patch b/patches/0003-cfg80211-wext-padding/include_net_cfg80211.patch
index a804077414d9..8f9b0985b769 100644
--- a/patches/0003-cfg80211-wext-padding/include_net_cfg80211.patch
+++ b/patches/0003-cfg80211-wext-padding/include_net_cfg80211.patch
@@ -4,7 +4,7 @@
  
  	/* assign these fields before you register the wiphy */
  
-+#define WIPHY_COMPAT_PAD_SIZE	2048
++#define WIPHY_COMPAT_PAD_SIZE	2304
 +	u8 padding[WIPHY_COMPAT_PAD_SIZE];
 +
  	u8 perm_addr[ETH_ALEN];
-- 
2.37.3

--
To unsubscribe from this list: send the line "unsubscribe backports" in
