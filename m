Return-Path: <SRS0=/q2A=AD=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5896EC433E0
	for <backports@archiver.kernel.org>; Mon, 22 Jun 2020 21:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3739D2075A
	for <backports@archiver.kernel.org>; Mon, 22 Jun 2020 21:38:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730484AbgFVVid (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 22 Jun 2020 17:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730626AbgFVVic (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 22 Jun 2020 17:38:32 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050::465:201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DFB8C061573
        for <backports@vger.kernel.org>; Mon, 22 Jun 2020 14:38:32 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 49rN7p62LQzQlKc;
        Mon, 22 Jun 2020 23:38:30 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter03.heinlein-hosting.de (spamfilter03.heinlein-hosting.de [80.241.56.117]) (amavisd-new, port 10030)
        with ESMTP id TIDAkGeH9P7b; Mon, 22 Jun 2020 23:38:27 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes@sipsolutions.net, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 7/7] backports: Include missing header file for mt76
Date:   Mon, 22 Jun 2020 23:38:04 +0200
Message-Id: <20200622213804.26477-8-hauke@hauke-m.de>
In-Reply-To: <20200622213804.26477-1-hauke@hauke-m.de>
References: <20200622213804.26477-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-SPAM-Probability: 0
X-Rspamd-Score: -4.20 / 15.00 / 15.00
X-Rspamd-Queue-Id: E00881800
X-Rspamd-UID: a79fbe
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

MODULE_PARM_DESC() is not defined without this header file on some
kernel versions.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 patches/0013-fix-makefile-includes/mt76.patch | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 patches/0013-fix-makefile-includes/mt76.patch

diff --git a/patches/0013-fix-makefile-includes/mt76.patch b/patches/0013-fix-makefile-includes/mt76.patch
new file mode 100644
index 00000000..b7628ff2
--- /dev/null
+++ b/patches/0013-fix-makefile-includes/mt76.patch
@@ -0,0 +1,12 @@
+additional include needed for kernel 4.2, 4.11, 4.12 and 4.13
+
+--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
++++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+@@ -6,6 +6,7 @@
+  */
+ 
+ #include <linux/firmware.h>
++#include <linux/module.h>
+ #include "mt7615.h"
+ #include "mcu.h"
+ #include "mac.h"
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
