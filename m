Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB12EC71155
	for <backports@archiver.kernel.org>; Tue,  1 Dec 2020 22:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51B402085B
	for <backports@archiver.kernel.org>; Tue,  1 Dec 2020 22:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="1tJTYJDM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730033AbgLAWF0 (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 1 Dec 2020 17:05:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730057AbgLAWF0 (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 1 Dec 2020 17:05:26 -0500
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050::465:101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 933F2C061A04
        for <backports@vger.kernel.org>; Tue,  1 Dec 2020 14:04:35 -0800 (PST)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4Clx360n8bzQlM3;
        Tue,  1 Dec 2020 23:04:34 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1606860272;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8MK4dFZXovNdmf3Lj1g/E5itizXxEPGWlUmiNMgwbmE=;
        b=1tJTYJDMqxQlEcMD6v2zaVQ4DKw9nzIJxTUSAGFz+Hk2dhiIohxezWzMmtgvEp9lUdPaMY
        R1qvHk/rkq5x3YjjvFzouFDrrNIlcxX8Sgb7yVfaFtkYePg/rbloZva2pBagX0rmPXZmH4
        OMU78cKaFsf0krYPYPYxnBvMLFSG7Q+OWcVZzFSQkobdYhbs2ShIzEziHhjuqOe1OG1nr/
        jaFWvzw73e2MTkKdFdPS4MLqN6XgIbW4o2s78qs0jtG2fn62Nti4UG/IzhR64uDfa0VU52
        tP8lhozVhYlATaMjof0gim6R3HDMBxhNpPD4E5HyzVa7chXE6igp6GlgezMQWA==
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter02.heinlein-hosting.de (spamfilter02.heinlein-hosting.de [80.241.56.116]) (amavisd-new, port 10030)
        with ESMTP id S6-DjB5eeW-J; Tue,  1 Dec 2020 23:04:31 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes@sipsolutions.net, Felix Fietkau <nbd@nbd.name>
Subject: [PATCH 06/30] backports: add tasklet_setup, from_tasklet
Date:   Tue,  1 Dec 2020 23:03:51 +0100
Message-Id: <20201201220415.30582-7-hauke@hauke-m.de>
In-Reply-To: <20201201220415.30582-1-hauke@hauke-m.de>
References: <20201201220415.30582-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -0.42 / 15.00 / 15.00
X-Rspamd-Queue-Id: 1A26D1478
X-Rspamd-UID: 4958e6
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

From: Felix Fietkau <nbd@nbd.name>

Add the new tasklet API

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 backport/backport-include/linux/interrupt.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/backport/backport-include/linux/interrupt.h b/backport/backport-include/linux/interrupt.h
index f7e7134d..f334a963 100644
--- a/backport/backport-include/linux/interrupt.h
+++ b/backport/backport-include/linux/interrupt.h
@@ -31,6 +31,23 @@ static inline void backport_hrtimer_start(struct hrtimer *timer, s64 time,
 	hrtimer_start(timer, _time, mode);
 }
 #define hrtimer_start LINUX_BACKPORT(hrtimer_start)
+
+#endif
+
+#if LINUX_VERSION_IS_LESS(5,9,0)
+
+static inline void
+tasklet_setup(struct tasklet_struct *t,
+	      void (*callback)(struct tasklet_struct *))
+{
+	void (*cb)(unsigned long data) = (void *)callback;
+
+	tasklet_init(t, cb, (unsigned long)t);
+}
+
+#define from_tasklet(var, callback_tasklet, tasklet_fieldname) \
+	container_of(callback_tasklet, typeof(*var), tasklet_fieldname)
+
 #endif
 
 #endif /* _BP_LINUX_INTERRUPT_H */
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
