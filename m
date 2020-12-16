Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91893C4361B
	for <backports@archiver.kernel.org>; Wed, 16 Dec 2020 15:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BF1C23105
	for <backports@archiver.kernel.org>; Wed, 16 Dec 2020 15:01:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725825AbgLPPBz (ORCPT <rfc822;backports@archiver.kernel.org>);
        Wed, 16 Dec 2020 10:01:55 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:36826 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725274AbgLPPBy (ORCPT
        <rfc822;backports@vger.kernel.org>); Wed, 16 Dec 2020 10:01:54 -0500
X-Greylist: delayed 2070 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Dec 2020 10:01:54 EST
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kpXlF-003IZU-5w; Wed, 16 Dec 2020 16:26:37 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     backports@vger.kernel.org
Cc:     johannes@sipsolutions.net, hauke@hauke-m.de
Date:   Wed, 16 Dec 2020 16:26:34 +0200
Message-Id: <20201216142634.1625546-1-luca@coelho.fi>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [PATCH] backport: declare GPIO own_desc functions if GPIOLIB is not defined
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

In kernels older than v5.4, the gpiochip_request_own_desc() and the
gpiochip_free_own_desc() functions are declared inside a
CONFIG_GPIOLIB ifdef, so we need to declare them in our implementation
to avoid compilation problems.

Change-Id: Ic6da0d7ff9d99c64d110da63fb950fb555fd2782
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 backport/compat/backport-5.3.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/backport/compat/backport-5.3.c b/backport/compat/backport-5.3.c
index f501448e24cd..46e6a11d8da3 100644
--- a/backport/compat/backport-5.3.c
+++ b/backport/compat/backport-5.3.c
@@ -45,6 +45,17 @@ static int gpiod_configure_flags(struct gpio_desc *desc, const char *con_id,
 }
 
 #undef gpiochip_request_own_desc
+
+/* In kernels older than 5.4, these function declarations are inside a
+ * CONFIG_GPIOLIB ifdef, so we need to declare them here.
+ */
+#ifndef CONFIG_GPIOLIB
+extern struct gpio_desc *gpiochip_request_own_desc(struct gpio_chip *chip,
+						   u16 hwnum,
+						   const char *label);
+void gpiochip_free_own_desc(struct gpio_desc *desc);
+#endif /* CONFIG_GPIOLIB */
+
 struct gpio_desc *backport_gpiochip_request_own_desc(struct gpio_chip *gc,
 					    unsigned int hwnum,
 					    const char *label,
-- 
2.29.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
