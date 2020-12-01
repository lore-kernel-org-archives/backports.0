Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1BC5C64E7A
	for <backports@archiver.kernel.org>; Tue,  1 Dec 2020 22:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8916120709
	for <backports@archiver.kernel.org>; Tue,  1 Dec 2020 22:05:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="eU9f7Gmj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728872AbgLAWFz (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 1 Dec 2020 17:05:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727531AbgLAWFy (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 1 Dec 2020 17:05:54 -0500
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [IPv6:2001:67c:2050::465:103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C908BC061A49
        for <backports@vger.kernel.org>; Tue,  1 Dec 2020 14:04:37 -0800 (PST)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4Clx383Rl2zQlLc;
        Tue,  1 Dec 2020 23:04:36 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1606860274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nwgBXPiy3Jio8xEggSavyH6BivgkBafP46CL11sI0TM=;
        b=eU9f7GmjfIJ/E2zPpRZATQboMg+T1Gx+oqhmOLTmaYuklMuP5LOmoQ8ILWni4MY3t6INGT
        z4ds+fVFmWV4lLYkF+RehYU6b/C/m2/FduU30eNVh6TjQ7eBwBaHiyGFY1CDAo79lPI2jI
        KnqOsgNK901d87q5imWuybK257/4HXNjtro3jgYZvj3wPKgLhVKf9+6bJUXFcswpS6+z81
        ug6uhxVJ5lNf9WFEzEXaw8ZZAiussoFDwB60tfiIHz3EcxsfpwUy6UyRgEpAQzxxr+RfG3
        Mh+Wc+S1x47oebBpyCpAYE8d9Q43d3ovLT3xJ7XHksybHMeMinhaS7EOkgRcrQ==
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter03.heinlein-hosting.de (spamfilter03.heinlein-hosting.de [80.241.56.117]) (amavisd-new, port 10030)
        with ESMTP id wdFyv7DOLdbv; Tue,  1 Dec 2020 23:04:33 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes@sipsolutions.net, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 11/30] header: dummy implementation for thermal_zone_device_enable
Date:   Tue,  1 Dec 2020 23:03:56 +0100
Message-Id: <20201201220415.30582-12-hauke@hauke-m.de>
In-Reply-To: <20201201220415.30582-1-hauke@hauke-m.de>
References: <20201201220415.30582-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -4.76 / 15.00 / 15.00
X-Rspamd-Queue-Id: 9ED8A184C
X-Rspamd-UID: c90fa3
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

Just provide an empty implementation of the thermal zone functions, they
were not called in older versions of the driver any way.
These functions were added in upstream Linux commit ac5d9ecc74d8
("thermal: Add mode helpers").

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/thermal.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/backport/backport-include/linux/thermal.h b/backport/backport-include/linux/thermal.h
index 8874e196..8ffe12aa 100644
--- a/backport/backport-include/linux/thermal.h
+++ b/backport/backport-include/linux/thermal.h
@@ -113,4 +113,14 @@ void backport_thermal_zone_device_unregister(struct thermal_zone_device *);
 #endif /* ! < 3.8.0 */
 #endif /* CONFIG_THERMAL */
 
+#if LINUX_VERSION_IS_LESS(5,9,0)
+#define thermal_zone_device_enable LINUX_BACKPORT(thermal_zone_device_enable)
+static inline int thermal_zone_device_enable(struct thermal_zone_device *tz)
+{ return 0; }
+
+#define thermal_zone_device_disable LINUX_BACKPORT(thermal_zone_device_disable)
+static inline int thermal_zone_device_disable(struct thermal_zone_device *tz)
+{ return 0; }
+#endif /* < 5.9 */
+
 #endif /* __BACKPORT_LINUX_THERMAL_H */
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
