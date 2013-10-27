Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:49261 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754036Ab3J0NkY (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 27 Oct 2013 09:40:24 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 1/5] backports: add REGULATOR_LINEAR_RANGE
Date: Sun, 27 Oct 2013 14:39:58 +0100
Message-Id: <1382881202-16709-2-git-send-email-hauke@hauke-m.de> (sfid-20131027_144026_665675_1E525EE5)
In-Reply-To: <1382881202-16709-1-git-send-email-hauke@hauke-m.de>
References: <1382881202-16709-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/regulator/driver.h |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/backport/backport-include/linux/regulator/driver.h b/backport/backport-include/linux/regulator/driver.h
index e1604bf..532eba0 100644
--- a/backport/backport-include/linux/regulator/driver.h
+++ b/backport/backport-include/linux/regulator/driver.h
@@ -35,4 +35,15 @@ void devm_regulator_unregister(struct device *dev, struct regulator_dev *rdev);
 #endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(3,13,0)) &&
 	  (LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)) */
 
+#ifndef REGULATOR_LINEAR_RANGE
+/* Initialize struct regulator_linear_range */
+#define REGULATOR_LINEAR_RANGE(_min_uV, _min_sel, _max_sel, _step_uV)	\
+{									\
+	.min_uV		= _min_uV,					\
+	.min_sel	= _min_sel,					\
+	.max_sel	= _max_sel,					\
+	.uV_step	= _step_uV,					\
+}
+#endif
+
 #endif /* __BACKPORT_LINUX_REGULATOR_DRIVER_H_ */
-- 
1.7.10.4

