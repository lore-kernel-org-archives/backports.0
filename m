Return-path: <backports-owner@vger.kernel.org>
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:1064 "EHLO
	mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751347AbaJJKNK (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 10 Oct 2014 06:13:10 -0400
From: Arend van Spriel <arend@broadcom.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
CC: <backports@vger.kernel.org>, Arend van Spriel <arend@broadcom.com>
Subject: [PATCH] defconfigs: enable PCIe support in brcmfmac defconfig
Date: Fri, 10 Oct 2014 12:13:05 +0200
Message-ID: <1412935985-6665-1-git-send-email-arend@broadcom.com> (sfid-20141010_121312_894873_E8461661)
MIME-Version: 1.0
Content-Type: text/plain
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

In 3.17 kernel the brcmfmac supports PCIe host interface. So enable
support when selecting defconfig-brcmfmac.

Signed-off-by: Arend van Spriel <arend@broadcom.com>
---
 backport/defconfigs/brcmfmac | 1 +
 1 file changed, 1 insertion(+)

diff --git a/backport/defconfigs/brcmfmac b/backport/defconfigs/brcmfmac
index 72b2859..f4657c7 100644
--- a/backport/defconfigs/brcmfmac
+++ b/backport/defconfigs/brcmfmac
@@ -4,3 +4,4 @@ CPTCFG_WLAN=y
 CPTCFG_BRCMFMAC=m
 CPTCFG_BRCMFMAC_SDIO=y
 CPTCFG_BRCMFMAC_USB=y
+CPTCFG_BRCMFMAC_PCIE=y
-- 
1.9.1

