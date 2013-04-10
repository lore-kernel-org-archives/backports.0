Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pb0-f45.google.com ([209.85.160.45]:54342 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751818Ab3DJLg4 (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 10 Apr 2013 07:36:56 -0400
Received: by mail-pb0-f45.google.com with SMTP id ro12so218294pbb.32
        for <backports@vger.kernel.org>; Wed, 10 Apr 2013 04:36:56 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 17/18] backports: use depmod -a
Date: Wed, 10 Apr 2013 04:35:27 -0700
Message-Id: <1365593728-5720-18-git-send-email-mcgrof@do-not-panic.com> (sfid-20130410_134305_435484_2B059C5D)
In-Reply-To: <1365593728-5720-1-git-send-email-mcgrof@do-not-panic.com>
References: <1365593728-5720-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

Use only depmod -a and at the same time tell the
user to reboot, we no longer support unloading /
loading for them given that we backport too many
modules.

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 backport/Makefile.real |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/backport/Makefile.real b/backport/Makefile.real
index 3eb92a7..f2b5b56 100644
--- a/backport/Makefile.real
+++ b/backport/Makefile.real
@@ -95,10 +95,8 @@ install: modules
 	done )
 	@./scripts/check_depmod
 	@./scripts/backport_firmware_install
-	@/sbin/depmod -ae
+	@/sbin/depmod -a
 	@echo
 	@echo Your backported driver modules should be installed now.
-	@echo Try loading them with modprobe.
+	@echo Reboot.
 	@echo
-# FIXME:
-#	install/load/unload/... scripts?
-- 
1.7.10.4

