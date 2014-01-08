Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52728 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755337AbaAHKox (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 8 Jan 2014 05:44:53 -0500
From: Stefan Assmann <sassmann@kpanic.de>
To: mcgrof@kernel.org
Cc: backports@vger.kernel.org, hauke@hauke-m.de, sassmann@kpanic.de
Subject: [PATCH v3 11/11] backports: enable igb and add defconfig
Date: Wed,  8 Jan 2014 11:44:14 +0100
Message-Id: <1389177854-24292-12-git-send-email-sassmann@kpanic.de> (sfid-20140108_120435_726611_EC7A1E05)
In-Reply-To: <1389177854-24292-1-git-send-email-sassmann@kpanic.de>
References: <1389177854-24292-1-git-send-email-sassmann@kpanic.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Add defconfig and necessary files to copy-list.

Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
---
 backport/defconfigs/igb | 2 ++
 copy-list               | 4 ++++
 2 files changed, 6 insertions(+)
 create mode 100644 backport/defconfigs/igb

diff --git a/backport/defconfigs/igb b/backport/defconfigs/igb
new file mode 100644
index 0000000..8045257
--- /dev/null
+++ b/backport/defconfigs/igb
@@ -0,0 +1,2 @@
+CPTCFG_NET_VENDOR_INTEL=y
+CPTCFG_IGB=m
diff --git a/copy-list b/copy-list
index 9444aff..2b2e177 100644
--- a/copy-list
+++ b/copy-list
@@ -100,6 +100,10 @@ drivers/net/ethernet/broadcom/Makefile
 drivers/net/ethernet/broadcom/b44.c
 drivers/net/ethernet/broadcom/b44.h
 
+drivers/net/ethernet/intel/Kconfig
+drivers/net/ethernet/intel/Makefile
+drivers/net/ethernet/intel/igb/
+
 # wwan drivers
 include/uapi/linux/usb/cdc.h
 include/uapi/linux/usb/cdc-wdm.h
-- 
1.8.4.2

