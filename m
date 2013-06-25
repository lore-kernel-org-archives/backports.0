Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:39861 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752693Ab3FYKqt (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 25 Jun 2013 06:46:49 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] backport: include printk.h into backport-3.11.c
Date: Tue, 25 Jun 2013 12:46:44 +0200
Message-Id: <1372157204-30109-1-git-send-email-johannes@sipsolutions.net> (sfid-20130625_124651_422228_75B53DA1)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

This is needed for pr_warn(), otherwise it's not defined on
all kernels (it is sometimes pulled in by other headers.)

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/compat/backport-3.11.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/backport/compat/backport-3.11.c b/backport/compat/backport-3.11.c
index dc9073e..332db4a 100644
--- a/backport/compat/backport-3.11.c
+++ b/backport/compat/backport-3.11.c
@@ -15,6 +15,7 @@
 #include <asm/mtrr.h>
 #include <asm/cpufeature.h>
 #include <linux/io.h>
+#include <linux/printk.h>
 
 /* arch_phys_wc_add returns an MTRR register index plus this offset. */
 #define MTRR_TO_PHYS_WC_OFFSET 1000
-- 
1.8.0

