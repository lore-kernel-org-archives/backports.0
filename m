Return-Path: <SRS0=+jjK=6E=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 072CFC54FCC
	for <backports@archiver.kernel.org>; Mon, 20 Apr 2020 22:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D99052078C
	for <backports@archiver.kernel.org>; Mon, 20 Apr 2020 22:16:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbgDTWQd (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 20 Apr 2020 18:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgDTWQd (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 20 Apr 2020 18:16:33 -0400
X-Greylist: delayed 104732 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 20 Apr 2020 15:16:33 PDT
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [IPv6:2001:67c:2050::465:103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12FBEC061A0C
        for <backports@vger.kernel.org>; Mon, 20 Apr 2020 15:16:33 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-103.mailbox.org (Postfix) with ESMTPS id 495gyj0MXfzKmYM;
        Tue, 21 Apr 2020 00:16:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter04.heinlein-hosting.de (spamfilter04.heinlein-hosting.de [80.241.56.122]) (amavisd-new, port 10030)
        with ESMTP id osG6ScV7yZwz; Tue, 21 Apr 2020 00:16:26 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes@sipsolutions.net, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 2/9] backports: pm_qos: Add cpu_latency_qos_* functions
Date:   Tue, 21 Apr 2020 00:16:08 +0200
Message-Id: <20200420221615.14734-3-hauke@hauke-m.de>
In-Reply-To: <20200420221615.14734-1-hauke@hauke-m.de>
References: <20200420221615.14734-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 478C11742
X-Rspamd-Score: -5.67 / 15.00 / 15.00
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

The upstream commit fa048c59bf1b ("PM: QoS: Add CPU latency QoS API
wrappers") add the new cpu_latency_qos_* functions. In the initial
commit they are just calling the functions from the old API. Use this
first step to backport these functions. They are used by the ath10k and
ipw2100 driver.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/pm_qos.h | 29 ++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/backport/backport-include/linux/pm_qos.h b/backport/backport-include/linux/pm_qos.h
index d5bfc9bc..18cbbace 100644
--- a/backport/backport-include/linux/pm_qos.h
+++ b/backport/backport-include/linux/pm_qos.h
@@ -13,4 +13,33 @@
 #define PM_QOS_DEFAULT_VALUE -1
 #endif
 
+#if LINUX_VERSION_IS_LESS(5,7,0)
+static inline void cpu_latency_qos_add_request(struct pm_qos_request *req,
+                                              s32 value)
+{
+	pm_qos_add_request(req, PM_QOS_CPU_DMA_LATENCY, value);
+}
+
+static inline void cpu_latency_qos_update_request(struct pm_qos_request *req,
+                                                 s32 new_value)
+{
+	pm_qos_update_request(req, new_value);
+}
+
+static inline void cpu_latency_qos_remove_request(struct pm_qos_request *req)
+{
+	pm_qos_remove_request(req);
+}
+
+static inline bool cpu_latency_qos_request_active(struct pm_qos_request *req)
+{
+	return pm_qos_request_active(req);
+}
+
+static inline s32 cpu_latency_qos_limit(void)
+{
+	return pm_qos_request(PM_QOS_CPU_DMA_LATENCY);
+}
+#endif /* < 5.7 */
+
 #endif	/* _COMPAT_LINUX_PM_QOS_H */
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
