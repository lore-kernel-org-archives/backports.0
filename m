Return-Path: <SRS0=giDq=U6=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E127CC5B578
	for <backports@archiver.kernel.org>; Mon,  1 Jul 2019 21:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE38421479
	for <backports@archiver.kernel.org>; Mon,  1 Jul 2019 21:49:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbfGAVt7 (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 1 Jul 2019 17:49:59 -0400
Received: from mx1.mailbox.org ([80.241.60.212]:40212 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726586AbfGAVt6 (ORCPT <rfc822;backports@vger.kernel.org>);
        Mon, 1 Jul 2019 17:49:58 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id 80AA45022D;
        Mon,  1 Jul 2019 23:49:56 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172]) (amavisd-new, port 10030)
        with ESMTP id 7iiACKcimLWB; Mon,  1 Jul 2019 23:49:52 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     Luca Coelho <luciano.coelho@intel.com>
Subject: [PATCH 03/18] backport: check for failure when allocating ops in genetlink
Date:   Mon,  1 Jul 2019 23:48:58 +0200
Message-Id: <20190701214914.8066-4-hauke@hauke-m.de>
In-Reply-To: <20190701214914.8066-1-hauke@hauke-m.de>
References: <20190701214914.8066-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 885f1756..16971ec3 100644
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
