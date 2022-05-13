Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11DF8C433F5
	for <backports@archiver.kernel.org>; Fri, 13 May 2022 16:06:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382332AbiEMQGd (ORCPT <rfc822;backports@archiver.kernel.org>);
        Fri, 13 May 2022 12:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382333AbiEMQGb (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 13 May 2022 12:06:31 -0400
Received: from web.adapt-ip.com (mail.adapt-ip.com [107.194.246.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3E13617F
        for <backports@vger.kernel.org>; Fri, 13 May 2022 09:06:27 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id 59FE46E3A79;
        Fri, 13 May 2022 16:06:27 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id NhagFuXUlQox; Fri, 13 May 2022 16:06:24 +0000 (UTC)
Received: from atlas.campbell.adapt-ip.com (c-73-162-155-239.hsd1.ca.comcast.net [73.162.155.239])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id E358F6E3A82;
        Fri, 13 May 2022 16:05:30 +0000 (UTC)
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     backports <backports@vger.kernel.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Thomas Pedersen <thomas@adapt-ip.com>
Subject: [PATCH v2 14/15] integration-patches: support 5.4 target kernel
Date:   Fri, 13 May 2022 09:05:22 -0700
Message-Id: <20220513160523.2944694-15-thomas@adapt-ip.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220513160523.2944694-1-thomas@adapt-ip.com>
References: <20220513160523.2944694-1-thomas@adapt-ip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

Signed-off-by: Thomas Pedersen <thomas@adapt-ip.com>
---
 .../0001-enable-backports-built-in.patch      | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 integration-patches/5.4/0001-enable-backports/0001-enable-backports-built-in.patch

diff --git a/integration-patches/5.4/0001-enable-backports/0001-enable-backports-built-in.patch b/integration-patches/5.4/0001-enable-backports/0001-enable-backports-built-in.patch
new file mode 100644
index 000000000000..f086e5412672
--- /dev/null
+++ b/integration-patches/5.4/0001-enable-backports/0001-enable-backports-built-in.patch
@@ -0,0 +1,40 @@
+diff --git a/Makefile b/Makefile
+index d4d36c61940b..ad559055bacf 100644
+--- a/Makefile
++++ b/Makefile
+@@ -616,6 +616,7 @@ endif
+ ifeq ($(KBUILD_EXTMOD),)
+ # Objects we will link into vmlinux / subdirs we need to visit
+ init-y		:= init/
++backports-y 	:= backports/
+ drivers-y	:= drivers/ sound/
+ drivers-$(CONFIG_SAMPLES) += samples/
+ drivers-$(CONFIG_KERNEL_HEADER_TEST) += include/
+@@ -1017,15 +1018,17 @@ core-y		+= kernel/ certs/ mm/ fs/ ipc/ security/ crypto/ block/
+ 
+ vmlinux-dirs	:= $(patsubst %/,%,$(filter %/, $(init-y) $(init-m) \
+ 		     $(core-y) $(core-m) $(drivers-y) $(drivers-m) \
++		     $(backports-y) $(backports-m) \
+ 		     $(net-y) $(net-m) $(libs-y) $(libs-m) $(virt-y)))
+ 
+ vmlinux-alldirs	:= $(sort $(vmlinux-dirs) Documentation \
+ 		     $(patsubst %/,%,$(filter %/, $(init-) $(core-) \
+-			$(drivers-) $(net-) $(libs-) $(virt-))))
++			$(drivers-) $(net-) $(libs-) $(virt-) $(backports))))
+ 
+ build-dirs	:= $(vmlinux-dirs)
+ clean-dirs	:= $(vmlinux-alldirs)
+ 
++backports-y	:= $(patsubst %/, %/built-in.a, $(backports-y))
+ init-y		:= $(patsubst %/, %/built-in.a, $(init-y))
+ core-y		:= $(patsubst %/, %/built-in.a, $(core-y))
+ drivers-y	:= $(patsubst %/, %/built-in.a, $(drivers-y))
+@@ -1036,7 +1039,7 @@ virt-y		:= $(patsubst %/, %/built-in.a, $(virt-y))
+ 
+ # Externally visible symbols (used by link-vmlinux.sh)
+ export KBUILD_VMLINUX_OBJS := $(head-y) $(init-y) $(core-y) $(libs-y2) \
+-			      $(drivers-y) $(net-y) $(virt-y)
++			      $(drivers-y) $(net-y) $(virt-y) $(backports-y)
+ export KBUILD_VMLINUX_LIBS := $(libs-y1)
+ export KBUILD_LDS          := arch/$(SRCARCH)/kernel/vmlinux.lds
+ export LDFLAGS_vmlinux
-- 
2.30.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
