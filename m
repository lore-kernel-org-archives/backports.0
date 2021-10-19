Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB3EC4707A
	for <backports@archiver.kernel.org>; Tue, 19 Oct 2021 21:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 247A261052
	for <backports@archiver.kernel.org>; Tue, 19 Oct 2021 21:44:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbhJSVqO (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 19 Oct 2021 17:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbhJSVqK (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 19 Oct 2021 17:46:10 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050::465:201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD0AC06161C
        for <backports@vger.kernel.org>; Tue, 19 Oct 2021 14:43:57 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:105:465:1:3:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4HYnLh2r9NzQlRJ;
        Tue, 19 Oct 2021 23:43:56 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1634679834;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f8NeG762liXyl+8QLgQvUXbfGvYo2HmO4TnSxQsJ9hk=;
        b=PwTIgfqq/xrKupStVppAH0CEizbynD1JhD9on2MGH/Y9V8+05nLMBTS6dwrNSamMnhrsEw
        vE9j1lcr79Wb0s89ByE0OYKVT9CtaAleibVmPoX77pv8B7GXEQmkhNwNvPXmIlYzCswYG3
        wz3Fqt7MR48oSnDuHD1LqPScMUqcskURRah6gtgc3R+WGZC54Zj3VnCFhI8pjE/PstvSet
        QH2y5d1FLtufh8tZV0f0K73KwyccSVQXtGxa5T2Lzyy9hM+La8cvTUXpjEOYX58nR1cjDi
        dvHCctLErgvuvUaxyXxkUimWdVmC90az9ghoYpQDr5m5VQ0Qx/ojxPrf/Y5Inw==
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 47/47] headers: Check for NULL in dev_put() and dev_hold()
Date:   Tue, 19 Oct 2021 23:43:20 +0200
Message-Id: <20211019214320.2035704-48-hauke@hauke-m.de>
In-Reply-To: <20211019214320.2035704-1-hauke@hauke-m.de>
References: <20211019214320.2035704-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B4E4F1311
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

Since kernel 5.15 the dev_put() and dev_hold() functions check if the
given dev is not NULL before accessing the pointer. Previously the code
to check for NULL was in the calling function. Add this check for NULL
because some checks were already removed from the driver code.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/netdevice.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/backport/backport-include/linux/netdevice.h b/backport/backport-include/linux/netdevice.h
index 5c30426d..22942398 100644
--- a/backport/backport-include/linux/netdevice.h
+++ b/backport/backport-include/linux/netdevice.h
@@ -151,4 +151,20 @@ struct rtnl_link_stats64 *
 bp_dev_get_tstats64(struct net_device *dev, struct rtnl_link_stats64 *s);
 #endif /* < 4.11 */
 
+#if LINUX_VERSION_IS_LESS(5,15,0)
+static inline void backport_dev_put(struct net_device *dev)
+{
+	if (dev)
+		dev_put(dev);
+}
+#define dev_put LINUX_BACKPORT(dev_put)
+
+static inline void backport_dev_hold(struct net_device *dev)
+{
+	if (dev)
+		dev_hold(dev);
+}
+#define dev_hold LINUX_BACKPORT(dev_hold)
+#endif /* < 5.15 */
+
 #endif /* __BACKPORT_NETDEVICE_H */
-- 
2.30.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
