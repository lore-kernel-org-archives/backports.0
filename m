Return-path: <backports-owner@vger.kernel.org>
Received: from 162-17-110-37-static.hfc.comcastbusiness.net ([162.17.110.37]:35616
	"EHLO stuffed.shaftnet.org" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1753239Ab3HQNDH (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 17 Aug 2013 09:03:07 -0400
From: Solomon Peachy <pizza@shaftnet.org>
To: backports@vger.kernel.org
Cc: Solomon Peachy <pizza@shaftnet.org>
Subject: [PATCH v2 4/4] backports: cw1200 needs the multicast API changes to support <=2.6.35
Date: Sat, 17 Aug 2013 09:02:59 -0400
Message-Id: <1376744579-4245-5-git-send-email-pizza@shaftnet.org> (sfid-20130817_150308_840596_20E27D4E)
In-Reply-To: <1376744579-4245-1-git-send-email-pizza@shaftnet.org>
References: <1376744579-4245-1-git-send-email-pizza@shaftnet.org>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Also, update the dependencies:

 cw1200_wlan_sdio needs >=2.6.34 due to missing sdio_set_host_pm_flags()
 cw1200_wlan_spi needs >=2.6.35 due to missing request_any_context_irq()

Signed-off-by: Solomon Peachy <pizza@shaftnet.org>
---
 dependencies                                       |  3 +
 .../drivers_net_wireless_cw1200_sta.patch          | 77 ++++++++++++++++++++++
 2 files changed, 80 insertions(+)
 create mode 100644 patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_cw1200_sta.patch

diff --git a/dependencies b/dependencies
index f1e514b..9bd5763 100644
--- a/dependencies
+++ b/dependencies
@@ -36,6 +36,9 @@ P54_SPI 2.6.25
 WL1251_SDIO 2.6.37
 WLCORE_SDIO 2.6.38
 
+CW1200_WLAN_SDIO 2.6.34
+CW1200_WLAN_SPI 2.6.35
+
 BRCMFMAC 2.6.29
 
 WL_TI 2.6.30
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_cw1200_sta.patch b/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_cw1200_sta.patch
new file mode 100644
index 0000000..269a696
--- /dev/null
+++ b/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_cw1200_sta.patch
@@ -0,0 +1,77 @@
+--- a/drivers/net/wireless/cw1200/sta.c
++++ b/drivers/net/wireless/cw1200/sta.c
+@@ -530,8 +530,13 @@ void cw1200_set_beacon_wakeup_period_work(struct work_struct *work)
+ 				     priv->join_dtim_period, 0);
+ }
+ 
++#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
+ u64 cw1200_prepare_multicast(struct ieee80211_hw *hw,
+ 			     struct netdev_hw_addr_list *mc_list)
++#else
++u64 cw1200_prepare_multicast(struct ieee80211_hw *hw, int mc_count,
++			     struct dev_addr_list *ha)
++#endif
+ {
+ 	static u8 broadcast_ipv6[ETH_ALEN] = {
+ 		0x33, 0x33, 0x00, 0x00, 0x00, 0x01
+@@ -540,13 +545,16 @@ u64 cw1200_prepare_multicast(struct ieee80211_hw *hw,
+ 		0x01, 0x00, 0x5e, 0x00, 0x00, 0x01
+ 	};
+ 	struct cw1200_common *priv = hw->priv;
++#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
+ 	struct netdev_hw_addr *ha;
++#endif
+ 	int count = 0;
+ 
+ 	/* Disable multicast filtering */
+ 	priv->has_multicast_subscription = false;
+ 	memset(&priv->multicast_filter, 0x00, sizeof(priv->multicast_filter));
+ 
++#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
+ 	if (netdev_hw_addr_list_count(mc_list) > WSM_MAX_GRP_ADDRTABLE_ENTRIES)
+ 		return 0;
+ 
+@@ -560,13 +568,26 @@ u64 cw1200_prepare_multicast(struct ieee80211_hw *hw,
+ 			priv->has_multicast_subscription = true;
+ 		count++;
+ 	}
++#else
++	while (ha &&
++	       count < mc_count &&
++	       count < WSM_MAX_GRP_ADDRTABLE_ENTRIES) {
++		memcpy(&priv->multicast_filter.macaddrs[count],
++		       ha->dmi_addr, ETH_ALEN);
++		if (memcmp(ha->dmi_addr, broadcast_ipv4, ETH_ALEN) &&
++		    memcmp(ha->dmi_addr, broadcast_ipv6, ETH_ALEN))
++			priv->has_multicast_subscription = true;
++		count++;
++		ha = ha->next;
++	}
++#endif
+ 
+ 	if (count) {
+ 		priv->multicast_filter.enable = __cpu_to_le32(1);
+ 		priv->multicast_filter.num_addrs = __cpu_to_le32(count);
+ 	}
+ 
+-	return netdev_hw_addr_list_count(mc_list);
++	return count;
+ }
+ 
+ void cw1200_configure_filter(struct ieee80211_hw *dev,
+--- a/drivers/net/wireless/cw1200/sta.h
++++ b/drivers/net/wireless/cw1200/sta.h
+@@ -42,8 +42,13 @@ int cw1200_set_rts_threshold(struct ieee80211_hw *hw, u32 value);
+ 
+ void cw1200_flush(struct ieee80211_hw *hw, u32 queues, bool drop);
+ 
++#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
+ u64 cw1200_prepare_multicast(struct ieee80211_hw *hw,
+ 			     struct netdev_hw_addr_list *mc_list);
++#else
++u64 cw1200_prepare_multicast(struct ieee80211_hw *dev, int mc_count,
++			     struct dev_addr_list *ha);
++#endif
+ 
+ int cw1200_set_pm(struct cw1200_common *priv, const struct wsm_set_pm *arg);
+ 
-- 
1.8.3.1

