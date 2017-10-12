Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.63.242]:42242 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751759AbdJLVAb (ORCPT
        <rfc822;backports@vger.kernel.org>); Thu, 12 Oct 2017 17:00:31 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 3/5] copy-list: move mpls includes
Date: Thu, 12 Oct 2017 23:00:23 +0200
Message-Id: <20171012210025.7490-3-johannes@sipsolutions.net> (sfid-20171012_230033_445238_ABBF2088)
In-Reply-To: <20171012210025.7490-1-johannes@sipsolutions.net>
References: <20171012210025.7490-1-johannes@sipsolutions.net>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 copy-list | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/copy-list b/copy-list
index 11fd3455d611..0bd232f44b56 100644
--- a/copy-list
+++ b/copy-list
@@ -65,6 +65,11 @@ net/Makefile
 net/Kconfig
 net/wireless/
 net/mac80211/
+# MPLS labels, checked on skb->protocol on the
+# respective 802 family, only ethernet seems to use
+# this right now, see 960d97f95
+include/linux/mpls.h
+include/uapi/linux/mpls.h
 
 drivers/net/wireless/ath/
 drivers/ssb/
@@ -113,9 +118,3 @@ include/uapi/linux/nfc.h
 drivers/nfc/
 include/linux/platform_data/nfcmrvl.h
 include/linux/platform_data/nxp-nci.h
-
-# MPLS labels, checked on skb->protocol on the
-# respective 802 family, only ethernet seems to use
-# this right now, see 960d97f95
-include/linux/mpls.h
-include/uapi/linux/mpls.h
-- 
2.14.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
