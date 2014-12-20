Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:35249 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751446AbaLTVju (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 20 Dec 2014 16:39:50 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 00/14] backports: updates for next-20141201
Date: Sat, 20 Dec 2014 22:39:23 +0100
Message-Id: <1419111577-22174-1-git-send-email-hauke@hauke-m.de> (sfid-20141220_223954_844382_FCFF5490)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This contains some patches needed to make backports compatible with
next-20141201.

Hauke Mehrtens (14):
  header: add for_each_compatible_node()
  header: add memcpy_from_msg()
  header: add empty of_find_compatible_node()
  header: include some other dma headers in dma-buf.h
  header: backport drain_workqueue() by calling flush_workqueue()
  backport: add debugfs_create_devm_seqfile()
  backport: add pci_device_is_present()
  backport: add of_property_read_u32()
  patches: disable tx status support in mwifiex
  patches: fix some v4l2 dma stuff
  patches: do not use DMA_ATTR_SKIP_CPU_SYNC
  patches: adapt api change of rchan_callbacks->create_buf_file in ath9k
  patches: refresh on next-20141201
  devel: update the test kernels

 backport/backport-include/linux/debugfs.h          |  23 +++
 backport/backport-include/linux/dma-buf.h          |   3 +
 backport/backport-include/linux/of.h               |  45 +++++-
 backport/backport-include/linux/pci.h              |   5 +
 backport/backport-include/linux/skbuff.h           |   6 +
 backport/backport-include/linux/workqueue.h        |   4 +
 backport/compat/backport-3.13.c                    |  52 +++++++
 backport/compat/backport-3.19.c                    |  56 ++++++++
 backport/compat/compat-3.1.c                       |  34 +++++
 devel/backports-update-manager                     |  14 +-
 patches/backport-adjustments/crypto-ccm.patch      |   7 +-
 patches/backport-adjustments/devcoredump.patch     |  35 ++---
 .../media/0001-dma_mmap_coherent-revert.patch      |   4 +-
 .../media/0002-no_dmabuf/v4l2.patch                | 158 ++++++++++++++++-----
 .../media/0005-dma-no-sync/v4l2.patch              |  64 +++++++++
 .../0002-disable-dump-adjust-on-old-kernels.patch  |   4 +-
 .../include_net_cfg80211.patch                     |   2 +-
 .../net_wireless_core.patch                        |   2 +-
 .../0011-mac80211-disable-tx-status/mwifiex.patch  |  28 ++++
 .../net_mac80211_tx.patch                          |   6 +-
 .../0014-netlink_seq/net_wireless_nl80211.patch    |   2 +-
 .../network/0021-umode_t-api-change/ath9k.patch    |  14 ++
 .../network/0024-led-blink-api/mac80211.patch      |   2 +-
 .../network/0027-genl-const/hwsim.patch            |   4 +-
 .../network/0027-genl-const/nl80211.patch          |   6 +-
 .../network/0028-select_queue/mwifiex.patch        |   2 +-
 .../0032-sriov_configure/igb_sriov_configure.patch |   8 +-
 .../0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch |   8 +-
 .../igb_ndo_set_vf_spoofchk.patch                  |   8 +-
 .../network/0035-skb_no_fcs/igb_skb_no_fcs.patch   |   2 +-
 .../network/0043-ndo_set_vf_rate/igb.patch         |  10 +-
 .../network/0046-mmc_rescan_entered/mwifiex.patch  |   2 +-
 .../network/0048-no_ndo_xmit_flush/igb.patch       |   2 +-
 .../network/0049-no-pfmemalloc/igb.patch           |   4 +-
 34 files changed, 518 insertions(+), 108 deletions(-)
 create mode 100644 backport/backport-include/linux/debugfs.h
 create mode 100644 patches/collateral-evolutions/media/0005-dma-no-sync/v4l2.patch
 create mode 100644 patches/collateral-evolutions/network/0011-mac80211-disable-tx-status/mwifiex.patch
 create mode 100644 patches/collateral-evolutions/network/0021-umode_t-api-change/ath9k.patch

-- 
1.9.1

