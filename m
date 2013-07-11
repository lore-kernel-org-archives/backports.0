Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:44174 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756796Ab3GKWMV (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 11 Jul 2013 18:12:21 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 04/19] backports: build NFC_MEI_PHY only on >= 3.10
Date: Fri, 12 Jul 2013 00:11:27 +0200
Message-Id: <1373580702-24752-6-git-send-email-hauke@hauke-m.de> (sfid-20130712_001232_108466_15B889A6)
In-Reply-To: <1373580702-24752-1-git-send-email-hauke@hauke-m.de>
References: <1373580702-24752-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Upstream commit 7ff43c90253ab78ade9696eb1f73964542710304

The MEI NFC driver needs include/linux/mei_cl_bus.h which was added
with kernel 3.10.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 dependencies |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/dependencies b/dependencies
index 07fd3bf..ab18807 100644
--- a/dependencies
+++ b/dependencies
@@ -201,3 +201,5 @@ BT_HIDP 2.6.33
 NFC 3.1
 
 INTEL_IPS 3.2
+
+NFC_MEI_PHY 3.10
-- 
1.7.10.4

