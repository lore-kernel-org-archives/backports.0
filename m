Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 1/3] compat-drivers: make patches apply again
Date: Thu, 27 Dec 2012 18:28:20 +0100
Message-Id: <1356629302-15682-1-git-send-email-hauke@hauke-m.de>
List-ID: <backports@vger.kernel.org>


Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 patches/collateral-evolutions/network/11-dev-pm-ops.patch |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/patches/collateral-evolutions/network/11-dev-pm-ops.patch b/patches/collateral-evolutions/network/11-dev-pm-ops.patch
index 8255138..acae45e 100644
--- a/patches/collateral-evolutions/network/11-dev-pm-ops.patch
+++ b/patches/collateral-evolutions/network/11-dev-pm-ops.patch
@@ -22,7 +22,7 @@ calls on compat code with only slight modifications.
 @@ -285,7 +288,12 @@ static struct pci_driver bcma_pci_bridge
  	.id_table = bcma_pci_bridge_tbl,
  	.probe = bcma_host_pci_probe,
- 	.remove = __devexit_p(bcma_host_pci_remove),
+ 	.remove = bcma_host_pci_remove,
 +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,29))
  	.driver.pm = BCMA_PM_OPS,
 +#elif defined(CONFIG_PM)
-- 
1.7.10.4
