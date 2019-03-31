Return-Path: <SRS0=C36q=SC=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D83C43381
	for <backports@archiver.kernel.org>; Sun, 31 Mar 2019 21:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D1CC2086C
	for <backports@archiver.kernel.org>; Sun, 31 Mar 2019 21:13:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="tF5JyOUh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731326AbfCaVND (ORCPT <rfc822;backports@archiver.kernel.org>);
        Sun, 31 Mar 2019 17:13:03 -0400
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:47522 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731241AbfCaVNC (ORCPT
        <rfc822;backports@vger.kernel.org>); Sun, 31 Mar 2019 17:13:02 -0400
Received: from mail-irv-17.broadcom.com (mail-irv-17.lvn.broadcom.net [10.75.224.233])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id 048D530C069;
        Sun, 31 Mar 2019 14:12:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com 048D530C069
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1554066731;
        bh=JSVVwpYbU+UjcH/2HK/YZspcuAHTTp9oXzOQlbUOtis=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tF5JyOUhTUtzdy7w/8Ac3rPwcNrHshS6XJHP7nm59Ihi5JMc7As5DKcwSJTTcr/05
         PgxexSjJTE5RchQ0AI1THChw0A9daHvezER1senCt0iJRyZ8ZsACA1b0IBHd2QMOvz
         2zjWdO2qE8WoD3CmEcHvzF8GSUUkzl3zYS9pblC4=
Received: from bld-bun-01.bun.broadcom.com (bld-bun-01.bun.broadcom.com [10.176.128.83])
        by mail-irv-17.broadcom.com (Postfix) with ESMTP id 6814D81EC5;
        Sun, 31 Mar 2019 14:13:01 -0700 (PDT)
Received: by bld-bun-01.bun.broadcom.com (Postfix, from userid 25152)
        id EA241B02A55; Sun, 31 Mar 2019 23:12:59 +0200 (CEST)
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
To:     backports@vger.kernel.org
Cc:     Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [PATCH 2/3] backport: add policy field in struct genl_family
Date:   Sun, 31 Mar 2019 23:12:41 +0200
Message-Id: <1554066762-20128-2-git-send-email-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1554066762-20128-1-git-send-email-arend.vanspriel@broadcom.com>
References: <1554066762-20128-1-git-send-email-arend.vanspriel@broadcom.com>
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

Commit 3b0f31f2b8c9 ("genetlink: make policy common to family") added
a common policy to the genl_family. So we need it in backport as well.
As the backport explicitly sets ops policy to NULL no further changes
are needed.

Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
 backport/backport-include/net/genetlink.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/backport/backport-include/net/genetlink.h b/backport/backport-include/net/genetlink.h
index 84011e7..1b5f4e1 100644
--- a/backport/backport-include/net/genetlink.h
+++ b/backport/backport-include/net/genetlink.h
@@ -115,6 +115,7 @@ struct backport_genl_family {
 	unsigned int		maxattr;
 	bool			netnsok;
 	bool			parallel_ops;
+	const struct nla_policy *policy;
 	int			(*pre_doit)(__genl_const struct genl_ops *ops,
 					    struct sk_buff *skb,
 					    struct genl_info *info);
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
