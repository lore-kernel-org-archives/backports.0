Return-Path: <SRS0=vds9=5F=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 159ACC54FCA
	for <backports@archiver.kernel.org>; Fri, 20 Mar 2020 23:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF66920714
	for <backports@archiver.kernel.org>; Fri, 20 Mar 2020 23:40:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbgCTXkR (ORCPT <rfc822;backports@archiver.kernel.org>);
        Fri, 20 Mar 2020 19:40:17 -0400
Received: from mout-p-101.mailbox.org ([80.241.56.151]:28572 "EHLO
        mout-p-101.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbgCTXkR (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 20 Mar 2020 19:40:17 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 48kgHg3s2czKmVC;
        Sat, 21 Mar 2020 00:40:15 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter06.heinlein-hosting.de (spamfilter06.heinlein-hosting.de [80.241.56.125]) (amavisd-new, port 10030)
        with ESMTP id xDzGN6CQ5RMw; Sat, 21 Mar 2020 00:40:12 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes@sipsolutions.net, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 8/8] backports: page_ref.h: Exclude page_ref_count() on kernel >= 4.4.216
Date:   Sat, 21 Mar 2020 00:39:50 +0100
Message-Id: <20200320233950.32257-9-hauke@hauke-m.de>
In-Reply-To: <20200320233950.32257-1-hauke@hauke-m.de>
References: <20200320233950.32257-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

page_ref_count() was backported to kernel version 4.4.216, do not add it
in backports for this kernel version any more.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/page_ref.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/backport/backport-include/linux/page_ref.h b/backport/backport-include/linux/page_ref.h
index e45734ec..12fd86c9 100644
--- a/backport/backport-include/linux/page_ref.h
+++ b/backport/backport-include/linux/page_ref.h
@@ -9,10 +9,12 @@ static inline void page_ref_inc(struct page *page)
 	atomic_inc(&page->_count);
 }
 
+#if !LINUX_VERSION_IN_RANGE(4,4,216, 4,5,0)
 static inline int page_ref_count(struct page *page)
 {
 	return atomic_read(&page->_count);
 }
+#endif /* 4.4.216 <= x < 4.5 */
 
 static inline int page_ref_sub_and_test(struct page *page, int nr)
 {
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
