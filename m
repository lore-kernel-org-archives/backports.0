Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:51218 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754936Ab3G3J0y (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 30 Jul 2013 05:26:54 -0400
Received: by mail-pd0-f174.google.com with SMTP id 3so5501905pdj.33
        for <backports@vger.kernel.org>; Tue, 30 Jul 2013 02:26:53 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 11/14] backports: fix patches for next-20130709
Date: Tue, 30 Jul 2013 02:25:56 -0700
Message-Id: <1375176359-1331-12-git-send-email-mcgrof@do-not-panic.com> (sfid-20130730_112704_435566_2534CC2B)
In-Reply-To: <1375176359-1331-1-git-send-email-mcgrof@do-not-panic.com>
References: <1375176359-1331-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

A hunk context was off for alx.

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 .../drivers_net_ethernet_atheros_alx_main.patch             |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_ethernet_atheros_alx_main.patch b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_ethernet_atheros_alx_main.patch
index 626f5c5..8dae6c0 100644
--- a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_ethernet_atheros_alx_main.patch
+++ b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_ethernet_atheros_alx_main.patch
@@ -1,17 +1,18 @@
 --- a/drivers/net/ethernet/atheros/alx/main.c
 +++ b/drivers/net/ethernet/atheros/alx/main.c
-@@ -1593,6 +1593,8 @@ static const struct pci_error_handlers a
- };
+@@ -1404,6 +1404,9 @@ static int alx_resume(struct device *dev
+ 	return __alx_open(alx, true);
+ }
  
- #ifdef CONFIG_PM_SLEEP
 +compat_pci_suspend(alx_suspend);
 +compat_pci_resume(alx_resume);
++
  static SIMPLE_DEV_PM_OPS(alx_pm_ops, alx_suspend, alx_resume);
  #define ALX_PM_OPS      (&alx_pm_ops)
  #else
-@@ -1618,7 +1620,12 @@ static struct pci_driver alx_driver = {
+@@ -1506,7 +1509,12 @@ static struct pci_driver alx_driver = {
+ 	.probe       = alx_probe,
  	.remove      = alx_remove,
- 	.shutdown    = alx_shutdown,
  	.err_handler = &alx_err_handlers,
 +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,29))
  	.driver.pm   = ALX_PM_OPS,
-- 
1.7.10.4

