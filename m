Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <backports-owner@vger.kernel.org>
Received: from mail-ea0-f174.google.com ([209.85.215.174]:52665 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753937Ab2J1Rzy (ORCPT
	<rfc822;backports@vger.kernel.org>); Sun, 28 Oct 2012 13:55:54 -0400
Received: by mail-ea0-f174.google.com with SMTP id c13so1431140eaa.19
        for <backports@vger.kernel.org>; Sun, 28 Oct 2012 10:55:53 -0700 (PDT)
From: =?UTF-8?q?Ozan=20=C3=87a=C4=9Flayan?= <ozancag@gmail.com>
To: backports@vger.kernel.org
Cc: mcgrof@kernel.org,
	=?UTF-8?q?Ozan=20=C3=87a=C4=9Flayan?= <ozancag@gmail.com>
Subject: [PATCH 2/3] compat-drivers: drm: Revert ACPI table size check for < 3.6
Date: Sun, 28 Oct 2012 19:55:44 +0200
Message-Id: <1351446945-23717-2-git-send-email-ozancag@gmail.com>
In-Reply-To: <1351446945-23717-1-git-send-email-ozancag@gmail.com>
References: <1351446945-23717-1-git-send-email-ozancag@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

acpi_get_table_with_size() was exported with kernels >= 3.6. Revert the
size checking for kernels < 3.6.

Signed-off-by: Ozan Çağlayan <ozancag@gmail.com>
---
 .../10-radeon-revert-acpi-table-size-check.patch   | 29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 patches/drm/10-radeon-revert-acpi-table-size-check.patch

diff --git a/patches/drm/10-radeon-revert-acpi-table-size-check.patch b/patches/drm/10-radeon-revert-acpi-table-size-check.patch
new file mode 100644
index 0000000..d595a98
--- /dev/null
+++ b/patches/drm/10-radeon-revert-acpi-table-size-check.patch
@@ -0,0 +1,29 @@
+acpi_get_table_with_size() was exported with kernels >= 3.6. Revert the
+size checking for kernels < 3.6.
+
+Index: compat-drivers/drivers/gpu/drm/radeon/radeon_bios.c
+===================================================================
+--- compat-drivers.orig/drivers/gpu/drm/radeon/radeon_bios.c
++++ compat-drivers/drivers/gpu/drm/radeon/radeon_bios.c
+@@ -554,12 +554,21 @@ static bool radeon_acpi_vfct_bios(struct
+ {
+ 	bool ret = false;
+ 	struct acpi_table_header *hdr;
++#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0))
+ 	acpi_size tbl_size;
++#else
++	/* acpi_get_table_with_size() not exported on kernels < 3.6 */
++	acpi_size tbl_size = 0x7fffffff;
++#endif
+ 	UEFI_ACPI_VFCT *vfct;
+ 	GOP_VBIOS_CONTENT *vbios;
+ 	VFCT_IMAGE_HEADER *vhdr;
+ 
++#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0))
+ 	if (!ACPI_SUCCESS(acpi_get_table_with_size("VFCT", 1, &hdr, &tbl_size)))
++#else
++	if (!ACPI_SUCCESS(acpi_get_table("VFCT", 1, &hdr)))
++#endif
+ 		return false;
+ 	if (tbl_size < sizeof(UEFI_ACPI_VFCT)) {
+ 		DRM_ERROR("ACPI VFCT table present but broken (too short #1)\n");
-- 
1.7.11.7

