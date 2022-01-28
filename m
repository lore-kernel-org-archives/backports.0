Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF6C6C43219
	for <backports@archiver.kernel.org>; Fri, 28 Jan 2022 08:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347398AbiA1Iws (ORCPT <rfc822;backports@archiver.kernel.org>);
        Fri, 28 Jan 2022 03:52:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347361AbiA1Iwk (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 28 Jan 2022 03:52:40 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72CA8C06173B
        for <backports@vger.kernel.org>; Fri, 28 Jan 2022 00:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=PWQXg1VQ3lI1x8rz1aZXiFqFEPlis4loDnpfeefp9w4=;
        t=1643359959; x=1644569559; b=qVVylLIuXJN428VcKVsJkcPwuIQ2KLYBWrLshbE2lAGi7/Y
        pNG5Y1GiOp8gzS2uDmpjHAZBP+JKOX3Eq4K3PMbDOqT9bjg3+RKKKX8E+hjYqYYKsc59tDp85Hgs3
        g7ouUdax9jurXj9fPOw7murjsqfs93EeNQsMIeZYTMDGTIVwJrgOohYH6nh+/A98zNqJqLXqfzeKR
        gZIgSbGn2kkJS3QwNc26Cna/ftwz6+/BMACsU/8/cdpuPW+mSqzNtou5RkgXSKU12X8Qh7SIAOOjj
        3khtKt0qoZ5Y6svazIKj3CWf9bHOBSOz6tFGRJIbXwZYblnPXtB/gFhWnTFYeGDg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nDMzj-00BMr8-Do;
        Fri, 28 Jan 2022 09:52:35 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     backports@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 2/3] main: add module_exit()
Date:   Fri, 28 Jan 2022 09:52:29 +0100
Message-Id: <20220128095230.0a57cdbba670.I1ef27160b229985f1bf154a8cc3d6f6b08328895@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220128095230.da47bbe7d248.I29005f305b7808de21837d75e992b07444b4eaaa@changeid>
References: <20220128095230.da47bbe7d248.I29005f305b7808de21837d75e992b07444b4eaaa@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

This is needed since we have module_init() and otherwise
the kernel cannot unload the module again.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/compat/main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/backport/compat/main.c b/backport/compat/main.c
index 2540e7573674..d4f3340dba48 100644
--- a/backport/compat/main.c
+++ b/backport/compat/main.c
@@ -72,3 +72,8 @@ static int __init backport_init(void)
         return 0;
 }
 subsys_initcall(backport_init);
+
+static void __exit backport_exit(void)
+{
+}
+module_exit(backport_exit);
-- 
2.34.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
