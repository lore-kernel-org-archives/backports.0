Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:45664 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751889AbaBJM02 (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 10 Feb 2014 07:26:28 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.1:RSA_AES_128_CBC_SHA1:128)
	(Exim 4.82)
	(envelope-from <johannes@sipsolutions.net>)
	id 1WCpwR-0008CW-S1
	for backports@vger.kernel.org; Mon, 10 Feb 2014 13:26:28 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Subject: [PATCH v2] backports: conditionally access net/ieee802154/ with make
Date: Mon, 10 Feb 2014 13:26:26 +0100
Message-Id: <1392035186-12434-1-git-send-email-johannes@sipsolutions.net> (sfid-20140210_132630_911174_13325CC0)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

This essentially reverts commit cb6f08d3c38c as that caused
issues with copy-list - the scripting when generating the
backport can't prove that net/ieee802154/ isn't needed and
will try to go into it even if it wasn't copied.

Instead, make net/ieee802154/ be entered whenever it might
be needed - which is for CPTCFG_IEEE802154 and CPTCFG_BT.
This is harmless if the directory ends up listed twice but
will cause this problem to disappear.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/Makefile.kernel | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/backport/Makefile.kernel b/backport/Makefile.kernel
index 0f5ed6c..ada6dec 100644
--- a/backport/Makefile.kernel
+++ b/backport/Makefile.kernel
@@ -34,7 +34,8 @@ obj-$(CPTCFG_NFC) += drivers/nfc/
 obj-$(CPTCFG_REGULATOR) += drivers/regulator/
 obj-$(CPTCFG_MEDIA_SUPPORT) += drivers/media/
 
-obj-y += net/ieee802154/
+obj-$(CPTCFG_IEEE802154) += net/ieee802154/
+obj-$(CPTCFG_BT) += net/ieee802154/
 obj-$(CPTCFG_MAC802154) += net/mac802154/
 obj-$(CPTCFG_IEEE802154) += drivers/net/ieee802154/
 
-- 
1.8.5.3

