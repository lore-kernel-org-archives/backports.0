Return-path: <backports-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:61563 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751702AbbIQVrm (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 17 Sep 2015 17:47:42 -0400
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: backports@vger.kernel.org
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH RFC 2/2] add script to enable audio backport
Date: Thu, 17 Sep 2015 16:47:17 -0500
Message-Id: <1442526437-22392-3-git-send-email-pierre-louis.bossart@linux.intel.com> (sfid-20150917_234743_628456_B160EAFA)
In-Reply-To: <1442526437-22392-1-git-send-email-pierre-louis.bossart@linux.intel.com>
References: <1442526437-22392-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

bash enable_audio.sh will add the required files in copylist
and patch some of the backport headers

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 copy-list.patch     | 37 +++++++++++++++++++++++++++++++++++++
 enable-audio.sh     |  3 +++
 sound_headers.patch | 38 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 78 insertions(+)
 create mode 100644 copy-list.patch
 create mode 100644 enable-audio.sh
 create mode 100644 sound_headers.patch

diff --git a/copy-list.patch b/copy-list.patch
new file mode 100644
index 0000000..1bd3065
--- /dev/null
+++ b/copy-list.patch
@@ -0,0 +1,37 @@
+diff --git a/copy-list b/copy-list
+index 2264d01..9a7fcf4 100644
+--- a/copy-list
++++ b/copy-list
+@@ -100,9 +100,9 @@ drivers/net/usb/usbnet.c
+ 
+ 
+ # Bluetooth
+-include/net/bluetooth/
+-net/bluetooth/
+-drivers/bluetooth/
++#include/net/bluetooth/
++#net/bluetooth/
++#drivers/bluetooth/
+ 
+ 
+ # Ethernet drivers
+@@ -145,7 +145,7 @@ include/linux/platform_data/nfcmrvl.h
+ include/linux/platform_data/nxp-nci.h
+ include/linux/platform_data/pn544.h
+ include/linux/platform_data/st21nfca.h
+-include/linux/platform_data/st_nci.h
++include/linux/platform_data/st-nci.h
+ 
+ # Media
+ include/media/
+@@ -192,3 +192,9 @@ drivers/net/ieee802154/
+ # this right now, see 960d97f95
+ include/linux/mpls.h
+ include/uapi/linux/mpls.h
++
++# Sound support
++sound/
++include/sound/
++include/uapi/sound/
++include/linux/list.h
+\ No newline at end of file
diff --git a/enable-audio.sh b/enable-audio.sh
new file mode 100644
index 0000000..666d8d8
--- /dev/null
+++ b/enable-audio.sh
@@ -0,0 +1,3 @@
+#!/bin/bash
+patch -p1 < copy-list.patch
+patch -p1 < sound_headers.patch
diff --git a/sound_headers.patch b/sound_headers.patch
new file mode 100644
index 0000000..9c09108
--- /dev/null
+++ b/sound_headers.patch
@@ -0,0 +1,38 @@
+diff --git a/backport/backport-include/sound/core.h b/backport/backport-include/sound/core.h
+index beb8935..4b39e5b 100644
+--- a/backport/backport-include/sound/core.h
++++ b/backport/backport-include/sound/core.h
+@@ -2,6 +2,7 @@
+ #define _BACKPORT_SOUND_CORE_H
+ #include_next <sound/core.h>
+ 
++#if 0
+ #if LINUX_VERSION_CODE < KERNEL_VERSION(3,15,0)
+ #define snd_card_new LINUX_BACKPORT(snd_card_new)
+ static inline
+@@ -16,5 +17,6 @@ int snd_card_new(struct device *parent, int idx, const char *xid,
+ 	return ret;
+ }
+ #endif
++#endif
+ 
+ #endif /* _BACKPORT_SOUND_CORE_H */
+diff --git a/backport/backport-include/sound/pcm.h b/backport/backport-include/sound/pcm.h
+index 469e871..51dc152 100644
+--- a/backport/backport-include/sound/pcm.h
++++ b/backport/backport-include/sound/pcm.h
+@@ -3,6 +3,7 @@
+ #include_next <sound/pcm.h>
+ #include <linux/version.h>
+ 
++#if 0
+ #if LINUX_VERSION_CODE < KERNEL_VERSION(3,19,0)
+ /**
+  * snd_pcm_stop_xrun - stop the running streams as XRUN
+@@ -25,5 +26,5 @@ static inline int snd_pcm_stop_xrun(struct snd_pcm_substream *substream)
+ 	return ret;
+ }
+ #endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,19,0) */
+-
++#endif
+ #endif /* __BACKPORT_SOUND_PCM_H */
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
