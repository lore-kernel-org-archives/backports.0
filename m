Return-Path: <SRS0=w1W3=R5=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A02C43381
	for <backports@archiver.kernel.org>; Tue, 26 Mar 2019 15:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0C7A2070D
	for <backports@archiver.kernel.org>; Tue, 26 Mar 2019 15:12:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbfCZPMA (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 26 Mar 2019 11:12:00 -0400
Received: from mx1.mailbox.org ([80.241.60.212]:29178 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727492AbfCZPMA (ORCPT <rfc822;backports@vger.kernel.org>);
        Tue, 26 Mar 2019 11:12:00 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id 81E4C4CCF4;
        Tue, 26 Mar 2019 16:11:58 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter02.heinlein-hosting.de (spamfilter02.heinlein-hosting.de [80.241.56.116]) (amavisd-new, port 10030)
        with ESMTP id 0RoWybzKThAx; Tue, 26 Mar 2019 16:11:47 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 2/4] backports: Add smp_acquire__after_ctrl_dep()
Date:   Tue, 26 Mar 2019 16:11:36 +0100
Message-Id: <20190326151138.4141-2-hauke@hauke-m.de>
In-Reply-To: <20190326151138.4141-1-hauke@hauke-m.de>
References: <20190326151138.4141-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

smp_acquire__after_ctrl_dep() was introduced in kernel 4.8 in upstream
Linux commit 33ac279677d ("locking/barriers: Introduce
smp_acquire__after_ctrl_dep()") and is used by backports lib-refcount.c
implementation now.

This just adds the default implementation to backports.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/asm/barrier.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/backport/backport-include/asm/barrier.h b/backport/backport-include/asm/barrier.h
index 9e1e1f11..bca05588 100644
--- a/backport/backport-include/asm/barrier.h
+++ b/backport/backport-include/asm/barrier.h
@@ -19,4 +19,8 @@
 #define smp_mb__after_atomic smp_mb__after_clear_bit
 #endif
 
+#ifndef smp_acquire__after_ctrl_dep
+#define smp_acquire__after_ctrl_dep()		smp_rmb()
+#endif
+
 #endif /* __BACKPORT_ASM_BARRIER_H */
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
