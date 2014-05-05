Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:41333 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933011AbaEEO6o (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 5 May 2014 10:58:44 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] gentree: remove stray print
Date: Mon,  5 May 2014 16:58:38 +0200
Message-Id: <1399301918-30691-1-git-send-email-johannes@sipsolutions.net> (sfid-20140505_165848_475267_B488D3F5)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

My previous commit to restrict the defconfig files left
a debugging print statement, remove it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 gentree.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/gentree.py b/gentree.py
index 8a8f6b6a22a4..5fe699650916 100755
--- a/gentree.py
+++ b/gentree.py
@@ -808,7 +808,6 @@ def process(kerneldir, outdir, copy_list_file, git_revision=None,
                     line_ok = True
                     break
             if not line_ok:
-                print dfbase, line
                 copy_defconfig = False
                 break
         if copy_defconfig:
-- 
2.0.0.rc0

