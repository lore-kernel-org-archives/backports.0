Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:33806 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755842Ab3EPIXx (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 16 May 2013 04:23:53 -0400
Received: by mail-pa0-f50.google.com with SMTP id fb10so2265042pad.23
        for <backports@vger.kernel.org>; Thu, 16 May 2013 01:23:52 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH v2 4/4] gentree.py: do not skip /dev/null patches
Date: Thu, 16 May 2013 01:23:30 -0700
Message-Id: <1368692610-24662-5-git-send-email-mcgrof@do-not-panic.com> (sfid-20130516_102356_806104_2369DBE5)
In-Reply-To: <1368692610-24662-1-git-send-email-mcgrof@do-not-panic.com>
References: <1368692610-24662-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

Patches where the origin is /dev/null should
be considered as needed.

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 gentree.py |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gentree.py b/gentree.py
index 9d0f3ae..372587f 100755
--- a/gentree.py
+++ b/gentree.py
@@ -368,7 +368,7 @@ def process(kerneldir, outdir, copy_list_file, git_revision=None,
         # assume the patch needs to be applied -- otherwise continue
         patched_file = '/'.join(p.items[0].source.split('/')[1:])
         fullfn = os.path.join(args.outdir, patched_file)
-        if not os.path.exists(fullfn):
+        if ((patched_file != "null") and (not os.path.exists(fullfn))):
             if args.verbose:
                 logwrite("Not applying %s, not needed" % print_name)
             continue
-- 
1.7.10.4

