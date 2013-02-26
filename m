Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 05/23] compat: ckmake: remove lots of warning spam for the log
Date: Tue, 26 Feb 2013 21:58:56 +0100
Message-Id: <1361912354-29498-6-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1361912354-29498-1-git-send-email-hauke@hauke-m.de>
References: <1361912354-29498-1-git-send-email-hauke@hauke-m.de>
List-ID: <backports@vger.kernel.org>

Set the environment variable KCFLAGS = "-Wno-unused-but-set-variable"
to remove lots of spam from the log.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 bin/ckmake |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/bin/ckmake b/bin/ckmake
index c821b0a..f5f46b0 100755
--- a/bin/ckmake
+++ b/bin/ckmake
@@ -141,9 +141,13 @@ def process_kernel(num, kset):
 		nice = 'ionice -c 3 nice -n 20 '
 		cmd = nice + 'make ' + jobs + make_args + log
 
+		my_env = os.environ.copy()
+		my_env["KCFLAGS"] = "-Wno-unused-but-set-variable"
+
 		kset.baking(rel)
 
 		p = subprocess.Popen([cmd],
+				     env = my_env,
 				     cwd = work_dir,
 				     stdout=None,
 				     stderr=None,
-- 
1.7.10.4
