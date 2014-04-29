Return-path: <backports-owner@vger.kernel.org>
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:25127 "EHLO
	mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754865AbaD2J6Z (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 29 Apr 2014 05:58:25 -0400
From: Arend van Spriel <arend@broadcom.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
CC: <backports@vger.kernel.org>, Arend van Spriel <arend@broadcom.com>
Subject: [PATCH V2] backports: lib: remove raising ExecutionError exception
Date: Tue, 29 Apr 2014 11:58:18 +0200
Message-ID: <1398765498-6957-1-git-send-email-arend@broadcom.com> (sfid-20140429_115827_636549_1BD58575)
In-Reply-To: <1398422668-11735-1-git-send-email-arend@broadcom.com>
References: <1398422668-11735-1-git-send-email-arend@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

In spatch a ExecutionError was raised, but that causes the thread
to finish without closing the outfile and more importantly without
putting (ret, fn) tuple on the return queue. This results in the
threaded_spatch routine to get stuck on the ret_q.get() call. This
patch removes raising the ExecutionError and just return the tuple.
The non-zero return code will result in ExecutionErrorThread exception
anyway.

Signed-off-by: Arend van Spriel <arend@broadcom.com>
---
A bit late but here is the rebased version.

Regards,
Arend
---
 lib/bpcoccinelle.py |    5 -----
 1 file changed, 5 deletions(-)

diff --git a/lib/bpcoccinelle.py b/lib/bpcoccinelle.py
index a71f425..fc503f1 100644
--- a/lib/bpcoccinelle.py
+++ b/lib/bpcoccinelle.py
@@ -4,9 +4,6 @@ from lib.tempdir import tempdir
 
 class CoccinelleError(Exception):
     pass
-class ExecutionError(CoccinelleError):
-    def __init__(self, errcode):
-        self.error_code = errcode
 class ExecutionErrorThread(CoccinelleError):
     def __init__(self, errcode, fn, cocci_file, threads, t, logwrite, print_name):
         self.error_code = errcode
@@ -48,8 +45,6 @@ def spatch(cocci_file, outdir,
                                close_fds=True, universal_newlines=True,
                                cwd=outdir)
     sprocess.wait()
-    if sprocess.returncode != 0:
-        raise ExecutionError(sprocess.returncode)
     outfile.close()
     ret_q.put((sprocess.returncode, fn))
 
-- 
1.7.9.5

