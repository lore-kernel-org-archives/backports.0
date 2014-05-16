Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38481 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932330AbaEPLWg (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 16 May 2014 07:22:36 -0400
From: Stefan Assmann <sassmann@kpanic.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, sassmann@kpanic.de
Subject: [PATCH 13/13] backports: handle pci_error_handlers change to const
Date: Fri, 16 May 2014 13:21:24 +0200
Message-Id: <1400239284-2916-14-git-send-email-sassmann@kpanic.de> (sfid-20140516_135147_721775_9799097B)
In-Reply-To: <1400239284-2916-1-git-send-email-sassmann@kpanic.de>
References: <1400239284-2916-1-git-send-email-sassmann@kpanic.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

In kernel 3.7 struct pci_driver changed pci_error_handlers to const.
Address this by putting ifdef around the code.

commit 494530284f16298050ab99f54b7b12dd7d1418a1
Author: Stephen Hemminger <shemminger@vyatta.com>
Date:   Fri Sep 7 09:33:14 2012 -0700

    PCI: Make pci_error_handlers const

git describe --contains 494530284f16298050ab99f54b7b12dd7d1418a1
v3.7-rc1~177^2~9^2~3

Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
---
 .../network/0042-pci_error_handlers/INFO                 | 12 ++++++++++++
 .../0042-pci_error_handlers/igb_pci_error_handlers.patch | 16 ++++++++++++++++
 2 files changed, 28 insertions(+)
 create mode 100644 patches/collateral-evolutions/network/0042-pci_error_handlers/INFO
 create mode 100644 patches/collateral-evolutions/network/0042-pci_error_handlers/igb_pci_error_handlers.patch

diff --git a/patches/collateral-evolutions/network/0042-pci_error_handlers/INFO b/patches/collateral-evolutions/network/0042-pci_error_handlers/INFO
new file mode 100644
index 0000000..ffb183c
--- /dev/null
+++ b/patches/collateral-evolutions/network/0042-pci_error_handlers/INFO
@@ -0,0 +1,12 @@
+In kernel 3.7 struct pci_driver changed pci_error_handlers to const.
+Address this by putting ifdef around the code.
+
+
+commit 494530284f16298050ab99f54b7b12dd7d1418a1
+Author: Stephen Hemminger <shemminger@vyatta.com>
+Date:   Fri Sep 7 09:33:14 2012 -0700
+
+    PCI: Make pci_error_handlers const
+
+git describe --contains 494530284f16298050ab99f54b7b12dd7d1418a1
+v3.7-rc1~177^2~9^2~3
diff --git a/patches/collateral-evolutions/network/0042-pci_error_handlers/igb_pci_error_handlers.patch b/patches/collateral-evolutions/network/0042-pci_error_handlers/igb_pci_error_handlers.patch
new file mode 100644
index 0000000..cedff12
--- /dev/null
+++ b/patches/collateral-evolutions/network/0042-pci_error_handlers/igb_pci_error_handlers.patch
@@ -0,0 +1,16 @@
+diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
+index 132cef8..0e616a7 100644
+--- a/drivers/net/ethernet/intel/igb/igb_main.c
++++ b/drivers/net/ethernet/intel/igb/igb_main.c
+@@ -234,7 +234,11 @@ static pci_ers_result_t igb_io_error_detected(struct pci_dev *,
+ static pci_ers_result_t igb_io_slot_reset(struct pci_dev *);
+ static void igb_io_resume(struct pci_dev *);
+ 
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,7,0)
+ static const struct pci_error_handlers igb_err_handler = {
++#else
++static struct pci_error_handlers igb_err_handler = {
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,7,0) */
+ 	.error_detected = igb_io_error_detected,
+ 	.slot_reset = igb_io_slot_reset,
+ 	.resume = igb_io_resume,
-- 
1.9.0

