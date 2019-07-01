Return-Path: <SRS0=giDq=U6=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D6BC5B578
	for <backports@archiver.kernel.org>; Mon,  1 Jul 2019 21:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A79FC21479
	for <backports@archiver.kernel.org>; Mon,  1 Jul 2019 21:50:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbfGAVuQ (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 1 Jul 2019 17:50:16 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:46544 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727047AbfGAVuQ (ORCPT <rfc822;backports@vger.kernel.org>);
        Mon, 1 Jul 2019 17:50:16 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 4BDA9A0195;
        Mon,  1 Jul 2019 23:50:15 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter04.heinlein-hosting.de (spamfilter04.heinlein-hosting.de [80.241.56.122]) (amavisd-new, port 10030)
        with ESMTP id ZU9fW9MDkvtY; Mon,  1 Jul 2019 23:49:56 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 09/18] header: Add HRTIMER_MODE_{ABS,REL}_SOFT
Date:   Mon,  1 Jul 2019 23:49:04 +0200
Message-Id: <20190701214914.8066-10-hauke@hauke-m.de>
In-Reply-To: <20190701214914.8066-1-hauke@hauke-m.de>
References: <20190701214914.8066-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

mac80211_hwsim uses HRTIMER_MODE_ABS_SOFT and HRTIMER_MODE_REL_SOFT now.
These enum entries were added in commit 98ecadd4305d ("hrtimer: Add
clock bases and hrtimer mode for softirq context") in kernel 4.16.
This will execute the timers in hard interrupt context and not in soft
interrupt context like intended.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/hrtimer.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 backport/backport-include/linux/hrtimer.h

diff --git a/backport/backport-include/linux/hrtimer.h b/backport/backport-include/linux/hrtimer.h
new file mode 100644
index 00000000..1152a58e
--- /dev/null
+++ b/backport/backport-include/linux/hrtimer.h
@@ -0,0 +1,13 @@
+#ifndef __BACKPORT_LINUX_HRTIMER_H
+#define __BACKPORT_LINUX_HRTIMER_H
+#include <linux/version.h>
+#include_next <linux/hrtimer.h>
+
+#if LINUX_VERSION_IS_LESS(4,16,0)
+
+#define HRTIMER_MODE_ABS_SOFT HRTIMER_MODE_ABS
+#define HRTIMER_MODE_REL_SOFT HRTIMER_MODE_REL
+
+#endif /* < 4.16 */
+
+#endif /* __BACKPORT_LINUX_HRTIMER_H */
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
