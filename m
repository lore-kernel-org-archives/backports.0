Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32927C433F5
	for <backports@archiver.kernel.org>; Tue, 19 Oct 2021 21:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D4B2610A3
	for <backports@archiver.kernel.org>; Tue, 19 Oct 2021 21:43:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbhJSVqF (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 19 Oct 2021 17:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbhJSVqB (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 19 Oct 2021 17:46:01 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [IPv6:2001:67c:2050::465:102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A2A8C061769
        for <backports@vger.kernel.org>; Tue, 19 Oct 2021 14:43:46 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:105:465:1:3:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4HYnLT28sjzQjgT;
        Tue, 19 Oct 2021 23:43:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1634679823;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cLc2UXtuSEVCgZKFbXeboJFoJXw7nXb0GS0/higextw=;
        b=ldgafAY3GqNoarDB1fXry2I9N6h1s38f8Y4MwbNtSqtDiVWMcYfCdSroMnR0CuU/ErPapX
        jCK5KSlpmStBO0KVvyvWpNWwPiO1KQrvlqKuNwL74CBJSqhvs8Vl/4xNTheIdX8vPct20d
        Lz00irg/ZjNcac8K+WYoT4qVt71SVwtaaiky5urYbinKk43lhnPxaMjeuxup/YqnM0ZaX1
        SC9oK33iAbxvyzGuI0iGyc7t+tMw91RbEoIVhlb1/6bxPD/yP23iE4yWJWmS0HSW/k1Eac
        AMzcSS+IdnkYHDeAG9BpyZbi982obPSOS+ZBSXCQZWCIr7ISFbyypj/GXU6P3Q==
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 19/47] headers: Add tasklet_disable_in_atomic()
Date:   Tue, 19 Oct 2021 23:42:52 +0200
Message-Id: <20211019214320.2035704-20-hauke@hauke-m.de>
In-Reply-To: <20211019214320.2035704-1-hauke@hauke-m.de>
References: <20211019214320.2035704-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8DBB11317
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

The tasklet_disable_in_atomic() function was added in kernel 5.13 and is
used by ath9k now.
The code was copied from the upstream kernel.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/interrupt.h | 23 ++++++++++++++++
 backport/compat/Makefile                    |  1 +
 backport/compat/backport-5.13.c             | 30 +++++++++++++++++++++
 3 files changed, 54 insertions(+)
 create mode 100644 backport/compat/backport-5.13.c

diff --git a/backport/backport-include/linux/interrupt.h b/backport/backport-include/linux/interrupt.h
index f334a963..41d50d7c 100644
--- a/backport/backport-include/linux/interrupt.h
+++ b/backport/backport-include/linux/interrupt.h
@@ -50,4 +50,27 @@ tasklet_setup(struct tasklet_struct *t,
 
 #endif
 
+#if LINUX_VERSION_IS_LESS(5,13,0)
+
+#define tasklet_unlock_spin_wait LINUX_BACKPORT(tasklet_unlock_spin_wait)
+#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT)
+void tasklet_unlock_spin_wait(struct tasklet_struct *t);
+
+#else
+static inline void tasklet_unlock_spin_wait(struct tasklet_struct *t) { }
+#endif
+
+/*
+ * Do not use in new code. Disabling tasklets from atomic contexts is
+ * error prone and should be avoided.
+ */
+#define tasklet_disable_in_atomic LINUX_BACKPORT(tasklet_disable_in_atomic)
+static inline void tasklet_disable_in_atomic(struct tasklet_struct *t)
+{
+	tasklet_disable_nosync(t);
+	tasklet_unlock_spin_wait(t);
+	smp_mb();
+}
+#endif
+
 #endif /* _BP_LINUX_INTERRUPT_H */
diff --git a/backport/compat/Makefile b/backport/compat/Makefile
index e927a0c8..2761e5f5 100644
--- a/backport/compat/Makefile
+++ b/backport/compat/Makefile
@@ -19,6 +19,7 @@ compat-$(CPTCFG_KERNEL_5_3) += backport-5.3.o
 compat-$(CPTCFG_KERNEL_5_5) += backport-5.5.o
 compat-$(CPTCFG_KERNEL_5_10) += backport-5.10.o
 compat-$(CPTCFG_KERNEL_5_11) += backport-5.11.o
+compat-$(CPTCFG_KERNEL_5_13) += backport-5.13.o
 
 compat-$(CPTCFG_BPAUTO_BUILD_SYSTEM_DATA_VERIFICATION) += verification/verify.o
 compat-$(CPTCFG_BPAUTO_BUILD_SYSTEM_DATA_VERIFICATION) += verification/pkcs7.asn1.o
diff --git a/backport/compat/backport-5.13.c b/backport/compat/backport-5.13.c
new file mode 100644
index 00000000..c10b3321
--- /dev/null
+++ b/backport/compat/backport-5.13.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/export.h>
+#include <linux/interrupt.h>
+
+#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT)
+/*
+ * Do not use in new code. Waiting for tasklets from atomic contexts is
+ * error prone and should be avoided.
+ */
+void tasklet_unlock_spin_wait(struct tasklet_struct *t)
+{
+	while (test_bit(TASKLET_STATE_RUN, &(t)->state)) {
+		if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
+			/*
+			 * Prevent a live lock when current preempted soft
+			 * interrupt processing or prevents ksoftirqd from
+			 * running. If the tasklet runs on a different CPU
+			 * then this has no effect other than doing the BH
+			 * disable/enable dance for nothing.
+			 */
+			local_bh_disable();
+			local_bh_enable();
+		} else {
+			cpu_relax();
+		}
+	}
+}
+EXPORT_SYMBOL_GPL(tasklet_unlock_spin_wait);
+#endif
-- 
2.30.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
