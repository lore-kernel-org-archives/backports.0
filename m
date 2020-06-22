Return-Path: <SRS0=/q2A=AD=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2118C433DF
	for <backports@archiver.kernel.org>; Mon, 22 Jun 2020 21:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9099F2076A
	for <backports@archiver.kernel.org>; Mon, 22 Jun 2020 21:38:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730586AbgFVVic (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 22 Jun 2020 17:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730600AbgFVVic (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 22 Jun 2020 17:38:32 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [IPv6:2001:67c:2050::465:102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B471FC061573
        for <backports@vger.kernel.org>; Mon, 22 Jun 2020 14:38:30 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 49rN7n3gT2zKmZB;
        Mon, 22 Jun 2020 23:38:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter05.heinlein-hosting.de (spamfilter05.heinlein-hosting.de [80.241.56.123]) (amavisd-new, port 10030)
        with ESMTP id gFdM2EEXMc19; Mon, 22 Jun 2020 23:38:26 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes@sipsolutions.net, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 5/7] backports: Adapt acpi_evaluate_dsm()
Date:   Mon, 22 Jun 2020 23:38:02 +0200
Message-Id: <20200622213804.26477-6-hauke@hauke-m.de>
In-Reply-To: <20200622213804.26477-1-hauke@hauke-m.de>
References: <20200622213804.26477-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-SPAM-Probability: 0
X-Rspamd-Score: -4.18 / 15.00 / 15.00
X-Rspamd-Queue-Id: 9FE3017FF
X-Rspamd-UID: 53d63f
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

The function signature of acpi_evaluate_dsm() changed in Linux
94116f8126de ("ACPI: Switch to use generic guid_t in
acpi_evaluate_dsm()"), add function to handle this new interface.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/acpi/acpi_bus.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
 create mode 100644 backport/backport-include/acpi/acpi_bus.h

diff --git a/backport/backport-include/acpi/acpi_bus.h b/backport/backport-include/acpi/acpi_bus.h
new file mode 100644
index 00000000..4c7404a2
--- /dev/null
+++ b/backport/backport-include/acpi/acpi_bus.h
@@ -0,0 +1,15 @@
+#ifndef _BACKPORTS_ACPI_BUS_H__
+#define _BACKPORTS_ACPI_BUS_H__ 1
+
+#include_next <acpi/acpi_bus.h>
+
+#if LINUX_VERSION_IN_RANGE(3,14,0, 4,13,0) 
+static inline union acpi_object *
+backport_acpi_evaluate_dsm(acpi_handle handle, const guid_t *guid, u64 rev, u64 func, union acpi_object *argv4)
+{
+	return acpi_evaluate_dsm(handle, guid->b, rev, func, argv4);
+}
+#define acpi_evaluate_dsm LINUX_BACKPORT(acpi_evaluate_dsm)
+#endif /* 3.14 <= x < 4.13.0 */
+
+#endif /* _BACKPORTS_ACPI_BUS_H__ */
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
