Return-Path: <mcgrof+caf_=mcgrof=gmail.com@frijolero.org>
Return-Path: <backports-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:56013 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752169Ab2HOJAr (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 15 Aug 2012 05:00:47 -0400
Received: by wgbdr13 with SMTP id dr13so1200525wgb.1
        for <backports@vger.kernel.org>; Wed, 15 Aug 2012 02:00:46 -0700 (PDT)
From: =?UTF-8?q?Ozan=20=C3=87a=C4=9Flayan?= <ozancag@gmail.com>
To: backports@vger.kernel.org
Cc: =?UTF-8?q?Ozan=20=C3=87a=C4=9Flayan?= <ozancag@gmail.com>
Subject: [PATCH] Switch README to markdown format
Date: Wed, 15 Aug 2012 12:00:33 +0300
Message-Id: <1345021233-3152-1-git-send-email-ozancag@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Ozan Çağlayan <ozancag@gmail.com>
---
 README    | 30 ------------------------------
 README.md | 27 +++++++++++++++++++++++++++
 2 files changed, 27 insertions(+), 30 deletions(-)
 delete mode 100644 README
 create mode 100644 README.md

diff --git a/README b/README
deleted file mode 100644
index 550de09..0000000
--- a/README
+++ /dev/null
@@ -1,30 +0,0 @@
-Linux compat drivers compatibility package
-==========================================
-
-This package provides backport support for drivers from newer kernels
-down to older kernels. It currently backports 3 subsystems:
-
-  * Ethernet
-  * Wireless
-  * Bluetooth
-
-This package provides the latest Linux kernel subsystem enhancements
-for kernels 2.6.24 and above. It is technically possible to support
-kernels < 2.6.24 but more work is required for that.
-
-Documentation
-------------
-
-This package is documented online and has more-up-to date information
-online than on this README file. You should read the wiki page
-and not rely on this README!
-
-https://backports.wiki.kernel.org
-
-License
--------
-
-This work is a subset of the Linux kernel as such we keep the kernel's
-Copyright practice. Some files have their own copyright and in those
-cases the license is mentioned in the file. All additional work made
-to building this package is licensed under the GPLv2.
diff --git a/README.md b/README.md
new file mode 100644
index 0000000..8945bc2
--- /dev/null
+++ b/README.md
@@ -0,0 +1,27 @@
+# Linux compat drivers compatibility package
+
+This package provides backport support for drivers from newer kernels
+down to older kernels. It currently backports 3 subsystems:
+
+  * Ethernet
+  * Wireless
+  * Bluetooth
+
+This package provides the latest Linux kernel subsystem enhancements
+for kernels 2.6.24 and above. It is technically possible to support
+kernels < 2.6.24 but more work is required for that.
+
+# Documentation
+
+This package is documented online and has more-up-to date information
+online than on this README file. You should read the wiki page
+and not rely on this README!
+
+https://backports.wiki.kernel.org
+
+# License
+
+This work is a subset of the Linux kernel as such we keep the kernel's
+Copyright practice. Some files have their own copyright and in those
+cases the license is mentioned in the file. All additional work made
+to building this package is licensed under the GPLv2.
-- 
1.7.11.2

