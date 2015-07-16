Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:36558 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753591AbbGPAdE (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 15 Jul 2015 20:33:04 -0400
Received: by pachj5 with SMTP id hj5so32617277pac.3
        for <backports@vger.kernel.org>; Wed, 15 Jul 2015 17:33:03 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: julia.lawall@lip6.fr, "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 2/2] ckmake: address directory max depth
Date: Wed, 15 Jul 2015 17:32:52 -0700
Message-Id: <1437006772-25592-3-git-send-email-mcgrof@do-not-panic.com> (sfid-20150716_023307_352517_654F32DC)
In-Reply-To: <1437006772-25592-1-git-send-email-mcgrof@do-not-panic.com>
References: <1437006772-25592-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

It seems new versions of python make the os walk recurse more
than we used to before, our ckmake implementation was picking up
more kernels targets than obviously we want to build then. Fix
this by replacing the os.walk() with a simple os.listdir()
which just keeps us at the top level directory of lib/modules.

There are issues still with the way kernels are reported but
that's a cosmetic thing which we can fix next.

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 devel/ckmake | 132 +++++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 84 insertions(+), 48 deletions(-)

diff --git a/devel/ckmake b/devel/ckmake
index 0c238a65de8d..23f3819221f8 100755
--- a/devel/ckmake
+++ b/devel/ckmake
@@ -455,52 +455,58 @@ class kernel_set():
                 return
         self.releases.insert(new_rel['idx'], new_rel)
 
-    def parse_releases(self, target_kranges):
+    def parse_releases(self, target_kranges, args):
         self.target_kranges = target_kranges
-        for dirname, dirnames, filenames in os.walk(modules):
-            rels = []
-            for subdirname in dirnames:
-                specifics = get_rel_spec_ubuntu(subdirname)
-                if (not specifics):
-                    continue
-                base_specs = get_base_spec(specifics)
-                if (not base_specs):
-                    continue
-                rc = False
-
-                ver = specifics['VERSION'] + '.' + \
-                    specifics['PATCHLEVEL']
-
-                if ("rc" in subdirname):
-                    rc = True
-                    ver = ver + '-rc' + specifics['EXTRAVERSION']
-                else:
-                    ver = ver + '.' + specifics['SUBLEVEL']
-
-                get_rel_spec_base(subdirname)
-                rel = dict(name=subdirname,
-                           full_path=dirname + '/' +
-                           subdirname,
-                           version=ver,
-                           is_rc=rc,
-                           ver=specifics['VERSION'],
-                           pat=specifics['PATCHLEVEL'],
-                           sub=specifics['SUBLEVEL'],
-                           ext=specifics['EXTRAVERSION'],
-                           base_weight=compute_rel_weight_base(base_specs),
-                           weight=compute_rel_weight(specifics),
-                           processed=False,
-                           log='',
-                           status=1234)
-                rels.append(rel)
-
-            def relsort(rel):
-                return int(rel['ver']), int(rel['pat']), int(rel['sub'])
-            rels.sort(key=relsort)
-            for rel in rels:
-                rel['idx'] = len(self.releases)
-                self.evaluate_new_rel(rel)
-        self.refresh()
+        rels = []
+        if args.develdebug:
+            sys.stdout.write("Paths for kernels:\n")
+        for path in os.listdir(os.path.abspath(modules)):
+            subdirname = os.path.abspath(os.path.join(modules, path))
+            if not os.path.isdir(subdirname):
+                continue
+            if args.develdebug:
+                sys.stdout.write("%s\n" % (subdirname))
+            specifics = get_rel_spec_ubuntu(path)
+            if (not specifics):
+                continue
+            base_specs = get_base_spec(specifics)
+            if (not base_specs):
+                continue
+            rc = False
+
+            ver = specifics['VERSION'] + '.' + \
+                specifics['PATCHLEVEL']
+
+            if ("rc" in subdirname):
+                rc = True
+                ver = ver + '-rc' + specifics['EXTRAVERSION']
+            else:
+                ver = ver + '.' + specifics['SUBLEVEL']
+
+            get_rel_spec_base(subdirname)
+            rel = dict(name=subdirname,
+                       full_path=subdirname,
+                       version=ver,
+                       is_rc=rc,
+                       ver=specifics['VERSION'],
+                       pat=specifics['PATCHLEVEL'],
+                       sub=specifics['SUBLEVEL'],
+                       ext=specifics['EXTRAVERSION'],
+                       base_weight=compute_rel_weight_base(base_specs),
+                       weight=compute_rel_weight(specifics),
+                       processed=False,
+                       log='',
+                       status=1234)
+            rels.append(rel)
+
+        def relsort(rel):
+            return int(rel['ver']), int(rel['pat']), int(rel['sub'])
+        rels.sort(key=relsort)
+        for rel in rels:
+            rel['idx'] = len(self.releases)
+            self.evaluate_new_rel(rel)
+        if not args.develdebug:
+            self.refresh()
 
     def setup_screen(self):
         for i in range(0, len(self.releases)):
@@ -519,6 +525,16 @@ class kernel_set():
             self.stdscr.refresh()
             self.lock.release()
 
+    def setup_screen_debug(self):
+        sys.stdout.write("%-4s" % ("IDX"))
+        sys.stdout.write("%-20s" % ("VERSION"))
+        sys.stdout.write("%-60s\n" % ("DIRECTORY"))
+        for i in range(0, len(self.releases)):
+            rel = self.releases[i]
+            sys.stdout.write("%-4d" % (rel['idx'] + 1))
+            sys.stdout.write("%-20s" % (rel['version']))
+            sys.stdout.write("%-60s\n" % (rel['full_path']))
+
     def create_threads(self, cmdline_args):
         for rel in self.releases:
             th = Thread(target=process_kernel, args=(0, self, cmdline_args))
@@ -552,9 +568,19 @@ class kernel_set():
 def main(stdscr, args, target_kranges):
     kset = kernel_set(stdscr)
 
-    kset.set_locale()
-    kset.parse_releases(target_kranges)
+    if args.develdebug:
+        kill_curses()
+    else:
+        kset.set_locale()
+
+    kset.parse_releases(target_kranges, args)
+
+    if args.develdebug:
+        kset.setup_screen_debug()
+        sys.exit(0)
+
     kset.setup_screen()
+
     kset.create_threads(args)
     kset.kick_threads()
     kset.wait_threads()
@@ -602,6 +628,9 @@ if __name__ == "__main__":
                         help='Build this defconfig rather than only backport code.')
     parser.add_argument('--revs', metavar='<revision-list>', type=str,
                         help='Optional list of kernel revisions to test for, example: 2.6.24,2.6.30,2.6.32..3.2,3.4')
+    parser.add_argument(
+        '--develdebug', const=True, default=False, action="store_const",
+        help='Development debug - use to debug which kernels we are going to process')
     args = parser.parse_args()
 
     target_kranges = []
@@ -624,8 +653,15 @@ if __name__ == "__main__":
         os.remove(ckmake_report)
     if os.path.exists(tmp_path):
         rmtree(tmp_path)
-    os.makedirs(tmp_path)
+
+    if not args.develdebug:
+        os.makedirs(tmp_path)
+
     curses.wrapper(main, args, target_kranges)
+
+    if args.develdebug:
+        sys.exit(ckmake_return)
+
     kill_curses()
     process_logs()
     clean()
-- 
2.3.2.209.gd67f9d5.dirty

--
To unsubscribe from this list: send the line "unsubscribe backports" in
