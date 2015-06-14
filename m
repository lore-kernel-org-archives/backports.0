Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:41033 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751625AbbFNO3h (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 14 Jun 2015 10:29:37 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 05/21] patches: remove additional member in struct mei_cl_device_id
Date: Sun, 14 Jun 2015 16:29:06 +0200
Message-Id: <1434292162-2261-6-git-send-email-hauke@hauke-m.de> (sfid-20150614_162943_857331_F84FBA4A)
In-Reply-To: <1434292162-2261-1-git-send-email-hauke@hauke-m.de>
References: <1434292162-2261-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The uuid member was added to the struct mei_cl_device_id in this commit:
commit c93b76b34b4d8dbe8e3443eb27e49ac60034342b
Author: Tomas Winkler <tomas.winkler@intel.com>
Date:   Thu May 7 15:54:02 2015 +0300

    mei: bus: report also uuid in module alias

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../network/0059-uuid-in-mei/INFO                  |  7 ++++++
 .../network/0059-uuid-in-mei/nfc.patch             | 28 ++++++++++++++++++++++
 2 files changed, 35 insertions(+)
 create mode 100644 patches/collateral-evolutions/network/0059-uuid-in-mei/INFO
 create mode 100644 patches/collateral-evolutions/network/0059-uuid-in-mei/nfc.patch

diff --git a/patches/collateral-evolutions/network/0059-uuid-in-mei/INFO b/patches/collateral-evolutions/network/0059-uuid-in-mei/INFO
new file mode 100644
index 0000000..4c96bf5
--- /dev/null
+++ b/patches/collateral-evolutions/network/0059-uuid-in-mei/INFO
@@ -0,0 +1,7 @@
+The uuid member was added to the struct mei_cl_device_id in this commit:
+commit c93b76b34b4d8dbe8e3443eb27e49ac60034342b
+Author: Tomas Winkler <tomas.winkler@intel.com>
+Date:   Thu May 7 15:54:02 2015 +0300
+
+    mei: bus: report also uuid in module alias
+
diff --git a/patches/collateral-evolutions/network/0059-uuid-in-mei/nfc.patch b/patches/collateral-evolutions/network/0059-uuid-in-mei/nfc.patch
new file mode 100644
index 0000000..69e20e2
--- /dev/null
+++ b/patches/collateral-evolutions/network/0059-uuid-in-mei/nfc.patch
@@ -0,0 +1,28 @@
+--- a/drivers/nfc/microread/mei.c
++++ b/drivers/nfc/microread/mei.c
+@@ -67,7 +67,11 @@ static int microread_mei_remove(struct m
+ }
+ 
+ static struct mei_cl_device_id microread_mei_tbl[] = {
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,2,0)
+ 	{ MICROREAD_DRIVER_NAME, MEI_NFC_UUID},
++#else
++	{ MICROREAD_DRIVER_NAME},
++#endif
+ 
+ 	/* required last entry */
+ 	{ }
+--- a/drivers/nfc/pn544/mei.c
++++ b/drivers/nfc/pn544/mei.c
+@@ -67,7 +67,11 @@ static int pn544_mei_remove(struct mei_c
+ }
+ 
+ static struct mei_cl_device_id pn544_mei_tbl[] = {
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,2,0)
+ 	{ PN544_DRIVER_NAME, MEI_NFC_UUID},
++#else
++	{ PN544_DRIVER_NAME},
++#endif
+ 
+ 	/* required last entry */
+ 	{ }
-- 
2.1.4

