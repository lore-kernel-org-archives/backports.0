Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E5FC433EF
	for <backports@archiver.kernel.org>; Tue, 19 Oct 2021 21:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D8FB61052
	for <backports@archiver.kernel.org>; Tue, 19 Oct 2021 21:43:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbhJSVqG (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 19 Oct 2021 17:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbhJSVqB (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 19 Oct 2021 17:46:01 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050::465:201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC044C061773
        for <backports@vger.kernel.org>; Tue, 19 Oct 2021 14:43:47 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [80.241.60.233])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4HYnLV2pFBzQkBc;
        Tue, 19 Oct 2021 23:43:46 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1634679824;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4pmDWboTyoy/z1kmLp+GJmGUDbKMdUJShpdmsgQ3VXc=;
        b=mecF7IfOW7WNbkK/Rz1ftYz4E+n/9W8+5rCwMtP+wWROzoYd5kdGw0q7wdo7/bcHekqbjw
        hA26qBFFREmGOPvIXGgJpbU+r6AEv15JykegZuROazC8LJ/nL4+GrYuauo9Vo3Fw67AUOH
        IN4sPJxkcBg2e+XOyyPkxtomLXhL3+/+QhWm8FmK3vl2Ko5QQJNk7sdcy5Uw7Y8TbWuXf8
        fzm7aJJ1ga/+UEzUXHFyuSNgCCKUTaUYrnuLGAJTKUewTUmvGaZrCWqLBwPoWLA7b48vfv
        NkqmRrg79IrLHoFHe/MKKMgHBDcfSJWHJRGfyW/9VGu7jSV0d15Tu5yaVXZFHw==
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 22/47] headers: Add rfkill_set_hw_state_reason()
Date:   Tue, 19 Oct 2021 23:42:55 +0200
Message-Id: <20211019214320.2035704-23-hauke@hauke-m.de>
In-Reply-To: <20211019214320.2035704-1-hauke@hauke-m.de>
References: <20211019214320.2035704-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AC5995AF
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

This adds the new function rfkill_set_hw_state_reason() from kernel 5.11
and maps it to the old rfkill_set_hw_state() by dropping the reason.
kernel 5.11 also moved some definitions to the uapi/linux/rfkill.h, but
on kernel versions < 5.11 it is not sufficient to only include the uapi
version.
This is used by the core wireless system.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/rfkill.h      | 24 +++++++++++++++++++
 .../0013-fix-makefile-includes/cfg80211.patch | 14 ++++++++++-
 2 files changed, 37 insertions(+), 1 deletion(-)
 create mode 100644 backport/backport-include/linux/rfkill.h

diff --git a/backport/backport-include/linux/rfkill.h b/backport/backport-include/linux/rfkill.h
new file mode 100644
index 00000000..c0b99d58
--- /dev/null
+++ b/backport/backport-include/linux/rfkill.h
@@ -0,0 +1,24 @@
+#ifndef __BACKPORT_UAPI__RFKILL_H
+#define __BACKPORT_UAPI__RFKILL_H
+#include_next <linux/rfkill.h>
+
+
+#if LINUX_VERSION_IS_LESS(5,11,0)
+
+/* This should come from uapi/linux/rfkill.h, but it was much easier
+ * to do it this way.
+ */
+enum rfkill_hard_block_reasons {
+	RFKILL_HARD_BLOCK_SIGNAL        = 1 << 0,
+	RFKILL_HARD_BLOCK_NOT_OWNER     = 1 << 1,
+};
+
+static inline bool rfkill_set_hw_state_reason(struct rfkill *rfkill,
+					      bool blocked, unsigned long reason)
+{
+	return rfkill_set_hw_state(rfkill, blocked);
+}
+
+#endif /* 5.11 */
+
+#endif /* __BACKPORT_UAPI__RFKILL_H */
diff --git a/patches/0013-fix-makefile-includes/cfg80211.patch b/patches/0013-fix-makefile-includes/cfg80211.patch
index 0e079911..c44e3f58 100644
--- a/patches/0013-fix-makefile-includes/cfg80211.patch
+++ b/patches/0013-fix-makefile-includes/cfg80211.patch
@@ -6,7 +6,19 @@ the type is renamed.
 
 --- a/include/net/cfg80211.h
 +++ b/include/net/cfg80211.h
-@@ -22,6 +22,7 @@
+@@ -11,7 +11,11 @@
+  */
+ 
+ #include <linux/ethtool.h>
++#if LINUX_VERSION_IS_LESS(5,11,0)
++#include <linux/rfkill.h>
++#else
+ #include <uapi/linux/rfkill.h>
++#endif
+ #include <linux/netdevice.h>
+ #include <linux/debugfs.h>
+ #include <linux/list.h>
+@@ -23,6 +27,7 @@
  #include <linux/ieee80211.h>
  #include <linux/net.h>
  #include <net/regulatory.h>
-- 
2.30.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
