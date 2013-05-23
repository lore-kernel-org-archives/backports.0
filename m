Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pb0-f49.google.com ([209.85.160.49]:38268 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756346Ab3EWDQS (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 22 May 2013 23:16:18 -0400
Received: by mail-pb0-f49.google.com with SMTP id rp8so2372174pbb.22
        for <backports@vger.kernel.org>; Wed, 22 May 2013 20:16:18 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH v3 2/8] lib/bpgit.py: add git status support
Date: Wed, 22 May 2013 20:15:50 -0700
Message-Id: <1369278956-17550-3-git-send-email-mcgrof@do-not-panic.com> (sfid-20130523_051619_885395_0D11993A)
In-Reply-To: <1369278956-17550-1-git-send-email-mcgrof@do-not-panic.com>
References: <1369278956-17550-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

We use --porcelain given that this spits out the results
in an easy-to-parse format for scripts and will remain stable
across git versions and regardless of user configuration.

We will use this later.

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 lib/bpgit.py |   54 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/lib/bpgit.py b/lib/bpgit.py
index 9a3f430..3f7eb1b 100644
--- a/lib/bpgit.py
+++ b/lib/bpgit.py
@@ -27,6 +27,60 @@ def rev_parse(rev='HEAD', tree=None):
         raise SHAError()
     return sha
 
+def status(tree=None):
+    '''
+    For interpretation of the porcelain output refer to
+    the git status(1) man page. In summary the first column is the
+    index state, the second represents the working tree state and
+    the third column are files in cases of renames. This gives back
+    None in case no changes are present, otherwise it returns a list
+    of dict entries with key values: index, work_tree, and files. The
+    files are a list of all files found on that entry, in case of a rename
+    this would consist of a list of 2 files.
+
+    As an example if you had this on your git status:
+
+    R  udev/foo.sh -> poo/foo.sh
+    D  scripts/bar.sh
+    ?? .poo.py.swp
+
+    This would be transposed into the following dict:
+
+        results = status(tree=your_git_tree_path)
+        if not results:
+            return 0
+        for entry in results:
+            print entry
+
+    {'files': [' udev/foo.sh', 'poo/foo.sh'], 'index': 'R', 'work_tree': ' '}
+    {'files': [' scripts/bar.sh'], 'index': 'D', 'work_tree': ' '}
+    {'files': [' .poo.py.swp'], 'index': '?', 'work_tree': '?'}
+    '''
+    def split_status(entry):
+        if len(entry) == 0:
+            return None
+        if len(entry) == 1:
+            return dict(index=entry[0], work_tree=None, files=None)
+        if len(entry) == 2:
+            return dict(index=entry[0], work_tree=entry[1], files=None)
+        else:
+            return dict(index=entry[0], work_tree=entry[1],
+                        files=entry[2:].split(' -> '))
+
+    cmd = ['git', 'status', '--porcelain']
+                                                                                
+    process = subprocess.Popen(cmd,
+            stdout=subprocess.PIPE, stderr=subprocess.STDOUT, close_fds=True,
+            universal_newlines=True, cwd=tree)
+    stdout = process.communicate()[0]
+    process.wait()
+    _check(process)
+
+    list_status = stdout.split('\n')
+    if (len(list_status) == 1 and list_status[0] == ''):
+        return None
+    return [split_status(entry) for entry in list_status]
+
 def describe(rev='HEAD', tree=None, extra_args=[]):
     cmd = ['git', 'describe', '--always']
 
-- 
1.7.10.4

