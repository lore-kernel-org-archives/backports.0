Return-path: <backports-owner@vger.kernel.org>
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:11912 "EHLO
	mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752281AbbIIMWy (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 9 Sep 2015 08:22:54 -0400
From: Arend van Spriel <arend@broadcom.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
CC: <backports@vger.kernel.org>, Arend van Spriel <arend@broadcom.com>
Subject: [PATCH] backports: fix typo in copy-list
Date: Wed, 9 Sep 2015 14:22:49 +0200
Message-ID: <1441801369-6348-1-git-send-email-arend@broadcom.com> (sfid-20150909_142256_293298_2400C2D6)
MIME-Version: 1.0
Content-Type: text/plain
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The platform data file is called st-nci.h instead of st_nci.h.

Signed-off-by: Arend van Spriel <arend@broadcom.com>
---
 copy-list | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/copy-list b/copy-list
index 2264d01..d0341c3 100644
--- a/copy-list
+++ b/copy-list
@@ -145,7 +145,7 @@ include/linux/platform_data/nfcmrvl.h
 include/linux/platform_data/nxp-nci.h
 include/linux/platform_data/pn544.h
 include/linux/platform_data/st21nfca.h
-include/linux/platform_data/st_nci.h
+include/linux/platform_data/st-nci.h
 
 # Media
 include/media/
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
