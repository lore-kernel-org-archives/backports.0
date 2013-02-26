Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 06/23] compat: ckmake: do not start all build at the same time
Date: Tue, 26 Feb 2013 21:58:57 +0100
Message-Id: <1361912354-29498-7-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1361912354-29498-1-git-send-email-hauke@hauke-m.de>
References: <1361912354-29498-1-git-send-email-hauke@hauke-m.de>
List-ID: <backports@vger.kernel.org>

When all builds are started at the same time this causes problems like,
because all threads want to access the same file.

In the compat-drivers build this resulted in this error for some threads:
./scripts/gen-compat-autoconf.sh: /usr/bin/env: bad interpreter: Text file busy

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 bin/ckmake |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/bin/ckmake b/bin/ckmake
index f5f46b0..3d30bee 100755
--- a/bin/ckmake
+++ b/bin/ckmake
@@ -22,6 +22,7 @@ import signal
 from Queue import *
 from threading import Thread, Lock
 from shutil import copytree, ignore_patterns, rmtree, copyfileobj
+from time import sleep
 
 releases_processed = []
 releases_baking = []
@@ -277,6 +278,7 @@ class kernel_set():
 	def kick_threads(self):
 		for rel in self.releases:
 			self.queue.put(rel)
+			sleep(1)
 	def wait_threads(self):
 		self.queue.join()
 	def update_status(self, rel, status):
-- 
1.7.10.4
