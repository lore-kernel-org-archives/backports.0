Return-Path: <SRS0=giDq=U6=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B50A5C5B578
	for <backports@archiver.kernel.org>; Mon,  1 Jul 2019 21:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9619221479
	for <backports@archiver.kernel.org>; Mon,  1 Jul 2019 21:50:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726966AbfGAVuB (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 1 Jul 2019 17:50:01 -0400
Received: from mx1.mailbox.org ([80.241.60.212]:40452 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726586AbfGAVuB (ORCPT <rfc822;backports@vger.kernel.org>);
        Mon, 1 Jul 2019 17:50:01 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id B34634EB6E;
        Mon,  1 Jul 2019 23:49:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter02.heinlein-hosting.de (spamfilter02.heinlein-hosting.de [80.241.56.116]) (amavisd-new, port 10030)
        with ESMTP id T4xcnK_uxb84; Mon,  1 Jul 2019 23:49:51 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     Arend van Spriel <arend.vanspriel@broadcom.com>,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 01/18] patches: update select queue patches
Date:   Mon,  1 Jul 2019 23:48:56 +0200
Message-Id: <20190701214914.8066-2-hauke@hauke-m.de>
In-Reply-To: <20190701214914.8066-1-hauke@hauke-m.de>
References: <20190701214914.8066-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

From: Arend van Spriel <arend.vanspriel@broadcom.com>

The select queue parameters changed so the patches need to be updated
as well.

Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
[Fix compile on kernel > 4.19]
Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 patches/0028-select_queue/mac80211.patch  | 24 +++++++++++++++--------
 patches/0028-select_queue/mwifiex.patch   | 12 ++++++++----
 patches/0028-select_queue/rtl8188eu.patch | 11 +++++++----
 patches/0028-select_queue/rtl8723bs.patch | 11 +++++++----
 4 files changed, 38 insertions(+), 20 deletions(-)

diff --git a/patches/0028-select_queue/mac80211.patch b/patches/0028-select_queue/mac80211.patch
index bca6793a..f488589d 100644
--- a/patches/0028-select_queue/mac80211.patch
+++ b/patches/0028-select_queue/mac80211.patch
@@ -1,14 +1,18 @@
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -1131,10 +1131,25 @@ static void ieee80211_uninit(struct net_
+@@ -1128,9 +1128,29 @@ static void ieee80211_uninit(struct net_
  	ieee80211_teardown_sdata(IEEE80211_DEV_TO_SUB_IF(dev));
  }
  
-+#if LINUX_VERSION_IS_GEQ(4,19,0)
++#if LINUX_VERSION_IS_GEQ(5,2,0)
  static u16 ieee80211_netdev_select_queue(struct net_device *dev,
  					 struct sk_buff *skb,
- 					 struct net_device *sb_dev,
- 					 select_queue_fallback_t fallback)
+ 					 struct net_device *sb_dev)
++#elif LINUX_VERSION_IS_GEQ(4,19,0)
++static u16 ieee80211_netdev_select_queue(struct net_device *dev,
++					 struct sk_buff *skb,
++					 struct net_device *sb_dev,
++					 select_queue_fallback_t fallback)
 +#elif LINUX_VERSION_IS_GEQ(3,14,0) || \
 +    (LINUX_VERSION_CODE == KERNEL_VERSION(3,13,11) && UTS_UBUNTU_RELEASE_ABI > 30)
 +static u16 ieee80211_netdev_select_queue(struct net_device *dev,
@@ -26,15 +30,19 @@
  {
  	return ieee80211_select_queue(IEEE80211_DEV_TO_SUB_IF(dev), skb);
  }
-@@ -1177,10 +1192,25 @@ static const struct net_device_ops ieee8
+@@ -1173,9 +1193,29 @@ static const struct net_device_ops ieee8
  	.ndo_get_stats64	= ieee80211_get_stats64,
  };
  
-+#if LINUX_VERSION_IS_GEQ(4,19,0)
++#if LINUX_VERSION_IS_GEQ(5,2,0)
  static u16 ieee80211_monitor_select_queue(struct net_device *dev,
  					  struct sk_buff *skb,
- 					  struct net_device *sb_dev,
- 					  select_queue_fallback_t fallback)
+ 					  struct net_device *sb_dev)
++#elif LINUX_VERSION_IS_GEQ(4,19,0)
++static u16 ieee80211_monitor_select_queue(struct net_device *dev,
++					  struct sk_buff *skb,
++					  struct net_device *sb_dev,
++					  select_queue_fallback_t fallback)
 +#elif LINUX_VERSION_IS_GEQ(3,14,0) || \
 +    (LINUX_VERSION_CODE == KERNEL_VERSION(3,13,11) && UTS_UBUNTU_RELEASE_ABI > 30)
 +static u16 ieee80211_monitor_select_queue(struct net_device *dev,
diff --git a/patches/0028-select_queue/mwifiex.patch b/patches/0028-select_queue/mwifiex.patch
index 87159fa9..8770aaf7 100644
--- a/patches/0028-select_queue/mwifiex.patch
+++ b/patches/0028-select_queue/mwifiex.patch
@@ -1,14 +1,18 @@
 --- a/drivers/net/wireless/marvell/mwifiex/main.c
 +++ b/drivers/net/wireless/marvell/mwifiex/main.c
-@@ -1280,10 +1280,24 @@ static struct net_device_stats *mwifiex_
+@@ -1280,9 +1280,28 @@ static struct net_device_stats *mwifiex_
  	return &priv->stats;
  }
  
-+#if LINUX_VERSION_IS_GEQ(4,19,0)
++#if LINUX_VERSION_IS_GEQ(5,2,0)
  static u16
  mwifiex_netdev_select_wmm_queue(struct net_device *dev, struct sk_buff *skb,
- 				struct net_device *sb_dev,
- 				select_queue_fallback_t fallback)
+ 				struct net_device *sb_dev)
++#elif LINUX_VERSION_IS_GEQ(4,19,0)
++static u16
++mwifiex_netdev_select_wmm_queue(struct net_device *dev, struct sk_buff *skb,
++				struct net_device *sb_dev,
++				select_queue_fallback_t fallback)
 +#elif LINUX_VERSION_IS_GEQ(3,14,0) || \
 +    (LINUX_VERSION_CODE == KERNEL_VERSION(3,13,11) && UTS_UBUNTU_RELEASE_ABI > 30)
 +static u16
diff --git a/patches/0028-select_queue/rtl8188eu.patch b/patches/0028-select_queue/rtl8188eu.patch
index 90ddb853..c0cec864 100644
--- a/patches/0028-select_queue/rtl8188eu.patch
+++ b/patches/0028-select_queue/rtl8188eu.patch
@@ -1,13 +1,16 @@
 --- a/drivers/staging/rtl8188eu/os_dep/os_intfs.c
 +++ b/drivers/staging/rtl8188eu/os_dep/os_intfs.c
-@@ -244,9 +244,15 @@ static unsigned int rtw_classify8021d(st
+@@ -244,8 +244,18 @@ static unsigned int rtw_classify8021d(st
  	return dscp >> 5;
  }
  
-+#if LINUX_VERSION_IS_GEQ(4,19,0)
++#if LINUX_VERSION_IS_GEQ(5,2,0)
  static u16 rtw_select_queue(struct net_device *dev, struct sk_buff *skb,
- 			    struct net_device *sb_dev,
- 			    select_queue_fallback_t fallback)
+ 			    struct net_device *sb_dev)
++#elif LINUX_VERSION_IS_GEQ(4,19,0)
++static u16 rtw_select_queue(struct net_device *dev, struct sk_buff *skb,
++			    struct net_device *sb_dev,
++			    select_queue_fallback_t fallback)
 +#else
 +static u16 rtw_select_queue(struct net_device *dev, struct sk_buff *skb,
 +			    void *accel_priv,
diff --git a/patches/0028-select_queue/rtl8723bs.patch b/patches/0028-select_queue/rtl8723bs.patch
index 7dbf7f60..345f560c 100644
--- a/patches/0028-select_queue/rtl8723bs.patch
+++ b/patches/0028-select_queue/rtl8723bs.patch
@@ -1,13 +1,16 @@
 --- a/drivers/staging/rtl8723bs/os_dep/os_intfs.c
 +++ b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
-@@ -403,9 +403,15 @@ static unsigned int rtw_classify8021d(st
+@@ -400,8 +400,18 @@ static unsigned int rtw_classify8021d(st
  }
  
  
-+#if LINUX_VERSION_IS_GEQ(4,19,0)
++#if LINUX_VERSION_IS_GEQ(5,2,0)
  static u16 rtw_select_queue(struct net_device *dev, struct sk_buff *skb,
- 			    struct net_device *sb_dev,
- 			    select_queue_fallback_t fallback)
+ 			    struct net_device *sb_dev)
++#elif LINUX_VERSION_IS_GEQ(4,19,0)
++static u16 rtw_select_queue(struct net_device *dev, struct sk_buff *skb,
++			    struct net_device *sb_dev,
++			    select_queue_fallback_t fallback)
 +#else
 +static u16 rtw_select_queue(struct net_device *dev, struct sk_buff *skb,
 +			    void *accel_priv,
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
