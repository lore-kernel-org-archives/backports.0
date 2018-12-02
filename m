Return-Path: <SRS0=7Ax0=OL=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C6CDC64EB4
	for <backports@archiver.kernel.org>; Sun,  2 Dec 2018 11:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DCD420834
	for <backports@archiver.kernel.org>; Sun,  2 Dec 2018 11:52:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DCD420834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=backports-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725821AbeLBLw4 (ORCPT <rfc822;backports@archiver.kernel.org>);
        Sun, 2 Dec 2018 06:52:56 -0500
Received: from mx2.mailbox.org ([80.241.60.215]:41080 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725814AbeLBLw4 (ORCPT <rfc822;backports@vger.kernel.org>);
        Sun, 2 Dec 2018 06:52:56 -0500
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id C4719A111F;
        Sun,  2 Dec 2018 12:52:52 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter02.heinlein-hosting.de (spamfilter02.heinlein-hosting.de [80.241.56.116]) (amavisd-new, port 10030)
        with ESMTP id 5CDV5mhmTKNI; Sun,  2 Dec 2018 12:52:52 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     johannes@sipsolutions.net
Cc:     backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 04/12] backports: Add missing include for mt76
Date:   Sun,  2 Dec 2018 12:52:18 +0100
Message-Id: <20181202115226.3594-5-hauke@hauke-m.de>
In-Reply-To: <20181202115226.3594-1-hauke@hauke-m.de>
References: <20181202115226.3594-1-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

Without the inclusion of linux/module.h, MODULE_FIRMWARE was not
declared when compiling against some kernel versions, add it.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 patches/0013-fix-makefile-includes/mt76.patch | 10 ++++++++++
 1 file changed, 10 insertions(+)
 create mode 100644 patches/0013-fix-makefile-includes/mt76.patch

diff --git a/patches/0013-fix-makefile-includes/mt76.patch b/patches/0013-fix-makefile-includes/mt76.patch
new file mode 100644
index 00000000..4f122c46
--- /dev/null
+++ b/patches/0013-fix-makefile-includes/mt76.patch
@@ -0,0 +1,10 @@
+--- a/drivers/net/wireless/mediatek/mt76/mt76x0/usb_mcu.c
++++ b/drivers/net/wireless/mediatek/mt76/mt76x0/usb_mcu.c
+@@ -15,6 +15,7 @@
+  */
+ #include <linux/kernel.h>
+ #include <linux/firmware.h>
++#include <linux/module.h>
+ 
+ #include "mt76x0.h"
+ #include "mcu.h"
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
