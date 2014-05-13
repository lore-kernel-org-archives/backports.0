Return-path: <backports-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:1975 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754170AbaEMNWD (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 13 May 2014 09:22:03 -0400
From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
To: backports@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH] backport: update drivers_net_wireless_iwlwifi_iwl-debug.patch
Date: Tue, 13 May 2014 16:19:12 +0300
Message-Id: <1399987152-20197-1-git-send-email-emmanuel.grumbach@intel.com> (sfid-20140513_152205_973395_8252570E)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The driver was updated - need to update the patch accordingly

commit 7f715626a9ddfa7df13f076f59fc62e3c99066cf
Author: Liad Kaufman <liad.kaufman@intel.com>
Date:   Thu May 8 15:24:54 2014 +0300

    iwlwifi: use dev_printk instead of dev_dbg for debug logs

Change-Id: I4006303e36bc170c3e91bbb9e5d9437a1f345b9f
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
---
 .../drivers_net_wireless_iwlwifi_iwl-debug.patch             | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/patches/collateral-evolutions/network/0018-pv-trace-fixes/drivers_net_wireless_iwlwifi_iwl-debug.patch b/patches/collateral-evolutions/network/0018-pv-trace-fixes/drivers_net_wireless_iwlwifi_iwl-debug.patch
index 3e454e2..6530cbb 100644
--- a/patches/collateral-evolutions/network/0018-pv-trace-fixes/drivers_net_wireless_iwlwifi_iwl-debug.patch
+++ b/patches/collateral-evolutions/network/0018-pv-trace-fixes/drivers_net_wireless_iwlwifi_iwl-debug.patch
@@ -1,6 +1,8 @@
+diff --git a/drivers/net/wireless/iwlwifi/iwl-debug.c b/drivers/net/wireless/iwlwifi/iwl-debug.c
+index 09feff4..c201d09 100644
 --- a/drivers/net/wireless/iwlwifi/iwl-debug.c
 +++ b/drivers/net/wireless/iwlwifi/iwl-debug.c
-@@ -76,13 +76,16 @@ void __iwl_ ##fn(struct device *dev, con
+@@ -74,13 +74,16 @@ void __iwl_ ##fn(struct device *dev, const char *fmt, ...)	\
  	struct va_format vaf = {				\
  		.fmt = fmt,					\
  	};							\
@@ -21,7 +23,7 @@
  }
  
  __iwl_fn(warn)
-@@ -101,13 +104,18 @@ void __iwl_err(struct device *dev, bool
+@@ -99,13 +102,18 @@ void __iwl_err(struct device *dev, bool rfkill_prefix, bool trace_only,
  	va_list args;
  
  	va_start(args, fmt);
@@ -41,7 +43,7 @@
  	trace_iwlwifi_err(&vaf);
  	va_end(args);
  }
-@@ -124,13 +132,19 @@ void __iwl_dbg(struct device *dev,
+@@ -122,13 +130,19 @@ void __iwl_dbg(struct device *dev,
  	va_list args;
  
  	va_start(args, fmt);
@@ -54,8 +56,8 @@
 +
 +		va_copy(args2, args);
 +		vaf.va = &args2;
- 		dev_dbg(dev, "%c %s %pV", in_interrupt() ? 'I' : 'U',
- 			function, &vaf);
+ 		dev_printk(KERN_DEBUG, dev, "%c %s %pV",
+ 			   in_interrupt() ? 'I' : 'U', function, &vaf);
 +		va_end(args2);
 +	}
  #endif
-- 
1.8.3.2

