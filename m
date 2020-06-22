Return-Path: <SRS0=/q2A=AD=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC627C433E1
	for <backports@archiver.kernel.org>; Mon, 22 Jun 2020 21:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B40452075A
	for <backports@archiver.kernel.org>; Mon, 22 Jun 2020 21:38:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730600AbgFVVic (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 22 Jun 2020 17:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730607AbgFVVic (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 22 Jun 2020 17:38:32 -0400
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [IPv6:2001:67c:2050::465:103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E6DC061795
        for <backports@vger.kernel.org>; Mon, 22 Jun 2020 14:38:31 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-103.mailbox.org (Postfix) with ESMTPS id 49rN7n0XHXzKmc4;
        Mon, 22 Jun 2020 23:38:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id JcwD5z6Ke6_i; Mon, 22 Jun 2020 23:38:26 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes@sipsolutions.net, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 4/7] backports: Add GUID_INIT()
Date:   Mon, 22 Jun 2020 23:38:01 +0200
Message-Id: <20200622213804.26477-5-hauke@hauke-m.de>
In-Reply-To: <20200622213804.26477-1-hauke@hauke-m.de>
References: <20200622213804.26477-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-SPAM-Probability: 0
X-Rspamd-Score: -4.21 / 15.00 / 15.00
X-Rspamd-Queue-Id: 2D14B1802
X-Rspamd-UID: c8b93c
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

Linux commit f9727a17db9b ("uuid: rename uuid types") added the
GUID_INIT() function, use the UUID_LE on older kernel versions.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/uuid.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/backport/backport-include/linux/uuid.h b/backport/backport-include/linux/uuid.h
index bc6fbe17..90352f1b 100644
--- a/backport/backport-include/linux/uuid.h
+++ b/backport/backport-include/linux/uuid.h
@@ -14,6 +14,7 @@
 #if LINUX_VERSION_IS_LESS(4,13,0)
 #define guid_t uuid_le
 #define uuid_t uuid_be
+#define GUID_INIT UUID_LE
 
 static inline void guid_gen(guid_t *u)
 {
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
