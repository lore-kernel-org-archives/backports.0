Return-Path: <SRS0=6Pme=4J=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A4B5C35640
	for <backports@archiver.kernel.org>; Fri, 21 Feb 2020 09:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24CC4206E2
	for <backports@archiver.kernel.org>; Fri, 21 Feb 2020 09:03:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbgBUJDP (ORCPT <rfc822;backports@archiver.kernel.org>);
        Fri, 21 Feb 2020 04:03:15 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:54812 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbgBUJDP (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 21 Feb 2020 04:03:15 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1j546t-00EncU-BI; Fri, 21 Feb 2020 09:56:35 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     backports@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 15/15] gentree: use 'git cat-file' to speed up obtaining objects
Date:   Fri, 21 Feb 2020 09:56:24 +0100
Message-Id: <20200221095437.3456e7c8b175.Iafc23c313ceb13c32022115a397ece34b2ed2780@changeid>
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

We can use the git cat-file --batch protocol to get objects,
which significantly speeds things up since we don't have to
start a new git process every time.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 gentree.py   | 23 ++++++++++++-----------
 lib/bpgit.py | 25 +++++++++++++++++++++++++
 2 files changed, 37 insertions(+), 11 deletions(-)

diff --git a/gentree.py b/gentree.py
index bf2965f2a8c6..2a9f60d7384b 100755
--- a/gentree.py
+++ b/gentree.py
@@ -213,17 +213,18 @@ def copy_git_files(srcpath, copy_list, rev, outdir):
     "Copy" files from a git repository. This really means listing them with
     ls-tree and then using git show to obtain all the blobs.
     """
-    for srcitem, tgtitem in copy_list:
-        for m, t, h, f in git.ls_tree(rev=rev, files=(srcitem,), tree=srcpath):
-            assert t == 'blob'
-            f = os.path.join(outdir, f.replace(srcitem, tgtitem))
-            d = os.path.dirname(f)
-            if not os.path.exists(d):
-                os.makedirs(d)
-            outf = open(f, 'w')
-            git.get_blob(h, outf, tree=srcpath)
-            outf.close()
-            os.chmod(f, int(m, 8))
+    with git.CatFile(tree=srcpath) as cf:
+        for srcitem, tgtitem in copy_list:
+            for m, t, h, f in git.ls_tree(rev=rev, files=(srcitem,), tree=srcpath):
+                assert t == 'blob'
+                f = os.path.join(outdir, f.replace(srcitem, tgtitem))
+                d = os.path.dirname(f)
+                if not os.path.exists(d):
+                    os.makedirs(d)
+                outf = open(f, 'w')
+                cf.get_blob(h, outf)
+                outf.close()
+                os.chmod(f, int(m, 8))
 
 def automatic_backport_mangle_c_file(name):
     return name.replace('/', '-')
diff --git a/lib/bpgit.py b/lib/bpgit.py
index 60d4abaa7a0d..7b57f6b2690a 100644
--- a/lib/bpgit.py
+++ b/lib/bpgit.py
@@ -357,3 +357,28 @@ def diff(tree=None, extra_args=None):
     _check(process)
 
     return stdout
+
+class CatFile(object):
+    def __init__(self, tree=None):
+        self.tree = tree
+        self.p = None
+
+    def __enter__(self):
+        self.p = subprocess.Popen(['git', 'cat-file', '--batch'], cwd=self.tree,
+                                  stdout=subprocess.PIPE, stdin=subprocess.PIPE)
+        return self
+
+    def get_blob(self, sha, outf):
+        self.p.stdin.write(sha + '\n')
+        hdr = self.p.stdout.readline().split()
+        assert len(hdr) == 3
+        assert hdr[1] == 'blob'
+        size = int(hdr[2])
+        outf.write(self.p.stdout.read(size))
+        assert self.p.stdout.readline() == '\n'
+
+    def __exit__(self, type, value, traceback):
+        self.p.stdin.close()
+        self.p.wait()
+        _check(self.p)
+        self.p = None
-- 
2.24.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
