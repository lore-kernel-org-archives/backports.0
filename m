Return-path: <backports-owner@vger.kernel.org>
Received: from mail-gw2-out.broadcom.com ([216.31.210.63]:25831 "EHLO
	mail-gw2-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753830AbbK3LxL (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 30 Nov 2015 06:53:11 -0500
From: Arend van Spriel <arend@broadcom.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
CC: <backports@vger.kernel.org>, Arend van Spriel <arend@broadcom.com>
Subject: [PATCH] patches: fix path in name_assign_type patch
Date: Mon, 30 Nov 2015 12:53:07 +0100
Message-ID: <1448884387-20806-1-git-send-email-arend@broadcom.com> (sfid-20151130_125314_276815_BDEC0377)
MIME-Version: 1.0
Content-Type: text/plain
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Patch for brcmfmac need update path as it now resides under
the broadcom vendor directory.

Signed-off-by: Arend van Spriel <arend@broadcom.com>
---
 .../network/0055-name_assign_type/brcmfmac.patch                      | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/patches/collateral-evolutions/network/0055-name_assign_type/brcmfmac.patch b/patches/collateral-evolutions/network/0055-name_assign_type/brcmfmac.patch
index c68e9d0..bcbac24 100644
--- a/patches/collateral-evolutions/network/0055-name_assign_type/brcmfmac.patch
+++ b/patches/collateral-evolutions/network/0055-name_assign_type/brcmfmac.patch
@@ -1,5 +1,5 @@
---- a/drivers/net/wireless/brcm80211/brcmfmac/p2p.c
-+++ b/drivers/net/wireless/brcm80211/brcmfmac/p2p.c
+--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
++++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
 @@ -2204,7 +2204,9 @@ struct wireless_dev *brcmf_p2p_add_vif(s
  	}
  
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
