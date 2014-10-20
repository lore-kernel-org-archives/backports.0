Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:58018 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753125AbaJTVeQ (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 20 Oct 2014 17:34:16 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 0/5] backports: bring it to next-20140919
Date: Mon, 20 Oct 2014 23:33:42 +0200
Message-Id: <1413840827-9142-1-git-send-email-hauke@hauke-m.de> (sfid-20141020_233419_137757_BAA2C0C9)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This brings backports to next-20140919.

Hauke Mehrtens (5):
  backports: add S8_MIN
  backports: add eth_get_headlen()
  backports: add skb_clone_sk()
  backports: these drivers need a new function
  backports: refresh on next-20140919

 backport/backport-include/linux/etherdevice.h      |   5 +
 backport/backport-include/linux/kernel.h           |  12 ++
 backport/backport-include/linux/skbuff.h           |  10 ++
 backport/compat/Makefile                           |   1 +
 backport/compat/backport-3.18.c                    | 196 +++++++++++++++++++++
 dependencies                                       |   5 +
 .../media/0002-no_dmabuf/v4l2.patch                |  32 ++--
 .../media/0003-devnode_param_type/ddbridge.patch   |   2 +-
 .../0002-disable-dump-adjust-on-old-kernels.patch  |   4 +-
 .../include_net_cfg80211.patch                     |   2 +-
 .../net_wireless_core.patch                        |   2 +-
 .../net_wireless_core.patch                        |   4 +-
 .../net_mac80211_tx.patch                          |   6 +-
 .../0014-netlink_seq/net_wireless_nl80211.patch    |   2 +-
 .../network/0017-get_ts_info/igb_get_ts_info.patch |   2 +-
 .../network/0024-led-blink-api/mac80211.patch      |   2 +-
 .../network/0027-genl-const/nl80211.patch          |  14 +-
 .../network/0028-select_queue/mac80211.patch       |   4 +-
 .../network/0028-select_queue/mwifiex.patch        |   2 +-
 .../0032-sriov_configure/igb_sriov_configure.patch |   8 +-
 .../0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch |   8 +-
 .../igb_ndo_set_vf_spoofchk.patch                  |   6 +-
 .../network/0036-ethtool_eee/igb_ethtool_eee.patch |   4 +-
 .../0037-ethtool_get_module/igb_get_module.patch   |   6 +-
 .../0038-ethtool_rxfh_indir/igb_rxfh_indir.patch   |  10 +-
 .../network/0043-ndo_set_vf_rate/igb.patch         |   8 +-
 26 files changed, 293 insertions(+), 64 deletions(-)
 create mode 100644 backport/compat/backport-3.18.c

-- 
1.9.1

