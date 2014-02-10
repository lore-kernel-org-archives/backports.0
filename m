Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:45659 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752357AbaBJMZu (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 10 Feb 2014 07:25:50 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.1:RSA_AES_128_CBC_SHA1:128)
	(Exim 4.82)
	(envelope-from <johannes@sipsolutions.net>)
	id 1WCpvo-0008B8-CT
	for backports@vger.kernel.org; Mon, 10 Feb 2014 13:25:48 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Subject: [PATCH 1/2] backports: make BACKPORT_BUILD_LEDS depend on LEDS_CLASS=n
Date: Mon, 10 Feb 2014 13:25:45 +0100
Message-Id: <1392035146-12349-1-git-send-email-johannes@sipsolutions.net> (sfid-20140210_132552_165434_A45F2720)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

Somehow !LEDS_CLASS and LEDS_CLASS=n seem to be different (likely
because LEDS_CLASS is tristate, but BACKPORT_BUILD_LEDS is just a
bool), so use LEDS_CLASS=n to fix build issues in other cases on
certain kernel configurations.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/compat/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/backport/compat/Kconfig b/backport/compat/Kconfig
index 2dda9ac..91531c3 100644
--- a/backport/compat/Kconfig
+++ b/backport/compat/Kconfig
@@ -146,7 +146,7 @@ config BACKPORT_BUILD_DMA_SHARED_HELPERS
 
 config BACKPORT_BUILD_LEDS
 	bool
-	depends on !NEW_LEDS || !LEDS_CLASS || !LEDS_TRIGGERS
+	depends on !NEW_LEDS || LEDS_CLASS=n || !LEDS_TRIGGERS
 	default y if BACKPORT_NEW_LEDS
 	default y if BACKPORT_LEDS_CLASS
 	default y if BACKPORT_LEDS_TRIGGERS
-- 
1.8.5.3

