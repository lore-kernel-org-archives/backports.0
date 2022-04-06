Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D348DC433EF
	for <backports@archiver.kernel.org>; Wed,  6 Apr 2022 22:03:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232022AbiDFWFk (ORCPT <rfc822;backports@archiver.kernel.org>);
        Wed, 6 Apr 2022 18:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235644AbiDFWFi (ORCPT
        <rfc822;backports@vger.kernel.org>); Wed, 6 Apr 2022 18:05:38 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6715C1D08F0
        for <backports@vger.kernel.org>; Wed,  6 Apr 2022 15:03:37 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4KYdnM4kJwz9scq;
        Thu,  7 Apr 2022 00:03:35 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1649282613;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xRPu0cyxBTirnvBqTqeR5mM2pLFw4+/ktArPGvOtQUM=;
        b=vTQUwBrIKRIKD4CBAsgy10ABlxQ+VF1MqgJPAcPA9j5qEeg/SEse4oAWw67OKkoDX2hjqw
        4z1nSK0gawggqwgv9qSJNzHpXKkvjBgpoGGvl0PKe1I3HPA1u7Sc1z9C1P2n4O6oPM02ZX
        kmsPaunQL+JhP42Cu/FtPHDEwwr+dySYncIZ69Gbb2xAR0VJZXRtLVaU4u6Eh4yYmI1TZ8
        rzvHFV4eTZsBJXIQpQrsFoG4Z/3Xh4HgPU1QLT93jBostqrjRu9plwvwOrWkBHm/nPlnHB
        Lje8v4mWWpCP5Kh5g5ageYMR5TrjLPvG1BjPYmjL8UqAm/PyySZARbWP5qGrXg==
To:     backports@vger.kernel.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 3/4] headers: Add WWAN_PORT_UNKNOWN
Date:   Thu,  7 Apr 2022 00:03:20 +0200
Message-Id: <20220406220321.3864576-3-hauke@hauke-m.de>
In-Reply-To: <20220406220321.3864576-1-hauke@hauke-m.de>
References: <20220406220321.3864576-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

WWAN_PORT_UNKNOWN was added to upstream Linux kernel in commit
bf30396cdf81 ("net: wwan: Add unknown port type"). It is intentionally
after the max enum value.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/wwan.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/backport/backport-include/linux/wwan.h b/backport/backport-include/linux/wwan.h
index b3e4769f..ef123e5d 100644
--- a/backport/backport-include/linux/wwan.h
+++ b/backport/backport-include/linux/wwan.h
@@ -3,6 +3,11 @@
 #include <linux/version.h>
 #if LINUX_VERSION_IS_GEQ(5,13,0)
 #include_next <linux/wwan.h>
+
+#if LINUX_VERSION_IS_LESS(5,14,0)
+#define WWAN_PORT_UNKNOWN (WWAN_PORT_MAX + 1)
+#endif /* <= 5.14 */
+
 #else
 
 /**
-- 
2.30.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
