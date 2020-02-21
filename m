Return-Path: <SRS0=6Pme=4J=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04CCCC35646
	for <backports@archiver.kernel.org>; Fri, 21 Feb 2020 08:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C90EE2067D
	for <backports@archiver.kernel.org>; Fri, 21 Feb 2020 08:56:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730680AbgBUI4e (ORCPT <rfc822;backports@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:56:34 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:54714 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730373AbgBUI4e (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 21 Feb 2020 03:56:34 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1j546q-00EncU-DT; Fri, 21 Feb 2020 09:56:32 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     backports@vger.kernel.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 05/15] backports: Do not access rx_count and rx_list attributes
Date:   Fri, 21 Feb 2020 09:56:14 +0100
Message-Id: <20200221085624.6213-3-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200221085624.6213-1-johannes@sipsolutions.net>
References: <20200221085624.6213-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

From: Hauke Mehrtens <hauke@hauke-m.de>

The rx_count and rx_list attributes were only added in kernel 5.4 in
commit 323ebb61e32b ("net: use listified RX for handling GRO_NORMAL skbs")

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
Link: https://lore.kernel.org/r/20200126231336.2573-1-hauke@hauke-m.de
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 patches/0092-listified-rx/iwlwifi.patch | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 patches/0092-listified-rx/iwlwifi.patch

diff --git a/patches/0092-listified-rx/iwlwifi.patch b/patches/0092-listified-rx/iwlwifi.patch
new file mode 100644
index 000000000000..925010fd5a5c
--- /dev/null
+++ b/patches/0092-listified-rx/iwlwifi.patch
@@ -0,0 +1,19 @@
+The rx_count and rx_list attributes were only added in kernel 5.4 in
+commit 323ebb61e32b ("net: use listified RX for handling GRO_NORMAL skbs")
+
+--- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
++++ b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
+@@ -1531,11 +1531,13 @@ out:
+ 	if (napi->poll) {
+ 		napi_gro_flush(napi, false);
+ 
++#if LINUX_VERSION_IS_GEQ(5,4,0)
+ 		if (napi->rx_count) {
+ 			netif_receive_skb_list(&napi->rx_list);
+ 			INIT_LIST_HEAD(&napi->rx_list);
+ 			napi->rx_count = 0;
+ 		}
++#endif
+ 	}
+ 
+ 	iwl_pcie_rxq_restock(trans, rxq);
-- 
2.24.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
