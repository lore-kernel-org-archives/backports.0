Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7059C43217
	for <backports@archiver.kernel.org>; Fri, 13 May 2022 16:06:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382321AbiEMQGK (ORCPT <rfc822;backports@archiver.kernel.org>);
        Fri, 13 May 2022 12:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381678AbiEMQGJ (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 13 May 2022 12:06:09 -0400
Received: from web.adapt-ip.com (mail.adapt-ip.com [107.194.246.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD55B87
        for <backports@vger.kernel.org>; Fri, 13 May 2022 09:06:06 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id CC5566E3A79;
        Fri, 13 May 2022 16:06:05 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id X86fpYKECXxG; Fri, 13 May 2022 16:06:03 +0000 (UTC)
Received: from atlas.campbell.adapt-ip.com (c-73-162-155-239.hsd1.ca.comcast.net [73.162.155.239])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id 985646E3A7A;
        Fri, 13 May 2022 16:05:27 +0000 (UTC)
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     backports <backports@vger.kernel.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Thomas Pedersen <thomas@adapt-ip.com>
Subject: [PATCH v2 06/15] gentree: update kconfig source var to new kconfig format
Date:   Fri, 13 May 2022 09:05:14 -0700
Message-Id: <20220513160523.2944694-7-thomas@adapt-ip.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220513160523.2944694-1-thomas@adapt-ip.com>
References: <20220513160523.2944694-1-thomas@adapt-ip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

Signed-off-by: Thomas Pedersen <thomas@adapt-ip.com>
---
 gentree.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/gentree.py b/gentree.py
index 05bb91b39291..4705ffa08fc4 100755
--- a/gentree.py
+++ b/gentree.py
@@ -701,7 +701,7 @@ def _main():
                            project_dir = args.outdir,
                            target_dir = os.path.join(args.outdir, 'backports/'),
                            target_dir_name = 'backports/',
-                           kconfig_source_var = '$BACKPORT_DIR',
+                           kconfig_source_var = '$(BACKPORT_DIR)',
                            )
     else:
         bpid = Bp_Identity(integrate = args.integrate,
@@ -710,7 +710,7 @@ def _main():
                            project_dir = args.outdir,
                            target_dir = args.outdir,
                            target_dir_name = '',
-                           kconfig_source_var = '$BACKPORT_DIR',
+                           kconfig_source_var = '$(BACKPORT_DIR)',
                            )
 
     def logwrite(msg):
-- 
2.30.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
