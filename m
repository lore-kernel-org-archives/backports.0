Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:51017 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751037AbaEIGvs (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 9 May 2014 02:51:48 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] backports: fix class/bus attribute group spatch conversion
Date: Fri,  9 May 2014 08:23:16 +0200
Message-Id: <1399616596-12805-1-git-send-email-johannes@sipsolutions.net> (sfid-20140509_085150_116257_F42348A3)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

The spatch conversion (commit 05d44557c6a83b4ecb935cb6306f62,
"backports: transform group attribute backport to SmPL form")
added an #ifdef that shouldn't be there - remove it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 .../generic/0001-group-attr/0001-group_attr_class.cocci               | 4 ----
 .../generic/0001-group-attr/0002-group_attr_bus.cocci                 | 4 ----
 2 files changed, 8 deletions(-)

diff --git a/patches/collateral-evolutions/generic/0001-group-attr/0001-group_attr_class.cocci b/patches/collateral-evolutions/generic/0001-group-attr/0001-group_attr_class.cocci
index fa700f82db77..ea2e7039f50c 100644
--- a/patches/collateral-evolutions/generic/0001-group-attr/0001-group_attr_class.cocci
+++ b/patches/collateral-evolutions/generic/0001-group-attr/0001-group_attr_class.cocci
@@ -66,13 +66,9 @@ fresh identifier group_class_init = "init_" ## attribute_group_mod.group ## "_at
 @@
 
 (
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0)
 +	group_class_init();
-+#endif
 	return class_register(&group_class);
 |
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0)
 +	group_class_init();
-+#endif
 	ret = class_register(&group_class);
 )
diff --git a/patches/collateral-evolutions/generic/0001-group-attr/0002-group_attr_bus.cocci b/patches/collateral-evolutions/generic/0001-group-attr/0002-group_attr_bus.cocci
index d4ae44c7dfa3..b01da875083b 100644
--- a/patches/collateral-evolutions/generic/0001-group-attr/0002-group_attr_bus.cocci
+++ b/patches/collateral-evolutions/generic/0001-group-attr/0002-group_attr_bus.cocci
@@ -64,14 +64,10 @@ fresh identifier group_bus_init = "init_" ## attribute_group_mod.group ## "_attr
 @@
 
 (
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,12,0)
 +       group_bus_init();
-+#endif
         return bus_register(&group_bus);
 |
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,12,0)
 +       group_bus_init();
-+#endif
         ret = bus_register(&group_bus);
 )
 
-- 
2.0.0.rc0

