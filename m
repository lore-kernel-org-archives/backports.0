Return-Path: <SRS0=8p+7=ZI=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B04C432C3
	for <backports@archiver.kernel.org>; Sat, 16 Nov 2019 18:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18C31206C0
	for <backports@archiver.kernel.org>; Sat, 16 Nov 2019 18:41:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727698AbfKPSlt (ORCPT <rfc822;backports@archiver.kernel.org>);
        Sat, 16 Nov 2019 13:41:49 -0500
Received: from mout-u-107.mailbox.org ([91.198.250.252]:50104 "EHLO
        mout-u-107.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727696AbfKPSlt (ORCPT
        <rfc822;backports@vger.kernel.org>); Sat, 16 Nov 2019 13:41:49 -0500
X-Greylist: delayed 309 seconds by postgrey-1.27 at vger.kernel.org; Sat, 16 Nov 2019 13:41:49 EST
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-u-107.mailbox.org (Postfix) with ESMTPS id 47FkT34JsbzKmkt;
        Sat, 16 Nov 2019 19:36:39 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter01.heinlein-hosting.de (spamfilter01.heinlein-hosting.de [80.241.56.115]) (amavisd-new, port 10030)
        with ESMTP id eNeOZ7-IYp-s; Sat, 16 Nov 2019 19:36:36 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes@sipsolutions.net, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 2/3] backports: Adapt to changes to skb_get_hash_perturb()
Date:   Sat, 16 Nov 2019 19:36:22 +0100
Message-Id: <20191116183623.8858-2-hauke@hauke-m.de>
In-Reply-To: <20191116183623.8858-1-hauke@hauke-m.de>
References: <20191116183623.8858-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

The skb_get_hash_perturb() function now takes a siphash_key_t instead of
an u32. This was changed in commit 55667441c84f ("net/flow_dissector:
switch to siphash"). Use the correct type in the fq header file
depending on the kernel version.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 patches/0091-fq-no-siphash_key_t/fq.patch | 36 +++++++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 patches/0091-fq-no-siphash_key_t/fq.patch

diff --git a/patches/0091-fq-no-siphash_key_t/fq.patch b/patches/0091-fq-no-siphash_key_t/fq.patch
new file mode 100644
index 00000000..95c28a19
--- /dev/null
+++ b/patches/0091-fq-no-siphash_key_t/fq.patch
@@ -0,0 +1,36 @@
+--- a/include/net/fq.h
++++ b/include/net/fq.h
+@@ -69,7 +69,15 @@ struct fq {
+ 	struct list_head backlogs;
+ 	spinlock_t lock;
+ 	u32 flows_cnt;
++#if LINUX_VERSION_IS_GEQ(5,3,10) || \
++    LINUX_VERSION_IN_RANGE(4,19,83, 4,20,0) || \
++    LINUX_VERSION_IN_RANGE(4,14,153, 4,15,0) || \
++    LINUX_VERSION_IN_RANGE(4,9,200, 4,10,0) || \
++    LINUX_VERSION_IN_RANGE(4,4,200, 4,5,0)
+ 	siphash_key_t	perturbation;
++#else
++	u32 perturbation;
++#endif
+ 	u32 limit;
+ 	u32 memory_limit;
+ 	u32 memory_usage;
+--- a/include/net/fq_impl.h
++++ b/include/net/fq_impl.h
+@@ -108,7 +108,15 @@ begin:
+ 
+ static u32 fq_flow_idx(struct fq *fq, struct sk_buff *skb)
+ {
++#if LINUX_VERSION_IS_GEQ(5,3,10) || \
++    LINUX_VERSION_IN_RANGE(4,19,83, 4,20,0) || \
++    LINUX_VERSION_IN_RANGE(4,14,153, 4,15,0) || \
++    LINUX_VERSION_IN_RANGE(4,9,200, 4,10,0) || \
++    LINUX_VERSION_IN_RANGE(4,4,200, 4,5,0)
+ 	u32 hash = skb_get_hash_perturb(skb, &fq->perturbation);
++#else
++	u32 hash = skb_get_hash_perturb(skb, fq->perturbation);
++#endif
+ 
+ 	return reciprocal_scale(hash, fq->flows_cnt);
+ }
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
