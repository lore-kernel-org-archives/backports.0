Return-path: <backports-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:59188 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753348AbaEHUkT (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 8 May 2014 16:40:19 -0400
Received: by mail-wi0-f174.google.com with SMTP id r20so330353wiv.13
        for <backports@vger.kernel.org>; Thu, 08 May 2014 13:40:18 -0700 (PDT)
From: Samuel Martin <s.martin49@gmail.com>
To: backports@vger.kernel.org
Cc: Samuel Martin <s.martin49@gmail.com>
Subject: [PATCH 02/10] backports: Makefile: introduce KVERSION and rework KLIB definition
Date: Thu,  8 May 2014 22:39:25 +0200
Message-Id: <1399581573-12072-3-git-send-email-s.martin49@gmail.com> (sfid-20140508_224021_406093_EDAAF47B)
In-Reply-To: <1399581573-12072-1-git-send-email-s.martin49@gmail.com>
References: <1399581573-12072-1-git-send-email-s.martin49@gmail.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Samuel Martin <s.martin49@gmail.com>
---
 backport/Makefile | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/backport/Makefile b/backport/Makefile
index 3ff74d9..e9256e4 100644
--- a/backport/Makefile
+++ b/backport/Makefile
@@ -12,10 +12,18 @@ KMODDIR ?= updates
 ifneq ($(origin KROOT), undefined)
 KMODPATH_ARG := "INSTALL_MOD_PATH=$(KROOT)"
 else
-KLIB := /lib/modules/$(shell uname -r)/
 KROOT := /
 KMODPATH_ARG :=
 endif
+
+ifneq ($(origin KLIB_BUILD), undefined)
+KVERSION := $(shell $(MAKE) -C $(KLIB_BUILD) $(if $(ARCH),ARCH=$(ARCH)) \
+	--no-print-directory -s kernelrelease)
+else
+KVERSION := $(shell uname -r)
+endif
+
+KLIB := $(KROOT)/lib/modules/$(KVERSION)
 KLIB_BUILD ?= $(KLIB)/build/
 KERNEL_CONFIG := $(KLIB_BUILD)/.config
 KERNEL_MAKEFILE := $(KLIB_BUILD)/Makefile
-- 
1.9.2

