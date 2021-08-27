Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7675BC432BE
	for <backports@archiver.kernel.org>; Fri, 27 Aug 2021 12:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EB8E608FB
	for <backports@archiver.kernel.org>; Fri, 27 Aug 2021 12:01:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbhH0MCE (ORCPT <rfc822;backports@archiver.kernel.org>);
        Fri, 27 Aug 2021 08:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbhH0MCD (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 27 Aug 2021 08:02:03 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C81C061757
        for <backports@vger.kernel.org>; Fri, 27 Aug 2021 05:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=euqNv0m1fUnbjhqTfsXvjGX3p6qY1f1+4V65SMV43o4=; t=1630065674; x=1631275274; 
        b=hHl7cRolw8G6slk+PzJ8IRlwnYb2TcqpF2+pC139GdmVSM+vFO19Wosp1ltp4n0sZYnrfkMvQTt
        GrZf7iZMAPJYk4apnuk1WBgQxh5wEdymCj/X97qw3BaU1g9GwHJtOUxAwfvMvnWSTQt+co2bbDtrP
        +IkYedY66fXpVGDVvlfRqVrcupEY+vKdpyKVPZzi9T20Gw/m8Q4Ggu8DgVsQD/ysARvXNKF/9Zt6R
        k9fX8OaOyB4sxdca+2X6kyZV7Fwv8PiQuJqLm8w3IfgVKWYciLTB7/4w/YZyYMkrXO1XdkTQCr+Wm
        2T43m8ePMChtxtBA+0col0TAN0sJw3+hoetg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mJaXm-00GbMM-KF; Fri, 27 Aug 2021 14:01:10 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     backports@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] gentree: fix $(srctree)/$(src) adjustment
Date:   Fri, 27 Aug 2021 14:01:08 +0200
Message-Id: <20210827140108.ba4d435eaf5e.I3808fb9cfaa17561ed46170716158fbc1e008333@changeid>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

We did an adjustment here, but only did it prefixed with -I,
but a long time ago cfg80211 started doing $(srctree)/$(src)
for the built-in certificates as well.

Fix the regex to always apply this also to other occurrences,
not just in cflags.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 gentree.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gentree.py b/gentree.py
index 1fc9dbb1dc37..2a9f60d7384b 100755
--- a/gentree.py
+++ b/gentree.py
@@ -1043,7 +1043,7 @@ def process(kerneldir, copy_list_file, git_revision=None,
             for r in regexes:
                 data = r.sub(r'' + bpid.full_prefix + '\\1', data)
             # we have an absolue path in $(src) since we compile out of tree
-            data = re.sub(r'-I ?\$\(srctree\)/\$\(src\)', '-I$(src)', data)
+            data = re.sub(r'\$\(srctree\)/\$\(src\)', '$(src)', data)
             data = re.sub(r'\$\(srctree\)', '$(backport_srctree)', data)
             data = re.sub(r'-Idrivers', '-I$(backport_srctree)/drivers', data)
             if bpid.integrate:
-- 
2.31.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
