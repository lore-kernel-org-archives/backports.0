Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:54807 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752381Ab3HPR1k (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 16 Aug 2013 13:27:40 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 09/13] backports: add some new regulator drivers to default config
Date: Fri, 16 Aug 2013 19:26:39 +0200
Message-Id: <1376674003-5801-9-git-send-email-hauke@hauke-m.de> (sfid-20130816_192741_603107_B825D54D)
In-Reply-To: <1376674003-5801-1-git-send-email-hauke@hauke-m.de>
References: <1376674003-5801-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/defconfigs/regulator |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/backport/defconfigs/regulator b/backport/defconfigs/regulator
index c080747..0b1bc27 100644
--- a/backport/defconfigs/regulator
+++ b/backport/defconfigs/regulator
@@ -1,4 +1,5 @@
 CPTCFG_REGULATOR=y
+CPTCFG_REGULATOR_88PM800=y
 CPTCFG_REGULATOR_88PM8607=y
 CPTCFG_REGULATOR_AAT2870=y
 CPTCFG_REGULATOR_AB3100=y
@@ -24,6 +25,7 @@ CPTCFG_REGULATOR_LP8755=y
 CPTCFG_REGULATOR_LP8788=y
 CPTCFG_REGULATOR_MAX1586=y
 CPTCFG_REGULATOR_MAX77686=y
+CPTCFG_REGULATOR_MAX77693=y
 CPTCFG_REGULATOR_MAX8649=y
 CPTCFG_REGULATOR_MAX8660=y
 CPTCFG_REGULATOR_MAX8907=y
@@ -38,6 +40,7 @@ CPTCFG_REGULATOR_MC13XXX_CORE=y
 CPTCFG_REGULATOR_PALMAS=y
 CPTCFG_REGULATOR_PCAP=y
 CPTCFG_REGULATOR_PCF50633=y
+CPTCFG_REGULATOR_PFUZE100=y
 CPTCFG_REGULATOR_RC5T583=y
 CPTCFG_REGULATOR_S2MPS11=y
 CPTCFG_REGULATOR_S5M8767=y
-- 
1.7.10.4

