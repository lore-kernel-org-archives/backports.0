Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E4ACC433ED
	for <backports@archiver.kernel.org>; Fri, 16 Apr 2021 09:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7101661152
	for <backports@archiver.kernel.org>; Fri, 16 Apr 2021 09:56:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239159AbhDPJ5H (ORCPT <rfc822;backports@archiver.kernel.org>);
        Fri, 16 Apr 2021 05:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239007AbhDPJ5E (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 16 Apr 2021 05:57:04 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70238C061574
        for <backports@vger.kernel.org>; Fri, 16 Apr 2021 02:56:40 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lXLDJ-00CVbC-TC; Fri, 16 Apr 2021 11:56:37 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     backports@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] backport: remove wext warning
Date:   Fri, 16 Apr 2021 11:56:33 +0200
Message-Id: <20210416115633.252b99aac931.I7a66b0233a0b6972378bb20b8d1a70b7360af932@changeid>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

wireless extensions are being used less, so remove the
warning about them not working - most people probably
won't ever see any failures, and even if not see the
warning.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 .../0010-add-wext-handlers-to-netdev/net_wireless_core.patch | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/patches/0010-add-wext-handlers-to-netdev/net_wireless_core.patch b/patches/0010-add-wext-handlers-to-netdev/net_wireless_core.patch
index 18b50f12601b..6397a04e1e40 100644
--- a/patches/0010-add-wext-handlers-to-netdev/net_wireless_core.patch
+++ b/patches/0010-add-wext-handlers-to-netdev/net_wireless_core.patch
@@ -18,11 +18,6 @@
 +#ifdef CONFIG_WIRELESS_EXT
 +	if (!wdev->netdev->wireless_handlers)
 +		wdev->netdev->wireless_handlers = &cfg80211_wext_handler;
-+#else
-+	printk_once(KERN_WARNING "cfg80211: wext will not work because "
-+		    "kernel was compiled with CONFIG_WIRELESS_EXT=n. "
-+		    "Tools using wext interface, like iwconfig will "
-+		    "not work.\n");
 +#endif
  	wdev->wext.default_key = -1;
  	wdev->wext.default_mgmt_key = -1;
-- 
2.30.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
