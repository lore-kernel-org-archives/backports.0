Return-Path: <SRS0=louc=RS=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E77FC4360F
	for <backports@archiver.kernel.org>; Fri, 15 Mar 2019 14:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D7F921871
	for <backports@archiver.kernel.org>; Fri, 15 Mar 2019 14:33:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729221AbfCOOd2 (ORCPT <rfc822;backports@archiver.kernel.org>);
        Fri, 15 Mar 2019 10:33:28 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:44036 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729283AbfCOOd2 (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 15 Mar 2019 10:33:28 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.91)
        (envelope-from <luca@coelho.fi>)
        id 1h4ntm-0004kR-Pi; Fri, 15 Mar 2019 16:33:27 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     backports@vger.kernel.org
Cc:     Luca Coelho <luciano.coelho@intel.com>
Date:   Fri, 15 Mar 2019 16:33:16 +0200
Message-Id: <20190315143318.4714-5-luca@coelho.fi>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190315143318.4714-1-luca@coelho.fi>
References: <20190315143318.4714-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [PATCH 4/6] backport: add include ftrace_event.h back to backport-4.0.c
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

At least one function, namely ftrace_print_array_seq(), still needs
the ftrace_event.h header file, otherwise sparse may warning that it
is declared as non-static without pre-declaration.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 backport/compat/backport-4.0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/backport/compat/backport-4.0.c b/backport/compat/backport-4.0.c
index 84a4c6bf27b7..fbe0ddbc3bdd 100644
--- a/backport/compat/backport-4.0.c
+++ b/backport/compat/backport-4.0.c
@@ -15,6 +15,7 @@
 #include <linux/printk.h>
 #include <linux/export.h>
 #include <linux/trace_seq.h>
+#include <linux/ftrace_event.h>
 #include <asm/unaligned.h>
 
 /**
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
