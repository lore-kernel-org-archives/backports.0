Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:45977 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753139AbaEOJWS (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 15 May 2014 05:22:18 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] backport: CCM: set correct dependencies
Date: Thu, 15 May 2014 11:22:06 +0200
Message-Id: <1400145726-16520-1-git-send-email-johannes@sipsolutions.net> (sfid-20140515_112220_823082_F95EE84B)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

If these aren't actually compiled in, then the mac80211
code will fail at runtime. Add these dependencies so we
at least get a warning at compile time about this.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/compat/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/backport/compat/Kconfig b/backport/compat/Kconfig
index 5af74337c43a..026b3f378f5b 100644
--- a/backport/compat/Kconfig
+++ b/backport/compat/Kconfig
@@ -128,6 +128,8 @@ config BACKPORT_USERSEL_BUILD_ALL
 	  you probably shouldn't enable it.
 
 config BACKPORT_CRYPTO_CCM
+	depends on CRYPTO_AEAD
+	depends on CRYPTO_CTR
 	bool
 
 config BACKPORT_BUILD_CRYPTO_CCM
-- 
2.0.0.rc0

