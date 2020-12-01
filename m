Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED1F0C8300F
	for <backports@archiver.kernel.org>; Tue,  1 Dec 2020 22:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9542620709
	for <backports@archiver.kernel.org>; Tue,  1 Dec 2020 22:05:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="v7U+LAnz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730057AbgLAWFz (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 1 Dec 2020 17:05:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728547AbgLAWFy (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 1 Dec 2020 17:05:54 -0500
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050::465:201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB5E6C061A4B
        for <backports@vger.kernel.org>; Tue,  1 Dec 2020 14:04:38 -0800 (PST)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Clx392YQLzQlXQ;
        Tue,  1 Dec 2020 23:04:37 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1606860275;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aEj0YdB06iV0qK6tYboKZu0X+ZHvolwZ4KGjOiShGgo=;
        b=v7U+LAnz8lvHjH+vZAXzBFZbpndxm4/lsqzAWA04923tR6W+FIyhSypzb18qgYgHlG8h57
        Vp5cQbwSreMN8pQk2D2tUDGlfK3eek66YWHimw0CsX3D3FikpNtVW8k46BWFx63NSgd9MY
        NY5ccekNOyW6LOlC/EKDFf2la5qRgqkS44Skp8UgdI4ayw6E23pfDgRCa4JIpZdF1HY1Es
        CAjI3r08iDoNDj2HiIYLK7wJUpi2I16j0tBoa0+uCfchjDY/IKMzXtq4MTwk1Jsrri6j0J
        tphU+foS32wsjSESxEMdlByQBX8BixSxKohsC9IzQQ/634/c3wBo5b7t2VNIMw==
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter02.heinlein-hosting.de (spamfilter02.heinlein-hosting.de [80.241.56.116]) (amavisd-new, port 10030)
        with ESMTP id QR6EZVpwxxHz; Tue,  1 Dec 2020 23:04:34 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes@sipsolutions.net, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 14/30] backports: add gpiochip_request_own_desc()
Date:   Tue,  1 Dec 2020 23:03:59 +0100
Message-Id: <20201201220415.30582-15-hauke@hauke-m.de>
In-Reply-To: <20201201220415.30582-1-hauke@hauke-m.de>
References: <20201201220415.30582-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -5.18 / 15.00 / 15.00
X-Rspamd-Queue-Id: 7763F1833
X-Rspamd-UID: 366f8f
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

The signature of the gpiochip_request_own_desc() function changes
multiple times, adapt this in the backports layer as good as possible.
brcmfmac is using this function.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/gpio/driver.h | 12 +++
 backport/compat/Makefile                      |  1 +
 backport/compat/backport-5.3.c                | 74 +++++++++++++++++++
 3 files changed, 87 insertions(+)
 create mode 100644 backport/compat/backport-5.3.c

diff --git a/backport/backport-include/linux/gpio/driver.h b/backport/backport-include/linux/gpio/driver.h
index 8df5c298..cebeb482 100644
--- a/backport/backport-include/linux/gpio/driver.h
+++ b/backport/backport-include/linux/gpio/driver.h
@@ -7,4 +7,16 @@
 #include_next <linux/gpio/driver.h>
 #endif
 
+#if LINUX_VERSION_IN_RANGE(3,17,0, 5,3,0)
+enum gpiod_flags;
+enum gpio_lookup_flags;
+
+#define gpiochip_request_own_desc LINUX_BACKPORT(gpiochip_request_own_desc)
+struct gpio_desc *backport_gpiochip_request_own_desc(struct gpio_chip *gc,
+					    unsigned int hwnum,
+					    const char *label,
+					    enum gpio_lookup_flags lflags,
+					    enum gpiod_flags dflags);
+#endif /* 3.17.0 <= x < 5.3.0 */
+
 #endif /* __BP_GPIO_DRIVER_H */
diff --git a/backport/compat/Makefile b/backport/compat/Makefile
index 6f1b0a89..8d917622 100644
--- a/backport/compat/Makefile
+++ b/backport/compat/Makefile
@@ -38,6 +38,7 @@ compat-$(CPTCFG_KERNEL_4_8) += backport-4.8.o
 compat-$(CPTCFG_KERNEL_4_10) += backport-4.10.o
 compat-$(CPTCFG_KERNEL_4_18) += backport-4.18.o
 compat-$(CPTCFG_KERNEL_5_2) += backport-5.2.o backport-genetlink.o
+compat-$(CPTCFG_KERNEL_5_3) += backport-5.3.o
 compat-$(CPTCFG_KERNEL_5_5) += backport-5.5.o
 
 compat-$(CPTCFG_BPAUTO_BUILD_SYSTEM_DATA_VERIFICATION) += verification/verify.o
diff --git a/backport/compat/backport-5.3.c b/backport/compat/backport-5.3.c
new file mode 100644
index 00000000..f501448e
--- /dev/null
+++ b/backport/compat/backport-5.3.c
@@ -0,0 +1,74 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/export.h>
+#include <linux/gpio.h>
+#if LINUX_VERSION_IS_GEQ(3,17,0)
+#include <linux/gpio/driver.h>
+#include <linux/gpio/consumer.h>
+#include <linux/gpio/machine.h>
+
+/**
+ * gpiod_configure_flags - helper function to configure a given GPIO
+ * @desc:	gpio whose value will be assigned
+ * @con_id:	function within the GPIO consumer
+ * @lflags:	bitmask of gpio_lookup_flags GPIO_* values - returned from
+ *		of_find_gpio() or of_get_gpio_hog()
+ * @dflags:	gpiod_flags - optional GPIO initialization flags
+ *
+ * Return 0 on success, -ENOENT if no GPIO has been assigned to the
+ * requested function and/or index, or another IS_ERR() code if an error
+ * occurred while trying to acquire the GPIO.
+ */
+static int gpiod_configure_flags(struct gpio_desc *desc, const char *con_id,
+		unsigned long lflags, enum gpiod_flags dflags)
+{
+	int ret;
+
+#ifdef GPIO_TRANSITORY
+	ret = gpiod_set_transitory(desc, (lflags & GPIO_TRANSITORY));
+	if (ret < 0)
+		return ret;
+#endif
+
+	/* No particular flag request, return here... */
+	if (!(dflags & GPIOD_FLAGS_BIT_DIR_SET))
+		return 0;
+
+	/* Process flags */
+	if (dflags & GPIOD_FLAGS_BIT_DIR_OUT)
+		ret = gpiod_direction_output(desc,
+				!!(dflags & GPIOD_FLAGS_BIT_DIR_VAL));
+	else
+		ret = gpiod_direction_input(desc);
+
+	return ret;
+}
+
+#undef gpiochip_request_own_desc
+struct gpio_desc *backport_gpiochip_request_own_desc(struct gpio_chip *gc,
+					    unsigned int hwnum,
+					    const char *label,
+					    enum gpio_lookup_flags lflags,
+					    enum gpiod_flags dflags)
+{
+	struct gpio_desc *desc;
+	int ret;
+
+#if LINUX_VERSION_IS_GEQ(5,0,0)
+	desc = gpiochip_request_own_desc(gc, hwnum, label, dflags);
+#else
+	desc = gpiochip_request_own_desc(gc, hwnum, label);
+#endif
+	if (IS_ERR(desc))
+		return desc;
+
+	ret = gpiod_configure_flags(desc, label, lflags, dflags);
+	if (ret) {
+		gpiochip_free_own_desc(desc);
+		return ERR_PTR(ret);
+	}
+
+	return desc;
+}
+EXPORT_SYMBOL_GPL(backport_gpiochip_request_own_desc);
+#endif /* > 3.17 */
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
