Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:33359 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751021Ab3EGKDc (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 7 May 2013 06:03:32 -0400
Received: by mail-pd0-f173.google.com with SMTP id v10so294554pde.18
        for <backports@vger.kernel.org>; Tue, 07 May 2013 03:03:32 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 1/2] ckmake: rename get_rel_spec() to get_rel_spec_ubuntu()
Date: Tue,  7 May 2013 02:07:05 -0700
Message-Id: <1367917626-21870-1-git-send-email-mcgrof@do-not-panic.com> (sfid-20130507_120335_363563_BE55A039)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

Vanilla Linux kernels are being used but the directory
file naming for for the kernels are Ubuntu specific,
clarify that.

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 devel/ckmake |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/devel/ckmake b/devel/ckmake
index bb81eb4..d77da62 100755
--- a/devel/ckmake
+++ b/devel/ckmake
@@ -220,7 +220,7 @@ def sig_handler(signal, frame):
 	clean()
 	sys.exit(-2)
 
-def get_rel_spec(rel):
+def get_rel_spec_ubuntu(rel):
 	if ("rc" in rel):
 		m = re.match(r"v*(?P<VERSION>\d+)\.+" \
 			     "(?P<PATCHLEVEL>\d+)[.]+" \
@@ -325,7 +325,7 @@ class kernel_set():
 		for dirname, dirnames, filenames in os.walk(modules):
 			dirnames.sort()
 			for subdirname in dirnames:
-				specifics = get_rel_spec(subdirname)
+				specifics = get_rel_spec_ubuntu(subdirname)
 				if (not specifics):
 					continue
 				rc = False
-- 
1.7.10.4

