Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:37684 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750944AbaKPUti (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 16 Nov 2014 15:49:38 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 04/20] headers: snd_pcm_stop_xrun()
Date: Sun, 16 Nov 2014 21:49:04 +0100
Message-Id: <1416170960-12868-5-git-send-email-hauke@hauke-m.de> (sfid-20141116_214942_188177_884D1A55)
In-Reply-To: <1416170960-12868-1-git-send-email-hauke@hauke-m.de>
References: <1416170960-12868-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This is used by the saa7134-alsa.c driver.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/sound/pcm.h | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 backport/backport-include/sound/pcm.h

diff --git a/backport/backport-include/sound/pcm.h b/backport/backport-include/sound/pcm.h
new file mode 100644
index 0000000..469e871
--- /dev/null
+++ b/backport/backport-include/sound/pcm.h
@@ -0,0 +1,29 @@
+#ifndef __BACKPORT_SOUND_PCM_H
+#define __BACKPORT_SOUND_PCM_H
+#include_next <sound/pcm.h>
+#include <linux/version.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,19,0)
+/**
+ * snd_pcm_stop_xrun - stop the running streams as XRUN
+ * @substream: the PCM substream instance
+ *
+ * This stops the given running substream (and all linked substreams) as XRUN.
+ * Unlike snd_pcm_stop(), this function takes the substream lock by itself.
+ *
+ * Return: Zero if successful, or a negative error code.
+ */
+static inline int snd_pcm_stop_xrun(struct snd_pcm_substream *substream)
+{
+	unsigned long flags;
+	int ret = 0;
+
+	snd_pcm_stream_lock_irqsave(substream, flags);
+	if (snd_pcm_running(substream))
+		ret = snd_pcm_stop(substream, SNDRV_PCM_STATE_XRUN);
+	snd_pcm_stream_unlock_irqrestore(substream, flags);
+	return ret;
+}
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,19,0) */
+
+#endif /* __BACKPORT_SOUND_PCM_H */
-- 
1.9.1

