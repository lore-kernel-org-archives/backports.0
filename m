Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:44126 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751427AbaFOQfq (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 15 Jun 2014 12:35:46 -0400
Received: from localhost (localhost [127.0.0.1])
	by hauke-m.de (Postfix) with ESMTP id E21167E32
	for <backports@vger.kernel.org>; Sun, 15 Jun 2014 18:35:44 +0200 (CEST)
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 3/6] backports: add i2c_add_mux_adapter()
Date: Sun, 15 Jun 2014 18:35:20 +0200
Message-Id: <1402850123-22382-4-git-send-email-hauke@hauke-m.de> (sfid-20140615_183555_194918_ED08D74F)
In-Reply-To: <1402850123-22382-1-git-send-email-hauke@hauke-m.de>
References: <1402850123-22382-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This adds i2c_add_mux_adapter() also for kernel < 3.5. This is needed
for some newly activated media driver.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/i2c-mux.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/backport/backport-include/linux/i2c-mux.h b/backport/backport-include/linux/i2c-mux.h
index a3a67ad..37db84d 100644
--- a/backport/backport-include/linux/i2c-mux.h
+++ b/backport/backport-include/linux/i2c-mux.h
@@ -3,7 +3,10 @@
 #include_next <linux/i2c-mux.h>
 #include <linux/version.h>
 
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,7,0))
+#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,5,0))
+#define i2c_add_mux_adapter(parent, mux_dev, mux_priv, force_nr, chan_id, class, select, deselect) \
+	i2c_add_mux_adapter(parent, mux_priv, force_nr, chan_id, select, deselect)
+#elif (LINUX_VERSION_CODE < KERNEL_VERSION(3,7,0))
 #define i2c_add_mux_adapter(parent, mux_dev, mux_priv, force_nr, chan_id, class, select, deselect) \
 	i2c_add_mux_adapter(parent, mux_dev, mux_priv, force_nr, chan_id, select, deselect)
 #endif
-- 
1.9.1

