Return-path: <backports-owner@vger.kernel.org>
Received: from mx2.mailbox.org ([80.241.60.215]:42954 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754198AbdHUW2t (ORCPT <rfc822;backports@vger.kernel.org>);
        Mon, 21 Aug 2017 18:28:49 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 17/21] patches: backport the probe_new for i2c drivers
Date: Tue, 22 Aug 2017 00:28:13 +0200
Message-Id: <20170821222817.17376-18-hauke@hauke-m.de> (sfid-20170822_002852_580908_5D54C557)
In-Reply-To: <20170821222817.17376-1-hauke@hauke-m.de>
References: <20170821222817.17376-1-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

I2C got a new probe function which does not take the struct
i2c_device_id any more, backport this to older kernel versions with a
spatch.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 patches/0080-i2c-proble-new.cocci | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 patches/0080-i2c-proble-new.cocci

diff --git a/patches/0080-i2c-proble-new.cocci b/patches/0080-i2c-proble-new.cocci
new file mode 100644
index 00000000..35580aca
--- /dev/null
+++ b/patches/0080-i2c-proble-new.cocci
@@ -0,0 +1,25 @@
+@r@
+identifier OPS;
+identifier i2c_probe;
+fresh identifier i2c_probe_wrap = "bp_" ## i2c_probe;
+position p;
+@@
+struct i2c_driver OPS@p = {
++#if LINUX_VERSION_IS_GEQ(4,10,0)
+	.probe_new = i2c_probe,
++#else
++	.probe = i2c_probe_wrap,
++#endif
+};
+
+@@
+identifier r.i2c_probe_wrap;
+identifier r.i2c_probe;
+@@
+int i2c_probe(...) {...}
++#if LINUX_VERSION_IS_LESS(4,10,0)
++static int i2c_probe_wrap(struct i2c_client *client, const struct i2c_device_id *id)
++{
++	return i2c_probe(client);
++}
++#endif
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
