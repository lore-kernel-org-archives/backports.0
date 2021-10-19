Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA9E9C4332F
	for <backports@archiver.kernel.org>; Tue, 19 Oct 2021 21:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9769861052
	for <backports@archiver.kernel.org>; Tue, 19 Oct 2021 21:43:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbhJSVqB (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 19 Oct 2021 17:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhJSVpz (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 19 Oct 2021 17:45:55 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [IPv6:2001:67c:2050::465:202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 220C6C061769
        for <backports@vger.kernel.org>; Tue, 19 Oct 2021 14:43:41 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [80.241.60.233])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4HYnLN0QWfzQk1m;
        Tue, 19 Oct 2021 23:43:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1634679818;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bZOgWqQoRlAyyww/Aykm/ovLFT8FnXuhusrCBP8gBuU=;
        b=DpRrj+/NFceMifVGAjQSkBnROBQQTkQcpBcL1P06IFROacRSxoUJNdrcol7Sqvo+OSEy6D
        KL4b/zcFh+zUWlHKhgrV8h8dy4TUQ+xJRQ9vNyW+TaWUqsC+RqcB0KXPydK48teg4VRGi7
        Vwy8B4zOJvyxfg5QLnkr/mk0I7zx07PJ//9szTxAKQjGIGT84ke8wkH8C/7iOwml1IbU5C
        aNaFw+lv0+lgNTZD+VzpotDJ0yVJrNSuYrl8eTHTlkiyNAVUavntWI5Dr8oThixrXKZlvZ
        x5INejPErUGH/9ukh/LHQmrcBMk/tpRCLM6FO2hvHyZHxeQdIkasL6Dra5TKPw==
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 06/47] headers: Add linux/kcov.h
Date:   Tue, 19 Oct 2021 23:42:39 +0200
Message-Id: <20211019214320.2035704-7-hauke@hauke-m.de>
In-Reply-To: <20211019214320.2035704-1-hauke@hauke-m.de>
References: <20211019214320.2035704-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 59DF0131E
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

This adds empty implementation for kcov_remote_start_common() and
kcov_remote_stop() on older kernel versions. kcov will probably not work
properly when used with backports and older kernel versions.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/kcov.h  | 16 ++++++++++++++++
 backport/backport-include/linux/sched.h |  5 +++++
 2 files changed, 21 insertions(+)
 create mode 100644 backport/backport-include/linux/kcov.h

diff --git a/backport/backport-include/linux/kcov.h b/backport/backport-include/linux/kcov.h
new file mode 100644
index 00000000..92095e63
--- /dev/null
+++ b/backport/backport-include/linux/kcov.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __BACKPORTS_LINUX_KCOV_H
+#define __BACKPORTS_LINUX_KCOV_H
+#include <linux/version.h>
+#if LINUX_VERSION_IS_GEQ(4,6,0)
+#include_next <linux/kcov.h>
+#endif
+
+#if LINUX_VERSION_IS_LESS(5,5,0)
+#define kcov_remote_stop LINUX_BACKPORT(kcov_remote_stop)
+static inline void kcov_remote_stop(void) {}
+#define kcov_remote_start_common LINUX_BACKPORT(kcov_remote_start_common)
+static inline void kcov_remote_start_common(u64 id) {}
+#endif
+
+#endif /* __BACKPORTS_LINUX_KCOV_H */
diff --git a/backport/backport-include/linux/sched.h b/backport/backport-include/linux/sched.h
index 36263857..6a5cf8db 100644
--- a/backport/backport-include/linux/sched.h
+++ b/backport/backport-include/linux/sched.h
@@ -4,6 +4,11 @@
 #include_next <linux/sched.h>
 #include <linux/version.h>
 
+/* kcov was added in 4.6 and is included since then */
+#if LINUX_VERSION_IS_LESS(4,6,0)
+#include <linux/kcov.h>
+#endif
+
 #if LINUX_VERSION_IS_LESS(5,9,0)
 #if LINUX_VERSION_IS_GEQ(4,11,0)
 #include <uapi/linux/sched/types.h>
-- 
2.30.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
