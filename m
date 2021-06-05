Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E436C47082
	for <backports@archiver.kernel.org>; Sat,  5 Jun 2021 22:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0110D613AC
	for <backports@archiver.kernel.org>; Sat,  5 Jun 2021 22:44:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbhFEWqN (ORCPT <rfc822;backports@archiver.kernel.org>);
        Sat, 5 Jun 2021 18:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbhFEWqN (ORCPT
        <rfc822;backports@vger.kernel.org>); Sat, 5 Jun 2021 18:46:13 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050::465:101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1B5C061766
        for <backports@vger.kernel.org>; Sat,  5 Jun 2021 15:44:24 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4FyF790v3kzQk2p;
        Sun,  6 Jun 2021 00:44:21 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1622933059;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Ezs1wABxemeMBZhfJR4LiEoIGsATAZ3lgY/YwybKxTk=;
        b=NTw7nE8SXPox42k4Ta00piLTbOr5HNWkvd25aiNztcupJH+8779VDOZtMWna4JjJD+w1na
        ab4PLzV+K2xNO04GNI5jskBuGiKZ9obJUiw8GjUcW1qce8xNtEBCexrw2GweCjAknpUv55
        6815+Sn/cWfs0xOKBMbzrq9YYFVBY6GdfQVriIWMvkPGZOb2+08Ylc/dHJMBaRmDvuIW54
        zHwPYApB/eVab9+0v+ppmIgp1VzBCUpfcWx5oUwihEEIVB8rtRdDOVPEgQlyGtO6oJvqDJ
        8K1uIoQADeG5w3pPwlLcKhzV+Vplucuj458rvwE3KvRj84H831L+ELz8rkDCvw==
Received: from smtp2.mailbox.org ([80.241.60.241])
        by hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172]) (amavisd-new, port 10030)
        with ESMTP id 91DPT5PSrgz8; Sun,  6 Jun 2021 00:44:18 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH] header: Add fsleep()
Date:   Sun,  6 Jun 2021 00:44:12 +0200
Message-Id: <20210605224412.3172140-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -2.47 / 15.00 / 15.00
X-Rspamd-Queue-Id: 4293817E8
X-Rspamd-UID: 4ea1cd
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

This was added in upstream Linux commit c6af13d33475 ("timer: add fsleep
for flexible sleeping") and is now used by the rtw88 driver.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/delay.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 backport/backport-include/linux/delay.h

diff --git a/backport/backport-include/linux/delay.h b/backport/backport-include/linux/delay.h
new file mode 100644
index 00000000..c19f4322
--- /dev/null
+++ b/backport/backport-include/linux/delay.h
@@ -0,0 +1,21 @@
+#ifndef __BACKPORT_LINUX_DELAY_H
+#define __BACKPORT_LINUX_DELAY_H
+#include_next <linux/delay.h>
+
+#include <linux/version.h>
+
+#if LINUX_VERSION_IS_LESS(5,8,0)
+#define fsleep LINUX_BACKPORT(fsleep)
+/* see Documentation/timers/timers-howto.rst for the thresholds */
+static inline void fsleep(unsigned long usecs)
+{
+	if (usecs <= 10)
+		udelay(usecs);
+	else if (usecs <= 20000)
+		usleep_range(usecs, 2 * usecs);
+	else
+		msleep(DIV_ROUND_UP(usecs, 1000));
+}
+#endif /* < 5.8.0 */
+
+#endif /* __BACKPORT_LINUX_DELAY_H */
-- 
2.30.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
