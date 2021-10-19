Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E889C43219
	for <backports@archiver.kernel.org>; Tue, 19 Oct 2021 21:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EED86610A3
	for <backports@archiver.kernel.org>; Tue, 19 Oct 2021 21:43:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbhJSVqG (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 19 Oct 2021 17:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbhJSVqB (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 19 Oct 2021 17:46:01 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050::465:101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A23E2C061772
        for <backports@vger.kernel.org>; Tue, 19 Oct 2021 14:43:47 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:105:465:1:3:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4HYnLT63dvzQk1x;
        Tue, 19 Oct 2021 23:43:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1634679824;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HlLS6EkqbhGFvX9IS7MZhwy/SV11PADMrsWG/0JTiII=;
        b=T8APTx5TZBgZvDLo80Zx7XxiLYwRQgfqZX1HSXTWS9FiXenI0Zd/9bW5F52ZzAk+ngYhLz
        q6WwmSzyAzODbqJgVG2pQ0rPi2f9I+MhOEBCT/Bu5cfACPL2M/sbqJbQI78VGjmidHPN1Y
        oHFx90wHLSm5wJhGEoSeGQvlGgTm2AmBe9SNv3uAe0AnGHw6WyVnw6S9xmQnzx309C2fe+
        gJpLBs9ILtDFLwS7XJ88hEeNItUbJo6zfpkE6TWTasi9x2KeLaY3rbTiaUvNv0Vuygu0aa
        PuAtEtQCS2hXoMXmKoE5qUNKL/QhFPxnQfLSGlXIxOzktRtTgCQwiDN0JCyjNQ==
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 20/47] headers: Add lockdep_assert_not_held()
Date:   Tue, 19 Oct 2021 23:42:53 +0200
Message-Id: <20211019214320.2035704-21-hauke@hauke-m.de>
In-Reply-To: <20211019214320.2035704-1-hauke@hauke-m.de>
References: <20211019214320.2035704-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1C8D6569
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

The lockdep_assert_not_held() define was added in kernel 5.13 and is
used by ath10k now.
The code was copied from the upstream kernel.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/lockdep.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/backport/backport-include/linux/lockdep.h b/backport/backport-include/linux/lockdep.h
index 7cf38b23..ed5ea678 100644
--- a/backport/backport-include/linux/lockdep.h
+++ b/backport/backport-include/linux/lockdep.h
@@ -9,4 +9,15 @@ struct lockdep_map { };
 #endif /* CONFIG_LOCKDEP */
 #endif /* LINUX_VERSION_IS_LESS(4,15,0) */
 
+#ifndef lockdep_assert_not_held
+#ifdef CONFIG_LOCKDEP
+#define lockdep_assert_not_held(l)	do {				\
+		WARN_ON(debug_locks &&					\
+			lockdep_is_held(l) == LOCK_STATE_HELD);		\
+	} while (0)
+#else
+#define lockdep_assert_not_held(l)		do { (void)(l); } while (0)
+#endif /* CONFIG_LOCKDEP */
+#endif /* lockdep_assert_not_held */
+
 #endif /* __BACKPORT_LINUX_LOCKDEP_H */
-- 
2.30.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
