Return-Path: <SRS0=louc=RS=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B149C43381
	for <backports@archiver.kernel.org>; Fri, 15 Mar 2019 14:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 252F221871
	for <backports@archiver.kernel.org>; Fri, 15 Mar 2019 14:33:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729287AbfCOOda (ORCPT <rfc822;backports@archiver.kernel.org>);
        Fri, 15 Mar 2019 10:33:30 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:44048 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729283AbfCOOda (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 15 Mar 2019 10:33:30 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.91)
        (envelope-from <luca@coelho.fi>)
        id 1h4ntn-0004kR-FU; Fri, 15 Mar 2019 16:33:29 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     backports@vger.kernel.org
Cc:     Luca Coelho <luciano.coelho@intel.com>
Date:   Fri, 15 Mar 2019 16:33:17 +0200
Message-Id: <20190315143318.4714-6-luca@coelho.fi>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190315143318.4714-1-luca@coelho.fi>
References: <20190315143318.4714-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [PATCH 5/6] backport: fix handling of nospec.h for 4.15.0 and 4.15.1
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

The patch that introduces nospec.h was cherry-picked for 4.15 only in
4.15.2, so we need to adjust the ifdefs of our stub.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 backport/backport-include/linux/nospec.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/backport/backport-include/linux/nospec.h b/backport/backport-include/linux/nospec.h
index 50cf46737cbb..07647241f78f 100644
--- a/backport/backport-include/linux/nospec.h
+++ b/backport/backport-include/linux/nospec.h
@@ -1,7 +1,8 @@
 #ifndef _BACKPORT_LINUX_NOSPEC_H
 #define _BACKPORT_LINUX_NOSPEC_H
 
-#if LINUX_VERSION_IS_GEQ(4,14,18) || \
+#if LINUX_VERSION_IS_GEQ(4,15,2) || \
+    LINUX_VERSION_IN_RANGE(4,14,18, 4,15,0) || \
     LINUX_VERSION_IN_RANGE(4,9,81, 4,10,0) || \
     LINUX_VERSION_IN_RANGE(4,4,118, 4,5,0)
 #include_next <linux/nospec.h>
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
