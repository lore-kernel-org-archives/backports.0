Return-path: <backports-owner@vger.kernel.org>
Received: from mail-lb0-f193.google.com ([209.85.217.193]:62810 "EHLO
	mail-lb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755426Ab3DXCQx (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 23 Apr 2013 22:16:53 -0400
Received: by mail-lb0-f193.google.com with SMTP id p10so356390lbi.8
        for <backports@vger.kernel.org>; Tue, 23 Apr 2013 19:16:52 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 23 Apr 2013 19:16:51 -0700
Message-ID: <CAJqaZwyQN+66QK1kC5qiALwYAN4V6AmxEWC9kE9_4B-9GAnnfg@mail.gmail.com> (sfid-20130424_041656_207358_FC1077D8)
Subject: [Patch] compat-drivers/Makefile: make uninstall leaves drm and two
 b44 files
From: ASIC Felix <ic.felix@gmail.com>
To: mcgrof@kernel.org
Cc: backports@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

make uninstall doesn't remove drm and two b44 ethernet modules.

Signed-off-by: Felix Bitterli <ic.felix@gmail.com>
diff --git a/Makefile b/Makefile
index dc25969..dd16833 100644
--- a/Makefile
+++ b/Makefile
@@ -249,6 +249,15 @@ uninstall:
        @rm -f $(KLIB)/$(KMODDIR)/drivers/misc/eeprom/eeprom_93cx6.ko*
        @rm -f $(KLIB)/$(KMODDIR)/drivers/misc/eeprom_93cx6.ko*
        @rm -f $(KLIB)/$(KMODDIR)/drivers/net/b44.ko*
+       @rm -f $(KLIB)/$(KMODDIR)/drivers/net/ethernet/broadcom/b44.ko*
+       @rm -f $(KLIB)/$(KMODDIR)/drivers/bcma/bcma.ko*
+       @rm -f $(KLIB)/$(KMODDIR)/drivers/gpu/drm/drm_kms_helper.ko*
+       @rm -f $(KLIB)/$(KMODDIR)/drivers/gpu/drm/drm.ko*
+       @rm -f $(KLIB)/$(KMODDIR)/drivers/gpu/drm/i915/i915.ko*
+       @rm -f $(KLIB)/$(KMODDIR)/drivers/gpu/drm/nouveau/nouveau.ko*
+       @rm -f $(KLIB)/$(KMODDIR)/drivers/gpu/drm/radeon/radeon.ko*
+       @rm -f $(KLIB)/$(KMODDIR)/drivers/gpu/drm/ttm/ttm.ko*
+       @rm -f $(KLIB)/$(KMODDIR)/drivers/video/hdmi.ko*
        @/sbin/depmod -a
        @./scripts/update-initramfs
        @echo
