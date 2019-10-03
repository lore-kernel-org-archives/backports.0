Return-Path: <SRS0=jmjh=X4=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D2BC10F14
	for <backports@archiver.kernel.org>; Thu,  3 Oct 2019 15:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBEE7207FF
	for <backports@archiver.kernel.org>; Thu,  3 Oct 2019 15:57:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730194AbfJCP51 (ORCPT <rfc822;backports@archiver.kernel.org>);
        Thu, 3 Oct 2019 11:57:27 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:38556 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730951AbfJCP50 (ORCPT <rfc822;backports@vger.kernel.org>);
        Thu, 3 Oct 2019 11:57:26 -0400
Received: from smtp2.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id B17BAA25EC;
        Thu,  3 Oct 2019 17:57:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.240])
        by spamfilter04.heinlein-hosting.de (spamfilter04.heinlein-hosting.de [80.241.56.122]) (amavisd-new, port 10030)
        with ESMTP id EwYUdx7ekI3h; Thu,  3 Oct 2019 17:57:22 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes@sipsolutions.net, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 11/11] backports: ckmake: limit load to number of CPUs
Date:   Thu,  3 Oct 2019 17:56:42 +0200
Message-Id: <20191003155642.14909-12-hauke@hauke-m.de>
In-Reply-To: <20191003155642.14909-1-hauke@hauke-m.de>
References: <20191003155642.14909-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

Instead of limiting the maximum load to a fixed number limit it to the
number of available CPUs. This should hopefully increase the speed as
less task switches are needed.

Also reduce the number of treads per build to half the number of
available CPUs. Normally multiple builds are done in parallel anyway.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 devel/ckmake | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/devel/ckmake b/devel/ckmake
index d8c16773..d16de3a7 100755
--- a/devel/ckmake
+++ b/devel/ckmake
@@ -152,8 +152,8 @@ def process_kernel(num, kset, cmdline_args):
                  work_dir,
                  ignore=ignore_patterns('.tmp*', ".git"))
         build = '%s/build/' % rel['full_path']
-        jobs = '-j%d' % kset.build_jobs
-        load = '-l%d' % 50
+        jobs = '-j%d' % (kset.build_jobs / 2)
+        load = '-l%d' % kset.build_jobs
         make_args = ['KLIB=%s' % build,
                      'KLIB_BUILD=%s' % build]
         nice = ['ionice', '-c', '3', 'nice', '-n', '20']
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
