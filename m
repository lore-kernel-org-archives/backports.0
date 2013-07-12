Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pb0-f47.google.com ([209.85.160.47]:60253 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932209Ab3GLBHx (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 11 Jul 2013 21:07:53 -0400
Received: by mail-pb0-f47.google.com with SMTP id rr13so8454091pbb.6
        for <backports@vger.kernel.org>; Thu, 11 Jul 2013 18:07:52 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH] backports: update README to include new subsystems
Date: Thu, 11 Jul 2013 18:07:47 -0700
Message-Id: <1373591267-14719-1-git-send-email-mcgrof@do-not-panic.com> (sfid-20130712_030756_318589_4676A2A8)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 README |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/README b/README
index 66e135f..2f03852 100644
--- a/README
+++ b/README
@@ -1,12 +1,16 @@
-# Linux driver backports package
+# Linux kernel backports package
 
 This package provides backport support for drivers from newer kernels
-down to older kernels. It currently backports 4 subsystems:
+down to older kernels. It currently backports the following subsystems:
 
   * Ethernet
   * Wireless
   * Bluetooth
+  * NFC
+  * ieee802154
   * GPU
+  * Media
+  * Regulator
 
 This package provides the latest Linux kernel subsystem enhancements
 for kernels 2.6.24 and above. It is technically possible to support
-- 
1.7.10.4

