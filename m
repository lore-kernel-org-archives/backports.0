Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:51414 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757856Ab3GLXAq (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 12 Jul 2013 19:00:46 -0400
Received: by mail-pd0-f175.google.com with SMTP id 4so9014996pdd.6
        for <backports@vger.kernel.org>; Fri, 12 Jul 2013 16:00:46 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 2/2] backports: add gplizer for EXPORT_SYMBOL_GPL() help
Date: Fri, 12 Jul 2013 16:00:36 -0700
Message-Id: <1373670037-28011-2-git-send-email-mcgrof@do-not-panic.com> (sfid-20130713_010048_405712_6A6F3F38)
In-Reply-To: <1373670037-28011-1-git-send-email-mcgrof@do-not-panic.com>
References: <1373670037-28011-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

If we forget to use EXPORT_SYMBOL_GPL() we can run this.
We may later use this for other things.

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 devel/gplizer |   28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100755 devel/gplizer

diff --git a/devel/gplizer b/devel/gplizer
new file mode 100755
index 0000000..209bb95
--- /dev/null
+++ b/devel/gplizer
@@ -0,0 +1,28 @@
+#!/usr/bin/env python
+"""
+ gplizer
+=========
+
+This modifies C files with EXPORT_SYMBOL() to EXPORT_SYMBOL_GPL().
+We use this as Python code here as we may use it later for broader
+substitutions. We keep it in backports as typically we forget to
+use EXPORT_SYMBOL_GPL() when backporting kernel symbols.
+
+In short this does this but in Python:
+
+for i in $(find ./ -type f -name \*.c); do
+	perl -pi -e'$_ =~ s|EXPORT_SYMBOL\(|EXPORT_SYMBOL_GPL\(|gs;' $i
+done
+"""
+
+import os, fileinput
+
+def gplize(f):
+    for line in fileinput.input(f, inplace=1):
+        print line.replace('EXPORT_SYMBOL(','EXPORT_SYMBOL_GPL('),
+
+if __name__ == '__main__':
+    for root, dirs, files in os.walk(os.getcwd()):
+        for f in files: 
+            if f.endswith('.c'):
+                gplize(os.path.join(root, f))
-- 
1.7.10.4

