Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.63.242]:49184 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757630AbdJMJmf (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 13 Oct 2017 05:42:35 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 10/11] backports-update-manager: use KPATH variable
Date: Fri, 13 Oct 2017 11:42:25 +0200
Message-Id: <20171013094226.10021-10-johannes@sipsolutions.net> (sfid-20171013_114237_958834_565B26F8)
In-Reply-To: <20171013094226.10021-1-johannes@sipsolutions.net>
References: <20171013094226.10021-1-johannes@sipsolutions.net>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

There's already a variable for the URL, use it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 devel/backports-update-manager | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/devel/backports-update-manager b/devel/backports-update-manager
index 64df29bcea26..8069fd485ea6 100755
--- a/devel/backports-update-manager
+++ b/devel/backports-update-manager
@@ -52,7 +52,7 @@ class backport_kernel_updater:
 
     @classmethod
     def _get_ubuntu_ppa_mainline_kernels(cls):
-        base = 'http://kernel.ubuntu.com/~kernel-ppa/mainline/'
+        base = KPATH
         html = urlopen(base).read()
         builds = re.findall(b'href="([-v.0-9a-z]*)/"', html)
         builds = [b.decode('ascii') for b in builds]
-- 
2.14.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
