Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46CA4C71156
	for <backports@archiver.kernel.org>; Tue,  1 Dec 2020 22:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0BDA2085B
	for <backports@archiver.kernel.org>; Tue,  1 Dec 2020 22:05:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="KIVFsBTj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729337AbgLAWFP (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 1 Dec 2020 17:05:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728654AbgLAWFP (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 1 Dec 2020 17:05:15 -0500
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [IPv6:2001:67c:2050::465:102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B16BC0617A7
        for <backports@vger.kernel.org>; Tue,  1 Dec 2020 14:04:35 -0800 (PST)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4Clx3541HvzQjZj;
        Tue,  1 Dec 2020 23:04:33 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1606860271;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JiTgdY4mqrpKzcCnzW+34YYWCt8fCbBHWkSmacktHNo=;
        b=KIVFsBTjbAviNhDHlcT7NffOxlxwm1b9sHM9JFrQslRrSqtSRku/ANqhpM6FcH/UM+3L5f
        sBVqO7/qEBwY0h5aF0KDFagM5+ZJIbAJ54N202CM9N/yCZavtjEyqEckLXkzjYNrU5xwh+
        hG6AoWdUwdIXXaOlnTPkyO2yO3JKvylD7tkTiiEQEIDrtiRVqYije91vj3AexESBlMVbft
        PXG8mDTWdoBx5/bsDeoRKWC8vRV3sZHt2Ks2ZodNe2+bJI8EQPOASeAWtl2sda7J4vs+O3
        rRxv1WUF+PUERD9nnuBKcq3GvRZkIRHEfFvkVqlhRP2bgYZNzH5RYV0Cyp7JZg==
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter03.heinlein-hosting.de (spamfilter03.heinlein-hosting.de [80.241.56.117]) (amavisd-new, port 10030)
        with ESMTP id eNpbD__JzgKJ; Tue,  1 Dec 2020 23:04:30 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes@sipsolutions.net, Felix Fietkau <nbd@nbd.name>,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 05/30] backports: add sched_set_fifo_low
Date:   Tue,  1 Dec 2020 23:03:50 +0100
Message-Id: <20201201220415.30582-6-hauke@hauke-m.de>
In-Reply-To: <20201201220415.30582-1-hauke@hauke-m.de>
References: <20201201220415.30582-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -6.26 / 15.00 / 15.00
X-Rspamd-Queue-Id: ADFDF263
X-Rspamd-UID: 9545cf
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

From: Felix Fietkau <nbd@nbd.name>

It is needed for mt76.

This was added in upsteram Linux commit 7318d4cc14c8 ("sched: Provide sched_set_fifo()")

Signed-off-by: Felix Fietkau <nbd@nbd.name>
[Use WARN_ON_ONCE(sched_setscheduler_nocheck(p, SCHED_FIFO, &sparam) !=
0); instead]
Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/sched.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 backport/backport-include/linux/sched.h

diff --git a/backport/backport-include/linux/sched.h b/backport/backport-include/linux/sched.h
new file mode 100644
index 00000000..36263857
--- /dev/null
+++ b/backport/backport-include/linux/sched.h
@@ -0,0 +1,20 @@
+#ifndef __BACKPORT_LINUX_SCHED_H
+#define __BACKPORT_LINUX_SCHED_H
+
+#include_next <linux/sched.h>
+#include <linux/version.h>
+
+#if LINUX_VERSION_IS_LESS(5,9,0)
+#if LINUX_VERSION_IS_GEQ(4,11,0)
+#include <uapi/linux/sched/types.h>
+#endif
+
+static inline void sched_set_fifo_low(struct task_struct *p)
+{
+	struct sched_param sparam = {.sched_priority = 1};
+
+	WARN_ON_ONCE(sched_setscheduler_nocheck(p, SCHED_FIFO, &sparam) != 0);
+}
+
+#endif /* < 5.9.0 */
+#endif /* __BACKPORT_LINUX_SCHED_H */
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
