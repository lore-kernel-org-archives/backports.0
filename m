Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:48146 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751953AbaIFXX6 (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 6 Sep 2014 19:23:58 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 0/4] backports: bring backports to next-20140905
Date: Sun,  7 Sep 2014 01:23:33 +0200
Message-Id: <1410045817-4112-1-git-send-email-hauke@hauke-m.de> (sfid-20140907_012405_794096_CB023EA4)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Just some small changes needed to get it to next-20130905.

Hauke Mehrtens (4):
  backports: adapt api change of rchan_callbacks->create_buf_file in
    ath10k
  backports: bluetooth revert patch adding write_iter
  backports: remove usage of skbuff->xmit_more
  backports: refresh patches on next-20140905

 .../include_net_cfg80211.patch                     |  2 +-
 .../0006-ieee802154-6lowpan-namespace.patch        | 13 +---
 .../network/0008-net-user-ns.patch                 |  4 +-
 .../net_wireless_core.patch                        |  2 +-
 .../net_mac80211_tx.patch                          |  4 +-
 .../0014-netlink_seq/net_wireless_nl80211.patch    |  2 +-
 .../network/0021-umode_t-api-change/ath10k.patch   | 14 ++++
 .../network/0027-genl-const/nl80211.patch          |  6 +-
 .../0032-sriov_configure/igb_sriov_configure.patch |  8 +--
 .../0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch |  8 +--
 .../igb_ndo_set_vf_spoofchk.patch                  |  6 +-
 .../network/0043-ndo_set_vf_rate/igb.patch         |  8 +--
 .../network/0047-write_iter/bluetooth.patch        | 83 ++++++++++++++++++++++
 .../network/0048-no_ndo_xmit_flush/igb.patch       | 14 ++++
 14 files changed, 137 insertions(+), 37 deletions(-)
 create mode 100644 patches/collateral-evolutions/network/0021-umode_t-api-change/ath10k.patch
 create mode 100644 patches/collateral-evolutions/network/0047-write_iter/bluetooth.patch
 create mode 100644 patches/collateral-evolutions/network/0048-no_ndo_xmit_flush/igb.patch

-- 
1.9.1

