Return-path: <backports-owner@vger.kernel.org>
Received: from static.88-198-24-112.clients.your-server.de ([88.198.24.112]:44126
	"EHLO nbd.name" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752916AbaKPNkD (ORCPT
	<rfc822;backports@vger.kernel.org>); Sun, 16 Nov 2014 08:40:03 -0500
From: Felix Fietkau <nbd@openwrt.org>
To: backports@vger.kernel.org
Cc: hauke@hauke-m.de
Subject: [PATCH v2 2/3] backports: add include/uapi/linux/pci_regs.h to copy-list
Date: Sun, 16 Nov 2014 14:39:58 +0100
Message-Id: <1416145199-44209-2-git-send-email-nbd@openwrt.org> (sfid-20141116_144007_509454_97C061D6)
In-Reply-To: <1416145199-44209-1-git-send-email-nbd@openwrt.org>
References: <1416145199-44209-1-git-send-email-nbd@openwrt.org>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Fixes a recent iwlwifi build error

Signed-off-by: Felix Fietkau <nbd@openwrt.org>
---
 copy-list | 1 +
 1 file changed, 1 insertion(+)

diff --git a/copy-list b/copy-list
index 75ef52f..6a6cb01 100644
--- a/copy-list
+++ b/copy-list
@@ -23,6 +23,7 @@ include/linux/wireless.h
 include/uapi/linux/wireless.h
 include/linux/ieee80211.h
 include/linux/pci_ids.h
+include/uapi/linux/pci_regs.h
 include/linux/mmc/sdio_ids.h
 include/linux/ath9k_platform.h
 include/uapi/linux/wil6210_uapi.h
-- 
2.1.2

