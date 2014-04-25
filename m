Return-path: <backports-owner@vger.kernel.org>
Received: from mail-gw2-out.broadcom.com ([216.31.210.63]:2566 "EHLO
	mail-gw2-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750926AbaDYKod (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 25 Apr 2014 06:44:33 -0400
From: Arend van Spriel <arend@broadcom.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
CC: <backports@vger.kernel.org>, Arend van Spriel <arend@broadcom.com>
Subject: [PATCH] backports: lib: remove raising ExecutionError exception
Date: Fri, 25 Apr 2014 12:44:28 +0200
Message-ID: <1398422668-11735-1-git-send-email-arend@broadcom.com> (sfid-20140425_124436_920238_3D2FE412)
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

