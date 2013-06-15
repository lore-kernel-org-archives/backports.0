Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:39360 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751048Ab3FOPic (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 15 Jun 2013 11:38:32 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 4/8] backports: add NET_CORE config option
Date: Sat, 15 Jun 2013 17:37:54 +0200
Message-Id: <1371310678-26491-5-git-send-email-hauke@hauke-m.de> (sfid-20130615_173833_291932_2650F3E2)
In-Reply-To: <1371310678-26491-1-git-send-email-hauke@hauke-m.de>
References: <1371310678-26491-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

NET_CORE was added with kernel 3.2 and before this patch no Ethernet
driver was build on older kernel versions.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/Kconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/backport/Kconfig b/backport/Kconfig
index d342647..c465ad1 100644
--- a/backport/Kconfig
+++ b/backport/Kconfig
@@ -17,6 +17,8 @@ source Kconfig.versions
 # some hacks ...
 config WIRELESS
 	def_bool y
+config NET_CORE
+	def_bool y
 config EXPERT
 	def_bool y
 
-- 
1.7.10.4

