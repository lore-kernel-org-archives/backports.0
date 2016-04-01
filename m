Return-path: <backports-owner@vger.kernel.org>
Received: from mail-gw2-out.broadcom.com ([216.31.210.63]:49477 "EHLO
	mail-gw2-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753274AbcDAIdn (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 1 Apr 2016 04:33:43 -0400
From: Arend van Spriel <arend@broadcom.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: backports@vger.kernel.org, Arend van Spriel <arend@broadcom.com>
Subject: [PATCH 2/2] defconfig: brcmsmac: remove selection of BCMA GPIO
Date: Fri,  1 Apr 2016 10:33:39 +0200
Message-Id: <1459499619-16641-2-git-send-email-arend@broadcom.com> (sfid-20160401_103345_348579_0D94CF5D)
In-Reply-To: <1459499619-16641-1-git-send-email-arend@broadcom.com>
References: <1459499619-16641-1-git-send-email-arend@broadcom.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

BCMA GPIO driver now relies on functionality that is available
since v4.5. Just drop GPIO which disables brcmsmac led functionality
so it can be backported to kernels prior to 4.5.

Signed-off-by: Arend van Spriel <arend@broadcom.com>
---
 backport/defconfigs/brcmsmac | 1 -
 1 file changed, 1 deletion(-)

diff --git a/backport/defconfigs/brcmsmac b/backport/defconfigs/brcmsmac
index a1c56bc..e4ca066 100644
--- a/backport/defconfigs/brcmsmac
+++ b/backport/defconfigs/brcmsmac
@@ -6,4 +6,3 @@ CPTCFG_WLAN=y
 CPTCFG_BRCMSMAC=m
 CPTCFG_BCMA=m
 CPTCFG_BCMA_HOST_PCI=y
-CPTCFG_BCMA_DRIVER_GPIO=y
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
