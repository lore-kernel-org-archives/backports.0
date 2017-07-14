Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36292 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752774AbdGNDH6 (ORCPT
        <rfc822;backports@vger.kernel.org>); Thu, 13 Jul 2017 23:07:58 -0400
Received: by mail-pg0-f65.google.com with SMTP id y129so9000507pgy.3
        for <backports@vger.kernel.org>; Thu, 13 Jul 2017 20:07:58 -0700 (PDT)
From: AceLan Kao <acelan.kao@canonical.com>
To: hauke@hauke-m.de, mcgrof@kernel.org, backports@vger.kernel.org
Subject: [PATCH 1/2] copy-list: remove wil6210_uapi.h
Date: Fri, 14 Jul 2017 11:07:53 +0800
Message-Id: <1500001674-24553-1-git-send-email-acelan.kao@canonical.com> (sfid-20170714_050800_578808_FD90DC9D)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

>From below commit, the file has been removed
   a520b49 wil6210: remove ioctl interface

Signed-off-by: AceLan Kao <acelan.kao@canonical.com>
---
 copy-list | 1 -
 1 file changed, 1 deletion(-)

diff --git a/copy-list b/copy-list
index a61e95b..52df0ea 100644
--- a/copy-list
+++ b/copy-list
@@ -31,7 +31,6 @@ include/linux/pci_ids.h
 include/uapi/linux/pci_regs.h
 include/linux/mmc/sdio_ids.h
 include/linux/ath9k_platform.h
-include/uapi/linux/wil6210_uapi.h
 include/linux/wl12xx.h
 include/linux/rndis.h
 include/linux/bcm47xx_wdt.h
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe backports" in
