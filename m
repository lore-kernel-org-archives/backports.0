Return-Path: <SRS0=6Pme=4J=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74FF3C35641
	for <backports@archiver.kernel.org>; Fri, 21 Feb 2020 09:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45042206E2
	for <backports@archiver.kernel.org>; Fri, 21 Feb 2020 09:03:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbgBUJDW (ORCPT <rfc822;backports@archiver.kernel.org>);
        Fri, 21 Feb 2020 04:03:22 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:54820 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbgBUJDV (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 21 Feb 2020 04:03:21 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1j546t-00EncU-2G; Fri, 21 Feb 2020 09:56:35 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     backports@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 14/15] git-tracker: refactor function that adds change-id
Date:   Fri, 21 Feb 2020 09:56:23 +0100
Message-Id: <20200221095437.c04553d91428.I5895c66b1942b16096979ea5bc1e38a4d9caaa75@changeid>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200221085624.6213-1-johannes@sipsolutions.net>
References: <20200221085624.6213-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 devel/git-tracker.py | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/devel/git-tracker.py b/devel/git-tracker.py
index 7e55fa5ccb8e..14e2f14b9a63 100755
--- a/devel/git-tracker.py
+++ b/devel/git-tracker.py
@@ -54,6 +54,16 @@ def update_cache_objects(gittree, objdir, input):
         git.set_origin(gittree, objdir)
         git.remote_update(objdir, env=env)
 
+def add_changeid_to_message(msg):
+    have_changeid = False
+    for line in msg.split('\n'):
+        if line.lower().startswith('change-id: I'):
+            have_changeid = True
+            break
+    if not have_changeid:
+        msg += 'Change-Id: I%s\n' % hashlib.sha1(msg).hexdigest()
+    return msg
+
 def handle_commit(args, msg, branch, treename, kernelobjdir, tmpdir, wgitdir, backport_rev, kernel_rev,
                   prev_kernel_rev=None, defconfig=None, env={}, commit_failure=True,
                   append_shortlog=None, add_changeid=False):
@@ -129,13 +139,7 @@ def handle_commit(args, msg, branch, treename, kernelobjdir, tmpdir, wgitdir, ba
           }
 
             if add_changeid:
-                have_changeid = False
-                for line in msg.split('\n'):
-                    if line.lower().startswith('change-id: I'):
-                        have_changeid = True
-                        break
-                if not have_changeid:
-                    msg += 'Change-Id: I%s\n' % hashlib.sha1(msg).hexdigest()
+                msg = add_changeid_to_message(msg)
 
             treeid = git.write_tree(tree=wdir)
             git.commit_tree(treeid, msg, parents, tree=wdir, env=env)
-- 
2.24.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
