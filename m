Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:53581 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751652Ab3H0VfM (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 27 Aug 2013 17:35:12 -0400
Received: by mail-pd0-f177.google.com with SMTP id y10so5359469pdj.8
        for <backports@vger.kernel.org>; Tue, 27 Aug 2013 14:35:11 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 2/4] backports: add generic semaphore.h
Date: Tue, 27 Aug 2013 14:44:23 -0700
Message-Id: <1377639864-25672-2-git-send-email-mcgrof@do-not-panic.com> (sfid-20130827_233525_360124_F3485535)
In-Reply-To: <1377639864-25672-1-git-send-email-mcgrof@do-not-panic.com>
References: <1377639864-25672-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

Matthew generalized the semaphore implementation and part of
that collateral evolution consisted of changing the header
used for the expected routines from asm/semaphore.h to
linux/semaphore.h.

mcgrof@garbanzo ~/linux-next (git::master)$ git describe --contains \
	64ac24e738823161693bf791f87adc802cf529ff
v2.6.26-rc1~1155^2~5

commit 64ac24e738823161693bf791f87adc802cf529ff
Author: Matthew Wilcox <matthew@wil.cx>
Date:   Fri Mar 7 21:55:58 2008 -0500

    Generic semaphore implementation

    Semaphores are no longer performance-critical, so a generic C
    implementation is better for maintainability, debuggability and
    extensibility.  Thanks to Peter Zijlstra for fixing the lockdep
    warning.  Thanks to Harvey Harrison for pointing out that the
    unlikely() was unnecessary.

    Signed-off-by: Matthew Wilcox <willy@linux.intel.com>
    Acked-by: Ingo Molnar <mingo@elte.hu>

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 backport/backport-include/linux/semaphore.h |   12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 backport/backport-include/linux/semaphore.h

diff --git a/backport/backport-include/linux/semaphore.h b/backport/backport-include/linux/semaphore.h
new file mode 100644
index 0000000..d242df4
--- /dev/null
+++ b/backport/backport-include/linux/semaphore.h
@@ -0,0 +1,12 @@
+#ifndef __BACKPORT_LINUX_SEMAPHORE_H
+#define __BACKPORT_LINUX_SEMAPHORE_H
+
+#include <linux/version.h>
+
+#if  LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,26)
+#include_next <linux/semaphore.h>
+#else
+#include <asm/semaphore.h>
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(2,6,26) */
+
+#endif /* __BACKPORT_LINUX_SEMAPHORE_H */
-- 
1.7.10.4

