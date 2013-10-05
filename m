Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:50894 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752325Ab3JEWot (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 5 Oct 2013 18:44:49 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, ozancag@gmail.com,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [RFC 07/15] backports: remove more hdmi stuff
Date: Sun,  6 Oct 2013 00:43:56 +0200
Message-Id: <1381013044-7724-8-git-send-email-hauke@hauke-m.de> (sfid-20131006_004450_876151_6B126E17)
In-Reply-To: <1381013044-7724-1-git-send-email-hauke@hauke-m.de>
References: <1381013044-7724-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This was only needed for some of the DRM drivers, remove it.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/hdmi.h |   36 ----------------------
 backport/compat/backport-3.12.c        |   51 --------------------------------
 2 files changed, 87 deletions(-)
 delete mode 100644 backport/backport-include/linux/hdmi.h

diff --git a/backport/backport-include/linux/hdmi.h b/backport/backport-include/linux/hdmi.h
deleted file mode 100644
index 41a5387..0000000
--- a/backport/backport-include/linux/hdmi.h
+++ /dev/null
@@ -1,36 +0,0 @@
-#ifndef __BACKPORT_LINUX_HDMI_H
-#define __BACKPORT_LINUX_HDMI_H
-#include_next <linux/hdmi.h>
-
-#include <linux/version.h>
-
-/* on kernel < 3.9 hdmi gets backported */
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,9,0)
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,12,0)
-
-struct hdmi_any_infoframe {
-	enum hdmi_infoframe_type type;
-	unsigned char version;
-	unsigned char length;
-};
-
-union hdmi_infoframe {
-	struct hdmi_any_infoframe any;
-	struct hdmi_avi_infoframe avi;
-	struct hdmi_spd_infoframe spd;
-	struct hdmi_vendor_infoframe vendor;
-	struct hdmi_audio_infoframe audio;
-};
-
-#define hdmi_infoframe_pack LINUX_BACKPORT(hdmi_infoframe_pack)
-ssize_t
-hdmi_infoframe_pack(union hdmi_infoframe *frame, void *buffer, size_t size);
-#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,12,0)*/ 
-#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,9,0) */
-
-#ifndef HDMI_INFOFRAME_SIZE
-#define HDMI_INFOFRAME_SIZE(type)	\
-	(HDMI_INFOFRAME_HEADER_SIZE + HDMI_ ## type ## _INFOFRAME_SIZE)
-#endif
-
-#endif /* __BACKPORT_LINUX_HDMI_H */
diff --git a/backport/compat/backport-3.12.c b/backport/compat/backport-3.12.c
index 44b98f1..7e3dc58 100644
--- a/backport/compat/backport-3.12.c
+++ b/backport/compat/backport-3.12.c
@@ -27,54 +27,3 @@ u8 *hid_alloc_report_buf(struct hid_report *report, gfp_t flags)
 	return kmalloc(len, flags);
 }
 EXPORT_SYMBOL_GPL(hid_alloc_report_buf);
-
-#ifdef CONFIG_HDMI
-
-/* on older kernel versions we backport hdmi completely. */
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,9,0)
-
-#include <linux/hdmi.h>
-
-/**
- * hdmi_infoframe_pack() - write a HDMI infoframe to binary buffer
- * @frame: HDMI infoframe
- * @buffer: destination buffer
- * @size: size of buffer
- *
- * Packs the information contained in the @frame structure into a binary
- * representation that can be written into the corresponding controller
- * registers. Also computes the checksum as required by section 5.3.5 of
- * the HDMI 1.4 specification.
- *
- * Returns the number of bytes packed into the binary buffer or a negative
- * error code on failure.
- */
-ssize_t
-hdmi_infoframe_pack(union hdmi_infoframe *frame, void *buffer, size_t size)
-{
-	ssize_t length;
-
-	switch (frame->any.type) {
-	case HDMI_INFOFRAME_TYPE_AVI:
-		length = hdmi_avi_infoframe_pack(&frame->avi, buffer, size);
-		break;
-	case HDMI_INFOFRAME_TYPE_SPD:
-		length = hdmi_spd_infoframe_pack(&frame->spd, buffer, size);
-		break;
-	case HDMI_INFOFRAME_TYPE_AUDIO:
-		length = hdmi_audio_infoframe_pack(&frame->audio, buffer, size);
-		break;
-	case HDMI_INFOFRAME_TYPE_VENDOR:
-		length = hdmi_vendor_infoframe_pack(&frame->vendor,
-						    buffer, size);
-		break;
-	default:
-		WARN(1, "Bad infoframe type %d\n", frame->any.type);
-		length = -EINVAL;
-	}
-
-	return length;
-}
-EXPORT_SYMBOL(hdmi_infoframe_pack);
-#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,9,0) */
-#endif /* CONFIG_HDMI*/
-- 
1.7.10.4

