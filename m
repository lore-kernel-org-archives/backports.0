Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A43C433F5
	for <backports@archiver.kernel.org>; Tue, 19 Oct 2021 21:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78BD661052
	for <backports@archiver.kernel.org>; Tue, 19 Oct 2021 21:43:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbhJSVqI (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 19 Oct 2021 17:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbhJSVqC (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 19 Oct 2021 17:46:02 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050::465:201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D2D6C06161C
        for <backports@vger.kernel.org>; Tue, 19 Oct 2021 14:43:49 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:105:465:1:3:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4HYnLW3HRhzQkhq;
        Tue, 19 Oct 2021 23:43:47 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1634679825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gEtnyIxHUjxaKbWG9BcyAyGuYv+R4GMqxCT1lvr6hIw=;
        b=LkTZigNVZZWg3EH9SRhBtsD8TUHPKtl8aPOq9Q+2Gn8yIstACftm2HptYivRNlcRMiaPKZ
        T6tIRs1nV9AfrBRhEnHjXyIP9FffbaUtU/P1suH4y7aoGIa0gDZ2zMdqq+bgmYGuUFa5/Q
        IVdA04a67xiHGaD3mrZ7jZRhimS5i6yI4aj8oEMQsQgdrNITgBPSwxR+sMWukqkV2dZjcI
        QlXKAURmqL1MkSZ2hK7QbMjdDl9hkAVJIZ1T26ZcN7azPQQDusiCzhN0n/IQ01R5dSCwSX
        PQwO/Ht3mMmZCkTDVPncahIKfYUHf7aYs96V0zvvEnz8vb+lTcDGjwzG2SbM/g==
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 25/47] headers: Add time_after32()
Date:   Tue, 19 Oct 2021 23:42:58 +0200
Message-Id: <20211019214320.2035704-26-hauke@hauke-m.de>
In-Reply-To: <20211019214320.2035704-1-hauke@hauke-m.de>
References: <20211019214320.2035704-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BF5881317
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

The function time_after32() was added in kernel 4.14 and is now used by
the mt76 driver.
The code was copied from the upstream kernel.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/time.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/backport/backport-include/linux/time.h b/backport/backport-include/linux/time.h
index ce8a1b03..712881db 100644
--- a/backport/backport-include/linux/time.h
+++ b/backport/backport-include/linux/time.h
@@ -12,4 +12,21 @@ static inline void time64_to_tm(time64_t totalsecs, int offset,
 }
 #endif
 
+#ifndef time_after32
+/**
+ * time_after32 - compare two 32-bit relative times
+ * @a:	the time which may be after @b
+ * @b:	the time which may be before @a
+ *
+ * time_after32(a, b) returns true if the time @a is after time @b.
+ * time_before32(b, a) returns true if the time @b is before time @a.
+ *
+ * Similar to time_after(), compare two 32-bit timestamps for relative
+ * times.  This is useful for comparing 32-bit seconds values that can't
+ * be converted to 64-bit values (e.g. due to disk format or wire protocol
+ * issues) when it is known that the times are less than 68 years apart.
+ */
+#define time_after32(a, b)	((s32)((u32)(b) - (u32)(a)) < 0)
+#endif
+
 #endif /* __BACKPORT_LINUX_TIME_H */
-- 
2.30.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
