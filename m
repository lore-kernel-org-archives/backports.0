Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:62951 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753215Ab3EPWaO (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 16 May 2013 18:30:14 -0400
Received: by mail-pd0-f173.google.com with SMTP id v10so2750333pde.18
        for <backports@vger.kernel.org>; Thu, 16 May 2013 15:30:13 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 1/2] backports: address nouveau file shuffling
Date: Thu, 16 May 2013 15:30:03 -0700
Message-Id: <1368743404-30324-2-git-send-email-mcgrof@do-not-panic.com> (sfid-20130517_003016_532608_77149864)
In-Reply-To: <1368743404-30324-1-git-send-email-mcgrof@do-not-panic.com>
References: <1368743404-30324-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

The recent file shuffling on nouveau requires some
changes not upstream to get it to compile to ensure
some objects do get interpreted as requiring the
new search path.

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 .../collateral-evolutions/drm/13-nouveau-include-fix/INFO   |    2 ++
 .../drivers_gpu_drm_nouveau_Makefile.patch                  |   11 +++++++++++
 2 files changed, 13 insertions(+)
 create mode 100644 patches/collateral-evolutions/drm/13-nouveau-include-fix/INFO
 create mode 100644 patches/collateral-evolutions/drm/13-nouveau-include-fix/drivers_gpu_drm_nouveau_Makefile.patch

diff --git a/patches/collateral-evolutions/drm/13-nouveau-include-fix/INFO b/patches/collateral-evolutions/drm/13-nouveau-include-fix/INFO
new file mode 100644
index 0000000..9fda4df
--- /dev/null
+++ b/patches/collateral-evolutions/drm/13-nouveau-include-fix/INFO
@@ -0,0 +1,2 @@
+The headers are not being picked up and require
+ensuring we are pointing to our backport selection.
diff --git a/patches/collateral-evolutions/drm/13-nouveau-include-fix/drivers_gpu_drm_nouveau_Makefile.patch b/patches/collateral-evolutions/drm/13-nouveau-include-fix/drivers_gpu_drm_nouveau_Makefile.patch
new file mode 100644
index 0000000..dace69b
--- /dev/null
+++ b/patches/collateral-evolutions/drm/13-nouveau-include-fix/drivers_gpu_drm_nouveau_Makefile.patch
@@ -0,0 +1,11 @@
+--- a/drivers/gpu/drm/nouveau/Makefile
++++ b/drivers/gpu/drm/nouveau/Makefile
+@@ -2,7 +2,7 @@
+ # Makefile for the drm device driver.  This driver provides support for the
+ # Direct Rendering Infrastructure (DRI) in XFree86 4.1.0 and higher.
+ 
+-ccflags-y := -Iinclude/drm
++ccflags-y += -I$(backport_srctree)/include/drm
+ ccflags-y += -I$(src)/core/include
+ ccflags-y += -I$(src)/core
+ ccflags-y += -I$(src)
-- 
1.7.10.4

