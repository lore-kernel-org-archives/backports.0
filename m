Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:46002 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752067Ab3JYV6f (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 25 Oct 2013 17:58:35 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 0/4] backports: update to next-20131004
Date: Fri, 25 Oct 2013 23:58:23 +0200
Message-Id: <1382738307-16123-1-git-send-email-hauke@hauke-m.de> (sfid-20131025_235837_439089_4AF91D02)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This brings backports to linux-next version next-20131004

Hauke Mehrtens (4):
  backports: add dma_set_mask_and_coherent()
  backports: fix usb-sg for usbnet
  backports: add NETIF_F_RXFCS and NETIF_F_RXALL
  backports: refresh patches on next-20131004

 backport/backport-include/linux/dma-mapping.h      |   16 +++++++++++
 backport/backport-include/linux/netdev_features.h  |    8 ++++++
 .../network/0001-netdev_ops/atl1e.patch            |    2 +-
 .../network/0001-netdev_ops/b44.patch              |    2 +-
 .../network/0001-netdev_ops/mwifiex.patch          |    2 +-
 .../network/0001-netdev_ops/qmi_wwan.patch         |    2 +-
 .../network/0001-netdev_ops/usbnet.patch           |    2 +-
 .../drivers_net_wireless_ti_wlcore_main.patch      |   17 +++++++-----
 .../net_wireless_core.patch                        |    2 +-
 ...drivers_net_wireless_rtlwifi_rtl8188ee_sw.patch |    4 +--
 ...drivers_net_wireless_rtlwifi_rtl8192ce_sw.patch |    4 +--
 ...drivers_net_wireless_rtlwifi_rtl8192de_sw.patch |    4 +--
 ...drivers_net_wireless_rtlwifi_rtl8723ae_sw.patch |    4 +--
 .../16-bluetooth/net_bluetooth_l2cap_sock.patch    |    6 ++---
 .../drivers_net_ethernet_broadcom_b44.patch        |    2 +-
 .../drivers_net_wireless_ti_wlcore_main.patch      |    4 +--
 ..._wireless_brcm80211_brcmfmac_bcmsdh_sdmmc.patch |    8 +++---
 ...ers_net_ethernet_atheros_atl1e_atl1e_main.patch |   14 +++++-----
 .../61-netdev-addr_assign_type/usbnet.patch        |    2 +-
 .../drivers_net_usb_qmi_wwan.patch                 |    2 +-
 ...ivers_net_wireless_brcm80211_brcmfmac_usb.patch |    2 +-
 .../drivers_net_wireless_rt2x00_rt2800usb.patch    |    2 +-
 ...drivers_net_wireless_rtlwifi_rtl8192cu_sw.patch |    2 +-
 .../drivers_net_ethernet_broadcom_b44.patch        |    4 +--
 .../network/78-usb-sg/usbnet.patch                 |   28 +++++++++++++++++---
 25 files changed, 97 insertions(+), 48 deletions(-)

-- 
1.7.10.4

