Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:35845 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753878Ab3H0VfI (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 27 Aug 2013 17:35:08 -0400
Received: by mail-pd0-f174.google.com with SMTP id y13so5434404pdi.33
        for <backports@vger.kernel.org>; Tue, 27 Aug 2013 14:35:08 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 1/4] backports: fix compilation for 2.6.25 for math64 header
Date: Tue, 27 Aug 2013 14:44:22 -0700
Message-Id: <1377639864-25672-1-git-send-email-mcgrof@do-not-panic.com> (sfid-20130827_233524_712233_C0C7FFEF)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

We need to ifdef correctly before assuming we can include that
header.

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 backport/backport-include/linux/math64.h |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/backport/backport-include/linux/math64.h b/backport/backport-include/linux/math64.h
index d551db6..b65fab3 100644
--- a/backport/backport-include/linux/math64.h
+++ b/backport/backport-include/linux/math64.h
@@ -2,7 +2,12 @@
 #define _COMPAT_LINUX_MATH64_H 1
 
 #include <linux/version.h>
+#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,25))
 #include_next <linux/math64.h>
+#else
+#include <linux/types.h>
+#include <asm/div64.h>
+#endif /* (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,25)) */
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,26)
 #if BITS_PER_LONG == 64
-- 
1.7.10.4

