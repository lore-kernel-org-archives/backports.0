Return-Path: <SRS0=vds9=5F=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0506C43333
	for <backports@archiver.kernel.org>; Fri, 20 Mar 2020 23:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBEEB20752
	for <backports@archiver.kernel.org>; Fri, 20 Mar 2020 23:40:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgCTXkQ (ORCPT <rfc822;backports@archiver.kernel.org>);
        Fri, 20 Mar 2020 19:40:16 -0400
Received: from mout-p-102.mailbox.org ([80.241.56.152]:45588 "EHLO
        mout-p-102.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726976AbgCTXkQ (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 20 Mar 2020 19:40:16 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 48kgHf4DPGzKmNY;
        Sat, 21 Mar 2020 00:40:14 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172]) (amavisd-new, port 10030)
        with ESMTP id oe6cnk7cGRlt; Sat, 21 Mar 2020 00:40:11 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes@sipsolutions.net, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 6/8] backports: netdevice.h: Add return value to napi_complete()
Date:   Sat, 21 Mar 2020 00:39:48 +0100
Message-Id: <20200320233950.32257-7-hauke@hauke-m.de>
In-Reply-To: <20200320233950.32257-1-hauke@hauke-m.de>
References: <20200320233950.32257-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

mt76 checks the return value of napi_complete() now, add the same
handling as already done for napi_complete_done().

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/netdevice.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/backport/backport-include/linux/netdevice.h b/backport/backport-include/linux/netdevice.h
index 76b57e4d..a71ed590 100644
--- a/backport/backport-include/linux/netdevice.h
+++ b/backport/backport-include/linux/netdevice.h
@@ -302,7 +302,13 @@ static inline bool backport_napi_complete_done(struct napi_struct *n, int work_d
 #endif /* < 3.19 */
 	return true;
 }
+
+static inline bool backport_napi_complete(struct napi_struct *n)
+{
+	return backport_napi_complete_done(n, 0);
+}
 #define napi_complete_done LINUX_BACKPORT(napi_complete_done)
+#define napi_complete LINUX_BACKPORT(napi_complete)
 #endif /* < 4.10 */
 
 #if LINUX_VERSION_IS_LESS(4,5,0)
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
