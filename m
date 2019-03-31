Return-Path: <SRS0=C36q=SC=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 341A3C10F0A
	for <backports@archiver.kernel.org>; Sun, 31 Mar 2019 21:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01EAA2086C
	for <backports@archiver.kernel.org>; Sun, 31 Mar 2019 21:13:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="C7zhwJk5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbfCaVND (ORCPT <rfc822;backports@archiver.kernel.org>);
        Sun, 31 Mar 2019 17:13:03 -0400
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:47508 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731237AbfCaVND (ORCPT
        <rfc822;backports@vger.kernel.org>); Sun, 31 Mar 2019 17:13:03 -0400
Received: from mail-irv-17.broadcom.com (mail-irv-17.lvn.broadcom.net [10.75.224.233])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id B4DD330C063;
        Sun, 31 Mar 2019 14:12:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com B4DD330C063
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1554066730;
        bh=C7osZeDw5PIUY4yT8Pp2X2j6aZcuwss74Qwz9/2YXJM=;
        h=From:To:Cc:Subject:Date:From;
        b=C7zhwJk5t0/Pl/GP2eNBL9NpvvSZWfnpfOuA4w77eihmUCsMqkXnNHuUZFcnCbHqX
         YjIRxasZe/FbFPmvUP6zJkSYAKeUITZsXSlcfyCBDqrqWuqVgXyjMliFQjlJCprKce
         C2UrSYRRtpbOUKFzYawDkcrjgdGqdMg4jNijR+OM=
Received: from bld-bun-01.bun.broadcom.com (bld-bun-01.bun.broadcom.com [10.176.128.83])
        by mail-irv-17.broadcom.com (Postfix) with ESMTP id F3B5F81ECA;
        Sun, 31 Mar 2019 14:13:00 -0700 (PDT)
Received: by bld-bun-01.bun.broadcom.com (Postfix, from userid 25152)
        id A1E7AB02AD3; Sun, 31 Mar 2019 23:12:59 +0200 (CEST)
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
To:     backports@vger.kernel.org
Cc:     Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [PATCH 1/3] patches: update select queue patches
Date:   Sun, 31 Mar 2019 23:12:40 +0200
Message-Id: <1554066762-20128-1-git-send-email-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 1.9.1
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

The select queue parameters changed so the patches need to be updated
as well.

Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
 patches/0028-select_queue/mac80211.patch  | 14 ++++++--------
 patches/0028-select_queue/mwifiex.patch   |  7 +++----
 patches/0028-select_queue/rtl8188eu.patch |  7 +++----
 patches/0028-select_queue/rtl8723bs.patch |  9 ++++-----
 4 files changed, 16 insertions(+), 21 deletions(-)

diff --git a/patches/0028-select_queue/mac80211.patch b/patches/0028-select_queue/mac80211.patch
index bca6793..b77cee8 100644
--- a/patches/0028-select_queue/mac80211.patch
+++ b/patches/0028-select_queue/mac80211.patch
@@ -1,14 +1,13 @@
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -1131,10 +1131,25 @@ static void ieee80211_uninit(struct net_
+@@ -1131,9 +1131,24 @@ static void ieee80211_uninit(struct net_
  	ieee80211_teardown_sdata(IEEE80211_DEV_TO_SUB_IF(dev));
  }
- 
+
 +#if LINUX_VERSION_IS_GEQ(4,19,0)
  static u16 ieee80211_netdev_select_queue(struct net_device *dev,
  					 struct sk_buff *skb,
- 					 struct net_device *sb_dev,
- 					 select_queue_fallback_t fallback)
+ 					 struct net_device *sb_dev)
 +#elif LINUX_VERSION_IS_GEQ(3,14,0) || \
 +    (LINUX_VERSION_CODE == KERNEL_VERSION(3,13,11) && UTS_UBUNTU_RELEASE_ABI > 30)
 +static u16 ieee80211_netdev_select_queue(struct net_device *dev,
@@ -26,15 +25,14 @@
  {
  	return ieee80211_select_queue(IEEE80211_DEV_TO_SUB_IF(dev), skb);
  }
-@@ -1177,10 +1192,25 @@ static const struct net_device_ops ieee8
+@@ -1176,9 +1191,24 @@ static const struct net_device_ops ieee8
  	.ndo_get_stats64	= ieee80211_get_stats64,
  };
- 
+
 +#if LINUX_VERSION_IS_GEQ(4,19,0)
  static u16 ieee80211_monitor_select_queue(struct net_device *dev,
  					  struct sk_buff *skb,
- 					  struct net_device *sb_dev,
- 					  select_queue_fallback_t fallback)
+ 					  struct net_device *sb_dev)
 +#elif LINUX_VERSION_IS_GEQ(3,14,0) || \
 +    (LINUX_VERSION_CODE == KERNEL_VERSION(3,13,11) && UTS_UBUNTU_RELEASE_ABI > 30)
 +static u16 ieee80211_monitor_select_queue(struct net_device *dev,
diff --git a/patches/0028-select_queue/mwifiex.patch b/patches/0028-select_queue/mwifiex.patch
index 87159fa..9a5692e 100644
--- a/patches/0028-select_queue/mwifiex.patch
+++ b/patches/0028-select_queue/mwifiex.patch
@@ -1,14 +1,13 @@
 --- a/drivers/net/wireless/marvell/mwifiex/main.c
 +++ b/drivers/net/wireless/marvell/mwifiex/main.c
-@@ -1280,10 +1280,24 @@ static struct net_device_stats *mwifiex_
+@@ -1280,9 +1280,23 @@ static struct net_device_stats *mwifiex_
  	return &priv->stats;
  }
- 
+
 +#if LINUX_VERSION_IS_GEQ(4,19,0)
  static u16
  mwifiex_netdev_select_wmm_queue(struct net_device *dev, struct sk_buff *skb,
- 				struct net_device *sb_dev,
- 				select_queue_fallback_t fallback)
+ 				struct net_device *sb_dev)
 +#elif LINUX_VERSION_IS_GEQ(3,14,0) || \
 +    (LINUX_VERSION_CODE == KERNEL_VERSION(3,13,11) && UTS_UBUNTU_RELEASE_ABI > 30)
 +static u16
diff --git a/patches/0028-select_queue/rtl8188eu.patch b/patches/0028-select_queue/rtl8188eu.patch
index 90ddb85..5bf4984 100644
--- a/patches/0028-select_queue/rtl8188eu.patch
+++ b/patches/0028-select_queue/rtl8188eu.patch
@@ -1,13 +1,12 @@
 --- a/drivers/staging/rtl8188eu/os_dep/os_intfs.c
 +++ b/drivers/staging/rtl8188eu/os_dep/os_intfs.c
-@@ -244,9 +244,15 @@ static unsigned int rtw_classify8021d(st
+@@ -244,8 +244,14 @@ static unsigned int rtw_classify8021d(st
  	return dscp >> 5;
  }
- 
+
 +#if LINUX_VERSION_IS_GEQ(4,19,0)
  static u16 rtw_select_queue(struct net_device *dev, struct sk_buff *skb,
- 			    struct net_device *sb_dev,
- 			    select_queue_fallback_t fallback)
+ 			    struct net_device *sb_dev)
 +#else
 +static u16 rtw_select_queue(struct net_device *dev, struct sk_buff *skb,
 +			    void *accel_priv,
diff --git a/patches/0028-select_queue/rtl8723bs.patch b/patches/0028-select_queue/rtl8723bs.patch
index 7dbf7f6..5b6f006 100644
--- a/patches/0028-select_queue/rtl8723bs.patch
+++ b/patches/0028-select_queue/rtl8723bs.patch
@@ -1,13 +1,12 @@
 --- a/drivers/staging/rtl8723bs/os_dep/os_intfs.c
 +++ b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
-@@ -403,9 +403,15 @@ static unsigned int rtw_classify8021d(st
+@@ -403,8 +403,14 @@ static unsigned int rtw_classify8021d(st
  }
- 
- 
+
+
 +#if LINUX_VERSION_IS_GEQ(4,19,0)
  static u16 rtw_select_queue(struct net_device *dev, struct sk_buff *skb,
- 			    struct net_device *sb_dev,
- 			    select_queue_fallback_t fallback)
+ 			    struct net_device *sb_dev)
 +#else
 +static u16 rtw_select_queue(struct net_device *dev, struct sk_buff *skb,
 +			    void *accel_priv,
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
