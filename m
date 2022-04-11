Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6BA7C433F5
	for <backports@archiver.kernel.org>; Mon, 11 Apr 2022 07:49:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233932AbiDKHva (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 11 Apr 2022 03:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240473AbiDKHv0 (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 11 Apr 2022 03:51:26 -0400
X-Greylist: delayed 558 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 11 Apr 2022 00:49:08 PDT
Received: from icts-p-cavspool-1.kulnet.kuleuven.be (icts-p-cavspool-1.kulnet.kuleuven.be [134.58.240.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D2015FF0
        for <backports@vger.kernel.org>; Mon, 11 Apr 2022 00:49:08 -0700 (PDT)
Received: from icts-p-cavuit-3.kulnet.kuleuven.be (icts-p-cavuit-3.kulnet.kuleuven.be [IPv6:2a02:2c40:0:c0::25:133])
        by icts-p-cavspool-1.kulnet.kuleuven.be (Postfix) with ESMTP id 16EB3F8D
        for <backports@vger.kernel.org>; Mon, 11 Apr 2022 09:39:51 +0200 (CEST)
X-KULeuven-Envelope-From: mathy.vanhoef@kuleuven.be
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: AC4EE2079D.A6D02
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-1.kuleuven.be (icts-p-ceifnet-smtps.service.icts.svcd [IPv6:2a02:2c40:0:51:135:242:ac11:14])
        by icts-p-cavuit-3.kulnet.kuleuven.be (Postfix) with ESMTP id AC4EE2079D
        for <backports@vger.kernel.org>; Mon, 11 Apr 2022 09:39:44 +0200 (CEST)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: 
X-CAV-Cluster: smtps
Received: from localhost.localdomain (unknown [IPv6:2001:4455:26b:9700:5ca6:2045:fde1:c64])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by icts-p-ceifnet-smtps-1.kuleuven.be (Postfix) with ESMTPSA id 590ECD4F4935A;
        Mon, 11 Apr 2022 09:39:43 +0200 (CEST)
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From:   Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
To:     backports@vger.kernel.org
Cc:     Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
Subject: [PATCHv2] backports: Update hwsim defconfig
Date:   Mon, 11 Apr 2022 15:39:31 +0800
Message-Id: <20220411073931.19198-1-Mathy.Vanhoef@kuleuven.be>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

In the current hwsim config no rate control algorithm is enabled. This
means that, when using defconfig-hwsim, the mac80211_hwsim fails to load
with the following error:

	[  132.155183] ieee80211 phy0: Failed to select rate control algorithm
	[  132.155196] ieee80211 phy0: Failed to initialize rate control algorithm

Fix this by enabling rate control algorithms in the provided hwsim
config.

Experiments were also less reliable when WEXT was enabled. So this patch
also disables WEXT when using defconfig-hwsim to make the default more
reliable for users.

Signed-off-by: Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
---
 backport/defconfigs/hwsim | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/backport/defconfigs/hwsim b/backport/defconfigs/hwsim
index 9d8006ea..7dda0cd9 100644
--- a/backport/defconfigs/hwsim
+++ b/backport/defconfigs/hwsim
@@ -1,11 +1,15 @@
 CPTCFG_CFG80211=m
 CPTCFG_CFG80211_DEFAULT_PS=y
 CPTCFG_CFG80211_DEBUGFS=y
-CPTCFG_CFG80211_WEXT=y
+# CPTCFG_CFG80211_WEXT is not set
 CPTCFG_MAC80211=m
+
 # CPTCFG_MAC80211_RC_PID is not set
-# CPTCFG_MAC80211_RC_MINSTREL is not set
-# CPTCFG_MAC80211_RC_DEFAULT_MINSTREL is not set
+CPTCFG_MAC80211_HAS_RC=y
+CPTCFG_MAC80211_RC_MINSTREL=y
+CPTCFG_MAC80211_RC_DEFAULT_MINSTREL=y
+CPTCFG_MAC80211_RC_DEFAULT="minstrel_ht"
+
 CPTCFG_MAC80211_DEBUGFS=y
 CPTCFG_MAC80211_MESSAGE_TRACING=y
 CPTCFG_WLAN=y
-- 
2.35.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
