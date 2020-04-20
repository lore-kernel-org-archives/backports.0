Return-Path: <SRS0=+jjK=6E=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E618EC55185
	for <backports@archiver.kernel.org>; Mon, 20 Apr 2020 22:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD53220722
	for <backports@archiver.kernel.org>; Mon, 20 Apr 2020 22:16:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbgDTWQe (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 20 Apr 2020 18:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbgDTWQd (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 20 Apr 2020 18:16:33 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [IPv6:2001:67c:2050::465:202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BE63C061A10
        for <backports@vger.kernel.org>; Mon, 20 Apr 2020 15:16:33 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 495gyl6WtWzQlFr;
        Tue, 21 Apr 2020 00:16:31 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter05.heinlein-hosting.de (spamfilter05.heinlein-hosting.de [80.241.56.123]) (amavisd-new, port 10030)
        with ESMTP id IqLT3mMoJfek; Tue, 21 Apr 2020 00:16:29 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes@sipsolutions.net, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 8/9] backports: patches: Avoid struct ethtool_ops.supported_coalesce_params
Date:   Tue, 21 Apr 2020 00:16:14 +0200
Message-Id: <20200420221615.14734-9-hauke@hauke-m.de>
In-Reply-To: <20200420221615.14734-1-hauke@hauke-m.de>
References: <20200420221615.14734-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2961F1745
X-Rspamd-Score: -5.66 / 15.00 / 15.00
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

The supported_coalesce_params member was added to the struct ethtool_ops
in upstream commit 95cddcb5cc20 ("ethtool: add infrastructure for
centralized checking of coalescing parameters"). This prevents the usage
in kernel < 5.7.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 patches/0096-ethtool-supported_coalesce_params.cocci | 9 +++++++++
 1 file changed, 9 insertions(+)
 create mode 100644 patches/0096-ethtool-supported_coalesce_params.cocci

diff --git a/patches/0096-ethtool-supported_coalesce_params.cocci b/patches/0096-ethtool-supported_coalesce_params.cocci
new file mode 100644
index 00000000..9b1b090e
--- /dev/null
+++ b/patches/0096-ethtool-supported_coalesce_params.cocci
@@ -0,0 +1,9 @@
+@r@
+identifier s,expr;
+@@
+
+struct ethtool_ops s = {
++#if LINUX_VERSION_IS_GEQ(5,7,0)
+	.supported_coalesce_params = expr,
++#endif
+};
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
