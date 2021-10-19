Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90185C433FE
	for <backports@archiver.kernel.org>; Tue, 19 Oct 2021 21:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 768B261052
	for <backports@archiver.kernel.org>; Tue, 19 Oct 2021 21:44:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbhJSVqN (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 19 Oct 2021 17:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbhJSVqK (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 19 Oct 2021 17:46:10 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050::465:101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E42D8C06161C
        for <backports@vger.kernel.org>; Tue, 19 Oct 2021 14:43:56 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [80.241.60.233])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4HYnLg1CDRzQkBQ;
        Tue, 19 Oct 2021 23:43:55 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1634679833;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fwcIJNIUdPl5ux5Xj9iGHXbm0+2MLA33381wO9oSuO0=;
        b=k+FN+G9AP1LmT0JtdN/bkMoYvAUxqQZrF2+DjSCb5is7WtSp2wNW1/kWhrLkK0r3i57zOE
        UxSgpEc89wc0U5gYeK7JonmAgJYro24N7sgWLnVefn/wZFnB7YSvalb+p4lcl7WKe4XYO0
        +I/w9+/xpTOKuLkmebs+JGrCiKgxfVO90O7QmmmgWMKDBcOQVvxKyNT2pn0H86RLS/rP0f
        vN1+Y5RWOAfGeLvmMLJnzYXR5xOPgDbmFBX1NFW6zRNP9hJM1odsmz8iXUp8Mwehm7kQMW
        blxkITsjjyite1xsmtweq/S4AuN0BDNAJa5l/r1gftCc1QdNR2ecKZDelxZ4ew==
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 44/47] headers: Add new include/linux/bits.h
Date:   Tue, 19 Oct 2021 23:43:17 +0200
Message-Id: <20211019214320.2035704-45-hauke@hauke-m.de>
In-Reply-To: <20211019214320.2035704-1-hauke@hauke-m.de>
References: <20211019214320.2035704-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6A2321319
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

With kernel 4.19 some defines from include/linux/bitops.h were extracted
to the new file include/linux/bits.h. This patch was also backported to
older stable kernel versions. This patch makes code include the
include/linux/bitops.h file on older kernel versions.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/bits.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 backport/backport-include/linux/bits.h

diff --git a/backport/backport-include/linux/bits.h b/backport/backport-include/linux/bits.h
new file mode 100644
index 00000000..db792196
--- /dev/null
+++ b/backport/backport-include/linux/bits.h
@@ -0,0 +1,14 @@
+#ifndef __BACKPORT_LINUX_BITS_H
+#define __BACKPORT_LINUX_BITS_H
+#include <linux/version.h>
+
+#if LINUX_VERSION_IS_GEQ(4,19,0) || \
+    LINUX_VERSION_IN_RANGE(4,14,119, 4,15,0) || \
+    LINUX_VERSION_IN_RANGE(4,9,176, 4,10,0) || \
+    LINUX_VERSION_IN_RANGE(4,4,180, 4,5,0)
+#include_next <linux/bits.h>
+#else
+#include <linux/bitops.h>
+#endif /* >= 4.19 */
+
+#endif /* __BACKPORT_LINUX_BITS_H */
-- 
2.30.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
