Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:62324 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752692AbaEAX1X (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 1 May 2014 19:27:23 -0400
Received: by mail-pd0-f180.google.com with SMTP id x10so3774458pdj.25
        for <backports@vger.kernel.org>; Thu, 01 May 2014 16:27:22 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@suse.com>
Subject: [PATCH 5/8] backports: add ckmake binary requirements
Date: Thu,  1 May 2014 16:26:48 -0700
Message-Id: <1398986811-25649-6-git-send-email-mcgrof@do-not-panic.com> (sfid-20140502_012724_646776_D87703E8)
In-Reply-To: <1398986811-25649-1-git-send-email-mcgrof@do-not-panic.com>
References: <1398986811-25649-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@suse.com>

Signed-off-by: Luis R. Rodriguez <mcgrof@suse.com>
---
 devel/ckmake | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 mode change 100644 => 100755 devel/ckmake

diff --git a/devel/ckmake b/devel/ckmake
old mode 100644
new mode 100755
index 3e3d95e..0c238a6
--- a/devel/ckmake
+++ b/devel/ckmake
@@ -25,6 +25,14 @@ from threading import Thread, Lock
 from shutil import copytree, ignore_patterns, rmtree, copyfileobj
 from time import sleep
 
+# find self
+source_dir = os.path.abspath(os.path.dirname(__file__))
+source_dir = os.path.dirname(source_dir)
+# add parent directory to path to get to lib/
+sys.path.append(source_dir)
+# import libraries we need
+from lib import bpreqs as reqs
+
 releases_processed = []
 releases_baking = []
 processed_lock = Lock()
@@ -580,6 +588,11 @@ def build_krange(krange_list):
     return {}
 
 if __name__ == "__main__":
+    req = reqs.Req()
+    req.require('make')
+    req.require('gcc')
+    if not req.reqs_match():
+        sys.exit(1)
     parser = argparse.ArgumentParser(
         description='compile against all kernels you have')
     parser.add_argument(
-- 
1.9.1

