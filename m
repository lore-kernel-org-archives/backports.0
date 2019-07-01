Return-Path: <SRS0=giDq=U6=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96728C0650E
	for <backports@archiver.kernel.org>; Mon,  1 Jul 2019 21:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E97F21479
	for <backports@archiver.kernel.org>; Mon,  1 Jul 2019 21:50:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbfGAVuC (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 1 Jul 2019 17:50:02 -0400
Received: from mx1.mailbox.org ([80.241.60.212]:40496 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726964AbfGAVuB (ORCPT <rfc822;backports@vger.kernel.org>);
        Mon, 1 Jul 2019 17:50:01 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id 36D474D3B2;
        Mon,  1 Jul 2019 23:50:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter05.heinlein-hosting.de (spamfilter05.heinlein-hosting.de [80.241.56.123]) (amavisd-new, port 10030)
        with ESMTP id cW93gW_hZrdu; Mon,  1 Jul 2019 23:49:52 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [PATCH 04/18] backport-include: add empty lockdep_map structure in lockdep.h
Date:   Mon,  1 Jul 2019 23:48:59 +0200
Message-Id: <20190701214914.8066-5-hauke@hauke-m.de>
In-Reply-To: <20190701214914.8066-1-hauke@hauke-m.de>
References: <20190701214914.8066-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

From: Arend van Spriel <arend.vanspriel@broadcom.com>

include/linux/rhashtable.h now uses struct lockdep_map unconditionally
which is fine for upstream as lockdep.h defines an empty lockdep_map
structure if CONFIG_LOCKDEP is not set. However, that is only true
since kernel 4.15 so adding such definition in our lockdep.h to cover
older kernels.

Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
 backport/backport-include/linux/lockdep.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/backport/backport-include/linux/lockdep.h b/backport/backport-include/linux/lockdep.h
index 5a5d0d0e..12b91b4f 100644
--- a/backport/backport-include/linux/lockdep.h
+++ b/backport/backport-include/linux/lockdep.h
@@ -14,4 +14,10 @@
 #endif /* CONFIG_LOCKDEP */
 #endif /* LINUX_VERSION_IS_LESS(3,9,0) */
 
+#if LINUX_VERSION_IS_LESS(4,15,0)
+#ifndef CONFIG_LOCKDEP
+struct lockdep_map { };
+#endif /* CONFIG_LOCKDEP */
+#endif /* LINUX_VERSION_IS_LESS(4,15,0) */
+
 #endif /* __BACKPORT_LINUX_LOCKDEP_H */
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
