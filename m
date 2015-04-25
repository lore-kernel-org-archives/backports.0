Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:49621 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751682AbbDYNvS (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 25 Apr 2015 09:51:18 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 0/9] backports: bring backports to next-20150402
Date: Sat, 25 Apr 2015 15:50:55 +0200
Message-Id: <1429969864-16831-1-git-send-email-hauke@hauke-m.de> (sfid-20150425_155122_673388_E417BC04)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

These patches are containing some small stuff needed for next-20150402. 
In addition they are fixing some compile problems with RHEL 7.1.

Hauke Mehrtens (9):
  patches: do not add backports code for recent kernel versions
  header: add DIV_ROUND_CLOSEST_ULL
  copy: add fixp-arith.h
  patches: do not access name_assign_type
  header: add module_pnp_driver()
  header: lockdep_assert_held is already in kernel 3.0
  header: add LINUX_BACKPORT() macro to reinit_completion()
  header: do not use genl backport on RHEL 7.0
  patches: refresh patches on next-20150402

 backport/backport-include/linux/completion.h       |  1 +
 backport/backport-include/linux/kernel.h           | 25 ++++++++++---
 backport/backport-include/linux/lockdep.h          | 10 ------
 backport/backport-include/linux/pnp.h              | 19 ++++++++++
 backport/backport-include/net/genetlink.h          |  2 +-
 backport/compat/backport-3.13.c                    |  3 ++
 copy-list                                          |  1 +
 patches/backport-adjustments/rhashtable.patch      |  2 +-
 .../media/0002-no_dmabuf/v4l2.patch                |  2 +-
 .../media/0003-devnode_param_type/dvb-core.patch   |  2 +-
 .../media/0004-missing-include/ir-hix5hd2.patch    |  4 +--
 .../0002-disable-dump-adjust-on-old-kernels.patch  |  4 +--
 .../include_net_cfg80211.patch                     |  2 +-
 .../0014-netlink_seq/net_wireless_nl80211.patch    |  2 +-
 .../network/0024-led-blink-api/mac80211.patch      |  2 +-
 .../network/0025-usb-sg/usbnet.patch               | 12 +++----
 .../network/0028-select_queue/mwifiex.patch        |  2 +-
 .../network/0031-sk_data_ready.cocci               |  2 ++
 .../0032-sriov_configure/igb_sriov_configure.patch |  4 +--
 .../0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch |  8 ++---
 .../network/0035-skb_no_fcs/igb_skb_no_fcs.patch   |  2 +-
 .../0038-ethtool_rxfh_indir/igb_rxfh_indir.patch   | 10 +++---
 .../0043-ndo_set_vf_rate/igb_set_vf_rate.patch     |  4 +--
 .../network/0046-mmc_rescan_entered/mwifiex.patch  |  2 +-
 .../network/0048-no_ndo_xmit_flush/igb.patch       |  2 +-
 .../network/0049-no-pfmemalloc/igb.patch           |  2 +-
 .../network/0050-iov_iter/bluetooth.patch          |  6 ++--
 .../network/0052-deactivate-ptp-pin/igb.patch      | 42 +++++++++++-----------
 .../network/0053-possible_net_t.patch              |  2 +-
 .../0053-remove_wait_on_bit_timeout/btusb.patch    | 12 +++----
 .../0054-struct-proto_ops-sig/bluetooth.patch      |  6 ++--
 .../network/0055-name_assign_type/brcmfmac.patch   | 12 +++++++
 32 files changed, 128 insertions(+), 83 deletions(-)
 delete mode 100644 backport/backport-include/linux/lockdep.h
 create mode 100644 backport/backport-include/linux/pnp.h
 create mode 100644 patches/collateral-evolutions/network/0055-name_assign_type/brcmfmac.patch

-- 
1.9.1

