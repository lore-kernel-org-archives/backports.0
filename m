Return-Path: <SRS0=7Ax0=OL=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B861EC64EB4
	for <backports@archiver.kernel.org>; Sun,  2 Dec 2018 11:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88C6020834
	for <backports@archiver.kernel.org>; Sun,  2 Dec 2018 11:52:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88C6020834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=backports-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725842AbeLBLw6 (ORCPT <rfc822;backports@archiver.kernel.org>);
        Sun, 2 Dec 2018 06:52:58 -0500
Received: from mx1.mailbox.org ([80.241.60.212]:50440 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725837AbeLBLw6 (ORCPT <rfc822;backports@vger.kernel.org>);
        Sun, 2 Dec 2018 06:52:58 -0500
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id BD52E40594;
        Sun,  2 Dec 2018 12:52:54 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id HRtjzmnA_M84; Sun,  2 Dec 2018 12:52:51 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     johannes@sipsolutions.net
Cc:     backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 03/12] backports: Add page_frag_alloc() and __page_frag_cache_drain()
Date:   Sun,  2 Dec 2018 12:52:17 +0100
Message-Id: <20181202115226.3594-4-hauke@hauke-m.de>
In-Reply-To: <20181202115226.3594-1-hauke@hauke-m.de>
References: <20181202115226.3594-1-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

This was introduced in kernel commit 8c2dd3e4a4b ("mm: rename
__alloc_page_frag to page_frag_alloc and __free_page_frag to
page_frag_free") and commit 44fdffd7050 ("mm: add support for releasing
multiple instances of a page") and is used by the mt76 driver.
Backporting it to kernel older than 4.2 is harder so just do it till
that version.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/gfp.h | 12 ++++++++++++
 backport/compat/backport-4.10.c       | 22 ++++++++++++++++++++++
 dependencies                          |  9 +++++----
 3 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/backport/backport-include/linux/gfp.h b/backport/backport-include/linux/gfp.h
index 42f818f1..d41d4277 100644
--- a/backport/backport-include/linux/gfp.h
+++ b/backport/backport-include/linux/gfp.h
@@ -10,4 +10,16 @@
 #define __GFP_KSWAPD_RECLAIM	((__force gfp_t)___GFP_KSWAPD_RECLAIM) /* kswapd can wake */
 #endif
 
+#if LINUX_VERSION_IS_LESS(4,10,0) && LINUX_VERSION_IS_GEQ(4,2,0)
+#define page_frag_alloc LINUX_BACKPORT(page_frag_alloc)
+static inline void *page_frag_alloc(struct page_frag_cache *nc,
+				    unsigned int fragsz, gfp_t gfp_mask)
+{
+	return __alloc_page_frag(nc, fragsz, gfp_mask);
+}
+
+#define __page_frag_cache_drain LINUX_BACKPORT(__page_frag_cache_drain)
+void __page_frag_cache_drain(struct page *page, unsigned int count);
+#endif /* < 4.10 && >= 4.2 */
+
 #endif /* __BACKPORT_LINUX_GFP_H */
diff --git a/backport/compat/backport-4.10.c b/backport/compat/backport-4.10.c
index 44e02dd7..a35c699e 100644
--- a/backport/compat/backport-4.10.c
+++ b/backport/compat/backport-4.10.c
@@ -12,6 +12,8 @@
 #include <linux/netdevice.h>
 #include <linux/ethtool.h>
 #include <linux/mii.h>
+#include <linux/page_ref.h>
+#include <linux/gfp.h>
 
 #if LINUX_VERSION_IS_GEQ(4,6,0)
 #if LINUX_VERSION_IS_LESS(4,7,0)
@@ -252,3 +254,23 @@ int mii_ethtool_get_link_ksettings(struct mii_if_info *mii,
 }
 EXPORT_SYMBOL(mii_ethtool_get_link_ksettings);
 #endif /* LINUX_VERSION_IS_GEQ(4,6,0) */
+
+#if LINUX_VERSION_IS_GEQ(4,2,0)
+void __page_frag_cache_drain(struct page *page, unsigned int count)
+{
+	VM_BUG_ON_PAGE(page_ref_count(page) == 0, page);
+
+	if (page_ref_sub_and_test(page, count)) {
+		unsigned int order = compound_order(page);
+
+		/*
+		 * __free_pages_ok() is not exported so call
+		 * __free_pages() which decrements the ref counter
+		 * and increment the ref counter before.
+		 */
+		page_ref_inc(page);
+		__free_pages(page, order);
+	}
+}
+EXPORT_SYMBOL_GPL(__page_frag_cache_drain);
+#endif
diff --git a/dependencies b/dependencies
index 84bffd77..7d483a28 100644
--- a/dependencies
+++ b/dependencies
@@ -71,11 +71,12 @@ RSI_SDIO 3.13
 # For Coexsitence the BT driver has to export rsi_bt_ops
 RSI_COEX 4.17
 
-# depends on devm_led_classdev_register()
+# depends on devm_led_classdev_register() and struct page_frag_cache
 # (can't use MT76_CORE for this as it's selected)
-MT76x0U 4.1
-MT76x2E 4.1
-MT76x2U 4.1
+MT76x0U 4.2
+MT76x0E 4.2
+MT76x2E 4.2
+MT76x2U 4.2
 
 # select_queue_fallback_t is missing
 RTL8723BS 3.14
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
