Return-Path: <SRS0=louc=RS=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F291BC43381
	for <backports@archiver.kernel.org>; Fri, 15 Mar 2019 14:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2CA221871
	for <backports@archiver.kernel.org>; Fri, 15 Mar 2019 14:33:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729288AbfCOOdc (ORCPT <rfc822;backports@archiver.kernel.org>);
        Fri, 15 Mar 2019 10:33:32 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:44058 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729283AbfCOOdc (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 15 Mar 2019 10:33:32 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.91)
        (envelope-from <luca@coelho.fi>)
        id 1h4ntp-0004kR-An; Fri, 15 Mar 2019 16:33:30 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     backports@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>
Date:   Fri, 15 Mar 2019 16:33:18 +0200
Message-Id: <20190315143318.4714-7-luca@coelho.fi>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190315143318.4714-1-luca@coelho.fi>
References: <20190315143318.4714-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [PATCH 6/6] backports: genetlink: avoid NULL dereference
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

If we fail to allocate extack, we fall back to the code path
that tries to send an error *with* extack, but that will
access our extack pointer. It also doesn't make sense, so just
return an error back to netlink immediately and let it handle
sending the error message to userspace.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 backport/compat/backport-genetlink.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/backport/compat/backport-genetlink.c b/backport/compat/backport-genetlink.c
index 71bf45adf88d..885f17568333 100644
--- a/backport/compat/backport-genetlink.c
+++ b/backport/compat/backport-genetlink.c
@@ -157,12 +157,10 @@ static int backport_pre_doit(__genl_const struct genl_ops *ops,
 #if LINUX_VERSION_IS_LESS(4,12,0)
 	struct netlink_ext_ack *extack = kzalloc(sizeof(*extack), GFP_KERNEL);
 
-	__bp_genl_info_userhdr_set(info, extack);
+	if (!extack)
+		return -ENOMEM;
 
-	if (!extack) {
-		err = -ENOMEM;
-		goto err;
-	}
+	__bp_genl_info_userhdr_set(info, extack);
 
 	extack->__bp_doit = ops->doit;
 #else
@@ -175,7 +173,6 @@ static int backport_pre_doit(__genl_const struct genl_ops *ops,
 		err = family->pre_doit(ops, skb, info);
 
 #if LINUX_VERSION_IS_LESS(4,12,0)
-err:
 	if (err) {
 		/* signal to do nothing */
 		extack->__bp_doit = NULL;
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
