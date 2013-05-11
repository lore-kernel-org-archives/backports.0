Return-path: <backports-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:43103 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755640Ab3EKA16 (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 10 May 2013 20:27:58 -0400
Received: by mail-ia0-f174.google.com with SMTP id j3so3935629iae.5
        for <backports@vger.kernel.org>; Fri, 10 May 2013 17:27:57 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 10/12] backports: fix atl1.c dev-pm-ops patch
Date: Fri, 10 May 2013 17:27:01 -0700
Message-Id: <1368232023-23817-11-git-send-email-mcgrof@do-not-panic.com> (sfid-20130511_022936_092857_7DD69964)
In-Reply-To: <1368232023-23817-1-git-send-email-mcgrof@do-not-panic.com>
References: <1368232023-23817-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

As of next-20130419 the atl1.c driver uses
atl1_pm_ops directly instead of the ATL1_PM_OPS
macro. This fixes that hunk.

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 .../drivers_net_ethernet_atheros_atlx_atl1.patch             |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_ethernet_atheros_atlx_atl1.patch b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_ethernet_atheros_atlx_atl1.patch
index 1e3cb6d..7fd2a4d 100644
--- a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_ethernet_atheros_atlx_atl1.patch
+++ b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_ethernet_atheros_atlx_atl1.patch
@@ -1,21 +1,21 @@
 --- a/drivers/net/ethernet/atheros/atlx/atl1.c
 +++ b/drivers/net/ethernet/atheros/atlx/atl1.c
-@@ -2877,6 +2877,9 @@ static int atl1_resume(struct device *de
- 	return 0;
+@@ -2878,6 +2878,9 @@ static int atl1_resume(struct device *de
  }
+ #endif
  
 +compat_pci_suspend(atl1_suspend)
 +compat_pci_resume(atl1_resume)
 +
  static SIMPLE_DEV_PM_OPS(atl1_pm_ops, atl1_suspend, atl1_resume);
- #define ATL1_PM_OPS	(&atl1_pm_ops)
  
-@@ -3147,7 +3150,12 @@ static struct pci_driver atl1_driver = {
+ static void atl1_shutdown(struct pci_dev *pdev)
+@@ -3142,7 +3145,12 @@ static struct pci_driver atl1_driver = {
  	.probe = atl1_probe,
  	.remove = atl1_remove,
  	.shutdown = atl1_shutdown,
 +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,29))
- 	.driver.pm = ATL1_PM_OPS,
+ 	.driver.pm = &atl1_pm_ops,
 +#elif defined(CONFIG_PM_SLEEP)
 +	.suspend        = atl1_suspend_compat,
 +	.resume         = atl1_resume_compat,
-- 
1.7.10.4

