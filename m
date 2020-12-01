Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD35C83017
	for <backports@archiver.kernel.org>; Tue,  1 Dec 2020 22:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 951BA20709
	for <backports@archiver.kernel.org>; Tue,  1 Dec 2020 22:05:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="cTo/EKvB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730170AbgLAWF5 (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 1 Dec 2020 17:05:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730097AbgLAWF4 (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 1 Dec 2020 17:05:56 -0500
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050::465:101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3698BC061A55
        for <backports@vger.kernel.org>; Tue,  1 Dec 2020 14:04:59 -0800 (PST)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4Clx340dY8zQlK5;
        Tue,  1 Dec 2020 23:04:32 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1606860270;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rOUxssH4OpzFsUsn6BhFYCfAETwCYnVQ4EaeX05Unao=;
        b=cTo/EKvB1wGLD9yGkv097AGIjEaNbvIiWnpbPhHnNtaiQRJBNPcfp/0Sil8Wc7xZNA8SiB
        WDznwrkbssm7/E/k3x1WD6V3nq2WicWPzPI8lqh48k6L7uBS7pKgUNCsNXultGYEVHSjuo
        ZoiF0v4UUTgiYf6qmyHeyhNXy2oUox04HTKt5r37lrNCZrhczNryuqNXPbw+/gTFWzmz+o
        wtwJg3qNLy0/OHH33LEJ4Tliq76UDI1Qn28DXVdAsC4uIs4c60LL5Xl/0dceRwh/j0FozL
        IvyPfNYz3Y1ldzcvogVdDpx0T+xruYphdOue5xqCsSDx9ONx4lkZEvgaIWNCAg==
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter04.heinlein-hosting.de (spamfilter04.heinlein-hosting.de [80.241.56.122]) (amavisd-new, port 10030)
        with ESMTP id rAP2ZHOjENPB; Tue,  1 Dec 2020 23:04:29 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes@sipsolutions.net, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 02/30] gentree.py: Remoace space between -I and $(src)
Date:   Tue,  1 Dec 2020 23:03:47 +0100
Message-Id: <20201201220415.30582-3-hauke@hauke-m.de>
In-Reply-To: <20201201220415.30582-1-hauke@hauke-m.de>
References: <20201201220415.30582-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -3.88 / 15.00 / 15.00
X-Rspamd-Queue-Id: 3B0CD180E
X-Rspamd-UID: fe52dd
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

When I compile backports on Debian 9 against kernel 4.9 it fails to
compile because the include "-I $(src)" does not work, the "-I" is
somehow lost. When I remove the space between this it is working.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 gentree.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gentree.py b/gentree.py
index 2a9f60d7..1fc9dbb1 100755
--- a/gentree.py
+++ b/gentree.py
@@ -1043,7 +1043,7 @@ def process(kerneldir, copy_list_file, git_revision=None,
             for r in regexes:
                 data = r.sub(r'' + bpid.full_prefix + '\\1', data)
             # we have an absolue path in $(src) since we compile out of tree
-            data = re.sub(r'\$\(srctree\)/\$\(src\)', '$(src)', data)
+            data = re.sub(r'-I ?\$\(srctree\)/\$\(src\)', '-I$(src)', data)
             data = re.sub(r'\$\(srctree\)', '$(backport_srctree)', data)
             data = re.sub(r'-Idrivers', '-I$(backport_srctree)/drivers', data)
             if bpid.integrate:
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
