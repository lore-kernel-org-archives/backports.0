Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:44267 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754161Ab3DMXzp (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 13 Apr 2013 19:55:45 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [RFC/RFT 35/42] backports: improve SIMPLE_DEV_PM_OPS macro
Date: Sun, 14 Apr 2013 01:53:55 +0200
Message-Id: <1365897243-31214-36-git-send-email-johannes@sipsolutions.net> (sfid-20130414_015639_928760_7DEE4F9C)
In-Reply-To: <1365897243-31214-1-git-send-email-johannes@sipsolutions.net>
References: <1365897243-31214-1-git-send-email-johannes@sipsolutions.net>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

To avoid warnings on old kernels, improve the macro
and give it some content rather than nothing.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/pm.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/backport/backport-include/linux/pm.h b/backport/backport-include/linux/pm.h
index a78477c..70f3a21 100644
--- a/backport/backport-include/linux/pm.h
+++ b/backport/backport-include/linux/pm.h
@@ -51,7 +51,10 @@ struct dev_pm_ops name = { \
 	.restore = resume_fn, \
 }
 #else
-#define SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn)
+#define ___BACKPORT_PASTE(a, b) a##b
+#define __BACKPORT_PASTE(a, b) ___BACKPORT_PASTE(a,b)
+#define SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
+	struct {} __maybe_unused __BACKPORT_PASTE(__backport_avoid_warning_, __LINE__)
 #endif /* >= 2.6.29 */
 #endif /* < 2.6.32 */
 
-- 
1.8.0

