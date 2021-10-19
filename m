Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CCDFC43217
	for <backports@archiver.kernel.org>; Tue, 19 Oct 2021 21:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88E0F610A3
	for <backports@archiver.kernel.org>; Tue, 19 Oct 2021 21:43:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbhJSVqG (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 19 Oct 2021 17:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbhJSVp7 (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 19 Oct 2021 17:45:59 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050::465:101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63DFDC061749
        for <backports@vger.kernel.org>; Tue, 19 Oct 2021 14:43:45 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:105:465:1:3:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4HYnLS0S24zQkBW;
        Tue, 19 Oct 2021 23:43:44 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1634679822;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WSFfJLmY1y93t+85Qr9gjsNwzoTL41iHC8P2iTjQhpE=;
        b=ToFseNoWkLSpXgya9xDQ7AZDOlAq0AHLCO1Rc8i0N7Vs5WE/o3VUnSg9bllM9ef7aeoEr0
        VfGfVtaeKJay2vnPgvsbAcvyaAJsvGQmPKlLnfIZxzNZP08QYPU8mjY6lVSFqdVWSV6A8g
        +Ri8Ld78HT1AmC2esUcTnzq10FhBw6+vgLJMJxItjwY/ddmPW5JXC5Bi6WFRBQGMmVw1zI
        LfIv40o2Jh+gYdy9AUDfi2m3ZsnycpaS0yPzq8ONjBMq0NNXYYDG2HEOfxtjlRY0TbKSmL
        CSSXCY6hknjI13qMbBGR+caP+LffLIrIbXjg8sOyLVzVzPyzelS7poF64rY9Tg==
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 16/47] headers: Add DECLARE_STATIC_KEY_FALSE
Date:   Tue, 19 Oct 2021 23:42:49 +0200
Message-Id: <20211019214320.2035704-17-hauke@hauke-m.de>
In-Reply-To: <20211019214320.2035704-1-hauke@hauke-m.de>
References: <20211019214320.2035704-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 52EAF569
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

This define was added in kernel 4.9 and is used by mac80211 now.
The code was copied from the upstream kernel.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/jump_label.h | 10 ++++++++++
 1 file changed, 10 insertions(+)
 create mode 100644 backport/backport-include/linux/jump_label.h

diff --git a/backport/backport-include/linux/jump_label.h b/backport/backport-include/linux/jump_label.h
new file mode 100644
index 00000000..43608fa0
--- /dev/null
+++ b/backport/backport-include/linux/jump_label.h
@@ -0,0 +1,10 @@
+#ifndef __BACKPORT_LINUX_JUMP_LABEL_H
+#define __BACKPORT_LINUX_JUMP_LABEL_H
+#include_next <linux/jump_label.h>
+
+#ifndef DECLARE_STATIC_KEY_FALSE
+#define DECLARE_STATIC_KEY_FALSE(name)	\
+	extern struct static_key_false name
+#endif
+
+#endif /* __BACKPORT_LINUX_JUMP_LABEL_H */
-- 
2.30.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
