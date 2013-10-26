Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:47096 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751558Ab3JZKNS (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 26 Oct 2013 06:13:18 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 0/4] backports: update to next-20131011
Date: Sat, 26 Oct 2013 12:13:05 +0200
Message-Id: <1382782389-4859-1-git-send-email-hauke@hauke-m.de> (sfid-20131026_121320_423692_D3A3C100)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This brings backports to linux-next version next-20131011

Hauke Mehrtens (4):
  backports: add VLAN_PRIO_MASK and VLAN_PRIO_SHIFT
  backports: add resource_size()
  backports: remove struct platform_device_id from wcn36xx
  backports: refresh patches on next-20131011

 backport/backport-include/linux/if_vlan.h          |    8 +++++
 backport/backport-include/linux/ioport.h           |    7 +++++
 .../network/0001-netdev_ops/mac80211.patch         |    6 ++--
 .../mac80211.patch                                 |    4 +--
 .../network/0005-netlink-portid/nl80211.patch      |   32 ++++++++++----------
 .../include_net_cfg80211.patch                     |    2 +-
 .../11-dev-pm-ops/drivers_bcma_host_pci.patch      |    4 +--
 .../drivers_net_wireless_iwlwifi_pcie_drv.patch    |    4 +--
 .../net_mac80211_tx.patch                          |    4 +--
 .../16-bluetooth/net_bluetooth_hci_sock.patch      |    4 +--
 .../16-bluetooth/net_bluetooth_l2cap_sock.patch    |    6 ++--
 .../17-netdev-queue/net_mac80211_iface.patch       |    4 +--
 .../network/22-multiqueue/net_mac80211_tx.patch    |    2 +-
 .../24-pcmcia/drivers_bluetooth_bluecard_cs.patch  |   18 +++++------
 .../24-pcmcia/drivers_bluetooth_bt3c_cs.patch      |   14 ++++-----
 .../24-pcmcia/drivers_bluetooth_btuart_cs.patch    |   18 +++++------
 .../24-pcmcia/drivers_bluetooth_dtl1_cs.patch      |   18 +++++------
 .../include_net_mac80211.patch                     |    2 +-
 .../net_mac80211_iface.patch                       |    4 +--
 .../drivers_bluetooth_btmrvl_sdio.patch            |    6 ++--
 .../network/30-bridge-port/net_wireless_util.patch |    2 +-
 .../42-netlink_seq/net_wireless_nl80211.patch      |    2 +-
 .../drivers_net_wireless_ath_wcn36xx_main.patch    |   28 +++++++++++++++++
 .../drivers_bluetooth_bfusb.patch                  |    2 +-
 .../drivers_bluetooth_bpa10x.patch                 |    2 +-
 .../69-wowlan-no-socket/net_wireless_nl80211.patch |    2 +-
 26 files changed, 124 insertions(+), 81 deletions(-)
 create mode 100644 patches/collateral-evolutions/network/45-remove-platform-id-table/drivers_net_wireless_ath_wcn36xx_main.patch

-- 
1.7.10.4

