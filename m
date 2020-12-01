Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 359C4C83018
	for <backports@archiver.kernel.org>; Tue,  1 Dec 2020 22:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD2432085B
	for <backports@archiver.kernel.org>; Tue,  1 Dec 2020 22:05:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="GLdpvriV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730097AbgLAWF5 (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 1 Dec 2020 17:05:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728261AbgLAWF4 (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 1 Dec 2020 17:05:56 -0500
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [IPv6:2001:67c:2050::465:103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC06C0613CF
        for <backports@vger.kernel.org>; Tue,  1 Dec 2020 14:04:46 -0800 (PST)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4Clx3J5dcPzQlLl;
        Tue,  1 Dec 2020 23:04:44 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1606860282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wRoFnEa7I+Fw1zlxenfb7qDtGsd73UMlyQf69c53wec=;
        b=GLdpvriVsxyRiasWxq/VTNbpeKayZFfqnjQBR8RVEkd6Xx1MVJ9ak//0u0Axg35fl88/lz
        7nNf1jMA6uPLtMiYmwSTOFLKckf1h60YYORi05wst05b/j9Uf04cpfeD5CcGqkET5O2Xe1
        3W53HPKpMrftDXdcpRoj+hkE+0r24hQ6Y9mhKRzadLcvbgTMAS/sY8t6U1L1adUiMHICyb
        M9LDw+RfsiolhDXt2cAXWGQ+uU5wBOMLh/RqSzbSAt75jnQjaCUEGnmyoehpWQMcK08/TD
        sbneWNsITGN7WsjtF491TUiEWi90ecpUwPCbKuacWFNc1MipfCvxdkDVojWAfQ==
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter04.heinlein-hosting.de (spamfilter04.heinlein-hosting.de [80.241.56.122]) (amavisd-new, port 10030)
        with ESMTP id bvdI46LcnkSZ; Tue,  1 Dec 2020 23:04:42 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes@sipsolutions.net, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 30/30] backports: Remove crypto/akcipher.h
Date:   Tue,  1 Dec 2020 23:04:15 +0100
Message-Id: <20201201220415.30582-31-hauke@hauke-m.de>
In-Reply-To: <20201201220415.30582-1-hauke@hauke-m.de>
References: <20201201220415.30582-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -4.76 / 15.00 / 15.00
X-Rspamd-Queue-Id: EBF87665
X-Rspamd-UID: 152a15
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

crypto/akcipher.h is only used by code which was anyway removed in the
patches/verify.patch patch from include/crypto/backport-public_key.h.

Remove the include, because is not available on older kernel version.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 patches/verify.patch | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/patches/verify.patch b/patches/verify.patch
index f76b6bf5..f1faff55 100644
--- a/patches/verify.patch
+++ b/patches/verify.patch
@@ -64,7 +64,15 @@
  	struct x509_certificate *signer;	/* Certificate that signed this one */
 --- a/include/crypto/backport-public_key.h
 +++ b/include/crypto/backport-public_key.h
-@@ -53,34 +53,6 @@ extern void public_key_signature_free(st
+@@ -12,7 +12,6 @@
+ 
+ #include <linux/keyctl.h>
+ #include <linux/oid_registry.h>
+-#include <crypto/akcipher.h>
+ 
+ /*
+  * Cryptographic data for the public-key subtype of the asymmetric key type.
+@@ -53,34 +52,6 @@ extern void public_key_signature_free(st
  
  extern struct asymmetric_key_subtype public_key_subtype;
  
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
