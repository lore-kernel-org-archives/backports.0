Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EDD0C433F5
	for <backports@archiver.kernel.org>; Wed, 24 Nov 2021 06:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233758AbhKXGDm (ORCPT <rfc822;backports@archiver.kernel.org>);
        Wed, 24 Nov 2021 01:03:42 -0500
Received: from mail.adapt-ip.com ([107.194.246.123]:56632 "EHLO
        web.adapt-ip.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233411AbhKXGDm (ORCPT
        <rfc822;backports@vger.kernel.org>); Wed, 24 Nov 2021 01:03:42 -0500
X-Greylist: delayed 322 seconds by postgrey-1.27 at vger.kernel.org; Wed, 24 Nov 2021 01:03:42 EST
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id E3978744D60;
        Wed, 24 Nov 2021 05:55:09 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id GSTnyP74lslO; Wed, 24 Nov 2021 05:55:06 +0000 (UTC)
Received: from atlas.campbell.adapt-ip.com (c-67-180-239-163.hsd1.ca.comcast.net [67.180.239.163])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id 45384744D67;
        Wed, 24 Nov 2021 05:55:06 +0000 (UTC)
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     backports <backports@vger.kernel.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        Luis Rodriguez <mcgrof@kernel.org>,
        Thomas Pedersen <thomas@ibsgaard.io>,
        Thomas Pedersen <thomas@adapt-ip.com>
Subject: [PATCH 1/7] backport: refresh integration patch
Date:   Tue, 23 Nov 2021 21:54:59 -0800
Message-Id: <20211124055505.1267128-2-thomas@adapt-ip.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211124055505.1267128-1-thomas@adapt-ip.com>
References: <20211124055505.1267128-1-thomas@adapt-ip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

From: Thomas Pedersen <thomas@ibsgaard.io>

This was refreshed on Linux v5-10.42.

Signed-off-by: Thomas Pedersen <thomas@adapt-ip.com>
---
 .../0001-enable-backports-built-in.patch      | 34 ++++++++-----------
 1 file changed, 15 insertions(+), 19 deletions(-)

diff --git a/integration-patches/0001-enable-backports/0001-enable-backports-built-in.patch b/integration-patches/0001-enable-backports/0001-enable-backports-built-in.patch
index d66b203d0d07..35765ed113eb 100644
--- a/integration-patches/0001-enable-backports/0001-enable-backports-built-in.patch
+++ b/integration-patches/0001-enable-backports/0001-enable-backports-built-in.patch
@@ -1,40 +1,36 @@
-Allow backports to be integrated into vmlinux.
-
 diff --git a/Makefile b/Makefile
-index 6d1e304..de26b18 100644
+index e5d41b6792d7..cdd600bda9d1 100644
 --- a/Makefile
 +++ b/Makefile
-@@ -542,6 +542,7 @@ scripts: scripts_basic include/config/auto.conf include/config/tristate.conf \
- 	$(Q)$(MAKE) $(build)=$(@)
+@@ -594,6 +594,7 @@ export KBUILD_MODULES KBUILD_BUILTIN
  
+ ifeq ($(KBUILD_EXTMOD),)
  # Objects we will link into vmlinux / subdirs we need to visit
 +backports-y 	:= backports/
  init-y		:= init/
  drivers-y	:= drivers/ sound/ firmware/
  net-y		:= net/
-@@ -820,13 +821,16 @@ core-y		+= kernel/ mm/ fs/ ipc/ security/ crypto/ block/
+@@ -989,11 +990,13 @@ core-y		+= kernel/ certs/ mm/ fs/ ipc/ security/ crypto/ block/
  
  vmlinux-dirs	:= $(patsubst %/,%,$(filter %/, $(init-y) $(init-m) \
  		     $(core-y) $(core-m) $(drivers-y) $(drivers-m) \
 +		     $(backports-y) $(backports-m) \
- 		     $(net-y) $(net-m) $(libs-y) $(libs-m)))
+ 		     $(net-y) $(net-m) $(libs-y) $(libs-m) $(virt-y)))
  
  vmlinux-alldirs	:= $(sort $(vmlinux-dirs) $(patsubst %/,%,$(filter %/, \
- 		     $(init-n) $(init-) \
- 		     $(core-n) $(core-) $(drivers-n) $(drivers-) \
-+		     $(backports-n) $(backports-) \
- 		     $(net-n)  $(net-)  $(libs-n)    $(libs-))))
+-		     $(init-) $(core-) $(drivers-) $(net-) $(libs-) $(virt-))))
++		     $(init-) $(core-) $(drivers-) $(net-) $(libs-) $(virt-) $(backports))))
  
-+backports-y	:= $(patsubst %/, %/built-in.o, $(backports-y))
- init-y		:= $(patsubst %/, %/built-in.o, $(init-y))
- core-y		:= $(patsubst %/, %/built-in.o, $(core-y))
- drivers-y	:= $(patsubst %/, %/built-in.o, $(drivers-y))
-@@ -837,7 +841,7 @@ libs-y		:= $(libs-y1) $(libs-y2)
++backports-y	:= $(patsubst %/, %/built-in.a, $(backports-y))
+ init-y		:= $(patsubst %/, %/built-in.a, $(init-y))
+ core-y		:= $(patsubst %/, %/built-in.a, $(core-y))
+ drivers-y	:= $(patsubst %/, %/built-in.a, $(drivers-y))
+@@ -1004,7 +1007,7 @@ virt-y		:= $(patsubst %/, %/built-in.a, $(virt-y))
  
  # Externally visible symbols (used by link-vmlinux.sh)
  export KBUILD_VMLINUX_INIT := $(head-y) $(init-y)
--export KBUILD_VMLINUX_MAIN := $(core-y) $(libs-y) $(drivers-y) $(net-y)
-+export KBUILD_VMLINUX_MAIN := $(core-y) $(libs-y) $(drivers-y) $(net-y) $(backports-y)
+-export KBUILD_VMLINUX_MAIN := $(core-y) $(libs-y2) $(drivers-y) $(net-y) $(virt-y)
++export KBUILD_VMLINUX_MAIN := $(core-y) $(libs-y2) $(drivers-y) $(net-y) $(virt-y) $(backports-y)
+ export KBUILD_VMLINUX_LIBS := $(libs-y1)
  export KBUILD_LDS          := arch/$(SRCARCH)/kernel/vmlinux.lds
  export LDFLAGS_vmlinux
- # used by scripts/pacmage/Makefile
-- 
2.30.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
