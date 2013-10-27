Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:50156 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752170Ab3J0TJz (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 27 Oct 2013 15:09:55 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 0/4] backports: update to next-20131025
Date: Sun, 27 Oct 2013 20:09:36 +0100
Message-Id: <1382900980-26610-1-git-send-email-hauke@hauke-m.de> (sfid-20131027_201002_123646_D98D180F)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This brings backports to linux-next version next-20131025.

Hauke Mehrtens (4):
  backports: add list_first_entry_or_null
  backports: add strtobool()
  backports: add missing header for struct in6_addr
  backports: refresh on next-20131025

 backport/backport-include/linux/list.h             |   13 +++++++++
 backport/backport-include/linux/string.h           |    5 ++++
 backport/compat/compat-3.0.c                       |   29 ++++++++++++++++++++
 .../drivers_net_wireless_iwlwifi.patch             |   11 ++++++++
 .../drivers_net_wireless_iwlwifi_pcie_trans.patch  |    4 +--
 .../drivers_net_wireless_libertas_if_spi.patch     |    6 ++--
 .../16-bluetooth/net_bluetooth_af_bluetooth.patch  |    6 ++--
 .../16-bluetooth/net_bluetooth_hci_sysfs.patch     |    4 +--
 .../16-bluetooth/net_bluetooth_l2cap_sock.patch    |    6 ++--
 .../drivers_net_wireless_libertas_if_cs.patch      |   18 ++++++------
 .../net_mac80211_ieee80211_i.patch                 |    2 +-
 .../drivers_net_wireless_libertas_if_sdio.patch    |    4 +--
 ..._wireless_brcm80211_brcmfmac_bcmsdh_sdmmc.patch |    8 +++---
 .../drivers_net_wireless_libertas_if_sdio.patch    |    4 +--
 .../drivers_net_wireless_libertas_if_usb.patch     |    4 +--
 .../drivers_net_wireless_libertas_if_usb.patch     |    2 +-
 .../drivers_net_wireless_rt2x00_rt2800usb.patch    |    2 +-
 .../drivers_net_wireless_iwlwifi_mvm_d3.patch      |    2 +-
 .../drivers_net_wireless_ath_ath9k_debug.patch     |    2 +-
 .../network/77-led-blink-api/mac80211.patch        |    2 +-
 .../nfc/01-netlink-portid/net_nfc_netlink.patch    |   16 +++++------
 21 files changed, 104 insertions(+), 46 deletions(-)
 create mode 100644 patches/collateral-evolutions/network/06-header-changes/drivers_net_wireless_iwlwifi.patch

-- 
1.7.10.4

