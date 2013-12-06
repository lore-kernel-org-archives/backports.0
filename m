Return-path: <backports-owner@vger.kernel.org>
Received: from mail-we0-f182.google.com ([74.125.82.182]:46357 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751475Ab3LFBzT (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 5 Dec 2013 20:55:19 -0500
Received: by mail-we0-f182.google.com with SMTP id q59so50283wes.41
        for <backports@vger.kernel.org>; Thu, 05 Dec 2013 17:55:17 -0800 (PST)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH] backports: add Python based get-backport-kernels
Date: Fri,  6 Dec 2013 02:55:13 +0100
Message-Id: <1386294913-6124-1-git-send-email-mcgrof@do-not-panic.com> (sfid-20131206_025523_291154_E7CFA3B4)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This replaces the old shell get-compat-kernels
with a shiny Python  based  get-backport-kernels.
The new version provides a few features which were
simply a difficult to implement and quite frankly
pointless to try to implement in shell. Things worth
mentioning:

  * This will now monitor your old directories
    and packages and remove any stale old directory
    or packages. You should feel comfortable with
    now just getting the latest code from the repo
    and always just running the script, it will do
    everything you wished it did for you.

  * This will always check the URLs and ensure your
    file size matches the target upstream size, we
    used to only check if you had the file or not

  * The compat-ksrc directory was renamed to
    ksrc-backports which goes inline with our
    rebranding crusade. The tool is smart enough
    to figure out if you had the old name and
    rename it for you. Its also smart enough to
    figure out if you had your old compat-ksrc
    as a symlink and preserve things just as you
    intended following the old real path.

  * The debs/ directory is now moved into
    ksrc-backports, making it easier to manage
    and detect what is or not part of backports.

  * I found no way to deal with objects to extract
    GNU archive items with Python, so we're stuck with
    requiring GNU ar, this provides a simple wrapper
    for our usage.

Relying on an continued update list is dumb though,
in the future we should look into putting out new
builds through without requiring GNU ar and also
updating the list through a json file just as the
kernel has its own now:

	https://www.kernel.org/releases.json

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 devel/get-backport-kernels | 523 +++++++++++++++++++++++++++++++++++++++++++++
 devel/get-compat-kernels   | 268 -----------------------
 lib/bpar.py                |  17 ++
 3 files changed, 540 insertions(+), 268 deletions(-)
 create mode 100755 devel/get-backport-kernels
 delete mode 100755 devel/get-compat-kernels
 create mode 100644 lib/bpar.py

diff --git a/devel/get-backport-kernels b/devel/get-backport-kernels
new file mode 100755
index 0000000..d689d1a
--- /dev/null
+++ b/devel/get-backport-kernels
@@ -0,0 +1,523 @@
+#!/usr/bin/env python
+import os, sys, errno, getopt, re
+import shutil, urllib2
+from urlparse import urljoin
+from distutils.version import LooseVersion
+import tarfile, tempfile
+import fileinput, subprocess
+source_dir = os.path.abspath(os.path.dirname(__file__))
+sys.path.append(source_dir + '/../')
+from lib import bpar as ar
+
+KPATH="http://kernel.ubuntu.com/~kernel-ppa/mainline/"
+BACKPORTS_KSRC_DIR="ksrc-backports"
+# ~ 101 MiB for installed space on usr/src/ and lib/modules/
+SPACE_PER_KERNEL=101
+# ~13 MiB of both deb files
+SPACE_PER_KERNEL_DEB=13
+
+# Having to update this manually is stupid, lets either get Ubuntu
+# folks to use a json files or we start seeing how we can start
+# building our own shit.
+# For example:
+# https://www.kernel.org/releases.json
+KERNEL_URLS = [
+    KPATH + "v2.6.25/linux-headers-2.6.25-020625_2.6.25-020625_all.deb",
+    KPATH + "v2.6.26/linux-headers-2.6.26-020626_2.6.26-020626_all.deb",
+    KPATH + "v2.6.27/linux-headers-2.6.27-020627_2.6.27-020627_all.deb",
+    KPATH + "v2.6.28.10/linux-headers-2.6.28-02062810_2.6.28-02062810_all.deb",
+    KPATH + "v2.6.29.6/linux-headers-2.6.29-02062906_2.6.29-02062906_all.deb",
+    KPATH + "v2.6.30.10/linux-headers-2.6.30-02063010_2.6.30-02063010_all.deb",
+    KPATH + "v2.6.31.13-karmic/linux-headers-2.6.31-02063113_2.6.31-02063113_all.deb",
+    KPATH + "v2.6.32.61-lucid/linux-headers-2.6.32-02063261_2.6.32-02063261.201306101105_all.deb",
+    KPATH + "v2.6.33.20-maverick/linux-headers-2.6.33-02063320_2.6.33-02063320.201111071735_all.deb",
+    KPATH + "v2.6.34.14-maverick/linux-headers-2.6.34-02063414_2.6.34-02063414.201301162135_all.deb",
+    KPATH + "v2.6.35.13-original-maverick/linux-headers-2.6.35-02063513_2.6.35-02063513.201107261012_all.deb",
+    KPATH + "v2.6.36.4-natty/linux-headers-2.6.36-02063604_2.6.36-02063604.201102180911_all.deb",
+    KPATH + "v2.6.37.6-natty/linux-headers-2.6.37-02063706_2.6.37-02063706.201103281005_all.deb",
+    KPATH + "v2.6.38.8-natty/linux-headers-2.6.38-02063808_2.6.38-02063808.201106040910_all.deb",
+    KPATH + "v2.6.39.4-oneiric/linux-headers-2.6.39-02063904_2.6.39-02063904.201108040905_all.deb",
+    KPATH + "v3.0.101-oneiric/linux-headers-3.0.101-0300101_3.0.101-0300101.201310220446_all.deb",
+    KPATH + "v3.1.10-precise/linux-headers-3.1.10-030110_3.1.10-030110.201201181135_all.deb",
+    KPATH + "v3.2.52-precise/linux-headers-3.2.52-030252_3.2.52-030252.201310262335_all.deb",
+    KPATH + "v3.3.8-quantal/linux-headers-3.3.8-030308_3.3.8-030308.201206041356_all.deb",
+    KPATH + "v3.4.70-quantal/linux-headers-3.4.70-030470_3.4.70-030470.201311201436_all.deb",
+    KPATH + "v3.5.7.12-quantal/linux-headers-3.5.7-03050712_3.5.7-03050712.201305111435_all.deb",
+    KPATH + "v3.6.11-raring/linux-headers-3.6.11-030611_3.6.11-030611.201212171335_all.deb",
+    KPATH + "v3.7.10-raring/linux-headers-3.7.10-030710_3.7.10-030710.201302271235_all.deb",
+    KPATH + "v3.8.13-raring/linux-headers-3.8.13-030813_3.8.13-030813.201305111843_all.deb",
+    KPATH + "v3.9.11-saucy/linux-headers-3.9.11-030911_3.9.11-030911.201307202035_all.deb",
+    KPATH + "v3.10.20-saucy/linux-headers-3.10.20-031020_3.10.20-031020.201311201536_all.deb",
+    KPATH + "v3.11.9-saucy/linux-headers-3.11.9-031109_3.11.9-031109.201311201635_all.deb",
+    KPATH + "v3.12.1-trusty/linux-headers-3.12.1-031201_3.12.1-031201.201311201654_all.deb",
+    KPATH + "v3.13-rc1-trusty/linux-headers-3.13.0-031300rc1_3.13.0-031300rc1.201311221535_all.deb",
+]
+
+NUM_KERNELS=len(KERNEL_URLS)
+
+class backport_kernel_updater:
+    """
+    This is the Linux kernel backports kernel updater. It ensures you
+    have your system up to date with the latest expected kernels, it
+    will also remove any stale kernels directories or files that the
+    upstream project no longer needs or wants.
+    """
+    def pkg_arch(self, machine):
+        if machine == "x86_64":
+            return "amd64"
+        elif machine == "i686":
+            return "i386"
+        sys.stdout.write("Unsupported machine type: %s\n" % machine)
+        sys.exit(1)
+    def __init__(self):
+        self.ksrc_base = ""
+        self.ksrc_prefix = ""
+        self.kernel_urls = KERNEL_URLS
+        self.kernel_urls_generic = list()
+        self.kernel_bases = list()
+        self.kernel_pkgs = list()
+        self.kernel_vers = list()
+        self.kernel_vers_count = list()
+        self.root = os.geteuid() == 0
+        self.force = False
+        self.rebuild_only = False
+        self.cwd = os.getcwd()
+        sysname, nodename, release, version, self.machine = os.uname()
+        self.pkg_arch = self.pkg_arch(self.machine)
+        if self.root:
+            self.ksrc_base = self.cwd + "/"
+            self.ksrc_prefix = self.ksrc_base + BACKPORTS_KSRC_DIR
+        else:
+            self.ksrc_base = os.environ['HOME'] + "/"
+            self.ksrc_prefix = self.ksrc_base + BACKPORTS_KSRC_DIR
+            try:
+                opts, args = getopt.getopt(sys.argv[1:],"hrf")
+            except getopt.GetoptError, err:
+                print str(err)
+                usage()
+        for kernel_url in self.kernel_urls:
+            pkg = kernel_url.split('/')[-1]
+            self.kernel_pkgs.append(pkg)
+            version = pkg.split('-')[2]
+            self.kernel_vers.append(version)
+            kver = dict(ver = version, count = 0)
+            self.kernel_vers_count.append(kver)
+            pkg_tmp = pkg.split('-')[2] + "-" + pkg.split('-')[3]
+            pkg_tmp_base = pkg_tmp.split('_')[0]
+            self.kernel_bases.append(pkg_tmp_base)
+            m = re.match(r"(?P<part_1>.*)_(?P<part_2>.*)_all.deb", kernel_url)
+            pkg_generic_file = m.group('part_1') + '-generic_' + \
+                               m.group('part_2') + '_' + self.pkg_arch + '.deb'
+            pkg_generic_url = urljoin(kernel_url, pkg_generic_file)
+            self.kernel_urls_generic.append(pkg_generic_url)
+
+        urls = self.kernel_urls + self.kernel_urls_generic
+        urls.sort()
+        self.all_kernel_urls = urls
+        self.all_new_kernels = list()
+
+        for o, a in opts:
+            if o in ("-f"):
+                self.force = True
+            elif o in ("-r", "--rebuild"):
+                self.rebuild_only = True
+            elif o in ("-h", "--help"):
+                usage()
+    def warn_root(self):
+        if not self.root:
+            return
+        sys.stdout.write("** Running as a privileged user!\n")
+        sys.stdout.write("** You are trying to force using %s and %s ...\n" % (
+                         self.ksrc_prefix + "/lib/modules",
+                         self.ksrc_prefix + "/usr/src"))
+        sys.stdout.write("** This is a terrible idea. Consider running " \
+                         "as a non root.\n")
+        if not self.force:
+            answer = raw_input("Do you still want to continue (y/N)? ")
+            if answer != "y":
+                sys.exit(1)
+    def warn_size_reqs(self):
+        sys.stdout.write("This will download %d kernel headers to allow you to\n" % NUM_KERNELS)
+        sys.stdout.write("cross compile any module over these kernels with ckmake.\n")
+        sys.stdout.write("The download payload is about ~ %d MiB, once uncompressed\n" %
+                         (SPACE_PER_KERNEL_DEB * NUM_KERNELS))
+        sys.stdout.write("it will stash kernel header files under the directories:\n\n\t%s\n\t%s\n\n" %
+                         (self.ksrc_prefix + "/usr/src/", self.ksrc_prefix + "/lib/modules/"))
+        sys.stdout.write("It will consume about ~ %d MiB of space.\n\n" % (NUM_KERNELS * SPACE_PER_KERNEL))
+        sys.stdout.write("The kernel headers used are from Vanilla kernels")
+        sys.stdout.write("from the \nUbuntu mainline / vanilla kernel PPA and are extracted\n")
+        sys.stdout.write("using the Python tar module:\n\n%s\n\n" % KPATH)
+        if not self.force:
+            answer = raw_input("Do you still want to continue (y/N)? ")
+            if answer != "y":
+                sys.exit(1)
+            sys.stdout.write("\n")
+    def move_dir(self, dirname, dir_target):
+        old_ksrc_prefix = self.ksrc_base + dir_target
+        if (os.path.islink(old_ksrc_prefix)):
+            old_real_path=os.path.realpath(old_ksrc_prefix)
+            old_base_dir=os.path.dirname(old_real_path)
+            new_real_path = old_base_dir + BACKPORTS_KSRC_DIR
+            try:
+                os.rename(old_base_dir + "compat-ksrc", new_real_path)
+                os.unlink(old_ksrc_prefix)
+                os.symlink(old_real_path, new_real_path)
+            except OSError as e:
+                if e.errno != errno.EEXIST:
+                    raise
+        elif (os.path.isdir(old_ksrc_prefix)):
+            try:
+                os.rename(old_ksrc_prefix, self.ksrc_prefix)
+            except OSError as e:
+                if e.errno != errno.EEXIST:
+                    raise
+    def move_old_compat_dirs(self):
+        old_ksrc_prefix = self.ksrc_base + "compat-ksrc"
+        if os.path.islink(old_ksrc_prefix):
+            old_real_path=os.path.realpath(old_ksrc_prefix)
+            old_base_dir=os.path.dirname(old_real_path)
+            new_real_path = old_base_dir + "/" + BACKPORTS_KSRC_DIR
+            try:
+                sys.stdout.write("Trying to mv %s %s\n\n" %(old_base_dir + "/compat-ksrc", new_real_path))
+                os.rename(old_base_dir + "/compat-ksrc", new_real_path)
+                os.unlink(old_ksrc_prefix)
+                os.symlink(new_real_path, self.ksrc_prefix)
+            except OSError as e:
+                if e.errno != errno.EEXIST:
+                    raise
+        elif os.path.isdir(old_ksrc_prefix):
+            try:
+                os.rename(old_ksrc_prefix, self.ksrc_prefix)
+            except OSError as e:
+                if e.errno != errno.EEXIST:
+                    raise
+        old_debs = self.ksrc_base + "debs"
+        if os.path.islink(old_debs):
+            old_real_path=os.path.realpath(old_debs)
+            old_base_dir=os.path.dirname(old_real_path)
+            new_real_path = old_base_dir + "/" + BACKPORTS_KSRC_DIR + "/" + "debs"
+            try:
+                sys.stdout.write("Trying to mv %s %s\n\n" %(old_base_dir + "/debs", new_real_path))
+                os.rename(old_base_dir + "/debs", new_real_path)
+                os.unlink(old_debs)
+                os.symlink(old_real_path, new_real_path)
+                os.symlink(old_deb, new_real_path)
+            except OSError as e:
+                if e.errno != errno.EEXIST:
+                    raise
+        elif os.path.isdir(old_debs):
+            try:
+                os.rename(old_debs, self.ksrc_prefix + "debs")
+            except OSError as e:
+                if e.errno != errno.EEXIST:
+                    raise
+    def prep_dirs(self):
+        for i in [self.ksrc_prefix,
+                  self.ksrc_prefix + "/debs",
+                  self.ksrc_prefix + "/usr/src",
+                  self.ksrc_prefix + "/lib/modules"]:
+            try:
+                path = os.path.join(self.ksrc_prefix, i)
+                if not os.path.isdir(path):
+                    sys.stdout.write("Creating %s\n" % path)
+                    os.makedirs(path)
+            except OSError as e:
+                if e.errno != errno.EEXIST:
+                    raise
+    def is_stale_kernel_str(self, pkg):
+        for kbase in self.kernel_bases:
+            if (kbase in pkg):
+                return False
+        return True
+    def remove_stale_kernel_pkgs(self):
+        pkg_path = os.path.join(self.ksrc_prefix, 'debs')
+        for root, dirs, files in os.walk(pkg_path):
+            for f in files:
+                if not f.endswith('.deb'):
+                    continue
+                if self.is_stale_kernel_str(f):
+                    pkg_full_path = os.path.join(pkg_path, f);
+                    sys.stdout.write("Removing old kpkg: %s\n" % pkg_full_path)
+                    os.remove(pkg_full_path)
+        return 0
+    def rm_clean_dir(self, d):
+        if not os.path.isdir(d):
+            return
+        shutil.rmtree(d, ignore_errors=True)
+        try:
+            os.rmdir(d)
+        except OSError as e:
+            if e.errno != errno.ENOENT:
+                raise
+    def remove_stale_kernel_dir(self, dir_name):
+        dir_path = os.path.join(self.ksrc_prefix, dir_name)
+        for stuff in os.listdir(dir_path):
+            d = os.path.join(dir_path, stuff)
+            if not os.path.isdir(d):
+                continue
+            if self.is_stale_kernel_str(d):
+                dir_full_path = os.path.join(dir_path, d);
+                sys.stdout.write("Removing old directory: %s\n" % d)
+                self.rm_clean_dir(d)
+    def remove_stale_kernel_dirs(self):
+        for i in [self.ksrc_prefix + "/usr/src",
+                  self.ksrc_prefix + "/lib/modules"]:
+            if os.path.isdir(i):
+                self.remove_stale_kernel_dir(i)
+    def wget_url(self, url, dir_target):
+        sys.stdout.write('Trying URL:  %s\n' % url) 
+        target = os.path.join(dir_target, url.split('/')[-1])
+        u = urllib2.urlopen(url)
+        f = open(target, 'wb')
+        meta = u.info()
+        target_size = int(meta.getheaders("Content-Length")[0])
+        sys.stdout.write('Target path: %s bytes: %s\n' % (target, target_size))
+        target_size_now = os.path.getsize(target)
+        check = 8192
+        if target_size_now > target_size:
+            sys.stdout.write('Filesystem file size (%d) > URL file size (%s) bytes: %s' % (target_size_now, target_size))
+            return
+        if target_size_now:
+            buff = u.read(target_size_now)
+            if not buff:
+                return
+        while True:
+            buff = u.read(check)
+            if not buff:
+                break
+            target_size_now += len(buff)
+            f.write(buff)
+            stat = r"%10d  [%3.2f%%]" % (target_size_now, target_size_now * 100. / target_size)
+            stat = stat + chr(8)*(len(stat) + 1)
+            print stat,
+        f.close()
+        sys.stdout.write("\n")
+    def url_file_chunks_missing(self, url, dir_target):
+        target = os.path.join(dir_target, url.split('/')[-1])
+        if not os.path.isfile(target):
+            return True
+        u = urllib2.urlopen(url)
+        meta = u.info()
+        target_size = int(meta.getheaders("Content-Length")[0])
+        target_size_now = os.path.getsize(target)
+        if target_size_now < target_size:
+            return True
+        return False
+    def get_kver(self, url):
+        for kver in self.kernel_vers_count:
+            if kver.get('ver') in url:
+                return kver
+        return None
+    def increase_kver_count(self, url):
+        kver = self.get_kver(url)
+        if not kver:
+            return
+        kver['count'] = kver['count'] + 1
+        if kver['count'] >= 2:
+            sys.stdout.write("%s - up to date !\n" % kver.get('ver'))
+    def is_new_kernel(self, string):
+        if self.force:
+            return True
+        for kernel in self.all_new_kernels:
+            if string in kernel:
+                return True
+        return False
+    def get_backport_pkgs(self):
+        sys.stdout.write("Looking for updates and downloading. You can hit CTRL-C\n")
+        sys.stdout.write("and come back at any time, we'll take off right where \n")
+        sys.stdout.write("we left off\n")
+        for url in self.all_kernel_urls:
+            dir_target = os.path.join(self.ksrc_prefix, "debs")
+            target = os.path.join(dir_target, url.split('/')[-1])
+            if not self.url_file_chunks_missing(url, dir_target):
+                self.increase_kver_count(url)
+                continue
+            self.wget_url(url, dir_target)
+            self.increase_kver_count(url)
+            self.all_new_kernels.append(url)
+        sys.stdout.write("\n")
+    def fix_and_install_header_lib_modules(self, dir_path):
+        """
+        Relink lib/modules/*/build/ directories relatively to make it work
+        for regular user based workflows
+        """
+        for kernel in os.listdir(dir_path):
+            if "generic" not in kernel:
+                continue
+            kver = self.get_kver(kernel)
+            sys.stdout.write("%s - adjusting build symlink for non-root installation ...\n" % (kver.get('ver')))
+            build_target = os.path.join(dir_path, kernel + '/build')
+            usr_src_sym = "../../../usr/src/linux-headers-" + kernel
+            os.unlink(build_target)
+            os.symlink(usr_src_sym, build_target)
+        for kernel in os.listdir(dir_path):
+            src = os.path.join(dir_path, kernel)
+            dst = os.path.join(self.ksrc_prefix, 'lib/modules/' + kernel)
+            kver = self.get_kver(kernel)
+            sys.stdout.write("%s - installing lib/modules/ ...\n" % (kver.get('ver')))
+            self.rm_clean_dir(dst)
+            shutil.move(src, dst)
+    def fix_makefile_old_kernels(self, makefile):
+        if not os.path.isfile(makefile):
+            return
+        if '-generic' in makefile:
+            return
+        kver = self.get_kver(makefile)
+        sys.stdout.write("%s - fixing Makefile due to make 3.82 bug (required for 2.6.24-2.6.28) ...\n" % (kver.get('ver')))
+        for line in fileinput.input(makefile, inplace=True):
+            print("%s" % (re.sub('^/ %', '%', line))),
+        fileinput.close()
+    def fix_and_install_header_usr_src(self, dir_path):
+        """
+        Because of a bug in make < 3.82, mixed implicit and normal
+        rules do not cause harm. Since the bug is fixed in the new make
+        we have to adjust older kernel's Makefiles to fix the bug.
+
+        The hunk we end up modifying looks as follows:
+
+        --- Makefile    2009-03-11 21:21:33.000000000 +0000
+        +++ Makefile.new        2013-12-05 13:01:06.000000000 +0000
+        @@ -1519,7 +1519,7 @@
+        $(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
+          # Modules
+          -/ %/: prepare scripts FORCE
+          +%/: prepare scripts FORCE
+
+        The affected kernels on Ubuntu's mainline build system are
+        2.6.24 - 2.6.28. If we use some other source for kernels later
+        we'll need to inspect this, once we deprecate <= 2.6.28 we can
+        remove this fix.
+        """
+        affected_kbuilds = ['2.6.24-0',
+                            '2.6.25-0',
+                            '2.6.26-0',
+                            '2.6.27-0',
+                            '2.6.28-0',
+                            ]
+        for kernel in os.listdir(dir_path):
+            src = os.path.join(dir_path, kernel)
+            dst = os.path.join(self.ksrc_prefix, 'usr/src/' + kernel)
+            kver = self.get_kver(kernel)
+            if any(affected in kernel for affected in affected_kbuilds):
+                makefile_path = os.path.join(src, "Makefile")
+                self.fix_makefile_old_kernels(makefile_path)
+            generic = ''
+            if '-generic' in dst:
+                generic = 'generic solution'
+            sys.stdout.write("%s - installing usr/src/ %s ...\n" % (kver.get('ver'), generic))
+            self.rm_clean_dir(dst)
+            shutil.move(src, dst)
+    def sanitize_and_install_kernel_dirs(self, dir_path):
+        d_lib_modules = os.path.join(dir_path, "lib/modules")
+        d_usr_src     = os.path.join(dir_path, "usr/src")
+        if os.path.isdir(d_lib_modules):
+            self.fix_and_install_header_lib_modules(d_lib_modules)
+        if os.path.isdir(d_usr_src):
+            self.fix_and_install_header_usr_src(d_usr_src)
+    def extract_backport_pkgs(self):
+        tmp_prefix = BACKPORTS_KSRC_DIR + '_'
+        tmpdir_path = tempfile.mkdtemp(prefix=tmp_prefix)
+        for url in self.all_kernel_urls:
+            kver = self.get_kver(url)
+            dir_target = os.path.join(self.ksrc_prefix, "debs")
+            target = os.path.join(dir_target, url.split('/')[-1])
+            if not self.is_new_kernel(url):
+                sys.stdout.write("%s - already installed %s ...\n" % (kver.get('ver'), target))
+                continue
+            sys.stdout.write("%s - extracting new %s ...\n" % (kver.get('ver'), target))
+            data, dpath = tempfile.mkstemp(prefix=tmp_prefix)
+            ar.print_data(target, data)
+            tar = tarfile.open(name=dpath, mode='r')
+            tar.extractall(path=tmpdir_path, members=bk_tar_members(tar))
+            os.unlink(dpath)
+        self.sanitize_and_install_kernel_dirs(tmpdir_path)
+        self.rm_clean_dir(tmpdir_path)
+    def rebuild_needed(self, kdir):
+        if '-generic' not in kdir:
+            return False
+        m = re.match(r"^(?P<VERSION>\d+)\.+" \
+                     "(?P<PATCHLEVEL>\d+)[.]*", \
+                     kdir)
+        if not m:
+            return False
+        rel_specs = m.groupdict()
+        if int(rel_specs['VERSION']) < 3:
+            return False
+        if int(rel_specs['PATCHLEVEL']) == 0:
+            return False
+        return True
+    def make_kdir(self, make_args, kbuild_path):
+        tmp_prefix = BACKPORTS_KSRC_DIR + '_rebuild_h_'
+        null_file = open('/dev/null', 'r')
+        p = subprocess.Popen(['make'] + make_args ,
+                             stdin=null_file,
+                             stdout=sys.stdout,
+                             stderr=sys.stdout,
+                             cwd=kbuild_path)
+        p.wait()
+        null_file.close()
+    def rebuild_binary_deps(self, kpath, count):
+        kbuild_path = os.path.join(kpath, "build")
+        for target in ['basic', 'mod', 'genksyms']:
+            modpath = 'scripts/' + target
+            if count == 0:
+                make_args = ['C=' + kbuild_path, 'M=' + modpath, '-j', '4', 'clean' ]
+                self.make_kdir(make_args, kbuild_path)
+            make_args = ['C=' + kbuild_path, 'M=' + modpath, '-j', '4' ]
+            self.make_kdir(make_args, kbuild_path)
+    def rebuild_kdir_binary_deps(self, kpath):
+        """
+        We found out empirically at least 4 rebuilds are required...
+        """
+        kver = self.get_kver(kpath)
+        sys.stdout.write("%s - rebuilding binary dependencies ...\n" % kver.get('ver'))
+        for count in range(0, 4):
+            self.rebuild_binary_deps(kpath, count)
+    def rebuild_header_binary_deps(self):
+        dir_target = os.path.join(self.ksrc_prefix, "lib/modules")
+        for kdir in os.listdir(dir_target):
+            if not self.rebuild_needed(kdir):
+                continue
+            if not self.rebuild_only and not self.is_new_kernel(kdir):
+                continue
+            kpath = os.path.join(dir_target, kdir)
+            self.rebuild_kdir_binary_deps(kpath)
+        sys.exit(0)
+
+def bk_tar_members(members):
+    for tarinfo in members:
+        if not "usr/share" in tarinfo.name:
+            yield tarinfo
+
+def usage():
+    print '%(cmd)s' % { "cmd": sys.argv[0] }
+    print 'Usage: %(cmd)s [ -h | --help | -f | --force | -r | --rebuild ]' % { "cmd": sys.argv[0] }
+    print ''
+    print '-h | --help    - Help menu'
+    print '-f | --force   - Force run without sanity or careful user checks'
+    print '-r | --rebuild - Only rebuild the binary kernel header dependencies, don\'t download new stuff'
+    sys.exit(2)
+
+def _main():
+    bk_updater = backport_kernel_updater()
+    bk_updater.warn_root()
+    bk_updater.warn_size_reqs()
+    bk_updater.move_old_compat_dirs()
+    bk_updater.prep_dirs()
+
+    if bk_updater.rebuild_only:
+        bk_updater.rebuild_header_binary_deps()
+        return 0
+
+    bk_updater.remove_stale_kernel_pkgs()
+    bk_updater.remove_stale_kernel_dirs()
+    bk_updater.get_backport_pkgs()
+    bk_updater.extract_backport_pkgs()
+    bk_updater.rebuild_header_binary_deps()
+
+    return 0
+
+if __name__ == '__main__':
+    ret = _main()
+if ret:
+    sys.exit(ret)
diff --git a/devel/get-compat-kernels b/devel/get-compat-kernels
deleted file mode 100755
index c2a5066..0000000
--- a/devel/get-compat-kernels
+++ /dev/null
@@ -1,268 +0,0 @@
-#!/bin/bash
-#
-# Copyright (C) 2012, Luis R. Rodriguez <mcgrof@do-not-panic.com>
-#
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# You can use this script to install all mainline kernels used
-# to test compile the Linux kernel compatibility module. You can
-# then use ckmake to cross compile against all supported kernels.
-
-# Pretty colors
-GREEN="\033[01;32m"
-YELLOW="\033[01;33m"
-NORMAL="\033[00m"
-BLUE="\033[34m"
-RED="\033[31m"
-PURPLE="\033[35m"
-CYAN="\033[36m"
-UNDERLINE="\033[02m"
-
-KERNELS=""
-KPATH="http://kernel.ubuntu.com/~kernel-ppa/mainline/"
-
-FORCE="0"
-KSRC_PREFIX=
-# Check whether we're running as root or not
-# If we're root stuff things into /usr/src and /lib/modules
-# else, use $HOME/compat-ksrc for enabling user-mode builds.
-if [[ "$EUID" != "0" ]]; then
-	KSRC_PREFIX="$HOME/compat-ksrc"
-else
-	KSRC_PREFIX="${PWD}/compat-ksrc"
-fi
-
-
-# Create target directories if they doesn't exist
-mkdir -p $KSRC_PREFIX/{usr/src,lib/modules}
-
-# List of currently supported kernels that will be downloaded
-KERNELS="$KERNELS ${KPATH}/v2.6.25/linux-headers-2.6.25-020625_2.6.25-020625_all.deb"
-KERNELS="$KERNELS ${KPATH}/v2.6.26/linux-headers-2.6.26-020626_2.6.26-020626_all.deb"
-KERNELS="$KERNELS ${KPATH}/v2.6.27/linux-headers-2.6.27-020627_2.6.27-020627_all.deb"
-KERNELS="$KERNELS ${KPATH}/v2.6.28.10/linux-headers-2.6.28-02062810_2.6.28-02062810_all.deb"
-KERNELS="$KERNELS ${KPATH}/v2.6.29.6/linux-headers-2.6.29-02062906_2.6.29-02062906_all.deb"
-KERNELS="$KERNELS ${KPATH}/v2.6.30.10/linux-headers-2.6.30-02063010_2.6.30-02063010_all.deb"
-KERNELS="$KERNELS ${KPATH}/v2.6.31.13-karmic/linux-headers-2.6.31-02063113_2.6.31-02063113_all.deb"
-KERNELS="$KERNELS ${KPATH}/v2.6.32.61-lucid/linux-headers-2.6.32-02063261_2.6.32-02063261.201306101105_all.deb"
-KERNELS="$KERNELS ${KPATH}/v2.6.33.20-maverick/linux-headers-2.6.33-02063320_2.6.33-02063320.201111071735_all.deb"
-KERNELS="$KERNELS ${KPATH}/v2.6.34.14-maverick/linux-headers-2.6.34-02063414_2.6.34-02063414.201301162135_all.deb"
-KERNELS="$KERNELS ${KPATH}/v2.6.35.13-original-maverick/linux-headers-2.6.35-02063513_2.6.35-02063513.201107261012_all.deb"
-KERNELS="$KERNELS ${KPATH}/v2.6.36.4-natty/linux-headers-2.6.36-02063604_2.6.36-02063604.201102180911_all.deb"
-KERNELS="$KERNELS ${KPATH}/v2.6.37.6-natty/linux-headers-2.6.37-02063706_2.6.37-02063706.201103281005_all.deb"
-KERNELS="$KERNELS ${KPATH}/v2.6.38.8-natty/linux-headers-2.6.38-02063808_2.6.38-02063808.201106040910_all.deb"
-KERNELS="$KERNELS ${KPATH}/v2.6.39.4-oneiric/linux-headers-2.6.39-02063904_2.6.39-02063904.201108040905_all.deb"
-KERNELS="$KERNELS ${KPATH}/v3.0.101-oneiric/linux-headers-3.0.101-0300101_3.0.101-0300101.201310220446_all.deb"
-KERNELS="$KERNELS ${KPATH}/v3.1.10-precise/linux-headers-3.1.10-030110_3.1.10-030110.201201181135_all.deb"
-KERNELS="$KERNELS ${KPATH}/v3.2.52-precise/linux-headers-3.2.52-030252_3.2.52-030252.201310262335_all.deb"
-KERNELS="$KERNELS ${KPATH}/v3.3.8-quantal/linux-headers-3.3.8-030308_3.3.8-030308.201206041356_all.deb"
-KERNELS="$KERNELS ${KPATH}/v3.4.70-quantal/linux-headers-3.4.70-030470_3.4.70-030470.201311201436_all.deb"
-KERNELS="$KERNELS ${KPATH}/v3.5.7.12-quantal/linux-headers-3.5.7-03050712_3.5.7-03050712.201305111435_all.deb"
-KERNELS="$KERNELS ${KPATH}/v3.6.11-raring/linux-headers-3.6.11-030611_3.6.11-030611.201212171335_all.deb"
-KERNELS="$KERNELS ${KPATH}/v3.7.10-raring/linux-headers-3.7.10-030710_3.7.10-030710.201302271235_all.deb"
-KERNELS="$KERNELS ${KPATH}/v3.8.13-raring/linux-headers-3.8.13-030813_3.8.13-030813.201305111843_all.deb"
-KERNELS="$KERNELS ${KPATH}/v3.9.11-saucy/linux-headers-3.9.11-030911_3.9.11-030911.201307202035_all.deb"
-KERNELS="$KERNELS ${KPATH}/v3.10.20-saucy/linux-headers-3.10.20-031020_3.10.20-031020.201311201536_all.deb"
-KERNELS="$KERNELS ${KPATH}/v3.11.9-saucy/linux-headers-3.11.9-031109_3.11.9-031109.201311201635_all.deb"
-KERNELS="$KERNELS ${KPATH}/v3.12.1-trusty/linux-headers-3.12.1-031201_3.12.1-031201.201311201654_all.deb"
-KERNELS="$KERNELS ${KPATH}/v3.13-rc1-trusty/linux-headers-3.13.0-031300rc1_3.13.0-031300rc1.201311221535_all.deb"
-
-# Number of kernels
-NUM_KERNELS=$(echo $KERNELS | wc -w)
-
-# ~ 101 MiB for installed space on $KSRC_PREFIX/usr/src/ and $KSRC_PREFIX/lib/modules/
-SPACE_PER_KERNEL="101"
-
-# ~13 MiB of both deb files
-SPACE_PER_KERNEL_DEB="13"
-
-function get_ubuntu_kernels() {
-
-	ARCH=$(uname -m)
-	TARGET=""
-
-	case $ARCH in
-	"x86_64")
-		TARGET="amd64"
-		;;
-	"i686")
-		TARGET="i386"
-		;;
-	*)
-		echo -e "Unsupported architecture"
-		exit
-		;;
-	esac
-
-	mkdir -p debs
-	cd debs
-
-	for i in $KERNELS; do
-		FILE=$(basename $i)
-		PKG=$(echo $FILE | awk -F"_" '{print $1}')
-
-		# Do not download if installed or deb exists
-		if [[ ! -d $KSRC_PREFIX/usr/src/$PKG && ! -f $FILE ]]; then
-			# Download the _all.deb
-			wget -c $i
-
-			# Download the generic-ARCH headers
-			GENERIC_DEB=`echo $i | sed -e "s:\(.*\)_\(.*\)_all.deb:\1-generic_\2_$TARGET.deb:"`
-			wget -c $GENERIC_DEB
-		fi
-	done
-
-	# List of downloaded debs
-	DEB_LIST=`ls linux-*.deb 2>/dev/null`
-
-	if [[ -z $DEB_LIST ]]; then
-		echo "All kernel sources are found in $KSRC_PREFIX/usr/src."
-		exit
-	fi
-
-	# Create a temporary directory first
-	TEMP_DIR=`mktemp -d`
-
-	for deb in $DEB_LIST; do
-		DIR_NAME=$(echo $deb | awk -F"_" '{print $1}')
-		if [[ ! -d $KSRC_PREFIX/usr/src/$DIR_NAME ]]; then
-			echo "Extracting $deb..."
-			ar p $deb data.tar.gz | tar xz --exclude=usr/share -C $TEMP_DIR
-		fi
-	done
-
-	# Move the extracted folders into the system
-	if [[ -d $TEMP_DIR/lib/modules ]]; then
-
-		# Relink lib/modules/*/build/ directories relatively to make it work
-		# for regular user based workflows
-		if [[ -n $KSRC_PREFIX ]]; then
-			echo "Adjusting build/ symlinks for non-root installation..."
-
-			for kernel in $(ls -d $TEMP_DIR/lib/modules/*generic); do
-				unlink $kernel/build
-				ln -s ../../../usr/src/linux-headers-`basename $kernel` $kernel/build
-			done
-		fi
-
-		mv $TEMP_DIR/lib/modules/* $KSRC_PREFIX/lib/modules
-	fi
-	if [[ -d $TEMP_DIR/usr/src ]]; then
-		# Because of a bug in make < 3.82, mixed implicit and normal
-		# rules do not cause harm. Since the bug is fixed in the new make
-		# we have to adjust older kernel's Makefiles to fix the bug.
-		sed -i 's#^/ %/:#%/:#' $TEMP_DIR/usr/src/linux-headers-2.6.2[45678]-0*/Makefile &>/dev/null
-
-		mv $TEMP_DIR/usr/src/* $KSRC_PREFIX/usr/src
-	fi
-
-	# Remove the temporary directory
-	rm -rf $TEMP_DIR
-}
-
-function rebuild_header_binary_deps() {
-	if [[ ! -d ${KSRC_PREFIX}/lib/modules/ ]]; then
-		echo "You do not seem to have any vanilla kernels available to fix"
-		exit 1
-	fi
-
-	COUNT=$(ls -d ${KSRC_PREFIX}/lib/modules/*generic | wc -l)
-	if [[ $COUNT -le 0 ]]; then
-		echo "You do not seem to have any vanilla kernels available to fix"
-		exit 1
-	fi
-
-	for kernel in $(ls -d ${KSRC_PREFIX}/lib/modules/*generic | grep -E "/3\.[2-9]\.|/3\.[1-9][0-9]\.|/[4-9]\."); do
-		echo $kernel
-
-		count=0
-		while [[ $count -ne 4 ]]; do
-			for i in basic mod genksyms; do
-				if [[ $count -eq 0 ]]; then
-					make -C ${kernel}/build/ M=scripts/${i}/ clean > /dev/null 2>&1
-				fi
-				make -C ${kernel}/build/ M=scripts/${i}/ > /dev/null 2>&1
-			done
-			let count=$count+1
-		done
-	done
-}
-
-function usage() {
-	echo -e "Usage: $0 [ -r ] [ -f ] "
-	echo -e "-r Rebuilds binaries required in kernel headers. Use"
-	echo -e "   this option if you've already ran this script and"
-	echo -e "   just need to fix the libc versions against which"
-	echo -e "   the binaries in the headers files are linked against. "
-	echo -e "   This was added since kernels >= 3.4 require"
-	echo -e "   a glibc >= 2.14 for memcpy(), and not all Linux"
-	echo -e "   distributions have such versions of glibc."
-	echo -e ""
-	echo -e "-f Force running, do not ask"
-}
-
-if [[ $# -gt 3 ]]; then
-	usage
-	exit 1
-fi
-
-if [[ $1 == "-r" ]]; then
-	rebuild_header_binary_deps
-	exit
-fi
-
-if [[ $1 == "-f" ]]; then
-	FORCE="1"
-	shift
-fi
-
-# Check for the availability of 'ar' before continuing
-which ar 2>&1 > /dev/null
-if [[ $? -ne 0 ]]; then
-	echo -e "${GREEN}ar${NORMAL} is not avilable, typically this is available through a package called binutils"
-	echo -e "Install binutils and run this script again..."
-	exit 1
-fi
-
-echo -e ""
-
-if [[ ! -n $KSRC_PREFIX ]]; then
-	echo -e "** Running as a privileged user!"
-	echo -e "** You are trying to force using ${BLUE}${KSRC_PREFIX}/lib/modules${NORMAL} and ${BLUE}${KSRC_PREFIX}/usr/src${NORMAL} ..."
-	echo -e "** This is a terrible idea. Consider running as a regular user."
-	echo -e ""
-	read -p "Do you still want to continue (y/N)? "
-	if [[ "${REPLY}" != "y" ]]; then
-		echo -e "Bailing out !"
-		exit 1
-	fi
-fi
-
-echo -e "This will download ${YELLOW}${NUM_KERNELS}${NORMAL} kernel headers to allow you to"
-echo -e "cross compile any module over these kernels with ${GREEN}ckmake${NORMAL}."
-echo -e "The download payload is about ${YELLOW}~ $((${SPACE_PER_KERNEL_DEB} * ${NUM_KERNELS})) ${CYAN}MiB${NORMAL}, once uncompressed"
-echo -e "it will stash kernel header files under ${BLUE}$KSRC_PREFIX/usr/src/${NORMAL}"
-echo -e "and ${BLUE}$KSRC_PREFIX/lib/modules/${NORMAL} and consume about ~ ${YELLOW}$((${NUM_KERNELS} * ${SPACE_PER_KERNEL})) ${RED}MiB${NORMAL} of space."
-echo -e ""
-echo -e "The kernel headers used are from ${PURPLE}${UNDERLINE}Vanilla${NORMAL} kernels"
-echo -e "from the Ubuntu mainline / vanilla kernel PPA and are extracted"
-echo -e "using ${GREEN}ar${NORMAL} and ${GREEN}tar${NORMAL}:"
-echo -e ""
-echo -e "${BLUE}http://kernel.ubuntu.com/~kernel-ppa/mainline/${NORMAL}"
-echo -e ""
-
-if [[ "$FORCE" != "1" ]]; then
-	read -p "Do you still want to continue (y/N)? "
-	if [[ "${REPLY}" != "y" ]]; then
-		echo -e "Bailing out !"
-		exit 1
-	fi
-fi
-
-get_ubuntu_kernels
-echo -e "Vanilla kernels headers ${BLUE}installed${NORMAL}, "
-echo -e "now going to ${GREEN}rebuild${NORMAL} some binary dependencies..."
-sleep 1
-rebuild_header_binary_deps
diff --git a/lib/bpar.py b/lib/bpar.py
new file mode 100644
index 0000000..dd37a6c
--- /dev/null
+++ b/lib/bpar.py
@@ -0,0 +1,17 @@
+import subprocess, os
+
+class ArError(Exception):
+    pass
+class ExecutionError(ArError):
+    def __init__(self, errcode):
+        self.error_code = errcode
+
+def print_data(input_file, out_file, tree=None):
+    cmd = ['ar', 'p', input_file, 'data.tar.gz']
+    process = subprocess.Popen(cmd,
+                               stdout=out_file, stderr=subprocess.STDOUT,
+                               close_fds=True, universal_newlines=True, cwd=tree)
+    stdout = process.communicate()[0]
+    process.wait()
+    if process.returncode != 0:
+        raise ExecutionError(process.returncode)
-- 
1.8.4.3

