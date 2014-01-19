Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:58375 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752421AbaASQsf (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 19 Jan 2014 11:48:35 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 13/16] backports: fix unused var ret warning
Date: Sun, 19 Jan 2014 17:47:34 +0100
Message-Id: <1390150057-11652-14-git-send-email-hauke@hauke-m.de> (sfid-20140119_174922_660083_A7A77930)
In-Reply-To: <1390150057-11652-1-git-send-email-hauke@hauke-m.de>
References: <1390150057-11652-1-git-send-email-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This fixes the following warning:

/drivers/net/wireless/mwifiex/sta_cmd.c: In function ‘mwifiex_cmd_cfg_data’:
/drivers/net/wireless/mwifiex/sta_cmd.c:1196:6: warning: unused variable ‘ret’ [-Wunused-variable]
  int ret;
      ^

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../network/82-struct_property_missing/mwifiex.patch         |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/patches/collateral-evolutions/network/82-struct_property_missing/mwifiex.patch b/patches/collateral-evolutions/network/82-struct_property_missing/mwifiex.patch
index d3712db..ac882e6 100644
--- a/patches/collateral-evolutions/network/82-struct_property_missing/mwifiex.patch
+++ b/patches/collateral-evolutions/network/82-struct_property_missing/mwifiex.patch
@@ -8,15 +8,19 @@
  
  /*
   * This function prepares command to set/get RSSI information.
-@@ -1194,6 +1195,7 @@ static int mwifiex_cmd_cfg_data(struct m
- 	int ret;
+@@ -1192,9 +1193,10 @@ static int mwifiex_cmd_cfg_data(struct m
+ 	struct property *prop = data_buf;
+ 	u32 len;
+ 	u8 *data = (u8 *)cmd + S_DS_GEN;
+-	int ret;
  
  	if (prop) {
 +#if defined(CONFIG_OF) || (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,39))
++		int ret;
  		len = prop->length;
  		ret = of_property_read_u8_array(adapter->dt_node, prop->name,
  						data, len);
-@@ -1201,6 +1203,9 @@ static int mwifiex_cmd_cfg_data(struct m
+@@ -1202,6 +1204,9 @@ static int mwifiex_cmd_cfg_data(struct m
  			return ret;
  		dev_dbg(adapter->dev,
  			"download cfg_data from device tree: %s\n", prop->name);
-- 
1.7.10.4

