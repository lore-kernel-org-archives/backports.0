Return-Path: <SRS0=giDq=U6=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF88C06511
	for <backports@archiver.kernel.org>; Mon,  1 Jul 2019 21:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0405D21479
	for <backports@archiver.kernel.org>; Mon,  1 Jul 2019 21:50:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbfGAVuH (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 1 Jul 2019 17:50:07 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:46028 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727028AbfGAVuH (ORCPT <rfc822;backports@vger.kernel.org>);
        Mon, 1 Jul 2019 17:50:07 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 73328A1052;
        Mon,  1 Jul 2019 23:50:06 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter04.heinlein-hosting.de (spamfilter04.heinlein-hosting.de [80.241.56.122]) (amavisd-new, port 10030)
        with ESMTP id JMiVZKfFSx-u; Mon,  1 Jul 2019 23:49:57 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 12/18] header: add hrtimer_forward() and ns_to_ktime()
Date:   Mon,  1 Jul 2019 23:49:07 +0200
Message-Id: <20190701214914.8066-13-hauke@hauke-m.de>
In-Reply-To: <20190701214914.8066-1-hauke@hauke-m.de>
References: <20190701214914.8066-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

ktime_t was converted from the union to s64 in kernel 4.10.
hrtimer_start() was already converted some time ago in backports, now
mac80211_hwsim uses hrtimer_start() together with the newly added
functions.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/interrupt.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/backport/backport-include/linux/interrupt.h b/backport/backport-include/linux/interrupt.h
index ad3cbf66..f7e7134d 100644
--- a/backport/backport-include/linux/interrupt.h
+++ b/backport/backport-include/linux/interrupt.h
@@ -5,6 +5,25 @@
 #include <linux/ktime.h>
 
 #if LINUX_VERSION_IS_LESS(4,10,0)
+
+/* Forward a hrtimer so it expires after now: */
+static inline u64
+backport_hrtimer_forward(struct hrtimer *timer, ktime_t now, s64 interval)
+{
+	ktime_t _interval = { .tv64 = interval };
+
+	return hrtimer_forward(timer, now, _interval);
+}
+#define hrtimer_forward LINUX_BACKPORT(hrtimer_forward)
+
+static inline s64 backport_ns_to_ktime(u64 ns)
+{
+	ktime_t _time = ns_to_ktime(ns);
+
+	return _time.tv64;
+}
+#define ns_to_ktime LINUX_BACKPORT(ns_to_ktime)
+
 static inline void backport_hrtimer_start(struct hrtimer *timer, s64 time,
 					  const enum hrtimer_mode mode)
 {
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
