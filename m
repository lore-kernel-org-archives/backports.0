Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:40006 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752582AbbDEWNb (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 5 Apr 2015 18:13:31 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 3/7] patches: add missing import to rhashtable
Date: Mon,  6 Apr 2015 00:13:16 +0200
Message-Id: <1428272000-19929-4-git-send-email-hauke@hauke-m.de> (sfid-20150406_001336_749552_2B4E59FD)
In-Reply-To: <1428272000-19929-1-git-send-email-hauke@hauke-m.de>
References: <1428272000-19929-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

lib-rhashtable.c misses a #include <linux/export.h> on some kernel
versions.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 patches/backport-adjustments/rhashtable.patch | 10 ++++++++++
 1 file changed, 10 insertions(+)
 create mode 100644 patches/backport-adjustments/rhashtable.patch

diff --git a/patches/backport-adjustments/rhashtable.patch b/patches/backport-adjustments/rhashtable.patch
new file mode 100644
index 0000000..1dd7acf
--- /dev/null
+++ b/patches/backport-adjustments/rhashtable.patch
@@ -0,0 +1,10 @@
+--- a/compat/lib-rhashtable.c
++++ b/compat/lib-rhashtable.c
+@@ -25,6 +25,7 @@
+ #include <linux/random.h>
+ #include <linux/rhashtable.h>
+ #include <linux/err.h>
++#include <linux/export.h>
+ 
+ #define HASH_DEFAULT_SIZE	64UL
+ #define HASH_MIN_SIZE		4UL
-- 
1.9.1

