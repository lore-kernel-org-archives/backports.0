Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:51291 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753946Ab3FINYT (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 9 Jun 2013 09:24:19 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 4/5] backports: add default config for alx
Date: Sun,  9 Jun 2013 15:23:52 +0200
Message-Id: <1370784233-18228-4-git-send-email-hauke@hauke-m.de> (sfid-20130609_152420_668542_E262AD1A)
In-Reply-To: <1370784233-18228-1-git-send-email-hauke@hauke-m.de>
References: <1370784233-18228-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/defconfigs/alx |    1 +
 1 file changed, 1 insertion(+)
 create mode 100644 backport/defconfigs/alx

diff --git a/backport/defconfigs/alx b/backport/defconfigs/alx
new file mode 100644
index 0000000..b4ae66f
--- /dev/null
+++ b/backport/defconfigs/alx
@@ -0,0 +1 @@
+CPTCFG_ALX=m
-- 
1.7.10.4

