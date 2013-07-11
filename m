Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:44205 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756891Ab3GKWMf (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 11 Jul 2013 18:12:35 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 09/19] backports: add default config for alx
Date: Fri, 12 Jul 2013 00:11:32 +0200
Message-Id: <1373580702-24752-11-git-send-email-hauke@hauke-m.de> (sfid-20130712_001240_617658_4CA79D1B)
In-Reply-To: <1373580702-24752-1-git-send-email-hauke@hauke-m.de>
References: <1373580702-24752-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Upstream commit 95c69b5d45e07b865c13fade1f1d61c6e55c5cfc

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
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

