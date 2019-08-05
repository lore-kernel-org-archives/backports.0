Return-Path: <SRS0=hnMY=WB=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 096B7C433FF
	for <backports@archiver.kernel.org>; Mon,  5 Aug 2019 12:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5D122086D
	for <backports@archiver.kernel.org>; Mon,  5 Aug 2019 12:07:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbfHEMHv (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 5 Aug 2019 08:07:51 -0400
Received: from mx1.mailbox.org ([80.241.60.212]:48784 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727259AbfHEMHv (ORCPT <rfc822;backports@vger.kernel.org>);
        Mon, 5 Aug 2019 08:07:51 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id AC4F051464;
        Mon,  5 Aug 2019 14:07:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id e_Ixs_BaA2OU; Mon,  5 Aug 2019 14:07:42 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes@sipsolutions.net, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 03/12] header: Add ktime_get_boottime_ns()
Date:   Mon,  5 Aug 2019 14:06:55 +0200
Message-Id: <20190805120704.13128-4-hauke@hauke-m.de>
In-Reply-To: <20190805120704.13128-1-hauke@hauke-m.de>
References: <20190805120704.13128-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

ktime_get_boottime_ns() was added in commit 9285ec4c8b61 ("timekeeping:
Use proper clock specifier names in functions") in kernel 5.3. This is
used by multiple drivers.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/timekeeping.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/backport/backport-include/linux/timekeeping.h b/backport/backport-include/linux/timekeeping.h
index 71871531..25ceaf3e 100644
--- a/backport/backport-include/linux/timekeeping.h
+++ b/backport/backport-include/linux/timekeeping.h
@@ -17,11 +17,17 @@ static inline u64 ktime_get_ns(void)
 }
 
 extern ktime_t ktime_get_boottime(void);
-#define ktime_get_boot_ns LINUX_BACKPORT(ktime_get_boot_ns)
-static inline u64 ktime_get_boot_ns(void)
+#define ktime_get_boottime_ns LINUX_BACKPORT(ktime_get_boottime_ns)
+static inline u64 ktime_get_boottime_ns(void)
 {
 	return ktime_to_ns(ktime_get_boottime());
 }
+#elif LINUX_VERSION_IS_LESS(5,3,0)
+#define ktime_get_boottime_ns LINUX_BACKPORT(ktime_get_boottime_ns)
+static inline u64 ktime_get_boottime_ns(void)
+{
+	return ktime_get_boot_ns();
+}
 #endif /* < 3.17 */
 
 #if LINUX_VERSION_IS_LESS(4,18,0)
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
