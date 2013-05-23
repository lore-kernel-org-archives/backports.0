Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:47107 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756623Ab3EWDQo (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 22 May 2013 23:16:44 -0400
Received: by mail-pb0-f46.google.com with SMTP id rq2so2399526pbb.19
        for <backports@vger.kernel.org>; Wed, 22 May 2013 20:16:44 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH v3 8/8] gentree.py: add kernel upload support
Date: Wed, 22 May 2013 20:15:56 -0700
Message-Id: <1369278956-17550-9-git-send-email-mcgrof@do-not-panic.com> (sfid-20130523_051647_045037_8195DCDD)
In-Reply-To: <1369278956-17550-1-git-send-email-mcgrof@do-not-panic.com>
References: <1369278956-17550-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

This streamlines our release process making it easier for
transitioning releases onto other backport developers.

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 gentree.py |  232 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 228 insertions(+), 4 deletions(-)

diff --git a/gentree.py b/gentree.py
index 2810415..c700309 100755
--- a/gentree.py
+++ b/gentree.py
@@ -4,6 +4,7 @@
 #
 
 import argparse, sys, os, errno, shutil, re, subprocess
+import tarfile, bz2
 
 # find self
 source_dir = os.path.abspath(os.path.dirname(__file__))
@@ -11,6 +12,8 @@ sys.path.append(source_dir)
 # and import libraries we have
 from lib import kconfig, patch, make
 from lib import bpgit as git
+from lib import bpgpg as gpg
+from lib import bpkup as kup
 
 def read_copy_list(copyfile):
     """
@@ -250,6 +253,169 @@ def git_debug_snapshot(args, name):
         return
     git.commit_all(name, tree=args.outdir)
 
+def get_rel_spec_stable(rel):
+    """
+    Returns release specs for a linux-stable backports based release.
+    """
+    if ("rc" in rel):
+        m = re.match(r"(?P<VERSION>\d+)\.+" \
+                     "(?P<PATCHLEVEL>\d+)[.]*" \
+                     "(?P<SUBLEVEL>\d*)" \
+                     "[-rc]+(?P<RC_VERSION>\d+)\-+" \
+                     "(?P<RELMOD_UPDATE>\d+)[-]*" \
+                     "(?P<RELMOD_TYPE>[usnpc]*)", \
+                     rel)
+    else:
+        m = re.match(r"(?P<VERSION>\d+)\.+" \
+                     "(?P<PATCHLEVEL>\d+)[.]*" \
+                     "(?P<SUBLEVEL>\d*)\-+" \
+                     "(?P<RELMOD_UPDATE>\d+)[-]*" \
+                     "(?P<RELMOD_TYPE>[usnpc]*)", \
+                     rel)
+    if (not m):
+        return m
+    return m.groupdict()
+
+def get_rel_spec_next(rel):
+    """
+    Returns release specs for a linux-next backports based release.
+    """
+    m = re.match(r"(?P<DATE_VERSION>\d+)[-]*" \
+                 "(?P<RELMOD_UPDATE>\d*)[-]*" \
+                 "(?P<RELMOD_TYPE>[usnpc]*)", \
+                 rel)
+    if (not m):
+        return m
+    return m.groupdict()
+
+def get_rel_prep(rel):
+    """
+    Returns a dict with prep work details we need prior to
+    uploading a backports release to kernel.org
+    """
+    rel_specs = get_rel_spec_stable(rel)
+    is_stable = True
+    rel_tag = ""
+    paths = list()
+    if (not rel_specs):
+        rel_specs = get_rel_spec_next(rel)
+        if (not rel_specs):
+            sys.stdout.write("rel: %s\n" % rel)
+            return None
+        if (rel_specs['RELMOD_UPDATE'] == '0' or
+            rel_specs['RELMOD_UPDATE'] == '1'):
+            return None
+        is_stable = False
+        date = rel_specs['DATE_VERSION']
+        year = date[0:4]
+        if (len(year) != 4):
+            return None
+        month = date[4:6]
+        if (len(month) != 2):
+            return None
+        day = date[6:8]
+        if (len(day) != 2):
+            return None
+        paths.append(year)
+        paths.append(month)
+        paths.append(day)
+        rel_tag = "backports-" + rel.replace(rel_specs['RELMOD_TYPE'], "")
+    else:
+        ignore = "-"
+        if (not rel_specs['RELMOD_UPDATE']):
+            return None
+        if (rel_specs['RELMOD_UPDATE'] == '0'):
+            return None
+        ignore += rel_specs['RELMOD_UPDATE']
+        if (rel_specs['RELMOD_TYPE'] != ''):
+            ignore += rel_specs['RELMOD_TYPE']
+        base_rel = rel.replace(ignore, "")
+        paths.append(base_rel)
+        rel_tag = "v" + rel.replace(rel_specs['RELMOD_TYPE'], "")
+
+    rel_prep = dict(stable = is_stable,
+                    expected_tag = rel_tag,
+                    paths_to_create = paths)
+    return rel_prep
+
+def create_tar_and_bz2(tar_name, dir_to_tar):
+    """
+    We need both a tar file and bzip2 for kernel.org, the tar file
+    gets signed, then we upload the compressed version, kup-server
+    in the backend decompresses and verifies the tarball against
+    our signature.
+    """
+    parent = os.path.dirname(tar_name)
+    tar = tarfile.open(tar_name, "w")
+    tar.add(dir_to_tar)
+    tar.close()
+
+    tar_file = open(tar_name, "r")
+
+    bz2_file = bz2.BZ2File(tar_name + ".bz2", 'wb', compresslevel=9)
+    bz2_file.write(tar_file.read())
+    bz2_file.close()
+
+    tar.close()
+
+def upload_release(args, rel_prep, logwrite=lambda x:None):
+    """
+    Given a path of a relase make tarball out of it, PGP sign it, and
+    then upload it to kernel.org using kup.
+
+    The linux-next based release do not require a RELMOD_UPDATE
+    given that typically only one release is made per day. Using
+    RELMOD_UPDATE for these releases is allowed though and if
+    present it must be > 1.
+
+    The linux-stable based releases require a RELMOD_UPDATE.
+
+    RELMOD_UPDATE must be numeric and > 0 just as the RC releases
+    of the Linux kernel.
+
+    The tree must also be tagged with the respective release, without
+    the RELMOD_TYPE. For linux-next based releases this consists of
+    backports- followed by DATE_VERSION and if RELMOD_TYPE is present.
+    For linux-stable releases this consists of v followed by the
+    full release version except the RELMOD_TYPE.
+
+    Uploads will not be allowed if these rules are not followed.
+    """
+    korg_path = "/pub/linux/kernel/projects/backports"
+
+    if (rel_prep['stable']):
+        korg_path += "stable"
+
+    parent = os.path.dirname(args.outdir)
+    release = os.path.basename(args.outdir)
+    tar_name = parent + '/' + release + ".tar"
+    bzip2_name = tar_name + ".bz2"
+
+    create_tar_and_bz2(tar_name, args.outdir)
+
+    logwrite(gpg.sign(tar_name, extra_args=['--armor', '--detach-sign']))
+
+    logwrite("------------------------------------------------------")
+
+    if (not args.kup_test):
+        logwrite("About to upload, current target path contents:")
+    else:
+        logwrite("kup-test: current target path contents:")
+
+    logwrite(kup.ls(path=korg_path))
+
+    for path in rel_prep['paths_to_create']:
+        korg_path += '/' + path
+        if (not args.kup_test):
+            logwrite(kup.mkdir(path))
+    if (not args.kup_test):
+        logwrite(kup.put(bzip2_name, tar_name + '.asc', korg_path))
+        logwrite("\nFinished upload!\n")
+        logwrite("Target path contents:")
+        logwrite(kup.ls(path=korg_path))
+    else:
+        kup_cmd = "kup put /\n\t\t%s /\n\t\t%s /\n\t\t%s" % (bzip2_name, tar_name + '.asc', korg_path)
+        logwrite("kup-test: skipping cmd: %s" % kup_cmd)
 
 def _main():
     # set up and parse arguments
@@ -278,6 +444,15 @@ def _main():
                         help='Print more verbose information')
     parser.add_argument('--extra-driver', nargs=2, metavar=('<source dir>', '<copy-list>'), type=str,
                         action='append', default=[], help='Extra driver directory/copy-list.')
+    parser.add_argument('--kup', const=True, default=False, action="store_const",
+                        help='For maintainers: upload a release to kernel.org')
+    parser.add_argument('--kup-test', const=True, default=False, action="store_const",
+                        help='For maintainers: do all the work as if you were about to ' +
+                             'upload to kernel.org but do not do the final `kup put` ' +
+                             'and also do not run any `kup mkdir` commands. This will ' +
+                             'however run `kup ls` on the target paths so ' +
+                             'at the very least we test your kup configuration. ' +
+                             'If this is your first time uploading use this first!')
     args = parser.parse_args()
 
     def logwrite(msg):
@@ -289,16 +464,22 @@ def _main():
                    git_revision=args.git_revision, clean=args.clean,
                    refresh=args.refresh, base_name=args.base_name,
                    gitdebug=args.gitdebug, verbose=args.verbose,
-                   extra_driver=args.extra_driver, logwrite=logwrite)
+                   extra_driver=args.extra_driver,
+                   kup=args.kup,
+                   kup_test=args.kup_test,
+                   logwrite=logwrite)
 
 def process(kerneldir, outdir, copy_list_file, git_revision=None,
             clean=False, refresh=False, base_name="Linux", gitdebug=False,
-            verbose=False, extra_driver=[], logwrite=lambda x:None,
+            verbose=False, extra_driver=[], kup=False,
+            kup_test=False,
+            logwrite=lambda x:None,
             git_tracked_version=False):
     class Args(object):
         def __init__(self, kerneldir, outdir, copy_list_file,
                      git_revision, clean, refresh, base_name,
-                     gitdebug, verbose, extra_driver):
+                     gitdebug, verbose, extra_driver, kup,
+                     kup_test):
             self.kerneldir = kerneldir
             self.outdir = outdir
             self.copy_list = copy_list_file
@@ -309,10 +490,48 @@ def process(kerneldir, outdir, copy_list_file, git_revision=None,
             self.gitdebug = gitdebug
             self.verbose = verbose
             self.extra_driver = extra_driver
+            self.kup = kup
+            self.kup_test = kup_test
+    def git_paranoia(tree=None, logwrite=lambda x:None):
+        data = git.paranoia(tree)
+        if (data['r'] != 0):
+            logwrite('Cannot use %s' % tree)
+            logwrite('%s' % data['output'])
+            sys.exit(data['r'])
+        else:
+            logwrite('Validated tree: %s' % tree)
+
     args = Args(kerneldir, outdir, copy_list_file,
                 git_revision, clean, refresh, base_name,
-                gitdebug, verbose, extra_driver)
+                gitdebug, verbose, extra_driver, kup, kup_test)
+    rel_prep = None
+
     # start processing ...
+    if (args.kup or args.kup_test):
+        git_paranoia(source_dir, logwrite)
+        git_paranoia(kerneldir, logwrite)
+
+        rel_describe = git.describe(rev=None, tree=source_dir, extra_args=['--dirty'])
+        release = os.path.basename(args.outdir)
+        version = release.replace("backports-", "")
+
+        rel_prep = get_rel_prep(version)
+        if (not rel_prep):
+            logwrite('Invalid backports release name: %s' % release)
+            logwrite('For rules on the release name see upload_release()')
+            sys.exit(1)
+        rel_type = "linux-stable"
+        if (not rel_prep['stable']):
+            rel_type = "linux-next"
+        if (rel_prep['expected_tag'] != rel_describe):
+            logwrite('Unexpected %s based backports release tag on' % rel_type)
+            logwrite('the backports tree tree: %s\n' % rel_describe)
+            logwrite('You asked to make a release with this ')
+            logwrite('directory name: %s' % release)
+            logwrite('The actual expected tag we should find on')
+            logwrite('the backports tree then is: %s\n' % rel_prep['expected_tag'])
+            logwrite('For rules on the release name see upload_release()')
+            sys.exit(1)
 
     copy_list = read_copy_list(args.copy_list)
     deplist = read_dependencies(os.path.join(source_dir, 'dependencies'))
@@ -342,6 +561,8 @@ def process(kerneldir, outdir, copy_list_file, git_revision=None,
 
     # FIXME: should we add a git version of this (e.g. --git-extra-driver)?
     for src, copy_list in args.extra_driver:
+        if (args.kup or args.kup_test):
+            git_paranoia(src)
         copy_files(src, read_copy_list(open(copy_list, 'r')), args.outdir)
 
     git_debug_snapshot(args, 'Add driver sources')
@@ -537,6 +758,9 @@ def process(kerneldir, outdir, copy_list_file, git_revision=None,
         fo.close()
     git_debug_snapshot(args, "disable unsatisfied Makefile parts")
 
+    if (args.kup or args.kup_test):
+        upload_release(args, rel_prep, logwrite=logwrite)
+
     logwrite('Done!')
     return 0
 
-- 
1.7.10.4

