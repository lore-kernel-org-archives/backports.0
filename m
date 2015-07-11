Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:56138 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751639AbbGKVeQ (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 11 Jul 2015 17:34:16 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 2/3] devel: add support for deb with xz
Date: Sat, 11 Jul 2015 23:34:09 +0200
Message-Id: <1436650450-2696-3-git-send-email-hauke@hauke-m.de> (sfid-20150711_233419_165383_16A75456)
In-Reply-To: <1436650450-2696-1-git-send-email-hauke@hauke-m.de>
References: <1436650450-2696-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This adds basic support for debian packages using the xz compression
algorithm.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 lib/bpar.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bpar.py b/lib/bpar.py
index dd37a6c..5e378d3 100644
--- a/lib/bpar.py
+++ b/lib/bpar.py
@@ -7,9 +7,9 @@ class ExecutionError(ArError):
         self.error_code = errcode
 
 def print_data(input_file, out_file, tree=None):
-    cmd = ['ar', 'p', input_file, 'data.tar.gz']
+    cmd = ['ar', 'p', input_file, 'data.tar.gz', 'data.tar.xz']
     process = subprocess.Popen(cmd,
-                               stdout=out_file, stderr=subprocess.STDOUT,
+                               stdout=out_file,
                                close_fds=True, universal_newlines=True, cwd=tree)
     stdout = process.communicate()[0]
     process.wait()
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe backports" in
