Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6713C4167B
	for <backports@archiver.kernel.org>; Tue, 19 Oct 2021 21:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD5E161052
	for <backports@archiver.kernel.org>; Tue, 19 Oct 2021 21:43:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbhJSVqK (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 19 Oct 2021 17:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbhJSVqF (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 19 Oct 2021 17:46:05 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [IPv6:2001:67c:2050::465:102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2AF9C061746
        for <backports@vger.kernel.org>; Tue, 19 Oct 2021 14:43:51 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [80.241.60.233])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4HYnLZ1j19zQjbF;
        Tue, 19 Oct 2021 23:43:50 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1634679828;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8dggJecNc+LTKr316HNJthcZTUVCgooYbzghF9ZSKyM=;
        b=fzuCmYJdbGtzLlJz2+WryJDApIgAFjIzIYbU2t0tSpJPr5wuAZV/Y/tNtuYv79veqsNk6H
        Te8CC7jyA3aId/PiCno22MfOIHriBozeG2DXrZ6J2iljQD5vfRtkXnxvQgAvs+/U7BqUEL
        6bBDIH350jGcOdDQ1iAClcN5JA5F1RQ3uPiq1F/vc7yF5SdrQHl3mIBe8dBdTUMf46nW9R
        NuR1eQ+BafjtmHJ+vwwyIJXX867Ha1oes+QL2GaGDwEf/tvN1+wXgxP+njUERZapFMRe1e
        JbZNxNnUe1bFihaY+KgAs6nCbIWR43JtO+d0e88rDy/U71PA7ILm8RuHWVENrg==
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 32/47] headers: Adapt signature of hrtimer_forward_now()
Date:   Tue, 19 Oct 2021 23:43:05 +0200
Message-Id: <20211019214320.2035704-33-hauke@hauke-m.de>
In-Reply-To: <20211019214320.2035704-1-hauke@hauke-m.de>
References: <20211019214320.2035704-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 852FF731
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

The hrtimer_forward_now() function is now used by mac80211_hwsim.
In kernel 4.10 the type of the interval parameter of
hrtimer_forward_now() was changed from ktime_t to s64. This change
converts calls using the new version to the old one.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/interrupt.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/backport/backport-include/linux/interrupt.h b/backport/backport-include/linux/interrupt.h
index 41d50d7c..f42f2ddd 100644
--- a/backport/backport-include/linux/interrupt.h
+++ b/backport/backport-include/linux/interrupt.h
@@ -16,6 +16,15 @@ backport_hrtimer_forward(struct hrtimer *timer, ktime_t now, s64 interval)
 }
 #define hrtimer_forward LINUX_BACKPORT(hrtimer_forward)
 
+static inline u64
+backport_hrtimer_forward_now(struct hrtimer *timer, s64 interval)
+{
+	ktime_t _interval = { .tv64 = interval };
+
+	return hrtimer_forward_now(timer, _interval);
+}
+#define hrtimer_forward_now LINUX_BACKPORT(hrtimer_forward_now)
+
 static inline s64 backport_ns_to_ktime(u64 ns)
 {
 	ktime_t _time = ns_to_ktime(ns);
-- 
2.30.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
