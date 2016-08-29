Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:45680 "EHLO sipsolutions.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754013AbcH2Rvy (ORCPT <rfc822;backports@vger.kernel.org>);
        Mon, 29 Aug 2016 13:51:54 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Jouni Malinen <j@w1.fi>, Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] gentree: create Kconfig.local, use it to restrict compat
Date: Mon, 29 Aug 2016 19:51:41 +0200
Message-Id: <1472493101-6058-1-git-send-email-johannes@sipsolutions.net> (sfid-20160829_195156_781608_735F5B56)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

Not all the compat code is always necessary, for example code
enabled by BPAUTO_CRYPTO_SKCIPHER and by BPAUTO_RHASHTABLE is
gated on other symbols being selected. Checking against the
Kconfig symbols as it's done right now is wrong though, since
the base kernel's Kconfig symbols would be used, selecting,
for example, BPAUTO_CRYPTO_SKCIPHER when the base kernel has
CONFIG_BT set, but doing that when BT isn't even part of the
backport, or when it's disabled in the backport.

To fix this, keep track of all the local Kconfig symbols,
similar to the .local-symbols files but as a Kconfig.local,
and add for each local symbol a symbol that just mirrors the
state of the symbol as selected by the user. This effectively
allows checking the source of the symbol.

Make the relevant backported items use the new BACKPORTED_*
symbols for dependencies, instead of the original ones, thus
avoiding the above-mentioned "leakage" of kernel symbols.
When the symbol isn't even present in the backport, it'll be
simply regarded as false by the kconfig system.

Reported-by: Jouni Malinen <j@w1.fi>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/Kconfig.integrate |  1 +
 backport/Kconfig.package   |  1 +
 backport/compat/Kconfig    | 16 ++++++++--------
 gentree.py                 | 12 +++++++++++-
 4 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/backport/Kconfig.integrate b/backport/Kconfig.integrate
index f64a3f6eb235..45ab3ecd4d57 100644
--- a/backport/Kconfig.integrate
+++ b/backport/Kconfig.integrate
@@ -32,5 +32,6 @@ if BACKPORT_LINUX
 
 source "$BACKPORT_DIR/Kconfig.versions"
 source "$BACKPORT_DIR/Kconfig.sources"
+source "$BACKPORT_DIR/Kconfig.local"
 
 endif # BACKPORT_LINUX
diff --git a/backport/Kconfig.package b/backport/Kconfig.package
index 96845740a42a..250cdf3e4278 100644
--- a/backport/Kconfig.package
+++ b/backport/Kconfig.package
@@ -22,3 +22,4 @@ source "$BACKPORT_DIR/Kconfig.sources"
 # these will be generated
 source "$BACKPORT_DIR/Kconfig.kernel"
 source "$BACKPORT_DIR/Kconfig.versions"
+source "$BACKPORT_DIR/Kconfig.local"
diff --git a/backport/compat/Kconfig b/backport/compat/Kconfig
index 710f626a5dbc..ffa8cea84295 100644
--- a/backport/compat/Kconfig
+++ b/backport/compat/Kconfig
@@ -116,10 +116,10 @@ config BPAUTO_BUILD_CRYPTO_CCM
 config BPAUTO_CRYPTO_SKCIPHER
 	tristate
 	depends on KERNEL_4_3
-	default y if MAC802154
-	default y if LIB80211_CRYPT_WEP
-	default y if LIB80211_CRYPT_TKIP
-	default y if BT
+	default y if BACKPORTED_MAC802154
+	default y if BACKPORTED_LIB80211_CRYPT_WEP
+	default y if BACKPORTED_LIB80211_CRYPT_TKIP
+	default y if BACKPORTED_BT
 	#c-file crypto/skcipher.c
 	#module-name skcipher
 
@@ -139,7 +139,7 @@ config BPAUTO_RHASHTABLE
 	# current API of rhashtable was introduced in version 4.1
 	depends on KERNEL_4_1
 	# not very nice - but better than always having it
-	default y if MAC80211
+	default y if BACKPORTED_MAC80211
 	#h-file linux/rhashtable.h
 	#c-file lib/rhashtable.c
 
@@ -155,9 +155,9 @@ config BPAUTO_HDMI
 	bool
 	select BPAUTO_BUILD_HDMI if KERNEL_4_0
 	# these drivers are using the new features of the hdmi driver.
-	default y if VIDEO_ADV7511
-	default y if VIDEO_ADV7604
-	default y if VIDEO_ADV7842
+	default y if BACKPORTED_VIDEO_ADV7511
+	default y if BACKPORTED_VIDEO_ADV7604
+	default y if BACKPORTED_VIDEO_ADV7842
 
 config BPAUTO_FRAME_VECTOR
 	bool
diff --git a/gentree.py b/gentree.py
index 419b13b5d048..222f4c585e20 100755
--- a/gentree.py
+++ b/gentree.py
@@ -924,7 +924,7 @@ def process(kerneldir, copy_list_file, git_revision=None,
 
     # some post-processing is required
     configtree = kconfig.ConfigTree(os.path.join(bpid.target_dir, 'Kconfig'), bpid)
-    ignore=['Kconfig.kernel', 'Kconfig.versions']
+    ignore=['Kconfig.kernel', 'Kconfig.versions', 'Kconfig.local']
 
     configtree.verify_sources(ignore=ignore)
     git_debug_snapshot(args, "verify sources on top level backports Kconfig")
@@ -942,6 +942,7 @@ def process(kerneldir, copy_list_file, git_revision=None,
     ignore = [os.path.join(bpid.target_dir, x) for x in [
                 'Kconfig.package.hacks',
                 'Kconfig.versions',
+                'Kconfig.local',
                 'Kconfig',
                 ]
             ]
@@ -960,6 +961,15 @@ def process(kerneldir, copy_list_file, git_revision=None,
             f.write('%s=\n' % sym)
         f.close()
         git_debug_snapshot(args, "add symbols files")
+    # also write Kconfig.local, representing all local symbols
+    # with a BACKPORTED_ prefix
+    f = open(os.path.join(bpid.target_dir, 'Kconfig.local'), 'w')
+    for sym in symbols:
+        f.write('config BACKPORTED_%s\n' % sym)
+        f.write('\ttristate\n')
+        f.write('\tdefault %s\n' % sym)
+    f.close()
+    git_debug_snapshot(args, "add Kconfig.local")
 
     # add defconfigs that we want
     defconfigs_dir = os.path.join(source_dir, 'backport', 'defconfigs')
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
