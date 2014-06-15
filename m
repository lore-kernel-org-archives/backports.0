Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:44128 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751698AbaFOQfs (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 15 Jun 2014 12:35:48 -0400
Received: from localhost (localhost [127.0.0.1])
	by hauke-m.de (Postfix) with ESMTP id 943077E24
	for <backports@vger.kernel.org>; Sun, 15 Jun 2014 18:35:46 +0200 (CEST)
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 4/6] backports: add I2C_CLIENT_SCCB
Date: Sun, 15 Jun 2014 18:35:21 +0200
Message-Id: <1402850123-22382-5-git-send-email-hauke@hauke-m.de> (sfid-20140615_183555_840627_F774BC3D)
In-Reply-To: <1402850123-22382-1-git-send-email-hauke@hauke-m.de>
References: <1402850123-22382-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This is needed for some newly activated media driver.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/i2c.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/backport/backport-include/linux/i2c.h b/backport/backport-include/linux/i2c.h
index ffa9027..2350835 100644
--- a/backport/backport-include/linux/i2c.h
+++ b/backport/backport-include/linux/i2c.h
@@ -38,4 +38,9 @@ extern int __i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
 			i2c_del_driver)
 #endif
 
+#ifndef I2C_CLIENT_SCCB
+#define I2C_CLIENT_SCCB	0x9000		/* Use Omnivision SCCB protocol */
+					/* Must match I2C_M_STOP|IGNORE_NAK */
+#endif
+
 #endif /* __BACKPORT_LINUX_I2C_H */
-- 
1.9.1

