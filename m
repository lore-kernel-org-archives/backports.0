Return-path: <backports-owner@vger.kernel.org>
Received: from 162-17-110-37-static.hfc.comcastbusiness.net ([162.17.110.37]:44889
	"EHLO stuffed.shaftnet.org" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1750964Ab3HQEXL (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 17 Aug 2013 00:23:11 -0400
From: Solomon Peachy <pizza@shaftnet.org>
To: backports@vger.kernel.org
Cc: Solomon Peachy <pizza@shaftnet.org>
Subject: [PATCH 4/4] backports: cw1200 requires >=2.6.35
Date: Sat, 17 Aug 2013 00:23:03 -0400
Message-Id: <1376713383-2624-4-git-send-email-pizza@shaftnet.org> (sfid-20130817_062316_491388_12044471)
In-Reply-To: <1376713383-2624-1-git-send-email-pizza@shaftnet.org>
References: <1376713383-2624-1-git-send-email-pizza@shaftnet.org>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The reason for the >=2.6.35 is mainly due to the multicast changes;
patch is coming to fix this in due course.

Signed-off-by: Solomon Peachy <pizza@shaftnet.org>
---
 dependencies | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/dependencies b/dependencies
index f1e514b..31427af 100644
--- a/dependencies
+++ b/dependencies
@@ -36,6 +36,8 @@ P54_SPI 2.6.25
 WL1251_SDIO 2.6.37
 WLCORE_SDIO 2.6.38
 
+CW1200 2.6.35
+
 BRCMFMAC 2.6.29
 
 WL_TI 2.6.30
-- 
1.8.3.1

