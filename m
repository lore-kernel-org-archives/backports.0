Return-path: <backports-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:52904 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754465Ab3EKA1f (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 10 May 2013 20:27:35 -0400
Received: by mail-ie0-f178.google.com with SMTP id b11so9435853iee.9
        for <backports@vger.kernel.org>; Fri, 10 May 2013 17:27:35 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 05/12] backports: remove brcmsmac / brcmutil Makefile patches
Date: Fri, 10 May 2013 17:26:56 -0700
Message-Id: <1368232023-23817-6-git-send-email-mcgrof@do-not-panic.com> (sfid-20130511_022736_834639_B960A4A7)
In-Reply-To: <1368232023-23817-1-git-send-email-mcgrof@do-not-panic.com>
References: <1368232023-23817-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

These are now upstream thanks to commit 8e8d4ff0 on
next-20130415.

commit 8e8d4ff051672d4a2939e7d6925c4acd234b0220
Author: Johannes Berg <johannes.berg@intel.com>
Date:   Thu Apr 11 16:15:28 2013 +0200

    brcm80211: simplify makefiles

    This came up during my backporting work but it seems
    perfectly appropriate for the kernel as well.

    Signed-off-by: Johannes Berg <johannes.berg@intel.com>
    Acked-by: Arend van Spriel <arend@broadcom.com>
    Signed-off-by: John W. Linville <linville@tuxdriver.com>

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 .../network/72-brcm80211-makefiles/brcmsmac.patch  |   25 --------------------
 .../network/72-brcm80211-makefiles/brcmutil.patch  |   15 ------------
 2 files changed, 40 deletions(-)
 delete mode 100644 patches/collateral-evolutions/network/72-brcm80211-makefiles/brcmsmac.patch
 delete mode 100644 patches/collateral-evolutions/network/72-brcm80211-makefiles/brcmutil.patch

diff --git a/patches/collateral-evolutions/network/72-brcm80211-makefiles/brcmsmac.patch b/patches/collateral-evolutions/network/72-brcm80211-makefiles/brcmsmac.patch
deleted file mode 100644
index 112c769..0000000
--- a/patches/collateral-evolutions/network/72-brcm80211-makefiles/brcmsmac.patch
+++ /dev/null
@@ -1,25 +0,0 @@
---- a/drivers/net/wireless/brcm80211/brcmsmac/Makefile
-+++ b/drivers/net/wireless/brcm80211/brcmsmac/Makefile
-@@ -21,7 +21,7 @@ ccflags-y := \
- 	-Idrivers/net/wireless/brcm80211/brcmsmac/phy \
- 	-Idrivers/net/wireless/brcm80211/include
- 
--BRCMSMAC_OFILES := \
-+brcmsmac-y := \
- 	mac80211_if.o \
- 	ucode_loader.o \
- 	ampdu.o \
-@@ -43,11 +43,6 @@ BRCMSMAC_OFILES := \
- 	brcms_trace_events.o \
- 	debug.o
- 
--ifdef CONFIG_BCMA_DRIVER_GPIO
--BRCMSMAC_OFILES += led.o
--endif
-+brcmsmac-$(CONFIG_BCMA_DRIVER_GPIO) += led.o
- 
--MODULEPFX := brcmsmac
--
--obj-$(CONFIG_BRCMSMAC)	+= $(MODULEPFX).o
--$(MODULEPFX)-objs	= $(BRCMSMAC_OFILES)
-+obj-$(CONFIG_BRCMSMAC)	+= brcmsmac.o
diff --git a/patches/collateral-evolutions/network/72-brcm80211-makefiles/brcmutil.patch b/patches/collateral-evolutions/network/72-brcm80211-makefiles/brcmutil.patch
deleted file mode 100644
index 3b84733..0000000
--- a/patches/collateral-evolutions/network/72-brcm80211-makefiles/brcmutil.patch
+++ /dev/null
@@ -1,15 +0,0 @@
---- a/drivers/net/wireless/brcm80211/brcmutil/Makefile
-+++ b/drivers/net/wireless/brcm80211/brcmutil/Makefile
-@@ -19,10 +19,5 @@ ccflags-y :=				\
- 	-Idrivers/net/wireless/brcm80211/brcmutil \
- 	-Idrivers/net/wireless/brcm80211/include
- 
--BRCMUTIL_OFILES := \
--	utils.o
--
--MODULEPFX := brcmutil
--
--obj-$(CONFIG_BRCMUTIL)	+= $(MODULEPFX).o
--$(MODULEPFX)-objs	= $(BRCMUTIL_OFILES)
-+obj-$(CONFIG_BRCMUTIL)	+= brcmutil.o
-+brcmutil-objs	= utils.o
-- 
1.7.10.4

