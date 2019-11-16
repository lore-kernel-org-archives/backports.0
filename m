Return-Path: <SRS0=8p+7=ZI=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D5BC432C3
	for <backports@archiver.kernel.org>; Sat, 16 Nov 2019 18:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B3FB206C0
	for <backports@archiver.kernel.org>; Sat, 16 Nov 2019 18:43:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbfKPSnm (ORCPT <rfc822;backports@archiver.kernel.org>);
        Sat, 16 Nov 2019 13:43:42 -0500
Received: from mout-u-204.mailbox.org ([91.198.250.253]:18198 "EHLO
        mout-u-204.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727620AbfKPSnm (ORCPT
        <rfc822;backports@vger.kernel.org>); Sat, 16 Nov 2019 13:43:42 -0500
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-u-204.mailbox.org (Postfix) with ESMTPS id 47FkT41kpJzQl32;
        Sat, 16 Nov 2019 19:36:40 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter03.heinlein-hosting.de (spamfilter03.heinlein-hosting.de [80.241.56.117]) (amavisd-new, port 10030)
        with ESMTP id 76MmBittNoXp; Sat, 16 Nov 2019 19:36:37 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes@sipsolutions.net, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 3/3] backports: Add kvcalloc()
Date:   Sat, 16 Nov 2019 19:36:23 +0100
Message-Id: <20191116183623.8858-3-hauke@hauke-m.de>
In-Reply-To: <20191116183623.8858-1-hauke@hauke-m.de>
References: <20191116183623.8858-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

kvcalloc() was added in kernel commit 1c542f38ab8d ("mm: Introduce
kvcalloc()") and is now used by the fq header filers.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/mm.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/backport/backport-include/linux/mm.h b/backport/backport-include/linux/mm.h
index b28156d3..8ff7d6a6 100644
--- a/backport/backport-include/linux/mm.h
+++ b/backport/backport-include/linux/mm.h
@@ -50,4 +50,12 @@ static inline void *kvzalloc(size_t size, gfp_t flags)
 }
 #endif
 
+#if LINUX_VERSION_IS_LESS(4,18,0)
+#define kvcalloc LINUX_BACKPORT(kvcalloc)
+static inline void *kvcalloc(size_t n, size_t size, gfp_t flags)
+{
+	return kvmalloc_array(n, size, flags | __GFP_ZERO);
+}
+#endif /* < 4.18 */
+
 #endif /* __BACKPORT_MM_H */
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
