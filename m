Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:50170 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752535Ab3J0TKA (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 27 Oct 2013 15:10:00 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 3/4] backports: add missing header for struct in6_addr
Date: Sun, 27 Oct 2013 20:09:39 +0100
Message-Id: <1382900980-26610-4-git-send-email-hauke@hauke-m.de> (sfid-20131027_201006_888748_0E89DDC9)
In-Reply-To: <1382900980-26610-1-git-send-email-hauke@hauke-m.de>
References: <1382900980-26610-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

fw-api-d3.h in the iwlwifi driver uses struct in6_addr and somehow it
does not get included on all kernel versions like 2.6.25. This patch
adds the missing include for linux/in6.h to fix the problem.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../06-header-changes/drivers_net_wireless_iwlwifi.patch    |   11 +++++++++++
 1 file changed, 11 insertions(+)
 create mode 100644 patches/collateral-evolutions/network/06-header-changes/drivers_net_wireless_iwlwifi.patch

diff --git a/patches/collateral-evolutions/network/06-header-changes/drivers_net_wireless_iwlwifi.patch b/patches/collateral-evolutions/network/06-header-changes/drivers_net_wireless_iwlwifi.patch
new file mode 100644
index 0000000..b27869c
--- /dev/null
+++ b/patches/collateral-evolutions/network/06-header-changes/drivers_net_wireless_iwlwifi.patch
@@ -0,0 +1,11 @@
+--- a/drivers/net/wireless/iwlwifi/mvm/fw-api-d3.h
++++ b/drivers/net/wireless/iwlwifi/mvm/fw-api-d3.h
+@@ -63,6 +63,8 @@
+ #ifndef __fw_api_d3_h__
+ #define __fw_api_d3_h__
+ 
++#include <linux/in6.h>
++
+ /**
+  * enum iwl_d3_wakeup_flags - D3 manager wakeup flags
+  * @IWL_WAKEUP_D3_CONFIG_FW_ERROR: wake up on firmware sysassert
-- 
1.7.10.4

