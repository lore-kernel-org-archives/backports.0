Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 453C8C43217
	for <backports@archiver.kernel.org>; Tue, 11 Oct 2022 21:05:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiJKVFA (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 11 Oct 2022 17:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiJKVE6 (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 11 Oct 2022 17:04:58 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E32248CA
        for <backports@vger.kernel.org>; Tue, 11 Oct 2022 14:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=xXYFXpikx8brd1Ao0HU0D3eAkU+Yt+ZgPmsOjx/inLU=;
        t=1665522295; x=1666731895; b=KCqgeBSEivxje3IcfTjwEAMG0ugebkQ0nLJ9Y5JsbPhEmOT
        2zATACaBb71RKBslV8KqTKPS80WjekwpsQpU3PkBNmsw8LhWUDRJ+0bV9EJpRNMKkiIP+ksupYZnk
        gA8VdcjLMwgqDgM/1tr7H2K+xw5P3e9Q2shII97hxk8sOQlYbPMVJjG9UGdeiMAmHj5Nx/BHsZ6JR
        l5UWATx04nMNERdG3pdIP0XpuJHzceRWxFtDXVW6TkhXykwqq0yEAl3So/TdtuojvNBqx8Ruzpa/9
        D86Uk03y6L2dMrH3C2AxQDQnXdopyzG8vrtMRtXLqgVIRvf9WhspRfYY6bnp+A7g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oiMQn-0045LP-1b;
        Tue, 11 Oct 2022 23:04:53 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     backports@vger.kernel.org
Cc:     nbd@nbd.name, Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 17/38] backports: define __is_constexpr() for older kernels
Date:   Tue, 11 Oct 2022 23:04:25 +0200
Message-Id: <20221011230356.1c8492a8a107.Ib82d1b3349ab6fc55b5f17dba1ada60601dcd742@changeid>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221011210446.144768-1-johannes@sipsolutions.net>
References: <20221011210446.144768-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

From: Gregory Greenman <gregory.greenman@intel.com>

type=maint
ticket=none

Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 backport/backport-include/linux/kernel.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/backport/backport-include/linux/kernel.h b/backport/backport-include/linux/kernel.h
index 36bb755e353c..2555e3c4a0a8 100644
--- a/backport/backport-include/linux/kernel.h
+++ b/backport/backport-include/linux/kernel.h
@@ -5,6 +5,17 @@
 #include <linux/bug.h>
 #include <linux/version.h>
 
+#if LINUX_VERSION_IS_LESS(4,17,0)
+
+/*
+ * This returns a constant expression while determining if an argument is
+ * a constant expression, most importantly without evaluating the argument.
+ * Glory to Martin Uecker <Martin.Uecker@med.uni-goettingen.de>
+ */
+#define __is_constexpr(x) \
+	(sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))
+
+#endif /* < 4.17.0 */
 
 #if LINUX_VERSION_IS_LESS(4,6,0)
 #define kstrtobool LINUX_BACKPORT(kstrtobool)
-- 
2.37.3

--
To unsubscribe from this list: send the line "unsubscribe backports" in
