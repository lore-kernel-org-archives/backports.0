Return-Path: <SRS0=dBk/=SE=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD137C10F0B
	for <backports@archiver.kernel.org>; Tue,  2 Apr 2019 13:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6B2720856
	for <backports@archiver.kernel.org>; Tue,  2 Apr 2019 13:08:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730581AbfDBNIb (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 2 Apr 2019 09:08:31 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:49396 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730245AbfDBNIa (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 2 Apr 2019 09:08:30 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.91)
        (envelope-from <luca@coelho.fi>)
        id 1hBJ9Q-0006zx-M3; Tue, 02 Apr 2019 16:08:29 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     backports@vger.kernel.org
Cc:     Luca Coelho <luciano.coelho@intel.com>
Date:   Tue,  2 Apr 2019 16:08:23 +0300
Message-Id: <20190402130823.13965-1-luca@coelho.fi>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [PATCH] backport: check for failure when allocating ops in genetlink
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

We were not checking if the allocation failed in
backport_genl_register_family(), which could lead to NULL pointer
dereferences later.  Fix that.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 backport/compat/backport-genetlink.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/backport/compat/backport-genetlink.c b/backport/compat/backport-genetlink.c
index 885f17568333..16971ec34e38 100644
--- a/backport/compat/backport-genetlink.c
+++ b/backport/compat/backport-genetlink.c
@@ -220,7 +220,11 @@ int backport_genl_register_family(struct genl_family *family)
 
 	/* we append one entry to the ops to find our family pointer ... */
 	ops = kzalloc(sizeof(*ops) * (family->n_ops + 1), GFP_KERNEL);
+	if (!ops)
+		return -ENOMEM;
+
 	memcpy(ops, family->ops, sizeof(*ops) * family->n_ops);
+
 	/*
 	 * Remove policy to skip validation as the struct nla_policy
 	 * memory layout isn't compatible with the old version
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
