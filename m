Return-Path: <SRS0=6Pme=4J=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B03FBC35641
	for <backports@archiver.kernel.org>; Fri, 21 Feb 2020 09:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EE1C206EF
	for <backports@archiver.kernel.org>; Fri, 21 Feb 2020 09:07:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbgBUJH5 (ORCPT <rfc822;backports@archiver.kernel.org>);
        Fri, 21 Feb 2020 04:07:57 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:54902 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727426AbgBUJH4 (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 21 Feb 2020 04:07:56 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1j54Hq-00Ep9Q-HW; Fri, 21 Feb 2020 10:07:54 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     backports@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2] git-tracker: use write-tree/commit-tree/update-ref
Date:   Fri, 21 Feb 2020 10:07:50 +0100
Message-Id: <20200221100750.61538df8b501.I370ee81ce341d4db00a2e5193efe3c697f944121@changeid>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

This gives us more flexibility, so we can create pretend
merge commits later.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
v2:
 * use -F - (two arguments) instead of -F- to make it
   compatible with ancient git
---
 devel/git-tracker.py |  4 +++-
 lib/bpgit.py         | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/devel/git-tracker.py b/devel/git-tracker.py
index 1cb26ec82eb0..7e55fa5ccb8e 100755
--- a/devel/git-tracker.py
+++ b/devel/git-tracker.py
@@ -104,6 +104,7 @@ def handle_commit(args, msg, branch, treename, kernelobjdir, tmpdir, wgitdir, ba
         else:
             git.reset(opts=['-q'], tree=wdir)
 
+        parents = [git.rev_parse('HEAD', tree=wdir)]
         if not failure or commit_failure:
             if append_shortlog:
                 files = []
@@ -136,7 +137,8 @@ def handle_commit(args, msg, branch, treename, kernelobjdir, tmpdir, wgitdir, ba
                 if not have_changeid:
                     msg += 'Change-Id: I%s\n' % hashlib.sha1(msg).hexdigest()
 
-            git.commit(msg, tree=wdir, env=env, opts=['-q', '--allow-empty'])
+            treeid = git.write_tree(tree=wdir)
+            git.commit_tree(treeid, msg, parents, tree=wdir, env=env)
             git.push(opts=['-f', '-q', 'origin', branch], tree=wdir)
         os.rename(os.path.join(wdir, '.git'), wgitdir)
     finally:
diff --git a/lib/bpgit.py b/lib/bpgit.py
index ff5f4a0c95b3..c80647465778 100644
--- a/lib/bpgit.py
+++ b/lib/bpgit.py
@@ -255,6 +255,40 @@ def add(fn, tree=None):
     process.wait()
     _check(process)
 
+def write_tree(tree=None):
+    process = subprocess.Popen(['git', 'write-tree'], stdout=subprocess.PIPE,
+                               close_fds=True, universal_newlines=True, cwd=tree)
+    stdout = process.communicate()[0]
+    process.wait()
+    _check(process)
+    sha = stdout.strip()
+    if not _sha_re.match(sha):
+        raise SHAError()
+    return sha
+
+def commit_tree(treeid, msg, parents, env=None, tree=None):
+    if env is None:
+        env = {}
+    opts = []
+    for p in parents:
+        opts.extend(['-p', p])
+    stdin = tempfile.NamedTemporaryFile(mode='wr')
+    stdin.write(msg)
+    stdin.seek(0)
+    process = subprocess.Popen(['git', 'commit-tree', '-F', '-', treeid] + opts,
+                               stdin=stdin.file, universal_newlines=True,
+                               stdout=subprocess.PIPE, env=env, cwd=tree)
+    stdout = process.communicate()[0]
+    process.wait()
+    _check(process)
+    sha = stdout.strip()
+    if not _sha_re.match(sha):
+        raise SHAError()
+    process = subprocess.Popen(['git', 'update-ref', 'HEAD', sha], cwd=tree)
+    process.wait()
+    _check(process)
+    return sha
+
 def commit(msg, tree=None, env = {}, opts=[]):
     stdin = tempfile.NamedTemporaryFile(mode='wr')
     stdin.write(msg)
-- 
2.24.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
