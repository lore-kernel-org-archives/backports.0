Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:32924 "EHLO sipsolutions.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752843AbdIHKEv (ORCPT <rfc822;backports@vger.kernel.org>);
        Fri, 8 Sep 2017 06:04:51 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] add (automatic) refcount backport
Date: Fri,  8 Sep 2017 12:04:46 +0200
Message-Id: <20170908100446.18997-1-johannes@sipsolutions.net> (sfid-20170908_120512_220461_895061C6)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/compat/Kconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/backport/compat/Kconfig b/backport/compat/Kconfig
index f350217f1ab7..b16667109489 100644
--- a/backport/compat/Kconfig
+++ b/backport/compat/Kconfig
@@ -167,3 +167,10 @@ config BPAUTO_BUILD_FRAME_VECTOR
 	default n if FRAME_VECTOR
 	default y if BPAUTO_FRAME_VECTOR
 	#c-file mm/frame_vector.c
+
+config BPAUTO_REFCOUNT
+	bool
+	default y
+	depends on KERNEL_4_11
+	#h-file linux/refcount.h
+	#c-file lib/refcount.c
-- 
2.14.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
