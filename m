Return-Path: <SRS0=hnMY=WB=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE59EC433FF
	for <backports@archiver.kernel.org>; Mon,  5 Aug 2019 12:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD78E2086D
	for <backports@archiver.kernel.org>; Mon,  5 Aug 2019 12:07:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbfHEMHt (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 5 Aug 2019 08:07:49 -0400
Received: from mx1.mailbox.org ([80.241.60.212]:48532 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727259AbfHEMHt (ORCPT <rfc822;backports@vger.kernel.org>);
        Mon, 5 Aug 2019 08:07:49 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id 9E4185160E;
        Mon,  5 Aug 2019 14:07:47 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter06.heinlein-hosting.de (spamfilter06.heinlein-hosting.de [80.241.56.125]) (amavisd-new, port 10030)
        with ESMTP id Vyixky_spldB; Mon,  5 Aug 2019 14:07:38 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes@sipsolutions.net, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 02/12] header: Add BITS_PER_TYPE()
Date:   Mon,  5 Aug 2019 14:06:54 +0200
Message-Id: <20190805120704.13128-3-hauke@hauke-m.de>
In-Reply-To: <20190805120704.13128-1-hauke@hauke-m.de>
References: <20190805120704.13128-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

BITS_PER_TYPE was moved in the upstream kernel in commit 9144d75e22ca
("include/linux/bitops.h: introduce BITS_PER_TYPE") in kernel 4.19 and
is now used by the ath10k driver.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/bitops.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/backport/backport-include/linux/bitops.h b/backport/backport-include/linux/bitops.h
index 86360d04..17bd8138 100644
--- a/backport/backport-include/linux/bitops.h
+++ b/backport/backport-include/linux/bitops.h
@@ -20,4 +20,8 @@
 #define BIT_ULL(nr) (1ULL << (nr))
 #endif
 
+#ifndef BITS_PER_TYPE
+#define BITS_PER_TYPE(type) (sizeof(type) * BITS_PER_BYTE)
+#endif
+
 #endif /* __BACKPORT_BITOPS_H */
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
