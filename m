Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C525FC55ABD
	for <backports@archiver.kernel.org>; Thu, 12 Nov 2020 10:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18EA322203
	for <backports@archiver.kernel.org>; Thu, 12 Nov 2020 10:35:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="pkFanqXw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbgKLKfv (ORCPT <rfc822;backports@archiver.kernel.org>);
        Thu, 12 Nov 2020 05:35:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727227AbgKLKfv (ORCPT
        <rfc822;backports@vger.kernel.org>); Thu, 12 Nov 2020 05:35:51 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46EA8C0613D4
        for <backports@vger.kernel.org>; Thu, 12 Nov 2020 02:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=j1KgL67lyZP6uzJjoiwKZGF+ZbugKqBQQNAbeV4fbTw=; b=pkFanqXwGuCkXvInZH5bVu70qq
        HLTENoK4dS/e9xtXO5IKnOntZAV9oMw3icednsGb/Uo1W8uFbeBA8YGqvxZOx9I+PBTfsz0Oc0JIE
        0xQYJtMk3kTXsWTBlTtXc1VO5yJafUH13ZFJfr4OGVvFbaFvc4uOCM7Cs7dZbEInlX9w=;
Received: from p5b206c33.dip0.t-ipconnect.de ([91.32.108.51] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kd9xD-0001JU-Vd
        for backports@vger.kernel.org; Thu, 12 Nov 2020 11:35:48 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     backports@vger.kernel.org
Subject: [PATCH 2/2] backports: add tasklet_setup, from_tasklet
Date:   Thu, 12 Nov 2020 11:35:46 +0100
Message-Id: <20201112103546.74014-2-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201112103546.74014-1-nbd@nbd.name>
References: <20201112103546.74014-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

Add the new tasklet API

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 backport/backport-include/linux/interrupt.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/backport/backport-include/linux/interrupt.h b/backport/backport-include/linux/interrupt.h
index f7e7134d8338..f334a9636180 100644
--- a/backport/backport-include/linux/interrupt.h
+++ b/backport/backport-include/linux/interrupt.h
@@ -31,6 +31,23 @@ static inline void backport_hrtimer_start(struct hrtimer *timer, s64 time,
 	hrtimer_start(timer, _time, mode);
 }
 #define hrtimer_start LINUX_BACKPORT(hrtimer_start)
+
+#endif
+
+#if LINUX_VERSION_IS_LESS(5,9,0)
+
+static inline void
+tasklet_setup(struct tasklet_struct *t,
+	      void (*callback)(struct tasklet_struct *))
+{
+	void (*cb)(unsigned long data) = (void *)callback;
+
+	tasklet_init(t, cb, (unsigned long)t);
+}
+
+#define from_tasklet(var, callback_tasklet, tasklet_fieldname) \
+	container_of(callback_tasklet, typeof(*var), tasklet_fieldname)
+
 #endif
 
 #endif /* _BP_LINUX_INTERRUPT_H */
-- 
2.28.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
