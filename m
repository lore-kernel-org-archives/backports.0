Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF046C433FE
	for <backports@archiver.kernel.org>; Wed,  6 Apr 2022 22:03:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236240AbiDFWFl (ORCPT <rfc822;backports@archiver.kernel.org>);
        Wed, 6 Apr 2022 18:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236644AbiDFWFj (ORCPT
        <rfc822;backports@vger.kernel.org>); Wed, 6 Apr 2022 18:05:39 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870461D08CA
        for <backports@vger.kernel.org>; Wed,  6 Apr 2022 15:03:41 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4KYdnM21Rsz9sRp;
        Thu,  7 Apr 2022 00:03:35 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1649282613;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YgLBV5FLnRmW0q6twzeWpIKz6PR8gBnnoBaMHZFPXJU=;
        b=0UMlVIA+gtfy04n2ncam3U0dcZw0irQoM5k4TeWwyplhBi1TAPaGz58oxHuLdl8oXFJuQt
        RbpuqjwF1nbPtDkpQ39TXD9MLAmbrxreGb3ngokHJr4hDrWQTxe80cdpgU8e6cpqmzEYt0
        y2+RVbzvAaZTg69EJ2mrVXLYKfqVerT/O3+m40IlnpT9sd1h8DfTrKyPKMza4+ekNab6YU
        NT0I5d+Xfr4rXVFHDyVkwWYxLsU/UiXBqz+yZPrZdHwCKBxbhBleLiR+sC41zBrj3BPc5V
        J/TeVCidFLCXQ6bbJdbrl5XcBecFzoUdOJS1WqvNI6OZrGAmHZmzx9/JmsJaBA==
To:     backports@vger.kernel.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 2/4] headers: Add data_race(expr)
Date:   Thu,  7 Apr 2022 00:03:19 +0200
Message-Id: <20220406220321.3864576-2-hauke@hauke-m.de>
In-Reply-To: <20220406220321.3864576-1-hauke@hauke-m.de>
References: <20220406220321.3864576-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

This define is just a hint for the compiler that it should ignore the
data race.
It was added to mainline Linux kernel in commit c48981eeb0d5
("include/linux/compiler.h: Introduce data_race(expr) macro") with
kernel 5.8 to provide a hint to the compiler and the reviewer that there
is an intentional data race.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/compiler.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/backport/backport-include/linux/compiler.h b/backport/backport-include/linux/compiler.h
index 51a6ec2c..820e6046 100644
--- a/backport/backport-include/linux/compiler.h
+++ b/backport/backport-include/linux/compiler.h
@@ -94,4 +94,8 @@ static __always_inline void __write_once_size(volatile void *p, void *res, int s
 #define OPTIMIZER_HIDE_VAR(var) barrier()
 #endif
 
+#ifndef data_race
+#define data_race(expr)	(expr)
+#endif
+
 #endif /* __BACKPORT_LINUX_COMPILER_H */
-- 
2.30.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
