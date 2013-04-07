Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:47027 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161185Ab3DGCWS (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 6 Apr 2013 22:22:18 -0400
Received: by mail-pa0-f44.google.com with SMTP id bi5so2664480pad.3
        for <backports@vger.kernel.org>; Sat, 06 Apr 2013 19:22:17 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 3/9] compat: backport __i2c_transfer()
Date: Sat,  6 Apr 2013 19:21:56 -0700
Message-Id: <1365301322-19327-3-git-send-email-mcgrof@do-not-panic.com> (sfid-20130407_042219_802700_F2D736A5)
In-Reply-To: <1365301322-19327-1-git-send-email-mcgrof@do-not-panic.com>
References: <1365301322-19327-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

mcgrof@frijol ~/linux-stable (git::master)$ git describe --contains b37d2a3a
v3.6-rc1~28^2~265

commit b37d2a3a75cb0e72e18c29336cb2095b63dabfc8
Author: Jean Delvare <khali@linux-fr.org>
Date:   Fri Jun 29 07:47:19 2012 -0300

    [media] i2c: Export an unlocked flavor of i2c_transfer

    Some drivers (in particular for TV cards) need exclusive access to
    their I2C buses for specific operations. Export an unlocked flavor
    of i2c_transfer to give them full control.

    The unlocked flavor has the following limitations:
    * Obviously, caller must hold the i2c adapter lock.
    * No debug messages are logged. We don't want to log messages while
      holding a rt_mutex.
    * No check is done on the existence of adap->algo->master_xfer. It
      is thus the caller's responsibility to ensure that the function is
      OK to call.

    Signed-off-by: Jean Delvare <khali@linux-fr.org>
    Signed-off-by: Mauro Carvalho Chehab <mchehab@redhat.com>

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 backport/compat/compat-3.6.c        |   34 ++++++++++++++++++++++++++++++++++
 backport/include/linux/compat-3.6.h |    9 +++++++++
 2 files changed, 43 insertions(+)

diff --git a/backport/compat/compat-3.6.c b/backport/compat/compat-3.6.c
index a50fc98..05954d4 100644
--- a/backport/compat/compat-3.6.c
+++ b/backport/compat/compat-3.6.c
@@ -13,6 +13,40 @@
 #include <linux/export.h>
 #include <linux/bug.h>
 #include <linux/bitmap.h>
+#include <linux/i2c.h>
+
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0))
+/**
+ * __i2c_transfer - unlocked flavor of i2c_transfer
+ * @adap: Handle to I2C bus
+ * @msgs: One or more messages to execute before STOP is issued to
+ *     terminate the operation; each message begins with a START.
+ * @num: Number of messages to be executed.
+ *
+ * Returns negative errno, else the number of messages executed.
+ *
+ * Adapter lock must be held when calling this function. No debug logging
+ * takes place. adap->algo->master_xfer existence isn't checked.
+ */
+int __i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
+{
+	unsigned long orig_jiffies;
+	int ret, try;
+
+	/* Retry automatically on arbitration loss */
+	orig_jiffies = jiffies;
+	for (ret = 0, try = 0; try <= adap->retries; try++) {
+		ret = adap->algo->master_xfer(adap, msgs, num);
+		if (ret != -EAGAIN)
+			break;
+		if (time_after(jiffies, orig_jiffies + adap->timeout))
+			break;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL(__i2c_transfer);
+#endif
 
 /**
  * memweight - count the total number of bits set in memory area
diff --git a/backport/include/linux/compat-3.6.h b/backport/include/linux/compat-3.6.h
index bef0503..8fddd31 100644
--- a/backport/include/linux/compat-3.6.h
+++ b/backport/include/linux/compat-3.6.h
@@ -7,6 +7,15 @@
 
 #include <linux/scatterlist.h>
 
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0))
+#include <linux/i2c.h>
+/* Unlocked flavor */
+#define __i2c_transfer LINUX_BACKPORT(__i2c_transfer)
+extern int __i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
+			  int num);
+#endif
+
+
 #define memweight LINUX_BACKPORT(memweight)
 extern size_t memweight(const void *ptr, size_t bytes);
 
-- 
1.7.10.4

