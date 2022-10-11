Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A632CC4332F
	for <backports@archiver.kernel.org>; Tue, 11 Oct 2022 21:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbiJKVFH (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 11 Oct 2022 17:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiJKVFA (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 11 Oct 2022 17:05:00 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F556222A8
        for <backports@vger.kernel.org>; Tue, 11 Oct 2022 14:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=6TbvNPpfVOQ/fOlKyLkhN8fj6WgIZKuDgHZjEknifI0=;
        t=1665522295; x=1666731895; b=oPKkDYAZq5DlbYka6SwuGeS9SfbAm4xRMh++1o4kpYSN+fs
        3tdhQfGf6F42s+9cDpySN0rAdoou3p992l5RAe9V2zoo1/hO15Y+99OcL0ZSPNnpliot35YLvwKcw
        st0X7g1qR00R5tFzIWPZDV6Ki8XxbNPcrbWayk717DF887jLb5OpgpmG+sqLdkkoA92/xVuHgWNEq
        muhn5RkbnNkChCTCSslkuq2EnRl6nM5SAVGFHPNMbpSuo7Ck1MONjDE5kLdaicPbG/MW98dwsOefq
        sq0/r/qxl+HEAm837XkY/mmf4AEfLTndoATVVaF++d2Cm6u6ya0N8aQqbxpAvvKQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oiMQj-0045LP-2z;
        Tue, 11 Oct 2022 23:04:50 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     backports@vger.kernel.org
Cc:     nbd@nbd.name, Luca Coelho <luciano.coelho@intel.com>
Subject: [PATCH 05/38] backport: include kcov.h in sched.h for kernels < v4.10
Date:   Tue, 11 Oct 2022 23:04:13 +0200
Message-Id: <20221011230356.d66a96d62361.Iee3a886f6b132d9f0a501fcace491dbb5d712500@changeid>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221011210446.144768-1-johannes@sipsolutions.net>
References: <20221011210446.144768-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

In kernel v4.10 and later, kcov.h is included in sched.h.  Now
mac80211 uses some kcov functions, but doesn't include kcov.h
explicitly, since it's included by sched.h.  Include kvoc.h in kernels
older than v4.10 to avoid compilation issues.

type=maint
ticket=jira:WIFI-95070

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Reviewed-on: https://git-ger-8.devtools.intel.com/gerrit/139719
---
 backport/backport-include/linux/sched.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/backport/backport-include/linux/sched.h b/backport/backport-include/linux/sched.h
index 6a5cf8db6b8c..29659af437de 100644
--- a/backport/backport-include/linux/sched.h
+++ b/backport/backport-include/linux/sched.h
@@ -3,6 +3,9 @@
 
 #include_next <linux/sched.h>
 #include <linux/version.h>
+#if LINUX_VERSION_IS_LESS(4,10,0)
+#include <linux/kcov.h>
+#endif /* LINUX_VERSION_IS_LESS(4,10,0) */
 
 /* kcov was added in 4.6 and is included since then */
 #if LINUX_VERSION_IS_LESS(4,6,0)
-- 
2.37.3

--
To unsubscribe from this list: send the line "unsubscribe backports" in
