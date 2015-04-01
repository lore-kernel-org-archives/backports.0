Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:59172 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751702AbbDAPbq (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 1 Apr 2015 11:31:46 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 1/5] backports: include rhashtable
Date: Wed,  1 Apr 2015 17:31:35 +0200
Message-Id: <1427902299-24079-1-git-send-email-johannes@sipsolutions.net> (sfid-20150401_173149_445100_86395FEE)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

As mac80211 now needs rhashtable, include it in backports.
For now, it actually depends on mac80211 and is selected
for kernels < 4.1 -- it existed in previous kernels but
with different API, so cannot be used from there easily.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/compat/Kconfig | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/backport/compat/Kconfig b/backport/compat/Kconfig
index aadf246896e9..8fcdb8a96bb3 100644
--- a/backport/compat/Kconfig
+++ b/backport/compat/Kconfig
@@ -135,3 +135,12 @@ config BPAUTO_BUILD_WANT_DEV_COREDUMP
 	default y if BPAUTO_WANT_DEV_COREDUMP
 	#h-file linux/devcoredump.h
 	#c-file drivers/base/devcoredump.c
+
+config BPAUTO_RHASHTABLE
+	bool
+	# current API of rhashtable was introduced in version 4.1
+	depends on KERNEL_4_1
+	# not very nice - but better than always having it
+	default y if MAC80211
+	#h-file linux/rhashtable.h
+	#c-file lib/rhashtable.c
-- 
2.1.4

