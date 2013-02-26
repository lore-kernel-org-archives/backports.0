Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 09/24] compat-drivers: make patches apply again
Date: Tue, 26 Feb 2013 21:38:01 +0100
Message-Id: <1361911096-29117-10-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1361911096-29117-1-git-send-email-hauke@hauke-m.de>
References: <1361911096-29117-1-git-send-email-hauke@hauke-m.de>
List-ID: <backports@vger.kernel.org>

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../network/45-remove-platform-id-table.patch                    |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/patches/collateral-evolutions/network/45-remove-platform-id-table.patch b/patches/collateral-evolutions/network/45-remove-platform-id-table.patch
index 29c4e73..c14a8b1 100644
--- a/patches/collateral-evolutions/network/45-remove-platform-id-table.patch
+++ b/patches/collateral-evolutions/network/45-remove-platform-id-table.patch
@@ -1,7 +1,7 @@
 --- a/drivers/net/wireless/ti/wl12xx/main.c
 +++ b/drivers/net/wireless/ti/wl12xx/main.c
-@@ -1725,16 +1725,20 @@ out:
- 	return ret;
+@@ -1813,16 +1813,20 @@ out:
+ 	return wlcore_remove(pdev);
  }
  
 +#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,30)
@@ -14,7 +14,7 @@
  
  static struct platform_driver wl12xx_driver = {
  	.probe		= wl12xx_probe,
- 	.remove		= wlcore_remove,
+ 	.remove		= wl12xx_remove,
 +#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,30)
  	.id_table	= wl12xx_id_table,
 +#endif
-- 
1.7.10.4
