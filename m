Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB39C433FE
	for <backports@archiver.kernel.org>; Tue, 11 Oct 2022 21:05:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiJKVF0 (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 11 Oct 2022 17:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiJKVFF (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 11 Oct 2022 17:05:05 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7880622B2E
        for <backports@vger.kernel.org>; Tue, 11 Oct 2022 14:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=WwwT8zETysXbIfEYDkOsyYMEKL5s092bPivdy2F8Sf8=;
        t=1665522301; x=1666731901; b=gTrqSfnkkMjYcw8JnUBC9JqmIh/Yv9NlYMREwOOO4YNBuEy
        z1+rwjdwSZcFr0H6c8IrAz9uv3AXqdxnAAupy4VcGmlUOiISz56Zc+6DRvQyDSRfdSpHm/QjO46cV
        V6RJOXkrcnEErLJFBlWzvjjoTh7kjGJtDTYdoXGwLPeiuPWYjTEWjA67DX9QRHS0+WK8/kp/anRoT
        5cX6Qwk2/5m6KyauEFAXI4mkymO5G7+trVSS2W8I2M7KoOQbR8qjYrMSYlJoHnVZPVqe9CiK6iR8v
        ouW2uyio+GpnB1KhmgaewLzx9KvpzWjF4xoQs5nykQrRO09/GV0e46ncZLvBVG1A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oiMQs-0045LP-1n;
        Tue, 11 Oct 2022 23:04:58 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     backports@vger.kernel.org
Cc:     nbd@nbd.name, Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 33/38] backports: add mul_u64_u64_div_u64()
Date:   Tue, 11 Oct 2022 23:04:41 +0200
Message-Id: <20221011230356.8a84958f6acb.Ia106b487910574e59b56065f04f9448655011b0a@changeid>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221011210446.144768-1-johannes@sipsolutions.net>
References: <20221011210446.144768-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/math64.h | 11 ++++++
 backport/compat/Makefile                 |  1 +
 backport/compat/backport-5.9.c           | 45 ++++++++++++++++++++++++
 3 files changed, 57 insertions(+)
 create mode 100644 backport/backport-include/linux/math64.h
 create mode 100644 backport/compat/backport-5.9.c

diff --git a/backport/backport-include/linux/math64.h b/backport/backport-include/linux/math64.h
new file mode 100644
index 000000000000..6aea9c9eec77
--- /dev/null
+++ b/backport/backport-include/linux/math64.h
@@ -0,0 +1,11 @@
+#ifndef __BACKPORT_LINUX_MATH64_H
+#define __BACKPORT_LINUX_MATH64_H
+#include_next <linux/math64.h>
+#include <linux/version.h>
+
+#if LINUX_VERSION_IS_LESS(5,9,0)
+#define mul_u64_u64_div_u64 LINUX_BACKPORT(mul_u64_u64_div_u64)
+extern u64 mul_u64_u64_div_u64(u64 a, u64 b, u64 c);
+#endif /* < 5.9 */
+
+#endif /* __BACKPORT_LINUX_MATH64_H */
diff --git a/backport/compat/Makefile b/backport/compat/Makefile
index b9f1dee9ae07..c488fcdc727f 100644
--- a/backport/compat/Makefile
+++ b/backport/compat/Makefile
@@ -17,6 +17,7 @@ compat-$(CPTCFG_KERNEL_4_18) += backport-4.18.o
 compat-$(CPTCFG_KERNEL_5_2) += backport-5.2.o backport-genetlink.o
 compat-$(CPTCFG_KERNEL_5_3) += backport-5.3.o
 compat-$(CPTCFG_KERNEL_5_5) += backport-5.5.o
+compat-$(CPTCFG_KERNEL_5_9) += backport-5.9.o
 compat-$(CPTCFG_KERNEL_5_10) += backport-5.10.o
 compat-$(CPTCFG_KERNEL_5_11) += backport-5.11.o
 compat-$(CPTCFG_KERNEL_5_13) += backport-5.13.o
diff --git a/backport/compat/backport-5.9.c b/backport/compat/backport-5.9.c
new file mode 100644
index 000000000000..54d1802efd31
--- /dev/null
+++ b/backport/compat/backport-5.9.c
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/export.h>
+#include <linux/kernel.h>
+#include <linux/math64.h>
+
+u64 mul_u64_u64_div_u64(u64 a, u64 b, u64 c)
+{
+	u64 res = 0, div, rem;
+	int shift;
+
+	/* can a * b overflow ? */
+	if (ilog2(a) + ilog2(b) > 62) {
+		/*
+		 * (b * a) / c is equal to
+		 *
+		 *      (b / c) * a +
+		 *      (b % c) * a / c
+		 *
+		 * if nothing overflows. Can the 1st multiplication
+		 * overflow? Yes, but we do not care: this can only
+		 * happen if the end result can't fit in u64 anyway.
+		 *
+		 * So the code below does
+		 *
+		 *      res = (b / c) * a;
+		 *      b = b % c;
+		 */
+		div = div64_u64_rem(b, c, &rem);
+		res = div * a;
+		b = rem;
+
+		shift = ilog2(a) + ilog2(b) - 62;
+		if (shift > 0) {
+			/* drop precision */
+			b >>= shift;
+			c >>= shift;
+			if (!c)
+				return res;
+		}
+	}
+
+	return res + div64_u64(a * b, c);
+}
+EXPORT_SYMBOL_GPL(mul_u64_u64_div_u64);
-- 
2.37.3

--
To unsubscribe from this list: send the line "unsubscribe backports" in
