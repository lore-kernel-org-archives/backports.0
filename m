Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.63.242]:49242 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753135AbdJMJn3 (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 13 Oct 2017 05:43:29 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 11/11] backports: no longer support kernels < 3.10
Date: Fri, 13 Oct 2017 11:42:26 +0200
Message-Id: <20171013094226.10021-11-johannes@sipsolutions.net> (sfid-20171013_114331_363749_ACF170EB)
In-Reply-To: <20171013094226.10021-1-johannes@sipsolutions.net>
References: <20171013094226.10021-1-johannes@sipsolutions.net>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

Since CRYPTO_CMAC was introduced in 3.10, and mac80211
depends on it, we basically get nothing out of it anyway.

I'm not removing the support code (yet) since it actually
compiles, and perhaps somebody has a need for (certain)
kernel versions lower than 3.10.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 README                         | 2 +-
 devel/backports-update-manager | 8 ++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/README b/README
index 8d544eb4870e..2b494c8c7238 100644
--- a/README
+++ b/README
@@ -8,7 +8,7 @@ down to older kernels. It currently backports the following subsystems:
   * WWAN
 
 This package provides the latest Linux kernel subsystem enhancements
-for kernels 3.0 and above.
+for kernels 3.10 and above.
 
 # Documentation
 
diff --git a/devel/backports-update-manager b/devel/backports-update-manager
index 8069fd485ea6..dc9697253e84 100755
--- a/devel/backports-update-manager
+++ b/devel/backports-update-manager
@@ -18,6 +18,8 @@ SPACE_PER_KERNEL=101
 # ~13 MiB of both deb files
 SPACE_PER_KERNEL_DEB=13
 
+MIN_VERSION = (3, 10)
+
 GIT_TREES = [
     "git://git.kernel.org/pub/scm/linux/kernel/git/backports/backports.git",
     "git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git",
@@ -82,6 +84,12 @@ class backport_kernel_updater:
                 while len(sver[0]) < n:
                     sver[0].append(0)
 
+        filtered = {}
+        for subvers in last:
+            if tuple(make_version_tuple(subvers[1:])) >= MIN_VERSION:
+                filtered[subvers] = last[subvers]
+        last = filtered
+
         result = []
         for subvers in last.values():
             subvers.sort(reverse=True)
-- 
2.14.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
