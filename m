Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:9539 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751724AbaA2JUR (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 29 Jan 2014 04:20:17 -0500
From: Stefan Assmann <sassmann@kpanic.de>
To: mcgrof@kernel.org
Cc: backports@vger.kernel.org, hauke@hauke-m.de, sassmann@kpanic.de
Subject: [PATCH v4 12/12] backports: enable igb and add defconfig
Date: Wed, 29 Jan 2014 10:19:09 +0100
Message-Id: <1390987149-11171-13-git-send-email-sassmann@kpanic.de> (sfid-20140129_102020_182850_969FEFB7)
In-Reply-To: <1390987149-11171-1-git-send-email-sassmann@kpanic.de>
References: <1390987149-11171-1-git-send-email-sassmann@kpanic.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Add defconfig and necessary files to copy-list.

Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
---
 backport/defconfigs/igb |    2 ++
 copy-list               |    4 ++++
 2 files changed, 6 insertions(+), 0 deletions(-)
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
index c516135..bde95a1 100644
--- a/copy-list
+++ b/copy-list
@@ -101,6 +101,10 @@ drivers/net/ethernet/broadcom/Makefile
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
1.7.1

