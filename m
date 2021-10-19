Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ACAFC433FE
	for <backports@archiver.kernel.org>; Tue, 19 Oct 2021 21:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CAEF610A3
	for <backports@archiver.kernel.org>; Tue, 19 Oct 2021 21:43:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbhJSVp5 (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 19 Oct 2021 17:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbhJSVpz (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 19 Oct 2021 17:45:55 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050::465:201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151EAC06174E
        for <backports@vger.kernel.org>; Tue, 19 Oct 2021 14:43:41 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [80.241.60.233])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4HYnLM1vxxzQkhq;
        Tue, 19 Oct 2021 23:43:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1634679817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DvojDQsFVZ49pOjh2OnrL7BINA86FDblHbRHBvnXZEw=;
        b=oAJAWcPm9myaqqsZ9yqpE6kazJVmOwmr/86QYy1QFLAvUVzymjxwrv5ACOnMFaBWXRI+ok
        Q9OV8Yhn7q9aiaDr+n6npeNdPU+GR5XJ59yJ2E7S7QgpKML8QZZAG5K/CduT/fSwqMs02U
        19xFxYzPtYBt7i7MB8Cu7hdL6Hd96hUoC8Q0LWDYufe0pbD50oexWFOK1ZbTQrchsx2bw1
        KZsPJVCtoIvlKx50U9cbQmkAkENuf+/fsRicPF+BcFbm7wpE/xpJURuT0mcC9lkeeExtKm
        bDdHUgDNiFTgYYqDiWNLT/Xb5wFiiO32T6rLgjehdQGRi08EkB0fGhFxQur7AA==
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 04/47] backports: Add linux/math.h
Date:   Tue, 19 Oct 2021 23:42:37 +0200
Message-Id: <20211019214320.2035704-5-hauke@hauke-m.de>
In-Reply-To: <20211019214320.2035704-1-hauke@hauke-m.de>
References: <20211019214320.2035704-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 852F35AF
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

This header file was added to the kernel, by extracting some functions
from linux/kernel.h. Add an empty version which itself includes
linux/kernel.h This way it will provide the same data also on older
kernel versions.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/math.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 backport/backport-include/linux/math.h

diff --git a/backport/backport-include/linux/math.h b/backport/backport-include/linux/math.h
new file mode 100644
index 00000000..10225a9d
--- /dev/null
+++ b/backport/backport-include/linux/math.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __BACKPORTS_LINUX_MATH_H
+#define __BACKPORTS_LINUX_MATH_H
+#include <linux/version.h>
+
+#if LINUX_VERSION_IS_GEQ(5,11,0)
+#include_next <linux/math.h>
+#else
+#include <linux/kernel.h>
+#endif
+
+#endif /* __BACKPORTS_LINUX_MATH_H */
-- 
2.30.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
