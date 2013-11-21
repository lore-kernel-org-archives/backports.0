Return-path: <backports-owner@vger.kernel.org>
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:27821 "EHLO
	mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754115Ab3KUQRD (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 21 Nov 2013 11:17:03 -0500
Date: Thu, 21 Nov 2013 17:16:56 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
To: Johannes Berg <johannes@sipsolutions.net>
cc: backports@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>,
	Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH] backports: move part of multicast handling into an
 spatch
In-Reply-To: <1385050282-4238-1-git-send-email-johannes@sipsolutions.net>
Message-ID: <alpine.DEB.2.02.1311211716301.2286@hadrien> (sfid-20131121_171716_315167_7226AA40)
References: <1385050282-4238-1-git-send-email-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Thu, 21 Nov 2013, Johannes Berg wrote:

> From: Johannes Berg <johannes.berg@intel.com>
>
> The netdev_for_each_mc_addr() handling can be done with a
> semantic patch and a simple macro encapsulating the addr
> dereferencing for the two cases.
>
> In fact, this already fixed a bug in dvb_net.c, although
> I think that depends on a newer kernel anyway.
>
> Thanks Julia for the help with iterator name!
>
> Cc: Julia Lawall <julia.lawall@lip6.fr>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Acked-by: Julia Lawall <julia.lawall@lip6.fr>

for the semantic patch.

> ---
>  backport/backport-include/linux/netdevice.h        |  3 ++
>  .../drivers_net_ethernet_atheros_alx_main.patch    | 14 --------
>  ...ers_net_ethernet_atheros_atl1c_atl1c_main.patch | 14 --------
>  ...ers_net_ethernet_atheros_atl1e_atl1e_main.patch | 14 --------
>  .../drivers_net_ethernet_atheros_atlx_atl2.patch   | 14 --------
>  .../drivers_net_ethernet_atheros_atlx_atlx.patch   | 14 --------
>  .../drivers_net_ethernet_broadcom_b44.patch        | 14 --------
>  .../drivers_net_wireless_ath_ath6kl_main.patch     | 38 ----------------------
>  ...net_wireless_brcm80211_brcmfmac_dhd_linux.patch | 14 --------
>  .../drivers_net_wireless_libertas_main.patch       | 37 ---------------------
>  .../drivers_net_wireless_mwifiex_debugfs.patch     | 14 --------
>  .../drivers_net_wireless_mwifiex_sta_ioctl.patch   | 14 --------
>  .../drivers_net_wireless_orinoco_hw.patch          | 26 ---------------
>  .../drivers_net_wireless_rndis_wlan.patch          | 14 --------
>  .../net_bluetooth_bnep_netdev.patch                | 16 ---------
>  .../network/25-multicast.cocci                     | 11 +++++++
>  16 files changed, 14 insertions(+), 257 deletions(-)
>  delete mode 100644 patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_ethernet_atheros_alx_main.patch
>  delete mode 100644 patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_ethernet_atheros_atl1c_atl1c_main.patch
>  delete mode 100644 patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_ethernet_atheros_atl1e_atl1e_main.patch
>  delete mode 100644 patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_ethernet_atheros_atlx_atl2.patch
>  delete mode 100644 patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_ethernet_atheros_atlx_atlx.patch
>  delete mode 100644 patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_ethernet_broadcom_b44.patch
>  delete mode 100644 patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_ath_ath6kl_main.patch
>  delete mode 100644 patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_brcm80211_brcmfmac_dhd_linux.patch
>  delete mode 100644 patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_libertas_main.patch
>  delete mode 100644 patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_mwifiex_debugfs.patch
>  delete mode 100644 patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_mwifiex_sta_ioctl.patch
>  delete mode 100644 patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_orinoco_hw.patch
>  delete mode 100644 patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_rndis_wlan.patch
>  delete mode 100644 patches/collateral-evolutions/network/25-multicast-list_head/net_bluetooth_bnep_netdev.patch
>  create mode 100644 patches/collateral-evolutions/network/25-multicast.cocci
>
> diff --git a/backport/backport-include/linux/netdevice.h b/backport/backport-include/linux/netdevice.h
> index 631fc84..f97e9e1 100644
> --- a/backport/backport-include/linux/netdevice.h
> +++ b/backport/backport-include/linux/netdevice.h
> @@ -255,6 +255,9 @@ static inline int netif_set_real_num_rx_queues(struct net_device *dev,
>  #define netif_set_real_num_tx_queues LINUX_BACKPORT(netif_set_real_num_tx_queues)
>  extern int netif_set_real_num_tx_queues(struct net_device *dev,
>  					unsigned int txq);
> +#define mc_addr(ha) (ha)->dmi_addr
> +#else
> +#define mc_addr(ha) (ha)->addr
>  #endif
>
>  #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,34)
> diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_ethernet_atheros_alx_main.patch b/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_ethernet_atheros_alx_main.patch
> deleted file mode 100644
> index 886bb87..0000000
> --- a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_ethernet_atheros_alx_main.patch
> +++ /dev/null
> @@ -1,14 +0,0 @@
> ---- a/drivers/net/ethernet/atheros/alx/main.c
> -+++ b/drivers/net/ethernet/atheros/alx/main.c
> -@@ -466,7 +466,11 @@ static void __alx_set_rx_mode(struct net
> -
> - 	if (!(netdev->flags & IFF_ALLMULTI)) {
> - 		netdev_for_each_mc_addr(ha, netdev)
> -+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
> - 			alx_add_mc_addr(hw, ha->addr, mc_hash);
> -+#else
> -+			alx_add_mc_addr(hw, ha->dmi_addr, mc_hash);
> -+#endif
> -
> - 		alx_write_mem32(hw, ALX_HASH_TBL0, mc_hash[0]);
> - 		alx_write_mem32(hw, ALX_HASH_TBL1, mc_hash[1]);
> diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_ethernet_atheros_atl1c_atl1c_main.patch b/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_ethernet_atheros_atl1c_atl1c_main.patch
> deleted file mode 100644
> index 5f18a4a..0000000
> --- a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_ethernet_atheros_atl1c_atl1c_main.patch
> +++ /dev/null
> @@ -1,14 +0,0 @@
> ---- a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
> -+++ b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
> -@@ -410,7 +410,11 @@ static void atl1c_set_multi(struct net_d
> -
> - 	/* comoute mc addresses' hash value ,and put it into hash table */
> - 	netdev_for_each_mc_addr(ha, netdev) {
> -+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
> - 		hash_value = atl1c_hash_mc_addr(hw, ha->addr);
> -+#else
> -+		hash_value = atl1c_hash_mc_addr(hw, ha->dmi_addr);
> -+#endif
> - 		atl1c_hash_set(hw, hash_value);
> - 	}
> - }
> diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_ethernet_atheros_atl1e_atl1e_main.patch b/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_ethernet_atheros_atl1e_atl1e_main.patch
> deleted file mode 100644
> index 0da229f..0000000
> --- a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_ethernet_atheros_atl1e_atl1e_main.patch
> +++ /dev/null
> @@ -1,14 +0,0 @@
> ---- a/drivers/net/ethernet/atheros/atl1e/atl1e_main.c
> -+++ b/drivers/net/ethernet/atheros/atl1e/atl1e_main.c
> -@@ -308,7 +308,11 @@ static void atl1e_set_multi(struct net_d
> -
> - 	/* comoute mc addresses' hash value ,and put it into hash table */
> - 	netdev_for_each_mc_addr(ha, netdev) {
> -+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
> - 		hash_value = atl1e_hash_mc_addr(hw, ha->addr);
> -+#else
> -+		hash_value = atl1e_hash_mc_addr(hw, ha->dmi_addr);
> -+#endif
> - 		atl1e_hash_set(hw, hash_value);
> - 	}
> - }
> diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_ethernet_atheros_atlx_atl2.patch b/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_ethernet_atheros_atlx_atl2.patch
> deleted file mode 100644
> index 815d3ca..0000000
> --- a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_ethernet_atheros_atlx_atl2.patch
> +++ /dev/null
> @@ -1,14 +0,0 @@
> ---- a/drivers/net/ethernet/atheros/atlx/atl2.c
> -+++ b/drivers/net/ethernet/atheros/atlx/atl2.c
> -@@ -159,7 +159,11 @@ static void atl2_set_multi(struct net_de
> -
> - 	/* comoute mc addresses' hash value ,and put it into hash table */
> - 	netdev_for_each_mc_addr(ha, netdev) {
> -+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
> - 		hash_value = atl2_hash_mc_addr(hw, ha->addr);
> -+#else
> -+		hash_value = atl2_hash_mc_addr(hw, ha->dmi_addr);
> -+#endif
> - 		atl2_hash_set(hw, hash_value);
> - 	}
> - }
> diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_ethernet_atheros_atlx_atlx.patch b/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_ethernet_atheros_atlx_atlx.patch
> deleted file mode 100644
> index 76e924d..0000000
> --- a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_ethernet_atheros_atlx_atlx.patch
> +++ /dev/null
> @@ -1,14 +0,0 @@
> ---- a/drivers/net/ethernet/atheros/atlx/atlx.c
> -+++ b/drivers/net/ethernet/atheros/atlx/atlx.c
> -@@ -149,7 +149,11 @@ static void atlx_set_multi(struct net_de
> -
> - 	/* compute mc addresses' hash value ,and put it into hash table */
> - 	netdev_for_each_mc_addr(ha, netdev) {
> -+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
> - 		hash_value = atlx_hash_mc_addr(hw, ha->addr);
> -+#else
> -+		hash_value = atlx_hash_mc_addr(hw, ha->dmi_addr);
> -+#endif
> - 		atlx_hash_set(hw, hash_value);
> - 	}
> - }
> diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_ethernet_broadcom_b44.patch b/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_ethernet_broadcom_b44.patch
> deleted file mode 100644
> index 41a7edb..0000000
> --- a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_ethernet_broadcom_b44.patch
> +++ /dev/null
> @@ -1,14 +0,0 @@
> ---- a/drivers/net/ethernet/broadcom/b44.c
> -+++ b/drivers/net/ethernet/broadcom/b44.c
> -@@ -1703,7 +1703,11 @@ static int __b44_load_mcast(struct b44 *
> - 	netdev_for_each_mc_addr(ha, dev) {
> - 		if (i == num_ents)
> - 			break;
> -+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
> - 		__b44_cam_write(bp, ha->addr, i++ + 1);
> -+#else
> -+		__b44_cam_write(bp, ha->dmi_addr, i++ + 1);
> -+#endif
> - 	}
> - 	return i+1;
> - }
> diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_ath_ath6kl_main.patch b/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_ath_ath6kl_main.patch
> deleted file mode 100644
> index 75e51fe..0000000
> --- a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_ath_ath6kl_main.patch
> +++ /dev/null
> @@ -1,38 +0,0 @@
> ---- a/drivers/net/wireless/ath/ath6kl/main.c
> -+++ b/drivers/net/wireless/ath/ath6kl/main.c
> -@@ -1208,7 +1208,11 @@ static void ath6kl_set_multicast_list(st
> - 	list_for_each_entry_safe(mc_filter, tmp, &vif->mc_filter, list) {
> - 		found = false;
> - 		netdev_for_each_mc_addr(ha, ndev) {
> -+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
> - 			if (memcmp(ha->addr, mc_filter->hw_addr,
> -+#else
> -+			if (memcmp(ha->dmi_addr, mc_filter->hw_addr,
> -+#endif
> - 				   ATH6KL_MCAST_FILTER_MAC_ADDR_SIZE) == 0) {
> - 				found = true;
> - 				break;
> -@@ -1242,7 +1246,11 @@ static void ath6kl_set_multicast_list(st
> - 	netdev_for_each_mc_addr(ha, ndev) {
> - 		found = false;
> - 		list_for_each_entry(mc_filter, &vif->mc_filter, list) {
> -+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
> - 			if (memcmp(ha->addr, mc_filter->hw_addr,
> -+#else
> -+			if (memcmp(ha->dmi_addr, mc_filter->hw_addr,
> -+#endif
> - 				   ATH6KL_MCAST_FILTER_MAC_ADDR_SIZE) == 0) {
> - 				found = true;
> - 				break;
> -@@ -1257,7 +1265,11 @@ static void ath6kl_set_multicast_list(st
> - 				goto out;
> - 			}
> -
> -+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
> - 			memcpy(mc_filter->hw_addr, ha->addr,
> -+#else
> -+			memcpy(mc_filter->hw_addr, ha->dmi_addr,
> -+#endif
> - 			       ATH6KL_MCAST_FILTER_MAC_ADDR_SIZE);
> - 			/* Set the multicast filter */
> - 			ath6kl_dbg(ATH6KL_DBG_TRC,
> diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_brcm80211_brcmfmac_dhd_linux.patch b/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_brcm80211_brcmfmac_dhd_linux.patch
> deleted file mode 100644
> index 90a9936..0000000
> --- a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_brcm80211_brcmfmac_dhd_linux.patch
> +++ /dev/null
> @@ -1,14 +0,0 @@
> ---- a/drivers/net/wireless/brcm80211/brcmfmac/dhd_linux.c
> -+++ b/drivers/net/wireless/brcm80211/brcmfmac/dhd_linux.c
> -@@ -116,7 +116,11 @@ static void _brcmf_set_multicast_list(st
> - 	netdev_for_each_mc_addr(ha, ndev) {
> - 		if (!cnt)
> - 			break;
> -+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
> - 		memcpy(bufp, ha->addr, ETH_ALEN);
> -+#else
> -+		memcpy(bufp, ha->dmi_addr, ETH_ALEN);
> -+#endif
> - 		bufp += ETH_ALEN;
> - 		cnt--;
> - 	}
> diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_libertas_main.patch b/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_libertas_main.patch
> deleted file mode 100644
> index a7a9bbc..0000000
> --- a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_libertas_main.patch
> +++ /dev/null
> @@ -1,37 +0,0 @@
> ---- a/drivers/net/wireless/libertas/main.c
> -+++ b/drivers/net/wireless/libertas/main.c
> -@@ -349,18 +349,34 @@ static int lbs_add_mcast_addrs(struct cm
> - 	netif_addr_lock_bh(dev);
> - 	cnt = netdev_mc_count(dev);
> - 	netdev_for_each_mc_addr(ha, dev) {
> -+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
> - 		if (mac_in_list(cmd->maclist, nr_addrs, ha->addr)) {
> -+#else
> -+		if (mac_in_list(cmd->maclist, nr_addrs, ha->dmi_addr)) {
> -+#endif
> - 			lbs_deb_net("mcast address %s:%pM skipped\n", dev->name,
> -+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
> - 				    ha->addr);
> -+#else
> -+				    ha->dmi_addr);
> -+#endif
> - 			cnt--;
> - 			continue;
> - 		}
> -
> - 		if (i == MRVDRV_MAX_MULTICAST_LIST_SIZE)
> - 			break;
> -+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
> - 		memcpy(&cmd->maclist[6*i], ha->addr, ETH_ALEN);
> -+#else
> -+		memcpy(&cmd->maclist[6*i], ha->dmi_addr, ETH_ALEN);
> -+#endif
> - 		lbs_deb_net("mcast address %s:%pM added to filter\n", dev->name,
> -+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
> - 			    ha->addr);
> -+#else
> -+			    ha->dmi_addr);
> -+#endif
> - 		i++;
> - 		cnt--;
> - 	}
> diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_mwifiex_debugfs.patch b/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_mwifiex_debugfs.patch
> deleted file mode 100644
> index 6add185..0000000
> --- a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_mwifiex_debugfs.patch
> +++ /dev/null
> @@ -1,14 +0,0 @@
> ---- a/drivers/net/wireless/mwifiex/debugfs.c
> -+++ b/drivers/net/wireless/mwifiex/debugfs.c
> -@@ -227,7 +227,11 @@ mwifiex_info_read(struct file *file, cha
> -
> - 		netdev_for_each_mc_addr(ha, netdev)
> - 			p += sprintf(p, "multicast_address[%d]=\"%pM\"\n",
> -+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
> - 					i++, ha->addr);
> -+#else
> -+					i++, ha->dmi_addr);
> -+#endif
> - 	}
> -
> - 	p += sprintf(p, "num_tx_bytes = %lu\n", priv->stats.tx_bytes);
> diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_mwifiex_sta_ioctl.patch b/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_mwifiex_sta_ioctl.patch
> deleted file mode 100644
> index a0741df..0000000
> --- a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_mwifiex_sta_ioctl.patch
> +++ /dev/null
> @@ -1,14 +0,0 @@
> ---- a/drivers/net/wireless/mwifiex/sta_ioctl.c
> -+++ b/drivers/net/wireless/mwifiex/sta_ioctl.c
> -@@ -43,7 +43,11 @@ int mwifiex_copy_mcast_addr(struct mwifi
> - 	struct netdev_hw_addr *ha;
> -
> - 	netdev_for_each_mc_addr(ha, dev)
> -+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
> - 		memcpy(&mlist->mac_list[i++], ha->addr, ETH_ALEN);
> -+#else
> -+		memcpy(&mlist->mac_list[i++], ha->dmi_addr, ETH_ALEN);
> -+#endif
> -
> - 	return i;
> - }
> diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_orinoco_hw.patch b/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_orinoco_hw.patch
> deleted file mode 100644
> index 9ad33bc..0000000
> --- a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_orinoco_hw.patch
> +++ /dev/null
> @@ -1,26 +0,0 @@
> ---- a/drivers/net/wireless/orinoco/hw.c
> -+++ b/drivers/net/wireless/orinoco/hw.c
> -@@ -1093,7 +1093,11 @@ int __orinoco_hw_set_multicast_list(stru
> - 		netdev_for_each_mc_addr(ha, dev) {
> - 			if (i == mc_count)
> - 				break;
> -+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
> - 			memcpy(mclist.addr[i++], ha->addr, ETH_ALEN);
> -+#else
> -+			memcpy(mclist.addr[i++], ha->dmi_addr, ETH_ALEN);
> -+#endif
> - 		}
> -
> - 		err = hw->ops->write_ltv(hw, USER_BAP,
> ---- a/drivers/net/wireless/orinoco/hw.h
> -+++ b/drivers/net/wireless/orinoco/hw.h
> -@@ -22,6 +22,9 @@
> -
> - /* Forward declarations */
> - struct orinoco_private;
> -+#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,35))
> -+struct dev_addr_list;
> -+#endif
> -
> - int determine_fw_capabilities(struct orinoco_private *priv, char *fw_name,
> - 			      size_t fw_name_len, u32 *hw_ver);
> diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_rndis_wlan.patch b/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_rndis_wlan.patch
> deleted file mode 100644
> index 31fc596..0000000
> --- a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_rndis_wlan.patch
> +++ /dev/null
> @@ -1,14 +0,0 @@
> ---- a/drivers/net/wireless/rndis_wlan.c
> -+++ b/drivers/net/wireless/rndis_wlan.c
> -@@ -1629,7 +1629,11 @@ static void set_multicast_list(struct us
> -
> - 		netdev_for_each_mc_addr(ha, usbdev->net)
> - 			memcpy(mc_addrs + i++ * ETH_ALEN,
> -+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
> - 			       ha->addr, ETH_ALEN);
> -+#else
> -+			       ha->dmi_addr, ETH_ALEN);
> -+#endif
> - 	}
> - 	netif_addr_unlock_bh(usbdev->net);
> -
> diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/net_bluetooth_bnep_netdev.patch b/patches/collateral-evolutions/network/25-multicast-list_head/net_bluetooth_bnep_netdev.patch
> deleted file mode 100644
> index 3d44951..0000000
> --- a/patches/collateral-evolutions/network/25-multicast-list_head/net_bluetooth_bnep_netdev.patch
> +++ /dev/null
> @@ -1,16 +0,0 @@
> ---- a/net/bluetooth/bnep/netdev.c
> -+++ b/net/bluetooth/bnep/netdev.c
> -@@ -93,8 +93,13 @@ static void bnep_net_set_mc_list(struct
> - 		netdev_for_each_mc_addr(ha, dev) {
> - 			if (i == BNEP_MAX_MULTICAST_FILTERS)
> - 				break;
> -+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
> - 			memcpy(__skb_put(skb, ETH_ALEN), ha->addr, ETH_ALEN);
> - 			memcpy(__skb_put(skb, ETH_ALEN), ha->addr, ETH_ALEN);
> -+#else
> -+			memcpy(__skb_put(skb, ETH_ALEN), ha->dmi_addr, ETH_ALEN);
> -+			memcpy(__skb_put(skb, ETH_ALEN), ha->dmi_addr, ETH_ALEN);
> -+#endif
> -
> - 			i++;
> - 		}
> diff --git a/patches/collateral-evolutions/network/25-multicast.cocci b/patches/collateral-evolutions/network/25-multicast.cocci
> new file mode 100644
> index 0000000..2d3d495
> --- /dev/null
> +++ b/patches/collateral-evolutions/network/25-multicast.cocci
> @@ -0,0 +1,11 @@
> +@@
> +identifier ha;
> +expression netdev;
> +iterator name netdev_for_each_mc_addr;
> +@@
> + netdev_for_each_mc_addr(ha, netdev) {
> + <...
> +-ha->addr
> ++mc_addr(ha)
> + ...>
> + }
> --
> 1.8.4.rc3
>
>
