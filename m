Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:49627 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756627AbbDYNvV (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 25 Apr 2015 09:51:21 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 6/9] header: lockdep_assert_held is already in kernel 3.0
Date: Sat, 25 Apr 2015 15:51:01 +0200
Message-Id: <1429969864-16831-7-git-send-email-hauke@hauke-m.de> (sfid-20150425_155127_219176_9750A704)
In-Reply-To: <1429969864-16831-1-git-send-email-hauke@hauke-m.de>
References: <1429969864-16831-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This backport is not needed because it is already provided by all
supported kernel versions.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/lockdep.h | 10 ----------
 1 file changed, 10 deletions(-)
 delete mode 100644 backport/backport-include/linux/lockdep.h

diff --git a/backport/backport-include/linux/lockdep.h b/backport/backport-include/linux/lockdep.h
deleted file mode 100644
index 1d4aa65..0000000
--- a/backport/backport-include/linux/lockdep.h
+++ /dev/null
@@ -1,10 +0,0 @@
-#ifndef __BACKPORT_LINUX_LOCKDEP_H
-#define __BACKPORT_LINUX_LOCKDEP_H
-#include_next <linux/lockdep.h>
-#include <linux/version.h>
-
-#ifndef lockdep_assert_held
-#define lockdep_assert_held(l)			do { } while (0)
-#endif
-
-#endif /* __BACKPORT_LINUX_LOCKDEP_H */
-- 
1.9.1

