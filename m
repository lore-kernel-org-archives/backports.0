Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6288AC4321E
	for <backports@archiver.kernel.org>; Tue, 19 Oct 2021 21:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51151610A3
	for <backports@archiver.kernel.org>; Tue, 19 Oct 2021 21:43:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbhJSVqH (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 19 Oct 2021 17:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbhJSVqC (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 19 Oct 2021 17:46:02 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [IPv6:2001:67c:2050::465:102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E950FC061765
        for <backports@vger.kernel.org>; Tue, 19 Oct 2021 14:43:48 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:105:465:1:3:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4HYnLW18fBzQjbF;
        Tue, 19 Oct 2021 23:43:47 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1634679825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nKnr81Qec8I3YvBDozuLQrT5EfHrVNUcsj8CiCSx1Pk=;
        b=HO3ZQANOKgLck4fU5BCz0Y3Fq4gtAZMEQm2Na3WsZj+onnu6I0y1H7VSFWjbKcU5+8wWr9
        CjZBHasVlKHQ+yu2dMewKANoKz069ZmESz2UH7axEUAlpC+ic6CVFCALRZKMT7M56L1Yct
        Di9g5y1vgoWd8ceeE1rBgLJXOstjZIEtf9wFC3KWp7O6YDMj7S888gYDBtvrBVCB0CfK5F
        M2FTBDxZJg/5WxMsXOAPTH7OVieAuqV9oEVg1Dh2shBLmAaG/LTcpJh/zzuicVD+ckdxXf
        nvNv5duh7s91mfRkmMyha28nGazvkyRqDSx9KNk+A5TDiSAMLBHxhEzY+a+c4w==
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 24/47] headers: Adapt signature of thermal_zone_device_update()
Date:   Tue, 19 Oct 2021 23:42:57 +0200
Message-Id: <20211019214320.2035704-25-hauke@hauke-m.de>
In-Reply-To: <20211019214320.2035704-1-hauke@hauke-m.de>
References: <20211019214320.2035704-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6C119C0A
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

The function signature of thermal_zone_device_update() function changed
in kernel 4.9. Drop the event parameter for older kernel versions. This
function is used by iwlwifi.
The code was partly copied from the upstream kernel.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/thermal.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/backport/backport-include/linux/thermal.h b/backport/backport-include/linux/thermal.h
index d9b8153e..8210facf 100644
--- a/backport/backport-include/linux/thermal.h
+++ b/backport/backport-include/linux/thermal.h
@@ -13,4 +13,27 @@ static inline int thermal_zone_device_disable(struct thermal_zone_device *tz)
 { return 0; }
 #endif /* < 5.9 */
 
+#if LINUX_VERSION_IS_LESS(4,9,0)
+/* Thermal notification reason */
+enum thermal_notify_event {
+	THERMAL_EVENT_UNSPECIFIED, /* Unspecified event */
+	THERMAL_EVENT_TEMP_SAMPLE, /* New Temperature sample */
+	THERMAL_TRIP_VIOLATED, /* TRIP Point violation */
+	THERMAL_TRIP_CHANGED, /* TRIP Point temperature changed */
+	THERMAL_DEVICE_DOWN, /* Thermal device is down */
+	THERMAL_DEVICE_UP, /* Thermal device is up after a down event */
+	THERMAL_DEVICE_POWER_CAPABILITY_CHANGED, /* power capability changed */
+	THERMAL_TABLE_CHANGED, /* Thermal table(s) changed */
+	THERMAL_EVENT_KEEP_ALIVE, /* Request for user space handler to respond */
+};
+
+static inline void
+backport_thermal_zone_device_update(struct thermal_zone_device *tz,
+				    enum thermal_notify_event event)
+{
+	thermal_zone_device_update(tz);
+}
+#define thermal_zone_device_update LINUX_BACKPORT(thermal_zone_device_update)
+#endif /* < 4.9 */
+
 #endif /* __BACKPORT_LINUX_THERMAL_H */
-- 
2.30.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
