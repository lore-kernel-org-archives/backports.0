Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F2EC433B4
	for <backports@archiver.kernel.org>; Tue,  4 May 2021 20:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24DD2613C3
	for <backports@archiver.kernel.org>; Tue,  4 May 2021 20:59:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232580AbhEDVAW (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 4 May 2021 17:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232455AbhEDVAW (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 4 May 2021 17:00:22 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22949C061574
        for <backports@vger.kernel.org>; Tue,  4 May 2021 13:59:27 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1le28b-004B2p-EC; Tue, 04 May 2021 22:59:25 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     backports@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] backports: suppress errors from 'make kernelversion'
Date:   Tue,  4 May 2021 22:59:20 +0200
Message-Id: <20210504225919.393f7f931e90.I3aace2170f657561190f0473f2affafc850559b3@changeid>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Since kernel 5.8, specifically commit 4d0831e8a029 ("kconfig: unify
cc-option and as-option"), 'make kernelversion' will call into the
Kconfig system, evaluating cc-option from scripts/Kconfig.include,
which requires a writable current working directory due to the use
of ".tmp_<pid>" for temporary files. This seems questionable, but
since the kernelversion really isn't affected, we can ignore it.

I also mentioned this upstream, see the thread after the commit:
https://lore.kernel.org/r/20200614144341.1077495-2-masahiroy@kernel.org

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/backport/Makefile b/backport/Makefile
index ee7df4ba29ce..2bdea02d4a46 100644
--- a/backport/Makefile
+++ b/backport/Makefile
@@ -84,8 +84,8 @@ mrproper:
 				echo ""							;\
 			done								\
 		) > Kconfig.kernel							;\
-		kver=$$($(MAKE) --no-print-directory -C $(KLIB_BUILD) kernelversion |	\
-			sed 's/^\(\([3-5]\|2\.6\)\.[0-9]\+\).*/\1/;t;d')		;\
+		kver=$$($(MAKE) --no-print-directory -C $(KLIB_BUILD) kernelversion 	\
+			2>/dev/null | sed 's/^\(\([3-5]\|2\.6\)\.[0-9]\+\).*/\1/;t;d')	;\
 		test "$$kver" != "" || echo "Kernel version parse failed!"		;\
 		test "$$kver" != ""							;\
 		kvers="$$(seq 14 39 | sed 's/^/2.6./')"					;\
-- 
2.30.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
