Return-Path: <SRS0=vn7s=4C=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD229C2BA83
	for <backports@archiver.kernel.org>; Fri, 14 Feb 2020 11:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 864CD2082F
	for <backports@archiver.kernel.org>; Fri, 14 Feb 2020 11:09:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729149AbgBNLJx (ORCPT <rfc822;backports@archiver.kernel.org>);
        Fri, 14 Feb 2020 06:09:53 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:42830 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729017AbgBNLJx (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 14 Feb 2020 06:09:53 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1j2Yr0-00BSz7-Mo; Fri, 14 Feb 2020 12:09:50 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     backports@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] gentree: add timing info to git debug commit message
Date:   Fri, 14 Feb 2020 12:09:47 +0100
Message-Id: <20200214120947.644e437c6838.If8a190b493b67963db290f8b6a69c8907f70d9bf@changeid>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

This is useful to see where we spend most time.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 gentree.py | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/gentree.py b/gentree.py
index 3273eedec928..8fdf34c60f7e 100755
--- a/gentree.py
+++ b/gentree.py
@@ -4,7 +4,7 @@
 #
 
 import argparse, sys, os, errno, shutil, re, subprocess
-import tarfile, gzip
+import tarfile, gzip, time
 
 # find self
 source_dir = os.path.abspath(os.path.dirname(__file__))
@@ -305,12 +305,17 @@ def git_debug_init(args):
     git.commit_all("Copied backport", tree=args.bpid.project_dir)
 
 
+prevtime = None
 def git_debug_snapshot(args, name):
     """
     Take a git snapshot for the debugging.
     """
     if not args.gitdebug:
         return
+    global prevtime
+    if prevtime is not None:
+        name += "\n\n(took %.2f seconds)\n" % (time.time() - prevtime)
+    prevtime = time.time()
     git.commit_all(name, tree=args.bpid.project_dir)
 
 def get_rel_spec_stable(rel):
-- 
2.24.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
