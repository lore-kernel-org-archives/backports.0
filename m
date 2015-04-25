Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:49625 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751975AbbDYNvW (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 25 Apr 2015 09:51:22 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 7/9] header: add LINUX_BACKPORT() macro to reinit_completion()
Date: Sat, 25 Apr 2015 15:51:02 +0200
Message-Id: <1429969864-16831-8-git-send-email-hauke@hauke-m.de> (sfid-20150425_155127_785903_5245E967)
In-Reply-To: <1429969864-16831-1-git-send-email-hauke@hauke-m.de>
References: <1429969864-16831-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This fixes compalation on RHEL 7.1

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/completion.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/backport/backport-include/linux/completion.h b/backport/backport-include/linux/completion.h
index 399430d..477530d 100644
--- a/backport/backport-include/linux/completion.h
+++ b/backport/backport-include/linux/completion.h
@@ -11,6 +11,7 @@
  * This inline function should be used to reinitialize a completion structure so it can
  * be reused. This is especially important after complete_all() is used.
  */
+#define reinit_completion LINUX_BACKPORT(reinit_completion)
 static inline void reinit_completion(struct completion *x)
 {
 	x->done = 0;
-- 
1.9.1

