Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C3FC433F5
	for <backports@archiver.kernel.org>; Fri, 18 Feb 2022 19:18:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236675AbiBRTSW (ORCPT <rfc822;backports@archiver.kernel.org>);
        Fri, 18 Feb 2022 14:18:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236628AbiBRTSV (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 18 Feb 2022 14:18:21 -0500
X-Greylist: delayed 426 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 18 Feb 2022 11:17:59 PST
Received: from icts-p-cavspool-1.kulnet.kuleuven.be (icts-p-cavspool-1.kulnet.kuleuven.be [134.58.240.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E43206DF9
        for <backports@vger.kernel.org>; Fri, 18 Feb 2022 11:17:59 -0800 (PST)
Received: from icts-p-cavuit-3.kulnet.kuleuven.be (icts-p-cavuit-3.kulnet.kuleuven.be [134.58.240.133])
        by icts-p-cavspool-1.kulnet.kuleuven.be (Postfix) with ESMTP id 3619AF48
        for <backports@vger.kernel.org>; Fri, 18 Feb 2022 20:10:54 +0100 (CET)
X-KULeuven-Envelope-From: mathy.vanhoef@kuleuven.be
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: A8A5B207D4.A4475
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-1.kuleuven.be (icts-p-ceifnet-smtps.service.icts.svcd [IPv6:2a02:2c40:0:51:130:242:ac11:24])
        by icts-p-cavuit-3.kulnet.kuleuven.be (Postfix) with ESMTP id A8A5B207D4
        for <backports@vger.kernel.org>; Fri, 18 Feb 2022 20:10:48 +0100 (CET)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: 
X-CAV-Cluster: smtps
Received: from localhost.localdomain (ip-62-235-85-165.dsl.scarlet.be [62.235.85.165])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by icts-p-ceifnet-smtps-1.kuleuven.be (Postfix) with ESMTPSA id 7D434D4FCBAEE;
        Fri, 18 Feb 2022 20:10:48 +0100 (CET)
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From:   Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
To:     backports@vger.kernel.org
Cc:     Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
Subject: [PATCH] backports: Update hwsim defconfig
Date:   Fri, 18 Feb 2022 20:10:38 +0100
Message-Id: <20220218191038.42064-1-Mathy.Vanhoef@kuleuven.be>
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
index 9d8006ea..9f054c79 100644
--- a/backport/defconfigs/hwsim
+++ b/backport/defconfigs/hwsim
@@ -1,11 +1,15 @@
 CPTCFG_CFG80211=m
 CPTCFG_CFG80211_DEFAULT_PS=y
 CPTCFG_CFG80211_DEBUGFS=y
-CPTCFG_CFG80211_WEXT=y
+CPTCFG_CFG80211_WEXT=n
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
