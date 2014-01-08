Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:46698 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753751AbaAHAfH (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 7 Jan 2014 19:35:07 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 06/17] backports: make b44 depend on kernel > 2.6.28
Date: Wed,  8 Jan 2014 01:34:23 +0100
Message-Id: <1389141274-2002-7-git-send-email-hauke@hauke-m.de> (sfid-20140108_013508_785720_57E4A645)
In-Reply-To: <1389141274-2002-1-git-send-email-hauke@hauke-m.de>
References: <1389141274-2002-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The mdio bus functions where introduced in that version.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 dependencies |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/dependencies b/dependencies
index 31de845..e4c1cb7 100644
--- a/dependencies
+++ b/dependencies
@@ -39,6 +39,9 @@ CW1200_WLAN_SPI 2.6.35
 
 BRCMFMAC 2.6.29
 
+# b44 depends on mdio_bus
+B44 2.6.28
+
 WL_TI 2.6.30
 WLCORE 2.6.30
 # requires irq_modify_status() which was only exported in 3.0
-- 
1.7.10.4

