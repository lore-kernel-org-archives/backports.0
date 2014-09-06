Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:48069 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751903AbaIFTog (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 6 Sep 2014 15:44:36 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 2/5] backports: fix build with Ubuntu mainline kernels
Date: Sat,  6 Sep 2014 21:44:16 +0200
Message-Id: <1410032659-30404-3-git-send-email-hauke@hauke-m.de> (sfid-20140906_214438_709939_281A8588)
In-Reply-To: <1410032659-30404-1-git-send-email-hauke@hauke-m.de>
References: <1410032659-30404-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

We only want the UTS_UBUNTU_RELEASE_ABI var when we are on a normal
Ubuntu distribution kernel and not when we are on a Ubuntu mainline
kernel. Some of the Ubuntu mainline kernel do have an invalid octal
number in this field like 031418 and we do not want to evaluate this at
all on the Ubuntu mainline kernels.  All Ubuntu distribution kernel
have CONFIG_VERSION_SIGNATURE set so this way we can detect the which
type of kernel we are on.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/generated/utsrelease.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/backport/backport-include/generated/utsrelease.h b/backport/backport-include/generated/utsrelease.h
index c1cf8af..a149b7a 100644
--- a/backport/backport-include/generated/utsrelease.h
+++ b/backport/backport-include/generated/utsrelease.h
@@ -1,5 +1,21 @@
+#ifndef __BACKPORT_GENERATED_UTS_RELEASE_H
+#define __BACKPORT_GENERATED_UTS_RELEASE_H
 #include_next <generated/utsrelease.h>
 
+/*
+ * We only want the UTS_UBUNTU_RELEASE_ABI var when we are on a normal
+ * Ubuntu distribution kernel and not when we are on a Ubuntu mainline
+ * kernel. Some of the Ubuntu mainline kernel do have an invalid octal
+ * number in this field like 031418 and we do not want to evaluate this
+ * at all on the Ubuntu mainline kernels.  All Ubuntu distribution
+ * kernel have CONFIG_VERSION_SIGNATURE set so this way we can detect
+ * the which type of kernel we are on.
+ */
 #ifndef UTS_UBUNTU_RELEASE_ABI
 #define UTS_UBUNTU_RELEASE_ABI 0
+#elif !defined(CONFIG_VERSION_SIGNATURE)
+#undef UTS_UBUNTU_RELEASE_ABI
+#define UTS_UBUNTU_RELEASE_ABI 0
 #endif
+
+#endif /* __BACKPORT_GENERATED_UTS_RELEASE_H */
-- 
1.9.1

