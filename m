Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F444C433B4
	for <backports@archiver.kernel.org>; Tue,  4 May 2021 21:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC230613BA
	for <backports@archiver.kernel.org>; Tue,  4 May 2021 21:12:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbhEDVNG (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 4 May 2021 17:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbhEDVNG (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 4 May 2021 17:13:06 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37CCBC061574
        for <backports@vger.kernel.org>; Tue,  4 May 2021 14:12:11 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1le2Kv-004BJB-Hl; Tue, 04 May 2021 23:12:09 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     backports@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2] backports: suppress errors from 'make kernelversion'
Date:   Tue,  4 May 2021 23:12:03 +0200
Message-Id: <20210504231203.d7b5b5ce71f7.I3aace2170f657561190f0473f2affafc850559b3@changeid>
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
of ".tmp_<pid>" for temporary files.

This was fixed upstream in commit 805b2e1d427a ("kbuild: include
Makefile.compiler only when compiler is needed").

To work around it, pass M= as suggested here:
https://lore.kernel.org/r/CAK7LNAROdVMPQq4Qn_M=OWzJrfqNOc4fyMicNKdnCqu7G9rFgw@mail.gmail.com

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/backport/Makefile b/backport/Makefile
index ee7df4ba29ce..77c2670d637e 100644
--- a/backport/Makefile
+++ b/backport/Makefile
@@ -84,8 +84,8 @@ mrproper:
 				echo ""							;\
 			done								\
 		) > Kconfig.kernel							;\
-		kver=$$($(MAKE) --no-print-directory -C $(KLIB_BUILD) kernelversion |	\
-			sed 's/^\(\([3-5]\|2\.6\)\.[0-9]\+\).*/\1/;t;d')		;\
+		kver=$$($(MAKE) --no-print-directory -C $(KLIB_BUILD) M=$(BACKPORT_DIR)	\
+			kernelversion |	sed 's/^\(\([3-5]\|2\.6\)\.[0-9]\+\).*/\1/;t;d');\
 		test "$$kver" != "" || echo "Kernel version parse failed!"		;\
 		test "$$kver" != ""							;\
 		kvers="$$(seq 14 39 | sed 's/^/2.6./')"					;\
-- 
2.30.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
