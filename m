Return-Path: <SRS0=xZrn=6D=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96EBAC54FCB
	for <backports@archiver.kernel.org>; Sun, 19 Apr 2020 17:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D420206E9
	for <backports@archiver.kernel.org>; Sun, 19 Apr 2020 17:11:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbgDSRLF (ORCPT <rfc822;backports@archiver.kernel.org>);
        Sun, 19 Apr 2020 13:11:05 -0400
Received: from mout-p-202.mailbox.org ([80.241.56.172]:15400 "EHLO
        mout-p-202.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbgDSRLE (ORCPT
        <rfc822;backports@vger.kernel.org>); Sun, 19 Apr 2020 13:11:04 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 494xDj0x6XzQlFh;
        Sun, 19 Apr 2020 19:11:01 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter05.heinlein-hosting.de (spamfilter05.heinlein-hosting.de [80.241.56.123]) (amavisd-new, port 10030)
        with ESMTP id pwNo0T7h9J3r; Sun, 19 Apr 2020 19:10:57 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes@sipsolutions.net, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 4/8] backports: patches: Refresh on kernel 5.6.5
Date:   Sun, 19 Apr 2020 19:10:35 +0200
Message-Id: <20200419171039.17268-5-hauke@hauke-m.de>
In-Reply-To: <20200419171039.17268-1-hauke@hauke-m.de>
References: <20200419171039.17268-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 50B60168A
X-Rspamd-Score: -5.67 / 15.00 / 15.00
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

The patch patches/0093-nl80211-vlan.patch was applied upstream.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../0002-disable-dump-adjust-on-old-kernels.patch    |  4 ++--
 patches/0014-netlink_seq/net_wireless_nl80211.patch  |  2 +-
 patches/0079-netdev-destructor/brcmfmac.patch        |  2 +-
 patches/0090-remove-GRO_CONSUMED.patch               |  2 +-
 patches/0092-listified-rx/iwlwifi.patch              |  2 +-
 patches/0093-nl80211-vlan.patch                      | 12 ------------
 6 files changed, 6 insertions(+), 18 deletions(-)
 delete mode 100644 patches/0093-nl80211-vlan.patch

diff --git a/patches/0002-disable-dump-adjust-on-old-kernels.patch b/patches/0002-disable-dump-adjust-on-old-kernels.patch
index 3d752359..5a41edfb 100644
--- a/patches/0002-disable-dump-adjust-on-old-kernels.patch
+++ b/patches/0002-disable-dump-adjust-on-old-kernels.patch
@@ -28,7 +28,7 @@ Date:   Fri Mar 1 14:03:49 2013 +0100
 
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -2549,6 +2549,7 @@ static int nl80211_dump_wiphy(struct sk_
+@@ -2550,6 +2550,7 @@ static int nl80211_dump_wiphy(struct sk_
  						 cb->nlh->nlmsg_seq,
  						 NLM_F_MULTI, state);
  			if (ret < 0) {
@@ -36,7 +36,7 @@ Date:   Fri Mar 1 14:03:49 2013 +0100
  				/*
  				 * If sending the wiphy data didn't fit (ENOBUFS
  				 * or EMSGSIZE returned), this SKB is still
-@@ -2570,6 +2571,7 @@ static int nl80211_dump_wiphy(struct sk_
+@@ -2571,6 +2572,7 @@ static int nl80211_dump_wiphy(struct sk_
  					rtnl_unlock();
  					return 1;
  				}
diff --git a/patches/0014-netlink_seq/net_wireless_nl80211.patch b/patches/0014-netlink_seq/net_wireless_nl80211.patch
index 28416330..c9442de4 100644
--- a/patches/0014-netlink_seq/net_wireless_nl80211.patch
+++ b/patches/0014-netlink_seq/net_wireless_nl80211.patch
@@ -1,6 +1,6 @@
 --- a/net/wireless/nl80211.c
 +++ b/net/wireless/nl80211.c
-@@ -8780,7 +8780,9 @@ static int nl80211_dump_scan(struct sk_b
+@@ -8781,7 +8781,9 @@ static int nl80211_dump_scan(struct sk_b
  	if (start == 0)
  		cfg80211_bss_expire(rdev);
  
diff --git a/patches/0079-netdev-destructor/brcmfmac.patch b/patches/0079-netdev-destructor/brcmfmac.patch
index 3ee6da62..6dc59043 100644
--- a/patches/0079-netdev-destructor/brcmfmac.patch
+++ b/patches/0079-netdev-destructor/brcmfmac.patch
@@ -24,7 +24,7 @@
  int brcmf_net_attach(struct brcmf_if *ifp, bool rtnl_locked)
  {
  	struct brcmf_pub *drvr = ifp->drvr;
-@@ -802,7 +819,11 @@ struct brcmf_if *brcmf_add_if(struct brc
+@@ -870,7 +887,11 @@ struct brcmf_if *brcmf_add_if(struct brc
  		if (!ndev)
  			return ERR_PTR(-ENOMEM);
  
diff --git a/patches/0090-remove-GRO_CONSUMED.patch b/patches/0090-remove-GRO_CONSUMED.patch
index ea0e1ea7..5ba92ae6 100644
--- a/patches/0090-remove-GRO_CONSUMED.patch
+++ b/patches/0090-remove-GRO_CONSUMED.patch
@@ -4,7 +4,7 @@ older kernel versions.
 
 --- a/drivers/net/wireless/ath/wil6210/txrx.c
 +++ b/drivers/net/wireless/ath/wil6210/txrx.c
-@@ -913,7 +913,9 @@ void wil_netif_rx(struct sk_buff *skb, s
+@@ -914,7 +914,9 @@ void wil_netif_rx(struct sk_buff *skb, s
  		[GRO_HELD]		= "GRO_HELD",
  		[GRO_NORMAL]		= "GRO_NORMAL",
  		[GRO_DROP]		= "GRO_DROP",
diff --git a/patches/0092-listified-rx/iwlwifi.patch b/patches/0092-listified-rx/iwlwifi.patch
index 925010fd..4d3e25cc 100644
--- a/patches/0092-listified-rx/iwlwifi.patch
+++ b/patches/0092-listified-rx/iwlwifi.patch
@@ -3,7 +3,7 @@ commit 323ebb61e32b ("net: use listified RX for handling GRO_NORMAL skbs")
 
 --- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
 +++ b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
-@@ -1531,11 +1531,13 @@ out:
+@@ -1581,11 +1581,13 @@ out:
  	if (napi->poll) {
  		napi_gro_flush(napi, false);
  
diff --git a/patches/0093-nl80211-vlan.patch b/patches/0093-nl80211-vlan.patch
deleted file mode 100644
index c1f8dac1..00000000
--- a/patches/0093-nl80211-vlan.patch
+++ /dev/null
@@ -1,12 +0,0 @@
-diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
-index ae8e3d9575d3..15c0e3c5c979 100644
---- a/net/wireless/nl80211.c
-+++ b/net/wireless/nl80211.c
-@@ -20,6 +20,7 @@
- #include <linux/netlink.h>
- #include <linux/nospec.h>
- #include <linux/etherdevice.h>
-+#include <linux/if_vlan.h>
- #include <net/net_namespace.h>
- #include <net/genetlink.h>
- #include <net/cfg80211.h>
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
