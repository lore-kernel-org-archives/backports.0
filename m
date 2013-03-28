Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 1/5] compat: add module_pcmcia_driver
Date: Thu, 28 Mar 2013 20:18:23 +0100
Message-Id: <1364498307-11855-1-git-send-email-hauke@hauke-m.de>
List-ID: <backports@vger.kernel.org>

This is a backport of:
commit 6ed7ffddcf61f668114edb676417e5fb33773b59
Author: H Hartley Sweeten <hsweeten@visionengravers.com>
Date:   Wed Mar 6 11:24:44 2013 -0700

    pcmcia/ds.h: introduce helper for pcmcia_driver module boilerplate

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 include/linux/compat-3.10.h |   22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/include/linux/compat-3.10.h b/include/linux/compat-3.10.h
index 9abfc4b..f972203 100644
--- a/include/linux/compat-3.10.h
+++ b/include/linux/compat-3.10.h
@@ -53,6 +53,28 @@ static inline void fb_enable_skip_vt_switch(struct fb_info *info)
 {
 }
 
+/**
+ * backport of:
+ *
+ * commit 6ed7ffddcf61f668114edb676417e5fb33773b59
+ * Author: H Hartley Sweeten <hsweeten@visionengravers.com>
+ * Date:   Wed Mar 6 11:24:44 2013 -0700
+ *
+ *     pcmcia/ds.h: introduce helper for pcmcia_driver module boilerplate
+ */
+
+/**
+ * module_pcmcia_driver() - Helper macro for registering a pcmcia driver
+ * @__pcmcia_driver: pcmcia_driver struct
+ *
+ * Helper macro for pcmcia drivers which do not do anything special in module
+ * init/exit. This eliminates a lot of boilerplate. Each module may only use
+ * this macro once, and calling it replaces module_init() and module_exit().
+ */
+#define module_pcmcia_driver(__pcmcia_driver) \
+	module_driver(__pcmcia_driver, pcmcia_register_driver, \
+			pcmcia_unregister_driver)
+
 #else /* kernel is >= 3.10 */
 /*
  * We'd delete this upstream ever got this, we use our
-- 
1.7.10.4
