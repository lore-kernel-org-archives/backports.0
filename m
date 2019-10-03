Return-Path: <SRS0=jmjh=X4=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 379C3C10F14
	for <backports@archiver.kernel.org>; Thu,  3 Oct 2019 17:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11EFF20865
	for <backports@archiver.kernel.org>; Thu,  3 Oct 2019 17:42:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732915AbfJCRmS (ORCPT <rfc822;backports@archiver.kernel.org>);
        Thu, 3 Oct 2019 13:42:18 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:38396 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730928AbfJCP5X (ORCPT <rfc822;backports@vger.kernel.org>);
        Thu, 3 Oct 2019 11:57:23 -0400
Received: from smtp2.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id F3720A33DD;
        Thu,  3 Oct 2019 17:57:21 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.240])
        by spamfilter04.heinlein-hosting.de (spamfilter04.heinlein-hosting.de [80.241.56.122]) (amavisd-new, port 10030)
        with ESMTP id Cpr35VEkpTGN; Thu,  3 Oct 2019 17:57:19 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes@sipsolutions.net, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 04/11] backports: platform_device.h: Add devm_platform_ioremap_resource()
Date:   Thu,  3 Oct 2019 17:56:35 +0200
Message-Id: <20191003155642.14909-5-hauke@hauke-m.de>
In-Reply-To: <20191003155642.14909-1-hauke@hauke-m.de>
References: <20191003155642.14909-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

Add devm_platform_ioremap_resource() from upstream kernel commit
7945f929f1a7 ("drivers: provide devm_platform_ioremap_resource()") which
is now used by the mt76 driver.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../backport-include/linux/platform_device.h  | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/backport/backport-include/linux/platform_device.h b/backport/backport-include/linux/platform_device.h
index 5b821ee4..87142d7c 100644
--- a/backport/backport-include/linux/platform_device.h
+++ b/backport/backport-include/linux/platform_device.h
@@ -33,4 +33,26 @@ module_exit(__platform_driver##_exit);
                         platform_driver_unregister)
 #endif
 
+#if LINUX_VERSION_IS_LESS(5,1,0)
+/**
+ * devm_platform_ioremap_resource - call devm_ioremap_resource() for a platform
+ *				    device
+ *
+ * @pdev: platform device to use both for memory resource lookup as well as
+ *        resource management
+ * @index: resource index
+ */
+#ifdef CONFIG_HAS_IOMEM
+#define devm_platform_ioremap_resource LINUX_BACKPORT(devm_platform_ioremap_resource)
+static inline void __iomem *devm_platform_ioremap_resource(struct platform_device *pdev,
+					     unsigned int index)
+{
+	struct resource *res;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, index);
+	return devm_ioremap_resource(&pdev->dev, res);
+}
+#endif /* CONFIG_HAS_IOMEM */
+#endif
+
 #endif /* __BACKPORT_PLATFORM_DEVICE_H */
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
