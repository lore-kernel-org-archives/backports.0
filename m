Return-Path: <SRS0=m0JF=NM=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D83C0044C
	for <backports@archiver.kernel.org>; Thu,  1 Nov 2018 13:08:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 551AD204FD
	for <backports@archiver.kernel.org>; Thu,  1 Nov 2018 13:08:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 551AD204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=coelho.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=backports-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbeKAWLS (ORCPT <rfc822;backports@archiver.kernel.org>);
        Thu, 1 Nov 2018 18:11:18 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:33756 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727644AbeKAWLS (ORCPT
        <rfc822;backports@vger.kernel.org>); Thu, 1 Nov 2018 18:11:18 -0400
Received: from 91-156-4-241.elisa-laajakaista.fi ([91.156.4.241] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.91)
        (envelope-from <luca@coelho.fi>)
        id 1gIChx-0006kD-Ma; Thu, 01 Nov 2018 15:08:22 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     backports@vger.kernel.org
Cc:     Luca Coelho <luciano.coelho@intel.com>
Date:   Thu,  1 Nov 2018 15:08:17 +0200
Message-Id: <20181101130817.10211-1-luca@coelho.fi>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [PATCH] backports: check if genl pre_doit and post_doit are set
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

In the pre_doit and post_doit backports, we set the ops to our
backported version, so genetlink itself will always call it.  But then
we don't check if the actual ops are set before calling them, which
causes a call to a NULL pointer.  Fix this by checking if the ops are
actually set before calling them.

Fixes: ff6746638cf1 ("backports: genetlink: update completely")
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 backport/compat/backport-genetlink.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/backport/compat/backport-genetlink.c b/backport/compat/backport-genetlink.c
index cc70cd73d0c0..71bf45adf88d 100644
--- a/backport/compat/backport-genetlink.c
+++ b/backport/compat/backport-genetlink.c
@@ -171,7 +171,7 @@ static int backport_pre_doit(__genl_const struct genl_ops *ops,
 
 	err = nlmsg_validate(info->nlhdr, GENL_HDRLEN + family->hdrsize,
 			     family->maxattr, ops->policy, extack);
-	if (!err)
+	if (!err && family->pre_doit)
 		err = family->pre_doit(ops, skb, info);
 
 #if LINUX_VERSION_IS_LESS(4,12,0)
@@ -205,7 +205,8 @@ static void backport_post_doit(__genl_const struct genl_ops *ops,
 #else
 	if (1)
 #endif
-		family->post_doit(ops, skb, info);
+		if (family->post_doit)
+			family->post_doit(ops, skb, info);
 
 #if LINUX_VERSION_IS_LESS(4,12,0)
 	kfree(__bp_genl_info_userhdr(info));
-- 
2.19.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
