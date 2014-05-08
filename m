Return-path: <backports-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:50362 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753348AbaEHUkQ (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 8 May 2014 16:40:16 -0400
Received: by mail-wi0-f169.google.com with SMTP id hi2so1585990wib.2
        for <backports@vger.kernel.org>; Thu, 08 May 2014 13:40:15 -0700 (PDT)
From: Samuel Martin <s.martin49@gmail.com>
To: backports@vger.kernel.org
Cc: Samuel Martin <s.martin49@gmail.com>
Subject: [PATCH 01/10] backports: Makefile: introduce KROOT and fix INSTALL_MOD_PATH definition
Date: Thu,  8 May 2014 22:39:24 +0200
Message-Id: <1399581573-12072-2-git-send-email-s.martin49@gmail.com> (sfid-20140508_224017_790702_021705A6)
In-Reply-To: <1399581573-12072-1-git-send-email-s.martin49@gmail.com>
References: <1399581573-12072-1-git-send-email-s.martin49@gmail.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

INSTALL_MOD_PATH should point to the root directory of the target
rootfs, what is KROOT.

Signed-off-by: Samuel Martin <s.martin49@gmail.com>
---
 backport/Makefile | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/backport/Makefile b/backport/Makefile
index ea3982b..3ff74d9 100644
--- a/backport/Makefile
+++ b/backport/Makefile
@@ -9,10 +9,11 @@ SHELL := /bin/bash
 BACKPORT_PWD := $(shell pwd)
 
 KMODDIR ?= updates
-ifneq ($(origin KLIB), undefined)
-KMODPATH_ARG := "INSTALL_MOD_PATH=$(KLIB)"
+ifneq ($(origin KROOT), undefined)
+KMODPATH_ARG := "INSTALL_MOD_PATH=$(KROOT)"
 else
 KLIB := /lib/modules/$(shell uname -r)/
+KROOT := /
 KMODPATH_ARG :=
 endif
 KLIB_BUILD ?= $(KLIB)/build/
-- 
1.9.2

