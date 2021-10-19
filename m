Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F0AC4167E
	for <backports@archiver.kernel.org>; Tue, 19 Oct 2021 21:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D78B610A3
	for <backports@archiver.kernel.org>; Tue, 19 Oct 2021 21:43:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbhJSVqI (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 19 Oct 2021 17:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbhJSVqD (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 19 Oct 2021 17:46:03 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050::465:201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E75C06161C
        for <backports@vger.kernel.org>; Tue, 19 Oct 2021 14:43:50 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [80.241.60.233])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4HYnLX6HX1zQkj1;
        Tue, 19 Oct 2021 23:43:48 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1634679827;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jOYHfFjPNiPEVhp0zvIsKIgSb/eAj9h7P2tAC3OM3TU=;
        b=i8jHNpKFDG1eiXffa0UlosEPYf5jVmc65c4JK0kM+0gZyoBNUgCjSO3V+75QKkQN85q9Mu
        cxhRxN7NSN1mnb06QPCU3OSbcYSICw0TXVDkqwxq0m2kA0fAJyz/54bHWuuKJr+qvUK+7B
        svirKH4nOjpPgMn+CzUA7sXVCUJ3jY0RGIO0Ztax/4AteacM3b95/Lf8NEZQh7fzjGH/ht
        5MsF+Yudg3UuuvsqYSKBrfLx/8meuSzQg2BA1l0GBhaBxZ8HQhvN1m9kGqxwPx4iOyRqrT
        aa1S2VoIRVu214U0/HMUnXSC73W5FvRX6hVt/F79XqfiG5I7RPYRaY+p4y9Sug==
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 28/47] headers: Add linux/wwan.h file
Date:   Tue, 19 Oct 2021 23:43:01 +0200
Message-Id: <20211019214320.2035704-29-hauke@hauke-m.de>
In-Reply-To: <20211019214320.2035704-1-hauke@hauke-m.de>
References: <20211019214320.2035704-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EF1581319
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

Add the linux/wwan.h header file from the new wwan subsystem. This adds
only the enum wwan_port_type which is also used when the wwan subsystem
is deactivated.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/wwan.h | 35 ++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 backport/backport-include/linux/wwan.h

diff --git a/backport/backport-include/linux/wwan.h b/backport/backport-include/linux/wwan.h
new file mode 100644
index 00000000..b3e4769f
--- /dev/null
+++ b/backport/backport-include/linux/wwan.h
@@ -0,0 +1,35 @@
+#ifndef __BACKPORT_WWAN_H
+#define __BACKPORT_WWAN_H
+#include <linux/version.h>
+#if LINUX_VERSION_IS_GEQ(5,13,0)
+#include_next <linux/wwan.h>
+#else
+
+/**
+ * enum wwan_port_type - WWAN port types
+ * @WWAN_PORT_AT: AT commands
+ * @WWAN_PORT_MBIM: Mobile Broadband Interface Model control
+ * @WWAN_PORT_QMI: Qcom modem/MSM interface for modem control
+ * @WWAN_PORT_QCDM: Qcom Modem diagnostic interface
+ * @WWAN_PORT_FIREHOSE: XML based command protocol
+ *
+ * @WWAN_PORT_MAX: Highest supported port types
+ * @WWAN_PORT_UNKNOWN: Special value to indicate an unknown port type
+ * @__WWAN_PORT_MAX: Internal use
+ */
+enum wwan_port_type {
+	WWAN_PORT_AT,
+	WWAN_PORT_MBIM,
+	WWAN_PORT_QMI,
+	WWAN_PORT_QCDM,
+	WWAN_PORT_FIREHOSE,
+
+	/* Add new port types above this line */
+
+	__WWAN_PORT_MAX,
+	WWAN_PORT_MAX = __WWAN_PORT_MAX - 1,
+	WWAN_PORT_UNKNOWN,
+};
+
+#endif /* >= 5.13 */
+#endif /* __BACKPORT_WWAN_H */
-- 
2.30.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
