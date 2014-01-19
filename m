Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:58370 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752421AbaASQsd (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 19 Jan 2014 11:48:33 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 12/16] backports: fix unused mwifiex_sdio_resume() warning
Date: Sun, 19 Jan 2014 17:47:33 +0100
Message-Id: <1390150057-11652-13-git-send-email-hauke@hauke-m.de> (sfid-20140119_174922_353137_49556E86)
In-Reply-To: <1390150057-11652-1-git-send-email-hauke@hauke-m.de>
References: <1390150057-11652-1-git-send-email-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This fixes the following warning:

/drivers/net/wireless/mwifiex/sdio.c:124:12: warning: ‘mwifiex_sdio_resume’ defined but not used [-Wunused-function]
 static int mwifiex_sdio_resume(struct device *dev)
            ^

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../drivers_net_wireless_mwifiex_sdio.patch        |   26 ++++++++++++++++----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/patches/collateral-evolutions/network/29-sdio_no_suspend/drivers_net_wireless_mwifiex_sdio.patch b/patches/collateral-evolutions/network/29-sdio_no_suspend/drivers_net_wireless_mwifiex_sdio.patch
index 11a3039..21b8109 100644
--- a/patches/collateral-evolutions/network/29-sdio_no_suspend/drivers_net_wireless_mwifiex_sdio.patch
+++ b/patches/collateral-evolutions/network/29-sdio_no_suspend/drivers_net_wireless_mwifiex_sdio.patch
@@ -1,6 +1,22 @@
 --- a/drivers/net/wireless/mwifiex/sdio.c
 +++ b/drivers/net/wireless/mwifiex/sdio.c
-@@ -183,8 +183,10 @@ mwifiex_sdio_remove(struct sdio_func *fu
+@@ -111,6 +111,7 @@ mwifiex_sdio_probe(struct sdio_func *fun
+ 	return ret;
+ }
+ 
++#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,34))
+ /*
+  * SDIO resume.
+  *
+@@ -155,6 +156,7 @@ static int mwifiex_sdio_resume(struct de
+ 
+ 	return 0;
+ }
++#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,34)) */
+ 
+ /*
+  * SDIO remove.
+@@ -183,8 +185,10 @@ mwifiex_sdio_remove(struct sdio_func *fu
  	wait_for_completion(&adapter->fw_load);
  
  	if (user_rmmod) {
@@ -11,7 +27,7 @@
  
  		for (i = 0; i < adapter->priv_num; i++)
  			if ((GET_BSS_ROLE(adapter->priv[i]) ==
-@@ -200,6 +202,7 @@ mwifiex_sdio_remove(struct sdio_func *fu
+@@ -200,6 +204,7 @@ mwifiex_sdio_remove(struct sdio_func *fu
  	mwifiex_remove_card(card->adapter, &add_remove_card_sem);
  }
  
@@ -19,7 +35,7 @@
  /*
   * SDIO suspend.
   *
-@@ -254,6 +257,7 @@ static int mwifiex_sdio_suspend(struct d
+@@ -254,6 +259,7 @@ static int mwifiex_sdio_suspend(struct d
  
  	return ret;
  }
@@ -27,7 +43,7 @@
  
  /* Device ID for SD8786 */
  #define SDIO_DEVICE_ID_MARVELL_8786   (0x9116)
-@@ -279,10 +283,12 @@ static const struct sdio_device_id mwifi
+@@ -279,10 +285,12 @@ static const struct sdio_device_id mwifi
  
  MODULE_DEVICE_TABLE(sdio, mwifiex_ids);
  
@@ -40,7 +56,7 @@
  
  static struct sdio_driver mwifiex_sdio = {
  	.name = "mwifiex_sdio",
-@@ -291,7 +297,9 @@ static struct sdio_driver mwifiex_sdio =
+@@ -291,7 +299,9 @@ static struct sdio_driver mwifiex_sdio =
  	.remove = mwifiex_sdio_remove,
  	.drv = {
  		.owner = THIS_MODULE,
-- 
1.7.10.4

