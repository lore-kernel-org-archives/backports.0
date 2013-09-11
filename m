Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:40698 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751284Ab3IKMMQ (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 11 Sep 2013 08:12:16 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 02/11] backports: add hdmi_infoframe_pack()
Date: Wed, 11 Sep 2013 14:11:46 +0200
Message-Id: <1378901515-14206-3-git-send-email-hauke@hauke-m.de> (sfid-20130911_141218_692342_4846A16B)
In-Reply-To: <1378901515-14206-1-git-send-email-hauke@hauke-m.de>
References: <1378901515-14206-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This adds the missing function hdmi_infoframe_pack() for kernels where
the HDMI subsystem is not backported, like all kernel >= 3.9.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/hdmi.h |   31 +++++++++++++++++++
 backport/compat/backport-3.12.c        |   52 ++++++++++++++++++++++++++++++++
 2 files changed, 83 insertions(+)
 create mode 100644 backport/backport-include/linux/hdmi.h

diff --git a/backport/backport-include/linux/hdmi.h b/backport/backport-include/linux/hdmi.h
new file mode 100644
index 0000000..c02787c
--- /dev/null
+++ b/backport/backport-include/linux/hdmi.h
@@ -0,0 +1,31 @@
+#ifndef __BACKPORT_LINUX_HDMI_H
+#define __BACKPORT_LINUX_HDMI_H
+#include_next <linux/hdmi.h>
+
+#include <linux/version.h>
+
+/* on kernel < 3.9 hdmi gets backported */
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,9,0)
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,12,0)
+
+struct hdmi_any_infoframe {
+	enum hdmi_infoframe_type type;
+	unsigned char version;
+	unsigned char length;
+};
+
+union hdmi_infoframe {
+	struct hdmi_any_infoframe any;
+	struct hdmi_avi_infoframe avi;
+	struct hdmi_spd_infoframe spd;
+	struct hdmi_vendor_infoframe vendor;
+	struct hdmi_audio_infoframe audio;
+};
+
+#define hdmi_infoframe_pack LINUX_BACKPORT(hdmi_infoframe_pack)
+ssize_t
+hdmi_infoframe_pack(union hdmi_infoframe *frame, void *buffer, size_t size);
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,12,0)*/ 
+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,9,0) */
+
+#endif /* __BACKPORT_LINUX_HDMI_H */
diff --git a/backport/compat/backport-3.12.c b/backport/compat/backport-3.12.c
index 8ca9a8e..44b98f1 100644
--- a/backport/compat/backport-3.12.c
+++ b/backport/compat/backport-3.12.c
@@ -10,6 +10,7 @@
 
 #include <linux/export.h>
 #include <linux/hid.h>
+#include <linux/bug.h>
 
 /*
  * Allocator for buffer that is going to be passed to hid_output_report()
@@ -26,3 +27,54 @@ u8 *hid_alloc_report_buf(struct hid_report *report, gfp_t flags)
 	return kmalloc(len, flags);
 }
 EXPORT_SYMBOL_GPL(hid_alloc_report_buf);
+
+#ifdef CONFIG_HDMI
+
+/* on older kernel versions we backport hdmi completely. */
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,9,0)
+
+#include <linux/hdmi.h>
+
+/**
+ * hdmi_infoframe_pack() - write a HDMI infoframe to binary buffer
+ * @frame: HDMI infoframe
+ * @buffer: destination buffer
+ * @size: size of buffer
+ *
+ * Packs the information contained in the @frame structure into a binary
+ * representation that can be written into the corresponding controller
+ * registers. Also computes the checksum as required by section 5.3.5 of
+ * the HDMI 1.4 specification.
+ *
+ * Returns the number of bytes packed into the binary buffer or a negative
+ * error code on failure.
+ */
+ssize_t
+hdmi_infoframe_pack(union hdmi_infoframe *frame, void *buffer, size_t size)
+{
+	ssize_t length;
+
+	switch (frame->any.type) {
+	case HDMI_INFOFRAME_TYPE_AVI:
+		length = hdmi_avi_infoframe_pack(&frame->avi, buffer, size);
+		break;
+	case HDMI_INFOFRAME_TYPE_SPD:
+		length = hdmi_spd_infoframe_pack(&frame->spd, buffer, size);
+		break;
+	case HDMI_INFOFRAME_TYPE_AUDIO:
+		length = hdmi_audio_infoframe_pack(&frame->audio, buffer, size);
+		break;
+	case HDMI_INFOFRAME_TYPE_VENDOR:
+		length = hdmi_vendor_infoframe_pack(&frame->vendor,
+						    buffer, size);
+		break;
+	default:
+		WARN(1, "Bad infoframe type %d\n", frame->any.type);
+		length = -EINVAL;
+	}
+
+	return length;
+}
+EXPORT_SYMBOL(hdmi_infoframe_pack);
+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,9,0) */
+#endif /* CONFIG_HDMI*/
-- 
1.7.10.4

