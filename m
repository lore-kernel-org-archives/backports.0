Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:36628 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751767AbaLURwA (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 21 Dec 2014 12:52:00 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 0/8] backports: updates for next-20141221
Date: Sun, 21 Dec 2014 18:51:46 +0100
Message-Id: <1419184314-1938-1-git-send-email-hauke@hauke-m.de> (sfid-20141221_185202_981699_EAF482EE)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This contains some patches needed to make backports compatible with
next-20141221.

Hauke Mehrtens (8):
  header: add napi_alloc_skb()
  header: add skb_put_padto()
  header: add eth_skb_pad()
  header: add dma_rmb()
  patches: revert iov_iter for bluetooth
  atches: fix ssb compile
  patches: remove ath9k-Revert-ath-ath9k-use-debugfs patch
  patches: refresh patches on next-20141221

 backport/backport-include/asm-generic/barrier.h    |   9 +
 backport/backport-include/asm/barrier.h            |   9 +
 backport/backport-include/linux/etherdevice.h      |  15 ++
 backport/backport-include/linux/netdevice.h        |   9 +
 backport/backport-include/linux/skbuff.h           |  24 ++
 .../0006-ath9k-Revert-ath-ath9k-use-debugfs.patch  | 253 ---------------------
 .../media/0002-no_dmabuf/v4l2.patch                |   6 +-
 .../media/0003-devnode_param_type/ddbridge.patch   |   2 +-
 .../network/0004-disable-wext-kconfig.patch        |   2 +-
 .../net_wireless_core.patch                        |   2 +-
 .../0014-netlink_seq/net_wireless_nl80211.patch    |   2 +-
 .../network/0017-get_ts_info/igb_get_ts_info.patch |   2 +-
 .../network/0027-genl-const/hwsim.patch            |   2 +-
 .../network/0027-genl-const/nfc.patch              |   4 +-
 .../network/0027-genl-const/nl80211.patch          |   6 +-
 .../network/0028-select_queue/mac80211.patch       |   4 +-
 .../network/0030-qdisc_tx_busylock/bluetooth.patch |   2 +-
 .../0030-qdisc_tx_busylock/ieee802154.patch        |   2 +-
 .../0032-sriov_configure/igb_sriov_configure.patch |  12 +-
 .../0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch |   8 +-
 .../igb_ndo_set_vf_spoofchk.patch                  |   8 +-
 .../network/0035-skb_no_fcs/igb_skb_no_fcs.patch   |   2 +-
 .../network/0036-ethtool_eee/igb_ethtool_eee.patch |   2 +-
 .../0037-ethtool_get_module/igb_get_module.patch   |   2 +-
 .../0038-ethtool_rxfh_indir/igb_rxfh_indir.patch   |  44 +++-
 .../igb_pci_error_handlers.patch                   |   2 +-
 .../network/0043-ndo_set_vf_rate/igb.patch         |  10 +-
 .../0044-no_user_ns_in_net/ieee802154.patch        |   4 +-
 .../network/0048-no_ndo_xmit_flush/igb.patch       |   2 +-
 .../network/0049-no-pfmemalloc/igb.patch           |   4 +-
 .../network/0050-iov_iter/bluetooth.patch          | 181 +++++++++++++++
 .../network/0051-no-wakeup_path/ssb.patch          |  12 +
 32 files changed, 340 insertions(+), 308 deletions(-)
 create mode 100644 backport/backport-include/asm-generic/barrier.h
 create mode 100644 backport/backport-include/asm/barrier.h
 delete mode 100644 patches/0000-upstream-backport-changes/0006-ath9k-Revert-ath-ath9k-use-debugfs.patch
 create mode 100644 patches/collateral-evolutions/network/0050-iov_iter/bluetooth.patch
 create mode 100644 patches/collateral-evolutions/network/0051-no-wakeup_path/ssb.patch

-- 
1.9.1

