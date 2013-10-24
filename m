Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:41554 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755859Ab3JXVEh (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 24 Oct 2013 17:04:37 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 2/3] backports: add backport prefix to devm_regulator_register()
Date: Thu, 24 Oct 2013 23:04:23 +0200
Message-Id: <1382648664-17110-3-git-send-email-hauke@hauke-m.de> (sfid-20131024_230438_750055_03013414)
In-Reply-To: <1382648664-17110-1-git-send-email-hauke@hauke-m.de>
References: <1382648664-17110-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Use LINUX_BACKPORT() to prevent a collision with some backported
patches in the kernel backports is being compiled against.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/regulator/driver.h |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/backport/backport-include/linux/regulator/driver.h b/backport/backport-include/linux/regulator/driver.h
index f56990b..e1604bf 100644
--- a/backport/backport-include/linux/regulator/driver.h
+++ b/backport/backport-include/linux/regulator/driver.h
@@ -25,10 +25,12 @@ int regulator_map_voltage_ascend(struct regulator_dev *rdev,
 
 #if (LINUX_VERSION_CODE < KERNEL_VERSION(3,13,0)) && \
     (LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0))
+#define devm_regulator_register LINUX_BACKPORT(devm_regulator_register)
 struct regulator_dev *
 devm_regulator_register(struct device *dev,
 			const struct regulator_desc *regulator_desc,
 			const struct regulator_config *config);
+#define devm_regulator_unregister LINUX_BACKPORT(devm_regulator_unregister)
 void devm_regulator_unregister(struct device *dev, struct regulator_dev *rdev);
 #endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(3,13,0)) &&
 	  (LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)) */
-- 
1.7.10.4

