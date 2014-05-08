Return-path: <backports-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:61372 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755663AbaEHUk3 (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 8 May 2014 16:40:29 -0400
Received: by mail-wg0-f51.google.com with SMTP id x13so3085826wgg.22
        for <backports@vger.kernel.org>; Thu, 08 May 2014 13:40:28 -0700 (PDT)
From: Samuel Martin <s.martin49@gmail.com>
To: backports@vger.kernel.org
Cc: Samuel Martin <s.martin49@gmail.com>
Subject: [PATCH 08/10] backports: Makefile.real: silent reboot message when cross-compiling
Date: Thu,  8 May 2014 22:39:31 +0200
Message-Id: <1399581573-12072-9-git-send-email-s.martin49@gmail.com> (sfid-20140508_224030_835397_BA84F71E)
In-Reply-To: <1399581573-12072-1-git-send-email-s.martin49@gmail.com>
References: <1399581573-12072-1-git-send-email-s.martin49@gmail.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Samuel Martin <s.martin49@gmail.com>
---
 backport/Makefile.real | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/backport/Makefile.real b/backport/Makefile.real
index 2503016..3be1913 100644
--- a/backport/Makefile.real
+++ b/backport/Makefile.real
@@ -103,10 +103,12 @@ install: modules
 		"$(shell sed -n '/^CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX=y/ s//_/p' \
 			$(KLIB_BUILD)/.config)"
 	@test -n "$(CROSS_COMPILE)" || ./scripts/update-initramfs.sh $(KLIB)
-	@echo
-	@echo Your backported driver modules should be installed now.
-	@echo Reboot.
-	@echo
+	@if test ! -n "$(CROSS_COMPILE)" ; then \
+		echo ; \
+		echo Your backported driver modules should be installed now. ; \
+		echo Reboot. ; \
+		echo ; \
+	fi
 
 .PHONY: modules_install
 modules_install: install
-- 
1.9.2

