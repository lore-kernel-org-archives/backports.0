Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:35016 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750871AbaBXAqc (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 23 Feb 2014 19:46:32 -0500
Received: from localhost (localhost [127.0.0.1])
	by hauke-m.de (Postfix) with ESMTP id 589AB7E57
	for <backports@vger.kernel.org>; Mon, 24 Feb 2014 01:46:31 +0100 (CET)
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 04/12] backports: add snd_card_new()
Date: Mon, 24 Feb 2014 01:45:46 +0100
Message-Id: <1393202754-12919-5-git-send-email-hauke@hauke-m.de> (sfid-20140224_014634_045087_D5850465)
In-Reply-To: <1393202754-12919-1-git-send-email-hauke@hauke-m.de>
References: <1393202754-12919-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This is needed by drivers/media/pci/cx18/cx18-alsa-main.c

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/sound/core.h |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 backport/backport-include/sound/core.h

diff --git a/backport/backport-include/sound/core.h b/backport/backport-include/sound/core.h
new file mode 100644
index 0000000..beb8935
--- /dev/null
+++ b/backport/backport-include/sound/core.h
@@ -0,0 +1,20 @@
+#ifndef _BACKPORT_SOUND_CORE_H
+#define _BACKPORT_SOUND_CORE_H
+#include_next <sound/core.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,15,0)
+#define snd_card_new LINUX_BACKPORT(snd_card_new)
+static inline
+int snd_card_new(struct device *parent, int idx, const char *xid,
+		 struct module *module, int extra_size,
+		 struct snd_card **card_ret)
+{
+	int ret;
+
+	ret = snd_card_create(idx, xid, module, extra_size, card_ret);
+	snd_card_set_dev(*card_ret, parent);
+	return ret;
+}
+#endif
+
+#endif /* _BACKPORT_SOUND_CORE_H */
-- 
1.7.10.4

