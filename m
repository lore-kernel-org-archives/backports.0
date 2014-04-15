Return-path: <backports-owner@vger.kernel.org>
Received: from www.linuxtv.org ([130.149.80.248]:51634 "EHLO www.linuxtv.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750932AbaDONQK (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 15 Apr 2014 09:16:10 -0400
Message-Id: <E1Wa2vC-0003HU-72@www.linuxtv.org> (sfid-20140415_151612_472667_E9369916)
From: Mauro Carvalho Chehab <m.chehab@samsung.com>
Date: Tue, 15 Apr 2014 14:48:27 +0200
Subject: [git:media_tree/fixes] [media] rtl28xxu: do not hard depend on staging SDR module
To: linuxtv-commits@linuxtv.org
Cc: backports@vger.kernel.org, Antti Palosaari <crope@iki.fi>
Reply-to: linux-media@vger.kernel.org
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This is an automatic generated email to let you know that the following patch were queued at the 
http://git.linuxtv.org/media_tree.git tree:

Subject: [media] rtl28xxu: do not hard depend on staging SDR module
Author:  Antti Palosaari <crope@iki.fi>
Date:    Wed Apr 9 12:42:35 2014 -0300

RTL2832 SDR extension module is currently on staging. SDR module
headers were included from staging causing direct dependency staging
directory. As a solution, add needed headers to main driver.
Motivation of that change comes from Luis / driver backports project.

Reported-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
Cc: backports@vger.kernel.org
Signed-off-by: Antti Palosaari <crope@iki.fi>
Signed-off-by: Mauro Carvalho Chehab <m.chehab@samsung.com>

 drivers/media/usb/dvb-usb-v2/Makefile   |    1 -
 drivers/media/usb/dvb-usb-v2/rtl28xxu.c |   21 ++++++++++++++++++++-
 2 files changed, 20 insertions(+), 2 deletions(-)

---

http://git.linuxtv.org/media_tree.git?a=commitdiff;h=1fd10f98d9abcde090b77cfa82c3f32f159e2d94

diff --git a/drivers/media/usb/dvb-usb-v2/Makefile b/drivers/media/usb/dvb-usb-v2/Makefile
index 7407b83..bc38f03 100644
--- a/drivers/media/usb/dvb-usb-v2/Makefile
+++ b/drivers/media/usb/dvb-usb-v2/Makefile
@@ -41,4 +41,3 @@ ccflags-y += -I$(srctree)/drivers/media/dvb-core
 ccflags-y += -I$(srctree)/drivers/media/dvb-frontends
 ccflags-y += -I$(srctree)/drivers/media/tuners
 ccflags-y += -I$(srctree)/drivers/media/common
-ccflags-y += -I$(srctree)/drivers/staging/media/rtl2832u_sdr
diff --git a/drivers/media/usb/dvb-usb-v2/rtl28xxu.c b/drivers/media/usb/dvb-usb-v2/rtl28xxu.c
index 61d196e..3a7a5a7 100644
--- a/drivers/media/usb/dvb-usb-v2/rtl28xxu.c
+++ b/drivers/media/usb/dvb-usb-v2/rtl28xxu.c
@@ -24,7 +24,6 @@
 
 #include "rtl2830.h"
 #include "rtl2832.h"
-#include "rtl2832_sdr.h"
 
 #include "qt1010.h"
 #include "mt2060.h"
@@ -36,6 +35,26 @@
 #include "tua9001.h"
 #include "r820t.h"
 
+/*
+ * RTL2832_SDR module is in staging. That logic is added in order to avoid any
+ * hard dependency to drivers/staging/ directory as we want compile mainline
+ * driver even whole staging directory is missing.
+ */
+#include <media/v4l2-subdev.h>
+
+#if IS_ENABLED(CONFIG_DVB_RTL2832_SDR)
+struct dvb_frontend *rtl2832_sdr_attach(struct dvb_frontend *fe,
+	struct i2c_adapter *i2c, const struct rtl2832_config *cfg,
+	struct v4l2_subdev *sd);
+#else
+static inline struct dvb_frontend *rtl2832_sdr_attach(struct dvb_frontend *fe,
+	struct i2c_adapter *i2c, const struct rtl2832_config *cfg,
+	struct v4l2_subdev *sd)
+{
+	return NULL;
+}
+#endif
+
 static int rtl28xxu_disable_rc;
 module_param_named(disable_rc, rtl28xxu_disable_rc, int, 0644);
 MODULE_PARM_DESC(disable_rc, "disable RTL2832U remote controller");
