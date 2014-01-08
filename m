Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:46744 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754309AbaAHAfl (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 7 Jan 2014 19:35:41 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 15/17] backports: fix i2c_add_mux_adapter() parameters
Date: Wed,  8 Jan 2014 01:34:32 +0100
Message-Id: <1389141274-2002-16-git-send-email-hauke@hauke-m.de> (sfid-20140108_013543_309026_EB6424D8)
In-Reply-To: <1389141274-2002-1-git-send-email-hauke@hauke-m.de>
References: <1389141274-2002-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The class parameter was added in kernel 3.7 to i2c_add_mux_adapter()
and could just be ignored by older kernel versions.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/i2c-mux.h |   11 +++++++++++
 1 file changed, 11 insertions(+)
 create mode 100644 backport/backport-include/linux/i2c-mux.h

diff --git a/backport/backport-include/linux/i2c-mux.h b/backport/backport-include/linux/i2c-mux.h
new file mode 100644
index 0000000..a3a67ad
--- /dev/null
+++ b/backport/backport-include/linux/i2c-mux.h
@@ -0,0 +1,11 @@
+#ifndef __BACKPORT_LINUX_I2C_MUX_H
+#define __BACKPORT_LINUX_I2C_MUX_H
+#include_next <linux/i2c-mux.h>
+#include <linux/version.h>
+
+#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,7,0))
+#define i2c_add_mux_adapter(parent, mux_dev, mux_priv, force_nr, chan_id, class, select, deselect) \
+	i2c_add_mux_adapter(parent, mux_dev, mux_priv, force_nr, chan_id, select, deselect)
+#endif
+
+#endif /* __BACKPORT_LINUX_I2C_MUX_H */
-- 
1.7.10.4

