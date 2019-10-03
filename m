Return-Path: <SRS0=jmjh=X4=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF2AC10F14
	for <backports@archiver.kernel.org>; Thu,  3 Oct 2019 17:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF5D121A4C
	for <backports@archiver.kernel.org>; Thu,  3 Oct 2019 17:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbfJCP50 (ORCPT <rfc822;backports@archiver.kernel.org>);
        Thu, 3 Oct 2019 11:57:26 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:38532 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730943AbfJCP5Z (ORCPT <rfc822;backports@vger.kernel.org>);
        Thu, 3 Oct 2019 11:57:25 -0400
Received: from smtp2.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 399A2A36C3;
        Thu,  3 Oct 2019 17:57:23 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.240])
        by spamfilter06.heinlein-hosting.de (spamfilter06.heinlein-hosting.de [80.241.56.125]) (amavisd-new, port 10030)
        with ESMTP id Hk1g9Z3Ddxrs; Thu,  3 Oct 2019 17:57:20 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes@sipsolutions.net, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 07/11] backports: io.h: Add __ioread32_copy()
Date:   Thu,  3 Oct 2019 17:56:38 +0200
Message-Id: <20191003155642.14909-8-hauke@hauke-m.de>
In-Reply-To: <20191003155642.14909-1-hauke@hauke-m.de>
References: <20191003155642.14909-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

Add __ioread32_copy() from usptream Linux commit a9aec5881b9d
("lib/iomap_copy.c: add __ioread32_copy()") which is used by mt76
driver.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/io.h |  5 +++++
 backport/compat/backport-4.5.c       | 22 ++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/backport/backport-include/linux/io.h b/backport/backport-include/linux/io.h
index 78ae4650..f91085be 100644
--- a/backport/backport-include/linux/io.h
+++ b/backport/backport-include/linux/io.h
@@ -6,4 +6,9 @@
 #define IOMEM_ERR_PTR(err) (__force void __iomem *)ERR_PTR(err)
 #endif
 
+#if LINUX_VERSION_IS_LESS(4,5,0)
+#define __ioread32_copy LINUX_BACKPORT(__ioread32_copy)
+void __ioread32_copy(void *to, const void __iomem *from, size_t count);
+#endif
+
 #endif /* __BP_LINUX_IO_H */
diff --git a/backport/compat/backport-4.5.c b/backport/compat/backport-4.5.c
index 13764dc7..b4aae624 100644
--- a/backport/compat/backport-4.5.c
+++ b/backport/compat/backport-4.5.c
@@ -18,6 +18,7 @@
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <asm/uaccess.h>
+#include <linux/io.h>
 
 #if LINUX_VERSION_IS_GEQ(3,19,0)
 int led_set_brightness_sync(struct led_classdev *led_cdev,
@@ -150,3 +151,24 @@ int devm_led_trigger_register(struct device *dev,
 	return rc;
 }
 EXPORT_SYMBOL_GPL(devm_led_trigger_register);
+
+/**
+ * __ioread32_copy - copy data from MMIO space, in 32-bit units
+ * @to: destination (must be 32-bit aligned)
+ * @from: source, in MMIO space (must be 32-bit aligned)
+ * @count: number of 32-bit quantities to copy
+ *
+ * Copy data from MMIO space to kernel space, in units of 32 bits at a
+ * time.  Order of access is not guaranteed, nor is a memory barrier
+ * performed afterwards.
+ */
+void __ioread32_copy(void *to, const void __iomem *from, size_t count)
+{
+	u32 *dst = to;
+	const u32 __iomem *src = from;
+	const u32 __iomem *end = src + count;
+
+	while (src < end)
+		*dst++ = __raw_readl(src++);
+}
+EXPORT_SYMBOL_GPL(__ioread32_copy);
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
