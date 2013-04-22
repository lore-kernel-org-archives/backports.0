Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <ic.felix@gmail.com>
MIME-Version: 1.0
Date: Sun, 21 Apr 2013 21:29:23 -0700
Message-ID: <CAJqaZwxq8DRUuQJ+376U+_dkS-+rkzTU8+7NWWLJzSJxk_EPzA@mail.gmail.com>
Subject: [Patch] compat-drivers/Makefile: make uninstall leaves drm and two
 b44 files
From: ASIC Felix <ic.felix@gmail.com>
To: mcgrof@kernel.org
Cc: backports@vger.kernel.org
Content-Type: multipart/alternative; boundary=047d7b3a85a260a53404daeb83a6
List-ID: <backports@vger.kernel.org>

--047d7b3a85a260a53404daeb83a6
Content-Type: text/plain; charset=UTF-8

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

--047d7b3a85a260a53404daeb83a6
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">make uninstall doesn&#39;t remove drm and two b44 ethernet=
 modules.<br><div><br>Signed-off-by: Felix Bitterli &lt;<a href=3D"mailto:i=
c.felix@gmail.com">ic.felix@gmail.com</a>&gt;<br>diff --git a/Makefile b/Ma=
kefile<br>
index dc25969..dd16833 100644<br>--- a/Makefile<br>+++ b/Makefile<br>@@ -24=
9,6 +249,15 @@ uninstall:<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 @rm=
 -f $(KLIB)/$(KMODDIR)/drivers/misc/eeprom/eeprom_93cx6.ko*<br>=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 @rm -f $(KLIB)/$(KMODDIR)/drivers/misc/eepro=
m_93cx6.ko*<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 @rm -f $(KLIB)/$(KMODDIR)/driver=
s/net/b44.ko*<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 @rm -f $(KLIB)/$(KMO=
DDIR)/drivers/net/ethernet/broadcom/b44.ko*<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 @rm -f $(KLIB)/$(KMODDIR)/drivers/bcma/bcma.ko*<br>+=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 @rm -f $(KLIB)/$(KMODDIR)/drivers/gpu/drm/drm_kms_=
helper.ko*<br>
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 @rm -f $(KLIB)/$(KMODDIR)/drivers/gpu=
/drm/drm.ko*<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 @rm -f $(KLIB)/$(KMOD=
DIR)/drivers/gpu/drm/i915/i915.ko*<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 @rm -f $(KLIB)/$(KMODDIR)/drivers/gpu/drm/nouveau/nouveau.ko*<br>+=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 @rm -f $(KLIB)/$(KMODDIR)/drivers/gpu/drm/ra=
deon/radeon.ko*<br>
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 @rm -f $(KLIB)/$(KMODDIR)/drivers/gpu=
/drm/ttm/ttm.ko*<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 @rm -f $(KLIB)/$(=
KMODDIR)/drivers/video/hdmi.ko*<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 @/sbin/depmod -a<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 @./scrip=
ts/update-initramfs<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 @echo <br=
><br></div></div>

--047d7b3a85a260a53404daeb83a6--
