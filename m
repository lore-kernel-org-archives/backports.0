Return-path: <backports-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:49734 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755659AbaEHUk1 (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 8 May 2014 16:40:27 -0400
Received: by mail-wi0-f169.google.com with SMTP id hi2so1585190wib.4
        for <backports@vger.kernel.org>; Thu, 08 May 2014 13:40:26 -0700 (PDT)
From: Samuel Martin <s.martin49@gmail.com>
To: backports@vger.kernel.org
Cc: Samuel Martin <s.martin49@gmail.com>
Subject: [PATCH 07/10] backports: Makefile.real: disable update-initramfs.sh execution when cross-compiling
Date: Thu,  8 May 2014 22:39:30 +0200
Message-Id: <1399581573-12072-8-git-send-email-s.martin49@gmail.com> (sfid-20140508_224028_587259_2FBDD54B)
In-Reply-To: <1399581573-12072-1-git-send-email-s.martin49@gmail.com>
References: <1399581573-12072-1-git-send-email-s.martin49@gmail.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Samuel Martin <s.martin49@gmail.com>
---
 backport/Makefile.real | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/backport/Makefile.real b/backport/Makefile.real
index 1dc9323..2503016 100644
--- a/backport/Makefile.real
+++ b/backport/Makefile.real
@@ -102,7 +102,7 @@ install: modules
 		$(KVERSION) \
 		"$(shell sed -n '/^CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX=y/ s//_/p' \
 			$(KLIB_BUILD)/.config)"
-	@./scripts/update-initramfs.sh $(KLIB)
+	@test -n "$(CROSS_COMPILE)" || ./scripts/update-initramfs.sh $(KLIB)
 	@echo
 	@echo Your backported driver modules should be installed now.
 	@echo Reboot.
-- 
1.9.2

