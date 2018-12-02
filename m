Return-Path: <SRS0=7Ax0=OL=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1407C64EB4
	for <backports@archiver.kernel.org>; Sun,  2 Dec 2018 11:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 748102082F
	for <backports@archiver.kernel.org>; Sun,  2 Dec 2018 11:52:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 748102082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=backports-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725837AbeLBLxA (ORCPT <rfc822;backports@archiver.kernel.org>);
        Sun, 2 Dec 2018 06:53:00 -0500
Received: from mx1.mailbox.org ([80.241.60.212]:50492 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725814AbeLBLxA (ORCPT <rfc822;backports@vger.kernel.org>);
        Sun, 2 Dec 2018 06:53:00 -0500
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id 1E17240608;
        Sun,  2 Dec 2018 12:52:57 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id VGfzdpvWyt3r; Sun,  2 Dec 2018 12:52:51 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     johannes@sipsolutions.net
Cc:     backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 02/12] backports: Add page_ref_count() and page_ref_sub_and_test()
Date:   Sun,  2 Dec 2018 12:52:16 +0100
Message-Id: <20181202115226.3594-3-hauke@hauke-m.de>
In-Reply-To: <20181202115226.3594-1-hauke@hauke-m.de>
References: <20181202115226.3594-1-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

This was introduced in kernel commit fe896d18789 ("mm: introduce page
reference manipulation functions") and will be used by
__page_frag_cache_drain() in the next commit.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/page_ref.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/backport/backport-include/linux/page_ref.h b/backport/backport-include/linux/page_ref.h
index 55fc14f5..e45734ec 100644
--- a/backport/backport-include/linux/page_ref.h
+++ b/backport/backport-include/linux/page_ref.h
@@ -8,6 +8,16 @@ static inline void page_ref_inc(struct page *page)
 {
 	atomic_inc(&page->_count);
 }
+
+static inline int page_ref_count(struct page *page)
+{
+	return atomic_read(&page->_count);
+}
+
+static inline int page_ref_sub_and_test(struct page *page, int nr)
+{
+	return atomic_sub_and_test(nr, &page->_count);
+}
 #endif
 
 #endif /* __BP_PAGE_REF_H */
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
