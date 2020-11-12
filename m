Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B382C2D0A3
	for <backports@archiver.kernel.org>; Thu, 12 Nov 2020 10:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A629E22210
	for <backports@archiver.kernel.org>; Thu, 12 Nov 2020 10:35:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="kt+Ip/ho"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbgKLKfv (ORCPT <rfc822;backports@archiver.kernel.org>);
        Thu, 12 Nov 2020 05:35:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbgKLKfv (ORCPT
        <rfc822;backports@vger.kernel.org>); Thu, 12 Nov 2020 05:35:51 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E285C0613D1
        for <backports@vger.kernel.org>; Thu, 12 Nov 2020 02:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=33FWT8Jteylzs0bd9BLoRcr2CNVwVNWgY4l86pbCLcg=; b=kt+Ip/hoDuL/BdsUMgYA2mIL3u
        1Cr5OwiWS2kE3RtmS09hTyuiHSTHqWXIUxVWx9HOAuBoekFIzTWDJTF6Jm/foPKQbQ1CL0mo1t3Ny
        O+WaQQFIww8MunA1NVZBRNzBlnmLFOH2tAIY84GyRcXLQj9JZek3F6cMFA3YCBuMURz0=;
Received: from p5b206c33.dip0.t-ipconnect.de ([91.32.108.51] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kd9xD-0001JU-Pn
        for backports@vger.kernel.org; Thu, 12 Nov 2020 11:35:47 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     backports@vger.kernel.org
Subject: [PATCH 1/2] backports: add sched_set_fifo_low
Date:   Thu, 12 Nov 2020 11:35:45 +0100
Message-Id: <20201112103546.74014-1-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

It is needed for mt76

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 backport/backport-include/linux/sched.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 backport/backport-include/linux/sched.h

diff --git a/backport/backport-include/linux/sched.h b/backport/backport-include/linux/sched.h
new file mode 100644
index 000000000000..be77a8d771ab
--- /dev/null
+++ b/backport/backport-include/linux/sched.h
@@ -0,0 +1,19 @@
+#ifndef __BACKPORT_LINUX_SCHED_H
+#define __BACKPORT_LINUX_SCHED_H
+
+#include_next <linux/sched.h>
+#include <linux/version.h>
+
+#if LINUX_VERSION_IS_LESS(5,9,0)
+#include <uapi/linux/sched/types.h>
+
+static inline void sched_set_fifo_low(struct task_struct *p)
+{
+	struct sched_param sparam = {.sched_priority = 1};
+
+	sched_setscheduler(p, SCHED_FIFO, &sparam);
+}
+
+#endif
+
+#endif
-- 
2.28.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
