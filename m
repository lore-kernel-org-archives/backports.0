Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:50199 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755715Ab3EVLf1 (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 22 May 2013 07:35:27 -0400
Received: by mail-pa0-f43.google.com with SMTP id hz10so1716438pad.16
        for <backports@vger.kernel.org>; Wed, 22 May 2013 04:35:27 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 9/9] gentree.py: add kernel upload support
Date: Wed, 22 May 2013 04:34:38 -0700
Message-Id: <1369222478-30577-10-git-send-email-mcgrof@do-not-panic.com> (sfid-20130522_133529_897575_BF4ED13D)
In-Reply-To: <1369222478-30577-1-git-send-email-mcgrof@do-not-panic.com>
References: <1369222478-30577-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

This streamlines our release process making it easier for
transitioning releases onto other backport developers.

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 gentree.py |  206 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 202 insertions(+), 4 deletions(-)

diff --git a/gentree.py b/gentree.py
index f25db52..52498f7 100755
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
@@ -250,6 +253,154 @@ def git_debug_snapshot(args, name):
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
+    korg_path = "/pub/linux/kernel/projects/backports/"
+
+    if (rel_prep['stable']):
+        korg_path += "stable/"
+
+    parent = os.path.dirname(args.outdir)
+    release = os.path.basename(args.outdir)
+    tar_name = parent + '/' + release + ".tar"
+    bzip2_name = tar_name + ".bz2"
+
+    create_tar_and_bz2(tar_name, args.outdir)
+
+    logwrite(kup.ls(korg_path))
+    logwrite(gpg.sign(tar_name))
+    return
+
+    for path in rel_prep['paths_to_create']:
+        korg_path += path
+        logwrite(kup.mkdir(path))
+    logwrite(kup.put(bzip2_name, tar_name + '.asc', korg_path))
 
 def _main():
     # set up and parse arguments
@@ -278,6 +429,8 @@ def _main():
                         help='Print more verbose information')
     parser.add_argument('--extra-driver', nargs=2, metavar=('<source dir>', '<copy-list>'), type=str,
                         action='append', default=[], help='Extra driver directory/copy-list.')
+    parser.add_argument('--kup', const=True, default=False, action="store_const",
+                        help='For maintainers: upload a release to kernel.org')
     args = parser.parse_args()
 
     def logwrite(msg):
@@ -289,16 +442,19 @@ def _main():
                    git_revision=args.git_revision, clean=args.clean,
                    refresh=args.refresh, base_name=args.base_name,
                    gitdebug=args.gitdebug, verbose=args.verbose,
-                   extra_driver=args.extra_driver, logwrite=logwrite)
+                   extra_driver=args.extra_driver,
+                   kup=args.kup,
+                   logwrite=logwrite)
 
 def process(kerneldir, outdir, copy_list_file, git_revision=None,
             clean=False, refresh=False, base_name="Linux", gitdebug=False,
-            verbose=False, extra_driver=[], logwrite=lambda x:None,
+            verbose=False, extra_driver=[], kup=False,
+            logwrite=lambda x:None,
             git_tracked_version=False):
     class Args(object):
         def __init__(self, kerneldir, outdir, copy_list_file,
                      git_revision, clean, refresh, base_name,
-                     gitdebug, verbose, extra_driver):
+                     gitdebug, verbose, extra_driver, kup):
             self.kerneldir = kerneldir
             self.outdir = outdir
             self.copy_list = copy_list_file
@@ -309,10 +465,47 @@ def process(kerneldir, outdir, copy_list_file, git_revision=None,
             self.gitdebug = gitdebug
             self.verbose = verbose
             self.extra_driver = extra_driver
+            self.kup = kup
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
+                gitdebug, verbose, extra_driver, kup)
+    rel_prep = None
+
     # start processing ...
+    if (args.kup):
+        git_paranoia(source_dir, logwrite)
+        git_paranoia(kerneldir, logwrite)
+
+        rel_describe = git.describe(tree=source_dir)
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
@@ -342,6 +535,8 @@ def process(kerneldir, outdir, copy_list_file, git_revision=None,
 
     # FIXME: should we add a git version of this (e.g. --git-extra-driver)?
     for src, copy_list in args.extra_driver:
+        if (args.kup):
+            git_paranoia(src)
         copy_files(src, read_copy_list(open(copy_list, 'r')), args.outdir)
 
     git_debug_snapshot(args, 'Add driver sources')
@@ -537,6 +732,9 @@ def process(kerneldir, outdir, copy_list_file, git_revision=None,
         fo.close()
     git_debug_snapshot(args, "disable unsatisfied Makefile parts")
 
+    if (args.kup):
+        upload_release(args, rel_prep)
+
     logwrite('Done!')
     return 0
 
-- 
1.7.10.4

