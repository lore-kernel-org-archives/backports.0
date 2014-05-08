Return-path: <backports-owner@vger.kernel.org>
Received: from mail-we0-f180.google.com ([74.125.82.180]:50124 "EHLO
	mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755656AbaEHUk0 (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 8 May 2014 16:40:26 -0400
Received: by mail-we0-f180.google.com with SMTP id t61so3005600wes.25
        for <backports@vger.kernel.org>; Thu, 08 May 2014 13:40:25 -0700 (PDT)
From: Samuel Martin <s.martin49@gmail.com>
To: backports@vger.kernel.org
Cc: Samuel Martin <s.martin49@gmail.com>
Subject: [PATCH 06/10] backports: Makefile.real: use depmod.sh instead of the depmod program
Date: Thu,  8 May 2014 22:39:29 +0200
Message-Id: <1399581573-12072-7-git-send-email-s.martin49@gmail.com> (sfid-20140508_224027_628480_AF15E21C)
In-Reply-To: <1399581573-12072-1-git-send-email-s.martin49@gmail.com>
References: <1399581573-12072-1-git-send-email-s.martin49@gmail.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Call depmod.sh from the kernel source tree and set all parameter to
improve cross-compilation support.

This way, target root location, kernel version and symbol prefix are
also handled.

Signed-off-by: Samuel Martin <s.martin49@gmail.com>
---
 backport/Makefile.real | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/backport/Makefile.real b/backport/Makefile.real
index a12a0db..1dc9323 100644
--- a/backport/Makefile.real
+++ b/backport/Makefile.real
@@ -97,7 +97,11 @@ install: modules
 	@./scripts/blacklist.sh $(KLIB)/ $(KLIB)/$(KMODDIR) $(KROOT)
 	@./scripts/compress_modules.sh $(KLIB)/$(KMODDIR)
 	@./scripts/check_depmod.sh $(DEPMOD) $(KROOT)
-	@$(DEPMOD) -a
+	@$(KMODPATH_ARGS) $(KLIB_BUILD)/scripts/depmod.sh \
+		$(DEPMOD) \
+		$(KVERSION) \
+		"$(shell sed -n '/^CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX=y/ s//_/p' \
+			$(KLIB_BUILD)/.config)"
 	@./scripts/update-initramfs.sh $(KLIB)
 	@echo
 	@echo Your backported driver modules should be installed now.
-- 
1.9.2

