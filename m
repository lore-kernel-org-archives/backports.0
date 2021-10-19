Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A972C18E0D
	for <backports@archiver.kernel.org>; Tue, 19 Oct 2021 21:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 624B661052
	for <backports@archiver.kernel.org>; Tue, 19 Oct 2021 21:43:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbhJSVqJ (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 19 Oct 2021 17:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbhJSVqE (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 19 Oct 2021 17:46:04 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [IPv6:2001:67c:2050::465:202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D009DC061746
        for <backports@vger.kernel.org>; Tue, 19 Oct 2021 14:43:50 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [80.241.60.233])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4HYnLY0j8QzQk0m;
        Tue, 19 Oct 2021 23:43:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1634679827;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GPN0onPzywBlnwIl9fxVlF7pByWhyA79v7+ZvVRDemI=;
        b=awIeemCJxUpJFMSeXoZogCWLsu5CnGP8bzxyET76Cp/EovMyhfxm6miQbOBFdSSZ5cVkao
        8blDxm4Z50iuHoz8wf+zABcLomFJRG4EM6EIVsCjBwWi0QdTBuQVxBRXaaFzc5qUhC1IYY
        iyB4hCe04EdY3cEHrVBIzCa4h3GKET8Y+U1tv55QX6hWFBGjAjkxCNtOQX9mko0nna0GL6
        jjtJpg1ExnbM3RUyMbVVPonIE3mVq8aPMhkOfs7GVBNo4zTbdrTyt7gmfejqMY2LTIj4W0
        XZ1SoyJWdN09ZrytrzGB0orX5OjFzmPZsiNTtqS3addovFPTKWMIlRco1qqhiw==
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 29/47] headers: Add DEVICE_ATTR_ADMIN_RW
Date:   Tue, 19 Oct 2021 23:43:02 +0200
Message-Id: <20211019214320.2035704-30-hauke@hauke-m.de>
In-Reply-To: <20211019214320.2035704-1-hauke@hauke-m.de>
References: <20211019214320.2035704-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 58A911312
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

The DEVICE_ATTR_ADMIN_RW define was added with kernel 5.9 and is now
used by ssb.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/device.h | 10 ++++++++++
 backport/backport-include/linux/sysfs.h  |  9 +++++++++
 2 files changed, 19 insertions(+)
 create mode 100644 backport/backport-include/linux/device.h

diff --git a/backport/backport-include/linux/device.h b/backport/backport-include/linux/device.h
new file mode 100644
index 00000000..46f2190b
--- /dev/null
+++ b/backport/backport-include/linux/device.h
@@ -0,0 +1,10 @@
+#ifndef __BACKPORT_DEVICE_H_
+#define __BACKPORT_DEVICE_H_
+#include_next <linux/device.h>
+
+#ifndef DEVICE_ATTR_ADMIN_RW
+#define DEVICE_ATTR_ADMIN_RW(_name) \
+	struct device_attribute dev_attr_##_name = __ATTR_RW_MODE(_name, 0600)
+#endif
+
+#endif /* __BACKPORT_DEVICE_H_ */
diff --git a/backport/backport-include/linux/sysfs.h b/backport/backport-include/linux/sysfs.h
index ad8a8229..7126fb03 100644
--- a/backport/backport-include/linux/sysfs.h
+++ b/backport/backport-include/linux/sysfs.h
@@ -22,4 +22,13 @@ static inline int sysfs_emit(char *buf, const char *fmt, ...)
 #endif /* CONFIG_SYSFS */
 #endif /* < 5.10 */
 
+#ifndef __ATTR_RW_MODE
+#define __ATTR_RW_MODE(_name, _mode) {					\
+	.attr	= { .name = __stringify(_name),				\
+		    .mode = VERIFY_OCTAL_PERMISSIONS(_mode) },		\
+	.show	= _name##_show,						\
+	.store	= _name##_store,					\
+}
+#endif
+
 #endif /* __BACKPORT_LINUX_SYSFS_H */
-- 
2.30.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
