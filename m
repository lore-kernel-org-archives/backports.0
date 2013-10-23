Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:35344 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752660Ab3JWS1z (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 23 Oct 2013 14:27:55 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 4/5] backports: do not use uapi in include
Date: Wed, 23 Oct 2013 20:27:31 +0200
Message-Id: <1382552852-15916-5-git-send-email-hauke@hauke-m.de> (sfid-20131023_202756_376476_40181149)
In-Reply-To: <1382552852-15916-1-git-send-email-hauke@hauke-m.de>
References: <1382552852-15916-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../collateral-evolutions/network/79-no-uapi/INFO  |    4 ++++
 .../network/79-no-uapi/mwifiex.patch               |   22 ++++++++++++++++++++
 2 files changed, 26 insertions(+)
 create mode 100644 patches/collateral-evolutions/network/79-no-uapi/INFO
 create mode 100644 patches/collateral-evolutions/network/79-no-uapi/mwifiex.patch

diff --git a/patches/collateral-evolutions/network/79-no-uapi/INFO b/patches/collateral-evolutions/network/79-no-uapi/INFO
new file mode 100644
index 0000000..8e86477
--- /dev/null
+++ b/patches/collateral-evolutions/network/79-no-uapi/INFO
@@ -0,0 +1,4 @@
+Older kernel versions do not have the uapi include directory, but they 
+have the same functions in the include file without uapi. On recent 
+kernel versions the include file without uapi in the name includes the 
+uapi one.
diff --git a/patches/collateral-evolutions/network/79-no-uapi/mwifiex.patch b/patches/collateral-evolutions/network/79-no-uapi/mwifiex.patch
new file mode 100644
index 0000000..41e5c9d
--- /dev/null
+++ b/patches/collateral-evolutions/network/79-no-uapi/mwifiex.patch
@@ -0,0 +1,22 @@
+--- a/drivers/net/wireless/mwifiex/decl.h
++++ b/drivers/net/wireless/mwifiex/decl.h
+@@ -26,7 +26,7 @@
+ #include <linux/wait.h>
+ #include <linux/timer.h>
+ #include <linux/ieee80211.h>
+-#include <uapi/linux/if_arp.h>
++#include <linux/if_arp.h>
+ #include <net/mac80211.h>
+ 
+ 
+--- a/drivers/net/wireless/mwifiex/sta_rx.c
++++ b/drivers/net/wireless/mwifiex/sta_rx.c
+@@ -17,7 +17,7 @@
+  * this warranty disclaimer.
+  */
+ 
+-#include <uapi/linux/ipv6.h>
++#include <linux/ipv6.h>
+ #include <net/ndisc.h>
+ #include "decl.h"
+ #include "ioctl.h"
-- 
1.7.10.4

