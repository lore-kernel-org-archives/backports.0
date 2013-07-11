Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:44232 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756938Ab3GKWMt (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 11 Jul 2013 18:12:49 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 13/19] backports: add NET_CORE config option
Date: Fri, 12 Jul 2013 00:11:36 +0200
Message-Id: <1373580702-24752-15-git-send-email-hauke@hauke-m.de> (sfid-20130712_001256_402924_1D9E7C6F)
In-Reply-To: <1373580702-24752-1-git-send-email-hauke@hauke-m.de>
References: <1373580702-24752-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Upstream commit 01d7e21c43c0255a0f107b18ce05b2350f561f84

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

