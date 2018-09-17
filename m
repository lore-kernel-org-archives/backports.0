Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.mailbox.org ([80.241.60.212]:60628 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727672AbeIRDA6 (ORCPT <rfc822;backports@vger.kernel.org>);
        Mon, 17 Sep 2018 23:00:58 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org, john@phrozen.org,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 3/7] patches: Adapt to new select queue API
Date: Mon, 17 Sep 2018 23:31:38 +0200
Message-Id: <20180917213142.7875-3-hauke@hauke-m.de> (sfid-20180917_233152_500664_B09B1BAE)
In-Reply-To: <20180917213142.7875-1-hauke@hauke-m.de>
References: <20180917213142.7875-1-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The select queue API was changed in upstream commit 4f49dec9075a ("net:
allow ndo_select_queue to pass netdev"). This patch adds a new version
of the API for kernel < 4.19

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 patches/0028-select_queue/mac80211.patch  | 26 ++++++++++++++++++--------
 patches/0028-select_queue/mwifiex.patch   | 13 +++++++++----
 patches/0028-select_queue/rtl8188eu.patch | 18 ++++++++++++++++++
 patches/0028-select_queue/rtl8723bs.patch | 18 ++++++++++++++++++
 4 files changed, 63 insertions(+), 12 deletions(-)
 create mode 100644 patches/0028-select_queue/rtl8188eu.patch
 create mode 100644 patches/0028-select_queue/rtl8723bs.patch

diff --git a/patches/0028-select_queue/mac80211.patch b/patches/0028-select_queue/mac80211.patch
index 2bfca8ee..82bf659f 100644
--- a/patches/0028-select_queue/mac80211.patch
+++ b/patches/0028-select_queue/mac80211.patch
@@ -1,15 +1,20 @@
 --- a/net/mac80211/iface.c
 +++ b/net/mac80211/iface.c
-@@ -1126,10 +1126,20 @@ static void ieee80211_uninit(struct net_
+@@ -1128,10 +1128,25 @@ static void ieee80211_uninit(struct net_
  	ieee80211_teardown_sdata(IEEE80211_DEV_TO_SUB_IF(dev));
  }
  
-+#if LINUX_VERSION_IS_GEQ(3,14,0) || \
-+    (LINUX_VERSION_CODE == KERNEL_VERSION(3,13,11) && UTS_UBUNTU_RELEASE_ABI > 30)
++#if LINUX_VERSION_IS_GEQ(4,19,0)
  static u16 ieee80211_netdev_select_queue(struct net_device *dev,
  					 struct sk_buff *skb,
- 					 void *accel_priv,
+ 					 struct net_device *sb_dev,
  					 select_queue_fallback_t fallback)
++#elif LINUX_VERSION_IS_GEQ(3,14,0) || \
++    (LINUX_VERSION_CODE == KERNEL_VERSION(3,13,11) && UTS_UBUNTU_RELEASE_ABI > 30)
++static u16 ieee80211_netdev_select_queue(struct net_device *dev,
++					 struct sk_buff *skb,
++					 void *accel_priv,
++					 select_queue_fallback_t fallback)
 +#elif LINUX_VERSION_IS_GEQ(3,13,0)
 +static u16 ieee80211_netdev_select_queue(struct net_device *dev,
 +					 struct sk_buff *skb,
@@ -21,16 +26,21 @@
  {
  	return ieee80211_select_queue(IEEE80211_DEV_TO_SUB_IF(dev), skb);
  }
-@@ -1172,10 +1182,20 @@ static const struct net_device_ops ieee8
+@@ -1174,10 +1189,25 @@ static const struct net_device_ops ieee8
  	.ndo_get_stats64	= ieee80211_get_stats64,
  };
  
-+#if LINUX_VERSION_IS_GEQ(3,14,0) || \
-+    (LINUX_VERSION_CODE == KERNEL_VERSION(3,13,11) && UTS_UBUNTU_RELEASE_ABI > 30)
++#if LINUX_VERSION_IS_GEQ(4,19,0)
  static u16 ieee80211_monitor_select_queue(struct net_device *dev,
  					  struct sk_buff *skb,
- 					  void *accel_priv,
+ 					  struct net_device *sb_dev,
  					  select_queue_fallback_t fallback)
++#elif LINUX_VERSION_IS_GEQ(3,14,0) || \
++    (LINUX_VERSION_CODE == KERNEL_VERSION(3,13,11) && UTS_UBUNTU_RELEASE_ABI > 30)
++static u16 ieee80211_monitor_select_queue(struct net_device *dev,
++					  struct sk_buff *skb,
++					  void *accel_priv,
++					  select_queue_fallback_t fallback)
 +#elif LINUX_VERSION_IS_GEQ(3,13,0)
 +static u16 ieee80211_monitor_select_queue(struct net_device *dev,
 +					  struct sk_buff *skb,
diff --git a/patches/0028-select_queue/mwifiex.patch b/patches/0028-select_queue/mwifiex.patch
index 5d2e257c..87159fa9 100644
--- a/patches/0028-select_queue/mwifiex.patch
+++ b/patches/0028-select_queue/mwifiex.patch
@@ -1,14 +1,19 @@
 --- a/drivers/net/wireless/marvell/mwifiex/main.c
 +++ b/drivers/net/wireless/marvell/mwifiex/main.c
-@@ -1261,9 +1261,19 @@ static struct net_device_stats *mwifiex_
+@@ -1280,10 +1280,24 @@ static struct net_device_stats *mwifiex_
  	return &priv->stats;
  }
  
-+#if LINUX_VERSION_IS_GEQ(3,14,0) || \
-+    (LINUX_VERSION_CODE == KERNEL_VERSION(3,13,11) && UTS_UBUNTU_RELEASE_ABI > 30)
++#if LINUX_VERSION_IS_GEQ(4,19,0)
  static u16
  mwifiex_netdev_select_wmm_queue(struct net_device *dev, struct sk_buff *skb,
- 				void *accel_priv, select_queue_fallback_t fallback)
+ 				struct net_device *sb_dev,
+ 				select_queue_fallback_t fallback)
++#elif LINUX_VERSION_IS_GEQ(3,14,0) || \
++    (LINUX_VERSION_CODE == KERNEL_VERSION(3,13,11) && UTS_UBUNTU_RELEASE_ABI > 30)
++static u16
++mwifiex_netdev_select_wmm_queue(struct net_device *dev, struct sk_buff *skb,
++				void *accel_priv, select_queue_fallback_t fallback)
 +#elif LINUX_VERSION_IS_GEQ(3,13,0)
 +static u16
 +mwifiex_netdev_select_wmm_queue(struct net_device *dev, struct sk_buff *skb,
diff --git a/patches/0028-select_queue/rtl8188eu.patch b/patches/0028-select_queue/rtl8188eu.patch
new file mode 100644
index 00000000..00413804
--- /dev/null
+++ b/patches/0028-select_queue/rtl8188eu.patch
@@ -0,0 +1,18 @@
+--- a/drivers/staging/rtl8188eu/os_dep/os_intfs.c
++++ b/drivers/staging/rtl8188eu/os_dep/os_intfs.c
+@@ -244,9 +244,15 @@ static unsigned int rtw_classify8021d(st
+ 	return dscp >> 5;
+ }
+ 
++#if LINUX_VERSION_IS_GEQ(4,19,0)
+ static u16 rtw_select_queue(struct net_device *dev, struct sk_buff *skb,
+ 			    struct net_device *sb_dev,
+ 			    select_queue_fallback_t fallback)
++#else
++static u16 rtw_select_queue(struct net_device *dev, struct sk_buff *skb,
++			    void *accel_priv,
++			    select_queue_fallback_t fallback)
++#endif
+ {
+ 	struct adapter	*padapter = rtw_netdev_priv(dev);
+ 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
diff --git a/patches/0028-select_queue/rtl8723bs.patch b/patches/0028-select_queue/rtl8723bs.patch
new file mode 100644
index 00000000..7dbf7f60
--- /dev/null
+++ b/patches/0028-select_queue/rtl8723bs.patch
@@ -0,0 +1,18 @@
+--- a/drivers/staging/rtl8723bs/os_dep/os_intfs.c
++++ b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
+@@ -403,9 +403,15 @@ static unsigned int rtw_classify8021d(st
+ }
+ 
+ 
++#if LINUX_VERSION_IS_GEQ(4,19,0)
+ static u16 rtw_select_queue(struct net_device *dev, struct sk_buff *skb,
+ 			    struct net_device *sb_dev,
+ 			    select_queue_fallback_t fallback)
++#else
++static u16 rtw_select_queue(struct net_device *dev, struct sk_buff *skb,
++			    void *accel_priv,
++			    select_queue_fallback_t fallback)
++#endif
+ {
+ 	struct adapter	*padapter = rtw_netdev_priv(dev);
+ 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
