Return-Path: <SRS0=louc=RS=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD1E8C43381
	for <backports@archiver.kernel.org>; Fri, 15 Mar 2019 14:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7E2421871
	for <backports@archiver.kernel.org>; Fri, 15 Mar 2019 14:33:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729286AbfCOOd2 (ORCPT <rfc822;backports@archiver.kernel.org>);
        Fri, 15 Mar 2019 10:33:28 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:44030 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729221AbfCOOd2 (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 15 Mar 2019 10:33:28 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.91)
        (envelope-from <luca@coelho.fi>)
        id 1h4ntm-0004kR-5m; Fri, 15 Mar 2019 16:33:26 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     backports@vger.kernel.org
Cc:     Luca Coelho <luciano.coelho@intel.com>
Date:   Fri, 15 Mar 2019 16:33:15 +0200
Message-Id: <20190315143318.4714-4-luca@coelho.fi>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190315143318.4714-1-luca@coelho.fi>
References: <20190315143318.4714-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [PATCH 3/6] backport: add atomic_fetch_add_unless()
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

The iwlwifi driver now needs this function.  Backport it.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 backport/backport-include/linux/atomic.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/backport/backport-include/linux/atomic.h b/backport/backport-include/linux/atomic.h
index b4dd2e1d34f0..9ceb586e864a 100644
--- a/backport/backport-include/linux/atomic.h
+++ b/backport/backport-include/linux/atomic.h
@@ -51,4 +51,13 @@
 
 #endif /* atomic_try_cmpxchg_acquire */
 
+#if LINUX_VERSION_IS_LESS(4,19,0)
+#ifndef atomic_fetch_add_unless
+static inline int atomic_fetch_add_unless(atomic_t *v, int a, int u)
+{
+	return __atomic_add_unless(v, a, u);
+}
+#endif
+#endif
+
 #endif /* __BP_ATOMIC_H */
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
