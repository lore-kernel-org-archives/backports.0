Return-path: <backports-owner@vger.kernel.org>
Received: from mail-da0-f47.google.com ([209.85.210.47]:44010 "EHLO
	mail-da0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752886Ab3DLGlM (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 12 Apr 2013 02:41:12 -0400
Received: by mail-da0-f47.google.com with SMTP id s35so1006243dak.6
        for <backports@vger.kernel.org>; Thu, 11 Apr 2013 23:41:11 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [RFC] backports: redefine srctree
Date: Thu, 11 Apr 2013 23:41:05 -0700
Message-Id: <1365748865-3132-1-git-send-email-mcgrof@do-not-panic.com> (sfid-20130412_084116_734066_D3C3238C)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

Drivers may do header sharing in their subsystems by
not using a full include path. There are different ways
folks append the include path, one strategy is to use
srctree as follows:

ccflags-y += -I$(srctree)/drivers/media/dvb-core/

Another example (for b2c2):

ccflags-y += -Idrivers/media/dvb-core/

The above gets fixed by the kernel through addtree which
prefixes -I with $(srctree) if it was not set. To take
advantage of the kernel's srctree but not break the build
we must lead it back in to the scripts/Makefile.build,
we do this by using our own scripts/Makefile.build that
points back to the kernel's.
---

Note: this breaks the kernel's build scripts that rely on
srctree so ideally we'd want to modify instead addtree but
I can't figure out how. Thoughts?

 backport/Makefile.kernel        |    2 ++
 backport/scripts/Makefile.build |    1 +
 2 files changed, 3 insertions(+)
 create mode 100644 backport/scripts/Makefile.build

diff --git a/backport/Makefile.kernel b/backport/Makefile.kernel
index 91e7dd6..12b5112 100644
--- a/backport/Makefile.kernel
+++ b/backport/Makefile.kernel
@@ -15,6 +15,8 @@ NOSTDINC_FLAGS := \
 	$(BACKPORTS_GIT_TRACKER_DEF) \
 	$(CFLAGS)
 
+srctree = $(M)
+
 obj-y += compat/
 
 obj-$(CPTCFG_CFG80211) += net/wireless/
diff --git a/backport/scripts/Makefile.build b/backport/scripts/Makefile.build
new file mode 100644
index 0000000..4c7498d
--- /dev/null
+++ b/backport/scripts/Makefile.build
@@ -0,0 +1 @@
+include $(KLIB_BUILD)/scripts/Makefile.build
-- 
1.7.10.4

