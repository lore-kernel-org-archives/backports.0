Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:36633 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753067AbaLURwC (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 21 Dec 2014 12:52:02 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 6/8] atches: fix ssb compile
Date: Sun, 21 Dec 2014 18:51:52 +0100
Message-Id: <1419184314-1938-7-git-send-email-hauke@hauke-m.de> (sfid-20141221_185205_975089_1D3FA09A)
In-Reply-To: <1419184314-1938-1-git-send-email-hauke@hauke-m.de>
References: <1419184314-1938-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The wakeup_path member was added in kernel 3.2, just ignore this on
older kernel versions. This will break WoL in b44 with these old kernel
versions.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../network/0051-no-wakeup_path/ssb.patch                    | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 patches/collateral-evolutions/network/0051-no-wakeup_path/ssb.patch

diff --git a/patches/collateral-evolutions/network/0051-no-wakeup_path/ssb.patch b/patches/collateral-evolutions/network/0051-no-wakeup_path/ssb.patch
new file mode 100644
index 0000000..23bab03
--- /dev/null
+++ b/patches/collateral-evolutions/network/0051-no-wakeup_path/ssb.patch
@@ -0,0 +1,12 @@
+--- a/drivers/ssb/pcihost_wrapper.c
++++ b/drivers/ssb/pcihost_wrapper.c
+@@ -33,7 +33,9 @@ static int ssb_pcihost_suspend(struct de
+ 
+ 	/* if there is a wakeup enabled child device on ssb bus,
+ 	   enable pci wakeup posibility. */
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0)
+ 	device_set_wakeup_enable(d, d->power.wakeup_path);
++#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0) */
+ 
+ 	pci_prepare_to_sleep(dev);
+ 
-- 
1.9.1

