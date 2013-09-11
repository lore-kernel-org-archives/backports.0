Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:40738 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751716Ab3IKMMe (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 11 Sep 2013 08:12:34 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 10/11] backports: do not build REGULATOR_PALMAS on older kernel versions.
Date: Wed, 11 Sep 2013 14:11:54 +0200
Message-Id: <1378901515-14206-11-git-send-email-hauke@hauke-m.de> (sfid-20130911_141831_330568_DF99D783)
In-Reply-To: <1378901515-14206-1-git-send-email-hauke@hauke-m.de>
References: <1378901515-14206-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

REGULATOR_PALMASi now needs some symbols form headers of very recent
kernel versions.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 dependencies |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dependencies b/dependencies
index a1ec791..142ea6b 100644
--- a/dependencies
+++ b/dependencies
@@ -99,7 +99,7 @@ REGULATOR_MAX8998 3.11
 REGULATOR_MC13783 3.6
 REGULATOR_MC13892 3.6
 REGULATOR_MC13XXX_CORE 3.6
-REGULATOR_PALMAS 3.11
+REGULATOR_PALMAS 3.12
 REGULATOR_PCAP 3.6
 REGULATOR_PCF50633 3.8
 REGULATOR_PFUZE100 3.6
-- 
1.7.10.4

