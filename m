Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D210C433EF
	for <backports@archiver.kernel.org>; Fri, 13 May 2022 16:06:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382329AbiEMQG2 (ORCPT <rfc822;backports@archiver.kernel.org>);
        Fri, 13 May 2022 12:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382328AbiEMQG0 (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 13 May 2022 12:06:26 -0400
Received: from web.adapt-ip.com (mail.adapt-ip.com [107.194.246.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CEE736175
        for <backports@vger.kernel.org>; Fri, 13 May 2022 09:06:25 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id E08EB6E3A74;
        Fri, 13 May 2022 16:06:24 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id kbYDcDo2YiSY; Fri, 13 May 2022 16:06:22 +0000 (UTC)
Received: from atlas.campbell.adapt-ip.com (c-73-162-155-239.hsd1.ca.comcast.net [73.162.155.239])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id 909CF6E3A86;
        Fri, 13 May 2022 16:05:30 +0000 (UTC)
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     backports <backports@vger.kernel.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Thomas Pedersen <thomas@adapt-ip.com>
Subject: [PATCH v2 13/15] integration-patches: make patches per target kernel version
Date:   Fri, 13 May 2022 09:05:21 -0700
Message-Id: <20220513160523.2944694-14-thomas@adapt-ip.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220513160523.2944694-1-thomas@adapt-ip.com>
References: <20220513160523.2944694-1-thomas@adapt-ip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

The integration patches are applied to the target kernel,
so really need to be versioned accordingly.

Signed-off-by: Thomas Pedersen <thomas@adapt-ip.com>
---
 gentree.py                                                     | 3 ++-
 .../0001-enable-backports/0001-enable-backports-built-in.patch | 0
 2 files changed, 2 insertions(+), 1 deletion(-)
 rename integration-patches/{ => 4.19}/0001-enable-backports/0001-enable-backports-built-in.patch (100%)

diff --git a/gentree.py b/gentree.py
index 9699ce0128d0..04e47c76e607 100755
--- a/gentree.py
+++ b/gentree.py
@@ -1137,8 +1137,9 @@ def process(kerneldir, copy_list_file, git_revision=None,
         f.write('source "backports/Kconfig"\n')
         f.close()
         git_debug_snapshot(args, "hooked backport to top level Kconfig")
+        patchdir = 'integration-patches/%s.%s/' % (rel_specs['VERSION'], rel_specs['PATCHLEVEL'])
 
-        failure = apply_patches(args, "integration", source_dir, 'integration-patches/',
+        failure = apply_patches(args, "integration", source_dir, patchdir,
                                 bpid.project_dir, logwrite)
         if failure:
             return failure
diff --git a/integration-patches/0001-enable-backports/0001-enable-backports-built-in.patch b/integration-patches/4.19/0001-enable-backports/0001-enable-backports-built-in.patch
similarity index 100%
rename from integration-patches/0001-enable-backports/0001-enable-backports-built-in.patch
rename to integration-patches/4.19/0001-enable-backports/0001-enable-backports-built-in.patch
-- 
2.30.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
