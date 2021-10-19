Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0862C4167D
	for <backports@archiver.kernel.org>; Tue, 19 Oct 2021 21:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D641F610A3
	for <backports@archiver.kernel.org>; Tue, 19 Oct 2021 21:44:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbhJSVqO (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 19 Oct 2021 17:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbhJSVqK (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 19 Oct 2021 17:46:10 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050::465:201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302BBC061749
        for <backports@vger.kernel.org>; Tue, 19 Oct 2021 14:43:57 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:105:465:1:3:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4HYnLg31RtzQkBc;
        Tue, 19 Oct 2021 23:43:55 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1634679833;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BwuoguDRRE7ldutAuKM1I9niXM5DfUsC0bLeyy5aw90=;
        b=qO9TDRtDTMEfvJf8oOWzJBjTtuQplZkROsipL6VG7zwCR5tjXzejeGkkf4DyF+gZzBgv+0
        hKcRg9+WwwkQ2w3Dl5HcIV0CvUguqo5apGMH7YyTd+qiVLasFwUCvydOMaBLzAMexSxDTX
        FIswf9lscFWc/69vmCRXY2kVY2LAxx+eUytSozjK2NSoUxmGZ1bf2gtqjezfQCV8KIw2P3
        Eywuyu4QBvF1Rx0Rgx47W5WD3Cpptmd7GZ7BObqdsVvp8yoKgNJ2DPVHfo5V2DzFDLr1ew
        ls38IEHh78IkYiu+m4BkxGONtmcHZo8jwlw7yP6Ub2u9QpO4QB9zqj8r4zGpFw==
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 45/47] headers: Add function devm_clk_get_optional()
Date:   Tue, 19 Oct 2021 23:43:18 +0200
Message-Id: <20211019214320.2035704-46-hauke@hauke-m.de>
In-Reply-To: <20211019214320.2035704-1-hauke@hauke-m.de>
References: <20211019214320.2035704-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B4C81131C
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

The devm_clk_get_optional() function was added with kernel 5.1 and is
used by the wilc1000 driver now.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/clk.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 backport/backport-include/linux/clk.h

diff --git a/backport/backport-include/linux/clk.h b/backport/backport-include/linux/clk.h
new file mode 100644
index 00000000..7b4ab5b0
--- /dev/null
+++ b/backport/backport-include/linux/clk.h
@@ -0,0 +1,20 @@
+#ifndef __BACKPORT_LINUX_CLK_H
+#define __BACKPORT_LINUX_CLK_H
+#include_next <linux/clk.h>
+
+#include <linux/version.h>
+#if LINUX_VERSION_IS_LESS(5,1,0)
+
+static inline
+struct clk *devm_clk_get_optional(struct device *dev, const char *id)
+{
+	struct clk *clk = devm_clk_get(dev, id);
+
+	if (clk == ERR_PTR(-ENOENT))
+		return NULL;
+
+	return clk;
+}
+
+#endif /* < 5.1 */
+#endif /* __BACKPORT_LINUX_CLK_H */
-- 
2.30.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
