Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:54275 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755912Ab3EGDDk (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 6 May 2013 23:03:40 -0400
Received: by mail-pa0-f44.google.com with SMTP id jh10so155402pab.3
        for <backports@vger.kernel.org>; Mon, 06 May 2013 20:03:39 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org, techtonik@gmail.com,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 2/3] lib/patch.py: add top header parsing support
Date: Mon,  6 May 2013 20:03:19 -0700
Message-Id: <1367895800-14305-3-git-send-email-mcgrof@do-not-panic.com> (sfid-20130507_050341_482300_767BCF1B)
In-Reply-To: <1367895800-14305-1-git-send-email-mcgrof@do-not-panic.com>
References: <1367895800-14305-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

Add a top_header for cases where a patchset might have a
full header that we may want users to keep around.

Cc: techtonik@gmail.com
Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 lib/patch.py |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/patch.py b/lib/patch.py
index 4a7578d..e167b4f 100644
--- a/lib/patch.py
+++ b/lib/patch.py
@@ -201,6 +201,7 @@ class PatchSet(object):
 
     # list of Patch objects
     self.items = []
+    self.top_header = ""
 
     self.errors = 0    # fatal parsing errors
     self.warnings = 0  # non-critical warnings
@@ -303,6 +304,7 @@ class PatchSet(object):
       if headscan:
         while not fe.is_empty and not fe.line.startswith("--- "):
             header.append(fe.line)
+            self.top_header += fe.line
             fe.next()
         if fe.is_empty:
             if p == None:
-- 
1.7.10.4

