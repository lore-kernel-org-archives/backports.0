Return-path: <backports-owner@vger.kernel.org>
Received: from lpdvrndsmtp01.broadcom.com ([192.19.229.170]:55285 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751116AbdFVHd0 (ORCPT
        <rfc822;backports@vger.kernel.org>); Thu, 22 Jun 2017 03:33:26 -0400
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: backports@vger.kernel.org,
        Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [PATCH] copy-list: remove nfc platform data headers
Date: Thu, 22 Jun 2017 08:33:21 +0100
Message-Id: <1498116801-18498-1-git-send-email-arend.vanspriel@broadcom.com> (sfid-20170622_093328_269068_90CE6103)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

These files got removed from upstream kernel so they result in
backport failure.

Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
 copy-list | 2 --
 1 file changed, 2 deletions(-)

diff --git a/copy-list b/copy-list
index b284771..3b1fa2a 100644
--- a/copy-list
+++ b/copy-list
@@ -113,8 +113,6 @@ include/uapi/linux/nfc.h
 drivers/nfc/
 include/linux/platform_data/nfcmrvl.h
 include/linux/platform_data/nxp-nci.h
-include/linux/platform_data/pn544.h
-include/linux/platform_data/st21nfca.h
 include/linux/platform_data/st-nci.h
 
 # MPLS labels, checked on skb->protocol on the
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
