Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:58764 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751744AbbBVBmU (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 21 Feb 2015 20:42:20 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 0/6] backports: make backports compatible with next-20150129
Date: Sun, 22 Feb 2015 02:42:02 +0100
Message-Id: <1424569328-12514-1-git-send-email-hauke@hauke-m.de> (sfid-20150222_024223_636815_27721660)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This brings backports to next-20150129.

This adds some missing small functions and removes a feature from igb.

Hauke Mehrtens (6):
  header: add get_user_pages_unlocked()
  header: add skb_vlan_tag_{present,get,get_id}
  patches: igb: remove access to programmable ptp pins
  header: add of_get_property() for 3.0
  devel: update the test kernels
  patches: refresh patches on next-20150129

 backport/backport-include/linux/if_vlan.h          |  12 ++
 backport/backport-include/linux/mm.h               |  17 +++
 backport/backport-include/linux/of.h               |  10 ++
 devel/backports-update-manager                     |  18 +--
 .../media/0002-no_dmabuf/v4l2.patch                |   4 +-
 .../0002-disable-dump-adjust-on-old-kernels.patch  |   4 +-
 .../include_net_cfg80211.patch                     |   2 +-
 .../net_wireless_core.patch                        |   2 +-
 .../net_wireless_core.patch                        |   4 +-
 .../0014-netlink_seq/net_wireless_nl80211.patch    |   2 +-
 .../0017-get_ts_info/drivers_net_usb_usbnet.patch  |   2 +-
 .../network/0021-umode_t-api-change/ath10k.patch   |   2 +-
 .../network/0024-led-blink-api/mac80211.patch      |   2 +-
 .../network/0025-usb-sg/usbnet.patch               |  12 +-
 .../network/0027-genl-const/hwsim.patch            |   2 +-
 .../network/0027-genl-const/ieee802154.patch       |   6 +-
 .../network/0027-genl-const/nfc.patch              |   2 +-
 .../network/0027-genl-const/nl80211.patch          |   6 +-
 .../network/0028-select_queue/mwifiex.patch        |   2 +-
 .../network/0030-qdisc_tx_busylock/bluetooth.patch |   2 +-
 .../0032-sriov_configure/igb_sriov_configure.patch |   8 +-
 .../0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch |   8 +-
 .../igb_ndo_set_vf_spoofchk.patch                  |   6 +-
 .../network/0042-pci_error_handlers/alx.patch      |   2 +-
 .../network/0043-ndo_set_vf_rate/igb.patch         |   8 +-
 .../network/0046-mmc_rescan_entered/mwifiex.patch  |   2 +-
 .../network/0049-no-pfmemalloc/igb.patch           |  28 ++---
 .../network/0050-iov_iter/bluetooth.patch          |  16 +--
 .../network/0052-deactivate-ptp-pin/INFO           |  20 +++
 .../network/0052-deactivate-ptp-pin/igb.patch      | 136 +++++++++++++++++++++
 30 files changed, 264 insertions(+), 83 deletions(-)
 create mode 100644 patches/collateral-evolutions/network/0052-deactivate-ptp-pin/INFO
 create mode 100644 patches/collateral-evolutions/network/0052-deactivate-ptp-pin/igb.patch

-- 
1.9.1

