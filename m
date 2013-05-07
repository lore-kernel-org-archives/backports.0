Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pb0-f51.google.com ([209.85.160.51]:38542 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755912Ab3EGDDp (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 6 May 2013 23:03:45 -0400
Received: by mail-pb0-f51.google.com with SMTP id wy7so67506pbc.38
        for <backports@vger.kernel.org>; Mon, 06 May 2013 20:03:44 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org, techtonik@gmail.com,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 3/3] gentree.py: keep patch headers for patch refresh
Date: Mon,  6 May 2013 20:03:20 -0700
Message-Id: <1367895800-14305-4-git-send-email-mcgrof@do-not-panic.com> (sfid-20130507_050346_645832_6291BD1F)
In-Reply-To: <1367895800-14305-1-git-send-email-mcgrof@do-not-panic.com>
References: <1367895800-14305-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

Without this change we were removing patch headers
when refreshing patches.

Cc: techtonik@gmail.com
Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 gentree.py |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/gentree.py b/gentree.py
index afe3645..5206fc7 100755
--- a/gentree.py
+++ b/gentree.py
@@ -401,7 +401,9 @@ def process(kerneldir, outdir, copy_list_file, git_revision=None,
             return 2
 
         if args.refresh:
-            pfilef = open(pfile + '.tmp', 'w')
+            pfilef = open(pfile + '.tmp', 'a')
+            pfilef.write(p.top_header)
+            pfilef.flush()
             for patchitem in p.items:
                 patched_file = '/'.join(patchitem.source.split('/')[1:])
                 fullfn = os.path.join(args.outdir, patched_file)
-- 
1.7.10.4

