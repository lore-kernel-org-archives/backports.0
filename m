Return-path: <backports-owner@vger.kernel.org>
Received: from static.88-198-24-112.clients.your-server.de ([88.198.24.112]:34412
	"EHLO nbd.name" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932767AbaKMUto (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 13 Nov 2014 15:49:44 -0500
From: Felix Fietkau <nbd@openwrt.org>
To: backports@vger.kernel.org
Cc: hauke@hauke-m.de
Subject: [PATCH 2/3] backports: add include/uapi/linux/pci_regs.h to copy-list
Date: Thu, 13 Nov 2014 21:49:39 +0100
Message-Id: <1415911780-52533-2-git-send-email-nbd@openwrt.org> (sfid-20141113_214946_239152_1F19A652)
In-Reply-To: <1415911780-52533-1-git-send-email-nbd@openwrt.org>
References: <1415911780-52533-1-git-send-email-nbd@openwrt.org>
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

