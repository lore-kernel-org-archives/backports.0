Return-path: <backports-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:54450 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161236Ab3DEPQ6 (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 5 Apr 2013 11:16:58 -0400
From: Thierry Escande <thierry.escande@linux.intel.com>
To: backports@vger.kernel.org
Subject: [PATCH v2 4/5] build: enable NFC build
Date: Fri,  5 Apr 2013 17:16:53 +0200
Message-Id: <1365175014-6028-4-git-send-email-thierry.escande@linux.intel.com> (sfid-20130405_171701_387162_1838CC96)
Content-Type: text/plain; charset = "utf-8"
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Thierry Escande <thierry.escande@linux.intel.com>
---
 backport/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/backport/Kconfig b/backport/Kconfig
index 87e3869..eb74b08 100644
--- a/backport/Kconfig
+++ b/backport/Kconfig
@@ -35,4 +35,4 @@ source drivers/net/ethernet/Kconfig
 source drivers/ssb/Kconfig
 source drivers/bcma/Kconfig
 
-# source net/nfc/Kconfig
+source net/nfc/Kconfig
-- 
1.7.10.4

