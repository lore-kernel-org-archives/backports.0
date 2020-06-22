Return-Path: <SRS0=/q2A=AD=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA7F2C433E0
	for <backports@archiver.kernel.org>; Mon, 22 Jun 2020 21:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3B0B20767
	for <backports@archiver.kernel.org>; Mon, 22 Jun 2020 21:38:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730565AbgFVVia (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 22 Jun 2020 17:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730567AbgFVVia (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 22 Jun 2020 17:38:30 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050::465:101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CECB3C061795
        for <backports@vger.kernel.org>; Mon, 22 Jun 2020 14:38:29 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 49rN7l60bFzKmfK;
        Mon, 22 Jun 2020 23:38:27 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter02.heinlein-hosting.de (spamfilter02.heinlein-hosting.de [80.241.56.116]) (amavisd-new, port 10030)
        with ESMTP id 7-Ken4A_re9W; Mon, 22 Jun 2020 23:38:24 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes@sipsolutions.net, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 2/7] backports: Add fallthrough attribute
Date:   Mon, 22 Jun 2020 23:37:59 +0200
Message-Id: <20200622213804.26477-3-hauke@hauke-m.de>
In-Reply-To: <20200622213804.26477-1-hauke@hauke-m.de>
References: <20200622213804.26477-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-SPAM-Probability: 0
X-Rspamd-Score: -4.21 / 15.00 / 15.00
X-Rspamd-Queue-Id: B30951784
X-Rspamd-UID: 732f02
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

This adds the fallthrough attribute from Linux commit 294f69e662d1
("compiler_attributes.h: Add 'fallthrough' pseudo keyword for switch/case use")
This also adds the __has_attribute() define for older compilers like
GCC < 5.

linux/compiler_attributes.h needs to be included, this file was only
added in more recent kernel versions.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/compiler.h    |  2 ++
 .../linux/compiler_attributes.h               | 34 +++++++++++++++++++
 2 files changed, 36 insertions(+)
 create mode 100644 backport/backport-include/linux/compiler_attributes.h

diff --git a/backport/backport-include/linux/compiler.h b/backport/backport-include/linux/compiler.h
index 53c069df..51a6ec2c 100644
--- a/backport/backport-include/linux/compiler.h
+++ b/backport/backport-include/linux/compiler.h
@@ -2,6 +2,8 @@
 #define __BACKPORT_LINUX_COMPILER_H
 #include_next <linux/compiler.h>
 
+#include <linux/compiler_attributes.h>
+
 #ifndef __rcu
 #define __rcu
 #endif
diff --git a/backport/backport-include/linux/compiler_attributes.h b/backport/backport-include/linux/compiler_attributes.h
new file mode 100644
index 00000000..31ddc163
--- /dev/null
+++ b/backport/backport-include/linux/compiler_attributes.h
@@ -0,0 +1,34 @@
+#ifndef _BACKPORTS_LINUX_COMPILER_ATTRIBUTES_H
+#define _BACKPORTS_LINUX_COMPILER_ATTRIBUTES_H 1
+
+#if LINUX_VERSION_IS_GEQ(4,20,0)
+#include_next <linux/compiler_attributes.h>
+#endif
+
+#ifndef __has_attribute
+# define __has_attribute(x) __GCC4_has_attribute_##x
+#endif
+
+#ifndef __GCC4_has_attribute___fallthrough__
+# define __GCC4_has_attribute___fallthrough__         0
+#endif /* __GCC4_has_attribute___fallthrough__ */
+
+#ifndef fallthrough
+/*
+ * Add the pseudo keyword 'fallthrough' so case statement blocks
+ * must end with any of these keywords:
+ *   break;
+ *   fallthrough;
+ *   goto <label>;
+ *   return [expression];
+ *
+ *  gcc: https://gcc.gnu.org/onlinedocs/gcc/Statement-Attributes.html#Statement-Attributes
+ */
+#if __has_attribute(__fallthrough__)
+# define fallthrough                    __attribute__((__fallthrough__))
+#else
+# define fallthrough                    do {} while (0)  /* fallthrough */
+#endif
+#endif /* fallthrough */
+
+#endif /* _BACKPORTS_LINUX_COMPILER_ATTRIBUTES_H */
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
