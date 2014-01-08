Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:46703 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753751AbaAHAfK (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 7 Jan 2014 19:35:10 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 07/17] backports: remove usage of members of struct property for kernel < 2.6.39
Date: Wed,  8 Jan 2014 01:34:24 +0100
Message-Id: <1389141274-2002-8-git-send-email-hauke@hauke-m.de> (sfid-20140108_013512_807339_FC62C815)
In-Reply-To: <1389141274-2002-1-git-send-email-hauke@hauke-m.de>
References: <1389141274-2002-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

struct property is missing in the general header files in older kernel
versions. There are different versions of this header depending on the
architecture code in use. This removed the access to any members of
struct property for older kernel version when CONFIG_OF is not set.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../network/82-struct_property_missing/INFO        |    4 +++
 .../82-struct_property_missing/mwifiex.patch       |   28 ++++++++++++++++++++
 2 files changed, 32 insertions(+)
 create mode 100644 patches/collateral-evolutions/network/82-struct_property_missing/INFO
 create mode 100644 patches/collateral-evolutions/network/82-struct_property_missing/mwifiex.patch

diff --git a/patches/collateral-evolutions/network/82-struct_property_missing/INFO b/patches/collateral-evolutions/network/82-struct_property_missing/INFO
new file mode 100644
index 0000000..b3e0ced
--- /dev/null
+++ b/patches/collateral-evolutions/network/82-struct_property_missing/INFO
@@ -0,0 +1,4 @@
+struct property is missing in the general header files in older kernel 
+versions. There are different versions of this header depending on the 
+architecture code in use. This removed the access to any members of 
+struct property
diff --git a/patches/collateral-evolutions/network/82-struct_property_missing/mwifiex.patch b/patches/collateral-evolutions/network/82-struct_property_missing/mwifiex.patch
new file mode 100644
index 0000000..d3712db
--- /dev/null
+++ b/patches/collateral-evolutions/network/82-struct_property_missing/mwifiex.patch
@@ -0,0 +1,28 @@
+--- a/drivers/net/wireless/mwifiex/sta_cmd.c
++++ b/drivers/net/wireless/mwifiex/sta_cmd.c
+@@ -25,6 +25,7 @@
+ #include "wmm.h"
+ #include "11n.h"
+ #include "11ac.h"
++#include <linux/of.h>
+ 
+ /*
+  * This function prepares command to set/get RSSI information.
+@@ -1194,6 +1195,7 @@ static int mwifiex_cmd_cfg_data(struct m
+ 	int ret;
+ 
+ 	if (prop) {
++#if defined(CONFIG_OF) || (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,39))
+ 		len = prop->length;
+ 		ret = of_property_read_u8_array(adapter->dt_node, prop->name,
+ 						data, len);
+@@ -1201,6 +1203,9 @@ static int mwifiex_cmd_cfg_data(struct m
+ 			return ret;
+ 		dev_dbg(adapter->dev,
+ 			"download cfg_data from device tree: %s\n", prop->name);
++#else
++		return -1;
++#endif
+ 	} else if (adapter->cal_data->data && adapter->cal_data->size > 0) {
+ 		len = mwifiex_parse_cal_cfg((u8 *)adapter->cal_data->data,
+ 					    adapter->cal_data->size, data);
-- 
1.7.10.4

