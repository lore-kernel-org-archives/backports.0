Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5595C433FE
	for <backports@archiver.kernel.org>; Tue, 19 Oct 2021 21:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A79061052
	for <backports@archiver.kernel.org>; Tue, 19 Oct 2021 21:43:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbhJSVqK (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 19 Oct 2021 17:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbhJSVqF (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 19 Oct 2021 17:46:05 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050::465:201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C42D7C06161C
        for <backports@vger.kernel.org>; Tue, 19 Oct 2021 14:43:51 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:105:465:1:3:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4HYnLZ3SbPzQkBc;
        Tue, 19 Oct 2021 23:43:50 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1634679828;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oulZDUJrDQsmZmTT68+o9i+mS4aKMAjVmtGUR0I293k=;
        b=zlonsh/u1yaxOMvizxaMIIcFnvIapjSsx84fx7ENo6ETqMzP8IOiMV6nf7NXFkL0oTN0AE
        2ljYtcQgRJh093S5jSLlISnFxMF3vtYcSR0sEUNV4kkH10Xecsu+WwKdbKAReR5guK7m2U
        OnBHCzqCIqiDn3GuAOcn6HmRUZwAxwoyUHCOJz6nOsfGkbYkdAGEe3up16wh/gdnOpDFQq
        ZZPawhD5lpNT00hJK99tX1d+lZrVb0NtSQSQ8N0nVvAJiviiUdROs968QtKsXX31NuNKZ/
        gVZyM1YPpsOmFIwLzo4lt4gF1j87EepdhFzhU9+Me4z4AEWBOCEb8dSCB4pTCw==
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 33/47] dependencies: Build RTL8723BS only on kernel >= 5.4
Date:   Tue, 19 Oct 2021 23:43:06 +0200
Message-Id: <20211019214320.2035704-34-hauke@hauke-m.de>
In-Reply-To: <20211019214320.2035704-1-hauke@hauke-m.de>
References: <20211019214320.2035704-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C4DDB1315
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

RTL8723BS now uses aes_expandkey() and aes_encrypt(), which were only
added in kernel 5.4

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 dependencies | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/dependencies b/dependencies
index 8f0ca5ef..d8c3f106 100644
--- a/dependencies
+++ b/dependencies
@@ -34,3 +34,6 @@ AIRO_CS 4.20
 
 # mt7915 testmode uses skb_copy_header()
 NL80211_TESTMODE 4.18
+
+# Needs aes_expandkey() and aes_encrypt()
+RTL8723BS 5.4
-- 
2.30.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
