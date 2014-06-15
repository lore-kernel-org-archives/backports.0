Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:44826 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751133AbaFOVWE (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 15 Jun 2014 17:22:04 -0400
Received: from localhost (localhost [127.0.0.1])
	by hauke-m.de (Postfix) with ESMTP id 180697E65
	for <backports@vger.kernel.org>; Sun, 15 Jun 2014 23:22:02 +0200 (CEST)
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 00/19] backports: add support for next-20140606
Date: Sun, 15 Jun 2014 23:21:28 +0200
Message-Id: <1402867307-31337-1-git-send-email-hauke@hauke-m.de> (sfid-20140615_232206_075917_FFE7B83E)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This brings backports to backports-20140606.

1   3.0.101             [  OK  ]
2   3.1.10              [  OK  ]
3   3.2.59              [  OK  ]
4   3.3.8               [  OK  ]
5   3.4.91              [  OK  ]
6   3.5.7               [  OK  ]
7   3.6.11              [  OK  ]
8   3.7.10              [  OK  ]
9   3.8.13              [  OK  ]
10  3.9.11              [  OK  ]
11  3.10.40             [  OK  ]
12  3.11.10             [  OK  ]
13  3.12.20             [  OK  ]
14  3.13.11             [  OK  ]
15  3.14.4              [  OK  ]
16  3.15-rc7            [  OK  ]


Hauke Mehrtens (19):
  backports: remove upstream patches
  backports: remove USHORT_MAX from kernel.h
  backports: add U32_MAX
  backports: add prandom_u32_max()
  backports: add crc7_be()
  backports: remove parameter from dma_buf_export()
  backports: add of_node_put()
  backports: add of_match_ptr()
  backports: add split_page()
  backports: copy include/linux/platform_data/st21nfca.h
  backports: remove usage of get_ts_info in cdc_ncm.c
  backports: handle rename of ndo_set_vf_tx_rate to ndo_set_vf_rate
  backports: do not access user_ns on struct net
  backports: remove const from pci error handlers on kernel < 3.7
  backports: add hashtable.h
  backports: make some regulator drivers depend on more recent kernel
    versions
  backports: activate NFC_TRF7970A on kernel 3.4
  backports: remove useless git patch header
  backports: refresh patches on next-20140606

 backport/backport-include/linux/crc7.h             | 14 ++++
 backport/backport-include/linux/dma-buf.h          |  9 +++
 backport/backport-include/linux/kernel.h           | 10 ++-
 backport/backport-include/linux/of.h               | 20 ++++++
 backport/backport-include/linux/random.h           | 20 ++++++
 backport/compat/backport-3.10.c                    | 46 ++++++++++++
 copy-list                                          |  2 +
 dependencies                                       |  9 ++-
 .../0003-technisat-usb2-led-rename.patch           | 83 ----------------------
 .../0004-bt8xx-rename-dst-ops.patch                | 67 -----------------
 .../media/0002-no_dmabuf/v4l2.patch                | 24 +++----
 .../0002-disable-dump-adjust-on-old-kernels.patch  |  4 +-
 .../include_net_cfg80211.patch                     |  2 +-
 .../net_wireless_core.patch                        |  2 +-
 .../net_wireless_core.patch                        |  4 +-
 .../0014-netlink_seq/net_wireless_nl80211.patch    |  2 +-
 .../network/0017-get_ts_info/cdc_ncm.patch         | 12 ++++
 .../network/0017-get_ts_info/igb_get_ts_info.patch |  4 +-
 .../network/0024-led-blink-api/mac80211.patch      |  2 +-
 .../network/0027-genl-const/ieee802154.patch       |  4 +-
 .../network/0027-genl-const/nl80211.patch          |  6 +-
 .../network/0028-select_queue/mac80211.patch       |  6 +-
 .../network/0028-select_queue/mwifiex.patch        |  2 -
 .../0032-sriov_configure/igb_sriov_configure.patch | 10 ++-
 .../network/0033-ndo_vlan_rx_vid/cdc_mbim.patch    |  2 -
 .../0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch | 10 ++-
 .../igb_ndo_set_vf_spoofchk.patch                  | 14 ++--
 .../network/0035-skb_no_fcs/igb_skb_no_fcs.patch   |  4 +-
 .../network/0036-ethtool_eee/igb_ethtool_eee.patch |  4 +-
 .../0037-ethtool_get_module/igb_get_module.patch   |  8 +--
 .../0038-ethtool_rxfh_indir/igb_rxfh_indir.patch   | 40 ++++++++---
 .../network/0039-ethtool_rxnfc/igb_rxnfc.patch     |  2 -
 .../igb_ethtool_cmd_mdix.patch                     |  2 -
 ...gb-devm_hwmon_device_register_with_groups.patch |  2 -
 .../network/0042-pci_error_handlers/alx.patch      | 14 ++++
 .../network/0042-pci_error_handlers/atl1c.patch    | 14 ++++
 .../network/0042-pci_error_handlers/atl1e.patch    | 14 ++++
 .../igb_pci_error_handlers.patch                   |  2 -
 .../network/0042-pci_error_handlers/ngene.patch    | 14 ++++
 .../network/0043-ndo_set_vf_rate/igb.patch         | 78 ++++++++++++++++++++
 .../0044-no_user_ns_in_net/ieee802154.patch        | 30 ++++++++
 41 files changed, 371 insertions(+), 247 deletions(-)
 create mode 100644 backport/backport-include/linux/crc7.h
 delete mode 100644 patches/0000-upstream-backport-changes/0003-technisat-usb2-led-rename.patch
 delete mode 100644 patches/0000-upstream-backport-changes/0004-bt8xx-rename-dst-ops.patch
 create mode 100644 patches/collateral-evolutions/network/0017-get_ts_info/cdc_ncm.patch
 create mode 100644 patches/collateral-evolutions/network/0042-pci_error_handlers/alx.patch
 create mode 100644 patches/collateral-evolutions/network/0042-pci_error_handlers/atl1c.patch
 create mode 100644 patches/collateral-evolutions/network/0042-pci_error_handlers/atl1e.patch
 create mode 100644 patches/collateral-evolutions/network/0042-pci_error_handlers/ngene.patch
 create mode 100644 patches/collateral-evolutions/network/0043-ndo_set_vf_rate/igb.patch
 create mode 100644 patches/collateral-evolutions/network/0044-no_user_ns_in_net/ieee802154.patch

-- 
1.9.1

