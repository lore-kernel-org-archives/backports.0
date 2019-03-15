Return-Path: <SRS0=louc=RS=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC88AC4360F
	for <backports@archiver.kernel.org>; Fri, 15 Mar 2019 14:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D24621871
	for <backports@archiver.kernel.org>; Fri, 15 Mar 2019 14:33:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729284AbfCOOd1 (ORCPT <rfc822;backports@archiver.kernel.org>);
        Fri, 15 Mar 2019 10:33:27 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:44018 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729241AbfCOOd1 (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 15 Mar 2019 10:33:27 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.91)
        (envelope-from <luca@coelho.fi>)
        id 1h4ntk-0004kR-RY; Fri, 15 Mar 2019 16:33:25 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     backports@vger.kernel.org
Cc:     Luca Coelho <luciano.coelho@intel.com>
Date:   Fri, 15 Mar 2019 16:33:13 +0200
Message-Id: <20190315143318.4714-2-luca@coelho.fi>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190315143318.4714-1-luca@coelho.fi>
References: <20190315143318.4714-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [PATCH 1/6] backport: add v5.* to the Makefile
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Now that 4.21 became 5.0, we need to update the Makefile accordingly.
Stop looking at 4.19 for the 4.* series and add 5.*.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 backport/Makefile | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/backport/Makefile b/backport/Makefile
index 0fd4cdb2f322..ee7df4ba29ce 100644
--- a/backport/Makefile
+++ b/backport/Makefile
@@ -85,12 +85,13 @@ mrproper:
 			done								\
 		) > Kconfig.kernel							;\
 		kver=$$($(MAKE) --no-print-directory -C $(KLIB_BUILD) kernelversion |	\
-			sed 's/^\(\([3-4]\|2\.6\)\.[0-9]\+\).*/\1/;t;d')		;\
+			sed 's/^\(\([3-5]\|2\.6\)\.[0-9]\+\).*/\1/;t;d')		;\
 		test "$$kver" != "" || echo "Kernel version parse failed!"		;\
 		test "$$kver" != ""							;\
 		kvers="$$(seq 14 39 | sed 's/^/2.6./')"					;\
 		kvers="$$kvers $$(seq 0 19 | sed 's/^/3./')"				;\
-		kvers="$$kvers $$(seq 0 99 | sed 's/^/4./')"				;\
+		kvers="$$kvers $$(seq 0 20 | sed 's/^/4./')"				;\
+		kvers="$$kvers $$(seq 0 99 | sed 's/^/5./')"				;\
 		print=0									;\
 		for v in $$kvers ; do							\
 			if [ "$$print" = "1" ] ; then					\
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
