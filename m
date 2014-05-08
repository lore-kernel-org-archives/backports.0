Return-path: <backports-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:49756 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753348AbaEHUkV (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 8 May 2014 16:40:21 -0400
Received: by mail-wi0-f176.google.com with SMTP id n15so337418wiw.3
        for <backports@vger.kernel.org>; Thu, 08 May 2014 13:40:20 -0700 (PDT)
From: Samuel Martin <s.martin49@gmail.com>
To: backports@vger.kernel.org
Cc: Samuel Martin <s.martin49@gmail.com>
Subject: [PATCH 03/10] backports: Makefile: export KROOT and KVERSION variables
Date: Thu,  8 May 2014 22:39:26 +0200
Message-Id: <1399581573-12072-4-git-send-email-s.martin49@gmail.com> (sfid-20140508_224022_567742_1482419F)
In-Reply-To: <1399581573-12072-1-git-send-email-s.martin49@gmail.com>
References: <1399581573-12072-1-git-send-email-s.martin49@gmail.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Samuel Martin <s.martin49@gmail.com>
---
 backport/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/backport/Makefile b/backport/Makefile
index e9256e4..2f446e6 100644
--- a/backport/Makefile
+++ b/backport/Makefile
@@ -29,7 +29,7 @@ KERNEL_CONFIG := $(KLIB_BUILD)/.config
 KERNEL_MAKEFILE := $(KLIB_BUILD)/Makefile
 CONFIG_MD5 := $(shell md5sum $(KERNEL_CONFIG) 2>/dev/null | sed 's/\s.*//')
 
-export KLIB KLIB_BUILD BACKPORT_PWD KMODDIR KMODPATH_ARG
+export KLIB KLIB_BUILD BACKPORT_PWD KMODDIR KMODPATH_ARG KROOT KVERSION
 
 # disable built-in rules for this file
 .SUFFIXES:
-- 
1.9.2

