Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:49939 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752463Ab3EFI7h (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 6 May 2013 04:59:37 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH] backports: kref_get_unless_zero was merged to stable
Date: Mon,  6 May 2013 10:39:45 +0200
Message-Id: <1367829585-18509-1-git-send-email-johannes@sipsolutions.net> (sfid-20130506_105939_268659_F4FF8767)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

Mask the symbol so no matter where it was backported we can
compile against that kernel tree.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Dor Shaish <dor.shaish@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/kref.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/backport/backport-include/linux/kref.h b/backport/backport-include/linux/kref.h
index 40f3c77..d7b6381 100644
--- a/backport/backport-include/linux/kref.h
+++ b/backport/backport-include/linux/kref.h
@@ -5,6 +5,10 @@
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3,8,0)
 #include <linux/atomic.h>
+
+/* This was backported to some kernels (e.g. 3.2.44 and 3.4.41), mask it */
+#define kref_get_unless_zero LINUX_BACKPORT(kref_get_unless_zero)
+
 /* This backports:
  *
  * commit 4b20db3de8dab005b07c74161cb041db8c5ff3a7
-- 
1.8.0

