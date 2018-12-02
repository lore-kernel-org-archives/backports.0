Return-Path: <SRS0=7Ax0=OL=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1632DC65BAE
	for <backports@archiver.kernel.org>; Sun,  2 Dec 2018 20:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D09DB206B7
	for <backports@archiver.kernel.org>; Sun,  2 Dec 2018 20:51:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D09DB206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=backports-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725780AbeLBUvu (ORCPT <rfc822;backports@archiver.kernel.org>);
        Sun, 2 Dec 2018 15:51:50 -0500
Received: from mx2.mailbox.org ([80.241.60.215]:33910 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbeLBUvu (ORCPT <rfc822;backports@vger.kernel.org>);
        Sun, 2 Dec 2018 15:51:50 -0500
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id E8D4DA1167;
        Sun,  2 Dec 2018 21:51:44 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172]) (amavisd-new, port 10030)
        with ESMTP id JtwoOttyiNrj; Sun,  2 Dec 2018 21:51:43 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     johannes@sipsolutions.net
Cc:     backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 7/7] backports: Add skcipher_request_zero()
Date:   Sun,  2 Dec 2018 21:51:31 +0100
Message-Id: <20181202205131.13519-8-hauke@hauke-m.de>
In-Reply-To: <20181202205131.13519-1-hauke@hauke-m.de>
References: <20181202205131.13519-1-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

This was added in commit 1aaa753d918 ("crypto: skcipher - Add helper to
zero stack request")

This is needed by lib80211, the code changes in kernel 4.20, so this is
only needed in kernel 4.19.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/crypto/skcipher.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 backport/backport-include/crypto/skcipher.h

diff --git a/backport/backport-include/crypto/skcipher.h b/backport/backport-include/crypto/skcipher.h
new file mode 100644
index 00000000..19a5a73d
--- /dev/null
+++ b/backport/backport-include/crypto/skcipher.h
@@ -0,0 +1,14 @@
+#ifndef __BP_CRYPTO_SKCIPHER_H
+#define __BP_CRYPTO_SKCIPHER_H
+#include_next <crypto/skcipher.h>
+
+#if LINUX_VERSION_IS_LESS(4,6,0)
+static inline void skcipher_request_zero(struct skcipher_request *req)
+{
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+
+	memzero_explicit(req, sizeof(*req) + crypto_skcipher_reqsize(tfm));
+}
+#endif
+
+#endif /* __BP_CRYPTO_SKCIPHER_H */
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
