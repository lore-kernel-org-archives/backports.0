Return-path: <backports-owner@vger.kernel.org>
Received: from mail-lb0-f195.google.com ([209.85.217.195]:54375 "EHLO
	mail-lb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750727Ab3D0ESu (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 27 Apr 2013 00:18:50 -0400
Received: by mail-lb0-f195.google.com with SMTP id 13so618404lba.10
        for <backports@vger.kernel.org>; Fri, 26 Apr 2013 21:18:49 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 26 Apr 2013 21:18:49 -0700
Message-ID: <CAJqaZwwH6HQqd0m9QO-Noc+SUAx79pHoSNWGfysei1Zgr9K4+g@mail.gmail.com> (sfid-20130427_061854_046583_D781CADE)
Subject: [PATCH v2] compat-drivers/Makefile: make uninstall leaves drm and two
 b44 files
From: ASIC Felix <ic.felix@gmail.com>
To: mcgrof@kernel.org
Cc: backports@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

make uninstall doesn't remove drm and two b44 ethernet modules.

Signed-off-by: Felix Bitterli <ic.felix@gmail.com>

---
 Makefile |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Makefile b/Makefile
index dc25969..dd16833 100644
--- a/Makefile
+++ b/Makefile
@@ -249,6 +249,15 @@ uninstall:
     @rm -f $(KLIB)/$(KMODDIR)/drivers/misc/eeprom/eeprom_93cx6.ko*
     @rm -f $(KLIB)/$(KMODDIR)/drivers/misc/eeprom_93cx6.ko*
     @rm -f $(KLIB)/$(KMODDIR)/drivers/net/b44.ko*
+    @rm -f $(KLIB)/$(KMODDIR)/drivers/net/ethernet/broadcom/b44.ko*
+    @rm -f $(KLIB)/$(KMODDIR)/drivers/bcma/bcma.ko*
+    @rm -f $(KLIB)/$(KMODDIR)/drivers/gpu/drm/drm_kms_helper.ko*
+    @rm -f $(KLIB)/$(KMODDIR)/drivers/gpu/drm/drm.ko*
+    @rm -f $(KLIB)/$(KMODDIR)/drivers/gpu/drm/i915/i915.ko*
+    @rm -f $(KLIB)/$(KMODDIR)/drivers/gpu/drm/nouveau/nouveau.ko*
+    @rm -f $(KLIB)/$(KMODDIR)/drivers/gpu/drm/radeon/radeon.ko*
+    @rm -f $(KLIB)/$(KMODDIR)/drivers/gpu/drm/ttm/ttm.ko*
+    @rm -f $(KLIB)/$(KMODDIR)/drivers/video/hdmi.ko*
     @/sbin/depmod -a
     @./scripts/update-initramfs
     @echo
