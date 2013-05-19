Return-path: <backports-owner@vger.kernel.org>
Received: from mail.nanl.de ([217.115.11.12]:40314 "EHLO mail.nanl.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753205Ab3ESSsS (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 19 May 2013 14:48:18 -0400
From: Jonas Gorski <jogo@openwrt.org>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: backports@vger.kernel.org
Subject: [PATCH 2/2] compat: handle renaming of random32() to prandom_u32()
Date: Sun, 19 May 2013 20:47:45 +0200
Message-Id: <1368989265-15164-3-git-send-email-jogo@openwrt.org> (sfid-20130519_204827_333143_DCA22CD2)
In-Reply-To: <1368989265-15164-1-git-send-email-jogo@openwrt.org>
References: <1368989265-15164-1-git-send-email-jogo@openwrt.org>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

496f2f93b1cc286f5a4f4f9acdc1e5314978683f renamed random32() to
prandom_u32(), so add an appropriate macro for older kernels.

Signed-off-by: Jonas Gorski <jogo@openwrt.org>
---
 include/linux/compat-3.10.h |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/compat-3.10.h b/include/linux/compat-3.10.h
index 9d6e55c..ac1dcfa 100644
--- a/include/linux/compat-3.10.h
+++ b/include/linux/compat-3.10.h
@@ -75,6 +75,20 @@ static inline void fb_enable_skip_vt_switch(struct fb_info *info)
 	module_driver(__pcmcia_driver, pcmcia_register_driver, \
 			pcmcia_unregister_driver)
 
+/**
+ * backport of:
+ *
+ * commit 496f2f93b1cc286f5a4f4f9acdc1e5314978683f
+ * Author: Akinobu Mita <akinobu.mita@gmail.com>
+ * Date:   Mon Dec 17 16:04:23 2012 -0800
+ *
+ *    random32: rename random32 to prandom
+ *
+ */
+#define prandom_u32()			random32()
+#define prandom_seed(seed)		srandom32(seed)
+#define	prandom_u32_state(state)	prandom32(state)
+
 #else /* kernel is >= 3.10 */
 /*
  * We'd delete this upstream ever got this, we use our
-- 
1.7.10.4

