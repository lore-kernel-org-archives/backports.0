Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:35004 "EHLO sipsolutions.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753645AbdIHMga (ORCPT <rfc822;backports@vger.kernel.org>);
        Fri, 8 Sep 2017 08:36:30 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] backport-update-manager: automatically get list of ubuntu kernels
Date: Fri,  8 Sep 2017 14:36:27 +0200
Message-Id: <20170908123627.10024-1-johannes@sipsolutions.net> (sfid-20170908_143702_448699_C1AD4288)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 devel/backports-update-manager | 107 ++++++++++++++++++++++++-----------------
 1 file changed, 62 insertions(+), 45 deletions(-)

diff --git a/devel/backports-update-manager b/devel/backports-update-manager
index 4678687b4cb1..8404c21448d1 100755
--- a/devel/backports-update-manager
+++ b/devel/backports-update-manager
@@ -18,46 +18,6 @@ SPACE_PER_KERNEL=101
 # ~13 MiB of both deb files
 SPACE_PER_KERNEL_DEB=13
 
-# Having to update this manually is stupid, lets either get Ubuntu
-# folks to use a json files or we start seeing how we can start
-# building our own shit.
-# For example:
-# https://www.kernel.org/releases.json
-KERNEL_URLS = [
-    KPATH + "v3.0.101-oneiric/linux-headers-3.0.101-0300101_3.0.101-0300101.201310220446_all.deb",
-    KPATH + "v3.1.10-precise/linux-headers-3.1.10-030110_3.1.10-030110.201201181135_all.deb",
-    KPATH + "v3.2.81-precise/linux-headers-3.2.81-030281_3.2.81-030281.201606152334_all.deb",
-    KPATH + "v3.3.8-quantal/linux-headers-3.3.8-030308_3.3.8-030308.201206041356_all.deb",
-    KPATH + "v3.4.112-precise/linux-headers-3.4.112-0304112_3.4.112-0304112.201604271231_all.deb",
-    KPATH + "v3.5.7.12-quantal/linux-headers-3.5.7-03050712_3.5.7-03050712.201305111435_all.deb",
-    KPATH + "v3.6.11-raring/linux-headers-3.6.11-030611_3.6.11-030611.201212171335_all.deb",
-    KPATH + "v3.7.10-raring/linux-headers-3.7.10-030710_3.7.10-030710.201302271235_all.deb",
-    KPATH + "v3.8.13-raring/linux-headers-3.8.13-030813_3.8.13-030813.201305111843_all.deb",
-    KPATH + "v3.9.11-saucy/linux-headers-3.9.11-030911_3.9.11-030911.201307202035_all.deb",
-    KPATH + "v3.10.102-precise/linux-headers-3.10.102-0310102_3.10.102-0310102.201606131145_all.deb",
-    KPATH + "v3.11.10-saucy/linux-headers-3.11.10-031110_3.11.10-031110.201311291453_all.deb",
-    KPATH + "v3.12.61-trusty/linux-headers-3.12.61-031261_3.12.61-031261.201606201232_all.deb",
-    KPATH + "v3.13.11-trusty/linux-headers-3.13.11-031311_3.13.11-031311.201404222035_all.deb",
-    KPATH + "v3.14.73-trusty/linux-headers-3.14.73-031473_3.14.73-031473.201606241434_all.deb",
-    KPATH + "v3.15.10-utopic/linux-headers-3.15.10-031510_3.15.10-031510.201408132333_all.deb",
-    KPATH + "v3.16.36-trusty/linux-headers-3.16.36-031636_3.16.36-031636.201606152333_all.deb",
-    KPATH + "v3.17.8-vivid/linux-headers-3.17.8-031708_3.17.8-031708.201501081837_all.deb",
-    KPATH + "v3.18.36-vivid/linux-headers-3.18.36-031836_3.18.36-031836.201606230133_all.deb",
-    KPATH + "v3.19.8-vivid/linux-headers-3.19.8-031908_3.19.8-031908.201505110938_all.deb",
-    KPATH + "v4.0.9-wily/linux-headers-4.0.9-040009_4.0.9-040009.201507212131_all.deb",
-    KPATH + "v4.1.27-wily/linux-headers-4.1.27-040127_4.1.27-040127.201606230134_all.deb",
-    KPATH + "v4.2.8-wily/linux-headers-4.2.8-040208_4.2.8-040208.201512150620_all.deb",
-    KPATH + "v4.3.6-wily/linux-headers-4.3.6-040306_4.3.6-040306.201602191831_all.deb",
-    KPATH + "v4.4.14-xenial/linux-headers-4.4.14-040414_4.4.14-040414.201606241434_all.deb",
-    KPATH + "v4.5.7-yakkety/linux-headers-4.5.7-040507_4.5.7-040507.201606100436_all.deb",
-    KPATH + "v4.6.3-yakkety/linux-headers-4.6.3-040603_4.6.3-040603.201606241434_all.deb",
-    KPATH + "v4.7.10/linux-headers-4.7.10-040710_4.7.10-040710.201610220847_all.deb",
-    KPATH + "v4.8.17/linux-headers-4.8.17-040817_4.8.17-040817.201701090438_all.deb",
-    KPATH + "v4.9.8/linux-headers-4.9.8-040908_4.9.8-040908.201702040431_all.deb",
-]
-
-NUM_KERNELS=len(KERNEL_URLS)
-
 GIT_TREES = [
     "git://git.kernel.org/pub/scm/linux/kernel/git/backports/backports.git",
     "git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git",
@@ -79,13 +39,71 @@ class backport_kernel_updater:
             return "i386"
         sys.stdout.write("Unsupported machine type: %s\n" % machine)
         sys.exit(1)
+
+    @classmethod
+    def _get_ubuntu_ppa_mainline_kernels(cls):
+        base = 'http://kernel.ubuntu.com/~kernel-ppa/mainline/'
+        html = urlopen(base).read()
+        builds = re.findall(b'href="([-v.0-9a-z]*)/"', html)
+        builds = [b.decode('ascii') for b in builds]
+        # remove some special kernels
+        builds = [b for b in builds if re.match('v[3-9]', b)]
+        builds = [b for b in builds if not '-rc' in b and not '-unstable' in b and not '-ckt' in b]
+        last = {}
+        for b in builds:
+            split = re.split(r'[.-]', b, 2)
+            ver = '.'.join(split[:2])
+            sub = b[len(ver):]
+            if not sub.startswith('.'):
+                sub = '.0' + sub
+            sub = sub[1:]
+            sub = re.split(r'[.-]', sub)
+            sver = []
+            for n in sub:
+                try:
+                    sver.append(int(n))
+                except ValueError:
+                    sver.append(-1)
+            item = (sver, b)
+            try:
+                last[ver].append(item)
+            except KeyError:
+                last[ver] = [item]
+        for ver in last:
+            n = 0
+            for sver in last[ver]:
+                if len(sver[0]) > n:
+                    n = len(sver[0])
+            for sver in last[ver]:
+                while len(sver[0]) < n:
+                    sver[0].append(0)
+
+        result = []
+        for subvers in last.values():
+            subvers.sort(reverse=True)
+            for version in subvers:
+                version = version[1]
+
+                html = urlopen(base + version + '/').read()
+                pkgs = re.findall(b'href="linux-headers-[^"]*_all\.deb"', html)
+                if not pkgs:
+                    continue
+                pkgs = [p[6:-1] for p in pkgs]
+                pkgs.sort()
+                pkg = pkgs[-1].decode('ascii')
+                result.append(base + version + '/' + pkg)
+                break
+
+        return result
+
     def __init__(self,
                  force=False,
                  git_trees_only=False,
                  reference=None):
         self.ksrc_base = ""
         self.ksrc_prefix = ""
-        self.kernel_urls = KERNEL_URLS
+        self.kernel_urls = self._get_ubuntu_ppa_mainline_kernels()
+        self.num_kernels = len(self.kernel_urls)
         self.git_trees = GIT_TREES
         self.git_trees_missing = list()
         self.git_trees_present = list()
@@ -172,7 +190,6 @@ class backport_kernel_updater:
             self.all_git_trees_present = len(self.git_trees_present) == len(self.git_trees)
 
         urls = self.kernel_urls + self.kernel_urls_generic
-        urls.sort()
         self.all_kernel_urls = urls
         self.all_new_kernels = list()
 
@@ -203,13 +220,13 @@ class backport_kernel_updater:
         sys.stdout.write("\n")
         sys.stdout.write("Stable kernel header release updater\n")
         sys.stdout.write("------------------------------------------------------------------\n")
-        sys.stdout.write("This will download %d kernel headers to allow you to\n" % NUM_KERNELS)
+        sys.stdout.write("This will download %d kernel headers to allow you to\n" % self.num_kernels)
         sys.stdout.write("cross compile any module over these kernels with ckmake.\n")
         sys.stdout.write("The download payload is about ~ %d MiB, once uncompressed\n" %
-                         (SPACE_PER_KERNEL_DEB * NUM_KERNELS))
+                         (SPACE_PER_KERNEL_DEB * self.num_kernels))
         sys.stdout.write("it will stash kernel header files under the directories:\n\n\t%s\n\t%s\n\n" %
                          (self.ksrc_prefix + "/usr/src/", self.ksrc_prefix + "/lib/modules/"))
-        sys.stdout.write("It will consume about ~ %d GiB of space.\n\n" % (NUM_KERNELS * SPACE_PER_KERNEL / 1024))
+        sys.stdout.write("It will consume about ~ %d GiB of space.\n\n" % (self.num_kernels * SPACE_PER_KERNEL / 1024))
         sys.stdout.write("The kernel headers used are from Vanilla kernels")
         sys.stdout.write("from the \nUbuntu mainline / vanilla kernel PPA and are extracted\n")
         sys.stdout.write("using the GNU ar and Python tar module:\n\n%s\n\n" % KPATH)
-- 
2.14.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
