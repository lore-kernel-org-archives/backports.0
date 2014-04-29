Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:43874 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932736AbaD2Jvl (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 29 Apr 2014 05:51:41 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 1/2] backports: remove IWLWIFI_P2P from iwlwifi defconfig
Date: Tue, 29 Apr 2014 11:31:27 +0200
Message-Id: <1398763888-20688-1-git-send-email-johannes@sipsolutions.net> (sfid-20140429_115142_806267_B98BB630)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

This symbol is obsolete, it was removed upstream, so just
remove it from the defconfig file as well.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/defconfigs/iwlwifi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/backport/defconfigs/iwlwifi b/backport/defconfigs/iwlwifi
index 9563c8bcd809..fe7c6c140059 100644
--- a/backport/defconfigs/iwlwifi
+++ b/backport/defconfigs/iwlwifi
@@ -15,4 +15,3 @@ CPTCFG_IWLMVM=m
 CPTCFG_IWLWIFI_DEBUG=y
 CPTCFG_IWLWIFI_DEBUGFS=y
 CPTCFG_IWLWIFI_DEVICE_TRACING=y
-CPTCFG_IWLWIFI_P2P=y
-- 
1.9.0

