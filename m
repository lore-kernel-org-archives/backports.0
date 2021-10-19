Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD717C43219
	for <backports@archiver.kernel.org>; Tue, 19 Oct 2021 21:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B751C61052
	for <backports@archiver.kernel.org>; Tue, 19 Oct 2021 21:43:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbhJSVqJ (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 19 Oct 2021 17:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbhJSVqE (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 19 Oct 2021 17:46:04 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050::465:201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E745AC061749
        for <backports@vger.kernel.org>; Tue, 19 Oct 2021 14:43:50 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [80.241.60.233])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4HYnLY46dzzQkhq;
        Tue, 19 Oct 2021 23:43:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1634679827;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KTtZsXY31hFSlmwDOu1wThfl0yHXRedpfSYkCy3niXo=;
        b=q6bUkUSykI2pzQfq9lSIsLgSCD5OJV0IhxjOz7DzU6dIlmj8Q4gH3RjPgigPxOKERlR+cp
        UjtJ65SfWDPk+dZyhnsv6b2lOxUCTHPT7CZqdRIw4XlcBUL0cjzy/GPjiq7GlrNG4nYrbE
        3zy8BDVuq8wrhhbhJxP/qNBOFeZUZZH97nMcqGpd3NaVzWvxJKElntAMMthUW/H1EZbiMN
        ok8wxzIzh4qHkAf5yndajEdSudjdD7smTD2X6Kxi1++kbPOGYWTnDkVWV6VdYZ7B8pSRNl
        oQnEMdlabcLQe/Ku4OoCeVqwrHdgi51h5XDZNo7JOdLtV4b+qplBi0EbSRnYqA==
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 30/47] headers: Add get_unaligned_be24
Date:   Tue, 19 Oct 2021 23:43:03 +0200
Message-Id: <20211019214320.2035704-31-hauke@hauke-m.de>
In-Reply-To: <20211019214320.2035704-1-hauke@hauke-m.de>
References: <20211019214320.2035704-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DCA7E1317
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

The get_unaligned_be24 function was added with kernel 5.7 to the general
header files and is now used by rtl8723bs.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/asm/unaligned.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 backport/backport-include/asm/unaligned.h

diff --git a/backport/backport-include/asm/unaligned.h b/backport/backport-include/asm/unaligned.h
new file mode 100644
index 00000000..4e2a6a41
--- /dev/null
+++ b/backport/backport-include/asm/unaligned.h
@@ -0,0 +1,17 @@
+#ifndef __BACKPORT_ASM_GENERIC_UNALIGNED_H
+#define __BACKPORT_ASM_GENERIC_UNALIGNED_H
+#include_next <asm/unaligned.h>
+
+#if LINUX_VERSION_IS_LESS(5,7,0)
+static inline u32 __get_unaligned_be24(const u8 *p)
+{
+	return p[0] << 16 | p[1] << 8 | p[2];
+}
+
+static inline u32 get_unaligned_be24(const void *p)
+{
+	return __get_unaligned_be24(p);
+}
+#endif /* < 5.7 */
+
+#endif /* __BACKPORT_ASM_GENERIC_UNALIGNED_H */
-- 
2.30.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
