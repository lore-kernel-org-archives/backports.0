Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B67C4332F
	for <backports@archiver.kernel.org>; Tue, 11 Oct 2022 21:05:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbiJKVF0 (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 11 Oct 2022 17:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiJKVFF (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 11 Oct 2022 17:05:05 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A0632ED3
        for <backports@vger.kernel.org>; Tue, 11 Oct 2022 14:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=6Cq8d78YqvCqI6Wj88yaArHunkR4IpVFQipK0dRnpcY=;
        t=1665522301; x=1666731901; b=URLBQCgE2gsbiAWaroX5Wjv/6yD9KDYwmISJKgpUIC7g6Rt
        1eyfm6wCtCTG9xqe1en2MynppwF2qLDAdjBU82dRshnQ+locswwj47yGNkWkKxImWL2nNjm/OPGFH
        WEKkJqyjqbl/dUeMv43hfCtyprNNmZCuA16HpjeVl1npP9VSqN+QdPBGxmJqazbpdAVVSRBt/R8vl
        +oNtv0nL6V+QHZc4GUMBzLsXqEZtaoUDsJTum2RVU50DYLLcEDMkyE6Dcb5lC3ORjrcIWkp8wmiUh
        mca61Vz7IoUFmbfmLzL5A1iZEwsVaoGfq5w0xJIPWDcBDuPEne6ikSvb8D/bXUSQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oiMQt-0045LP-1j;
        Tue, 11 Oct 2022 23:04:59 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     backports@vger.kernel.org
Cc:     nbd@nbd.name, Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 36/38] backports: use kernel verification only if CONFIG_CRYPTO_HASH_INFO
Date:   Tue, 11 Oct 2022 23:04:44 +0200
Message-Id: <20221011230356.7805e942abc6.Ie109060a7378c3c603673bc488e2df0f7509c147@changeid>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221011210446.144768-1-johannes@sipsolutions.net>
References: <20221011210446.144768-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

If we don't have CONFIG_CRYPTO_HASH_INFO then we cannot use this.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/verification.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/backport/backport-include/linux/verification.h b/backport/backport-include/linux/verification.h
index 5fd0a2d3b09f..908d1a2601ca 100644
--- a/backport/backport-include/linux/verification.h
+++ b/backport/backport-include/linux/verification.h
@@ -1,7 +1,8 @@
 #ifndef __BP_VERIFICATION_H
 #define __BP_VERIFICATION_H
 #include <linux/version.h>
-#if LINUX_VERSION_IS_GEQ(4,7,0) && !defined(CPTCFG_BPAUTO_BUILD_SYSTEM_DATA_VERIFICATION)
+#if (LINUX_VERSION_IS_GEQ(4,7,0) && !defined(CPTCFG_BPAUTO_BUILD_SYSTEM_DATA_VERIFICATION)) && \
+	defined(CONFIG_CRYPTO_HASH_INFO)
 #include_next <linux/verification.h>
 #else
 #include <linux/key.h>
-- 
2.37.3

--
To unsubscribe from this list: send the line "unsubscribe backports" in
