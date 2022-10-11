Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15874C43217
	for <backports@archiver.kernel.org>; Tue, 11 Oct 2022 21:05:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbiJKVFN (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 11 Oct 2022 17:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiJKVFA (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 11 Oct 2022 17:05:00 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8982019E
        for <backports@vger.kernel.org>; Tue, 11 Oct 2022 14:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=qBSi4tOYNjLsxkWAR/PSJiKBdkukvzKA5pVY1qt2nuI=;
        t=1665522295; x=1666731895; b=lfMfe++WFIowrawd8f99r0tfMccRVh+GBq+wthRBHz0KJkE
        me9VoSDbNJRNPrvbD3ejxOu6123U8/7FKvr05WP2X0fBz601Tsq7ieUls9BEHehZH+wwIROikZbpk
        pk8LEZL/qaLr4v/SEuKyUSVBr9qvxvXpSIp4BZFNb9Hi8qvw5HPLVe8TuAawysjiMMynQUbWQlzsH
        YF30Uk7MjI2yloSkb0qstLJsUtKoQcBcR/FwJkZtAWTCo1qzbncyYV5Zuqt993jSjbeeMeWpc8Ay1
        pyAei2G4BP44IAYdamrDro5fd/WyGE8aQp/U6KyCFToNgX5b89x6F3H03IOlrLmA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oiMQl-0045LP-0C;
        Tue, 11 Oct 2022 23:04:51 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     backports@vger.kernel.org
Cc:     nbd@nbd.name, Johannes Berg <johannes.berg@intel.com>,
        Luciano Coelho <luciano.coelho@intel.com>
Subject: [PATCH 09/38] main: add module_exit()
Date:   Tue, 11 Oct 2022 23:04:17 +0200
Message-Id: <20221011230356.75710624f93f.I1ef27160b229985f1bf154a8cc3d6f6b08328895@changeid>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221011210446.144768-1-johannes@sipsolutions.net>
References: <20221011210446.144768-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

This is needed since we have module_init() and otherwise
the kernel cannot unload the module again.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-on: https://git-ger-8.devtools.intel.com/gerrit/149476
Reviewed-by: Luciano Coelho <luciano.coelho@intel.com>
Tested-by: Luciano Coelho <luciano.coelho@intel.com>
---
 backport/compat/main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/backport/compat/main.c b/backport/compat/main.c
index 17ade98b8b51..ba1422b5d778 100644
--- a/backport/compat/main.c
+++ b/backport/compat/main.c
@@ -71,3 +71,8 @@ static int __init backport_init(void)
         return 0;
 }
 subsys_initcall(backport_init);
+
+static void __exit backport_exit(void)
+{
+}
+module_exit(backport_exit);
-- 
2.37.3

--
To unsubscribe from this list: send the line "unsubscribe backports" in
