Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:48699 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752843AbbF1V7a (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 28 Jun 2015 17:59:30 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 02/14] copy: rename st21nfcb.h to st_nci.h
Date: Sun, 28 Jun 2015 23:59:08 +0200
Message-Id: <1435528760-19913-3-git-send-email-hauke@hauke-m.de> (sfid-20150628_235934_153534_33C54E2A)
In-Reply-To: <1435528760-19913-1-git-send-email-hauke@hauke-m.de>
References: <1435528760-19913-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

st21nfcb.h was renamed in the upstream kernel, do the same for
backports. This rename was done in this commit:
commit ed06aeefdac348cfb91a3db5fe1067e3202afd70
Author: Christophe Ricard <christophe.ricard@gmail.com>
Date:   Tue Jun 9 22:26:05 2015 +0200

    nfc: st-nci: Rename st21nfcb to st-nci

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 copy-list | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/copy-list b/copy-list
index a679c77..1583512 100644
--- a/copy-list
+++ b/copy-list
@@ -144,7 +144,7 @@ drivers/nfc/
 include/linux/platform_data/nxp-nci.h
 include/linux/platform_data/pn544.h
 include/linux/platform_data/st21nfca.h
-include/linux/platform_data/st21nfcb.h
+include/linux/platform_data/st_nci.h
 
 # Media
 include/media/
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe backports" in
