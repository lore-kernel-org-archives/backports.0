Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.mailbox.org ([80.241.60.212]:38496 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726467AbeIWXoE (ORCPT <rfc822;backports@vger.kernel.org>);
        Sun, 23 Sep 2018 19:44:04 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org, john@phrozen.org,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 08/10] patches: remove .coredump from struct driver for kernel < 4.16
Date: Sun, 23 Sep 2018 19:45:33 +0200
Message-Id: <20180923174535.16198-9-hauke@hauke-m.de> (sfid-20180923_194553_442604_1A88B709)
In-Reply-To: <20180923174535.16198-1-hauke@hauke-m.de>
References: <20180923174535.16198-1-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Kernel 4.16 added a new .coredump member to the driver structure which
can be implemented by drivers. Remove this member on older kernel
versions as they do not support this feature.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 patches/0088-coredump.cocci | 93 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)
 create mode 100644 patches/0088-coredump.cocci

diff --git a/patches/0088-coredump.cocci b/patches/0088-coredump.cocci
new file mode 100644
index 00000000..329e0315
--- /dev/null
+++ b/patches/0088-coredump.cocci
@@ -0,0 +1,93 @@
+@r1@
+identifier drv, fn;
+@@
+static struct pci_driver drv = {
+	.driver = {
++#if LINUX_VERSION_IS_GEQ(4,16,0)
+		.coredump = fn,
++#endif
+		...
+	},
+	...
+};
+
+@r11 depends on r1@
+identifier r1.fn;
+@@
++#if LINUX_VERSION_IS_GEQ(4,16,0)
+fn(...)
+{
+	...
+}
++#endif
+
+
+@r2@
+identifier drv, fn;
+@@
+ static struct pci_driver drv = {
++#if LINUX_VERSION_IS_GEQ(4,16,0)
+	.driver.coredump = fn,
++#endif
+	...
+ };
+
+@r21 depends on r2@
+identifier r2.fn;
+@@
++#if LINUX_VERSION_IS_GEQ(4,16,0)
+fn(...)
+{
+	...
+}
++#endif
+
+
+@r3@
+identifier drv, fn;
+@@
+static struct usb_driver drv = {
+	.drvwrap.driver = {
++#if LINUX_VERSION_IS_GEQ(4,16,0)
+		.coredump = fn,
++#endif
+		...
+	},
+	...
+};
+
+
+@r31 depends on r3@
+identifier r3.fn;
+@@
++#if LINUX_VERSION_IS_GEQ(4,16,0)
+fn(...)
+{
+	...
+}
++#endif
+
+
+@r4@
+identifier driver, fn;
+@@
+ static struct sdio_driver driver = {
+	.drv = {
++#if LINUX_VERSION_IS_GEQ(4,16,0)
+		.coredump = fn,
++#endif
+		...
+	},
+	...
+};
+
+
+@r41 depends on r4@
+identifier r4.fn;
+@@
++#if LINUX_VERSION_IS_GEQ(4,16,0)
+fn(...)
+{
+	...
+}
++#endif
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
