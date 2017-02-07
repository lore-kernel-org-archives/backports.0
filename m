Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:54398 "EHLO sipsolutions.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751094AbdBGJEh (ORCPT <rfc822;backports@vger.kernel.org>);
        Tue, 7 Feb 2017 04:04:37 -0500
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] backports: improve MTU spatch
Date: Tue,  7 Feb 2017 10:04:33 +0100
Message-Id: <20170207090433.22264-1-johannes@sipsolutions.net> (sfid-20170207_100440_042243_5F4DEC48)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

Improve the MTU spatch to
 1) not handle arbitrary expressions, only constants - the one
    case where I found expressions can't actually just move it
    to a function, it won't compile
 2) if min_mtu isn't set, assume 0

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 patches/0073-netdevice-mtu-range.cocci | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/patches/0073-netdevice-mtu-range.cocci b/patches/0073-netdevice-mtu-range.cocci
index 30276f950e10..d9fb3d7ab3fa 100644
--- a/patches/0073-netdevice-mtu-range.cocci
+++ b/patches/0073-netdevice-mtu-range.cocci
@@ -3,6 +3,32 @@
 
 first_ops = 0
 
+@both@
+expression ndevexp;
+constant e1, e2;
+identifier func;
+position p;
+@@
+func(...) {
+	<+...
+	ndevexp->min_mtu = e1;
+	ndevexp->max_mtu@p = e2;
+	...+>
+}
+
+@@
+expression ndevexp;
+constant MAX;
+identifier func;
+position p != both.p;
+@@
+func(...) {
+	<+...
++	ndevexp->min_mtu = 0;
+	ndevexp->max_mtu@p = MAX;
+	...+>
+}
+
 @r@
 identifier OPS;
 position p;
@@ -32,7 +58,8 @@ if not(first_ops == ln):
   cocci.include_match(False)
 
 @r1 exists@
-expression ndevexp, e1, e2;
+expression ndevexp;
+constant e1, e2;
 identifier func;
 @@
 func(...) {
@@ -45,7 +72,7 @@ func(...) {
 }
 
 @r2@
-expression r1.e1,r1.e2;
+constant r1.e1,r1.e2;
 identifier r.OPS;
 @@
 +#if LINUX_VERSION_CODE < KERNEL_VERSION(4,10,0)
-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe backports" in
