Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:44277 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753966Ab3DMXzy (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 13 Apr 2013 19:55:54 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [RFC/RFT 38/42] backports: avoid module parameter warnings
Date: Sun, 14 Apr 2013 01:53:58 +0200
Message-Id: <1365897243-31214-39-git-send-email-johannes@sipsolutions.net> (sfid-20130414_015638_871568_16BE8FEF)
In-Reply-To: <1365897243-31214-1-git-send-email-johannes@sipsolutions.net>
References: <1365897243-31214-1-git-send-email-johannes@sipsolutions.net>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

On old kernels, boolean module parameters had to be int.
When we backport, they're bool, and thus cause warnings.
Suppress the warnings by redefining the parameter check,
it's not entirely clear that it'll do the right thing
though?

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/module.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/backport/backport-include/linux/module.h b/backport/backport-include/linux/module.h
index 6bddc76..82c96bd 100644
--- a/backport/backport-include/linux/module.h
+++ b/backport/backport-include/linux/module.h
@@ -59,4 +59,9 @@ extern void backport_dependency_symbol(void);
 	}								\
 	void cleanup_module(void) __attribute__((alias("__exit_compat")));
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,3,0)
+#undef param_check_bool
+#define param_check_bool(name, p) __param_check(name, p, bool)
+#endif
+
 #endif /* __BACKPORT_LINUX_MODULE_H */
-- 
1.8.0

