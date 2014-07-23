Return-path: <backports-owner@vger.kernel.org>
Received: from test.hauke-m.de ([5.39.93.123]:55525 "EHLO test.hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933893AbaGWWLe (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 23 Jul 2014 18:11:34 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 00/11] backports: bring it to next-20140710, fix ubuntu trusty
Date: Thu, 24 Jul 2014 00:11:17 +0200
Message-Id: <1406153488-23896-1-git-send-email-hauke@hauke-m.de> (sfid-20140724_001137_471950_359E13A3)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This adds various patches to add support for next-20140710 and some 
fixes needed for the default kernel of ubuntu trusty and RedHat 7.0.

Hauke Mehrtens (11):
  backports: remove parameter from dma_buf_export()
  backports: add U16_MAX
  backports: add cc2520 driver
  backports: add pci_zalloc_consistent()
  backports: add request_firmware_direct()
  backports: backport __QUEUE_STATE_{DRV,STACK}_XOFF
  backports: build some regulator drivers only with kernel 3.17
  backports: add some ubuntu trusty specific changes
  backports: disable some more media drivers
  backports: make AT86RF230 driver depend on kernel > 3.4
  backports: refresh patches on next-20140710

 .../backport-include/asm-generic/pci-dma-compat.h  | 17 +++++++++++++++
 backport/backport-include/generated/utsrelease.h   |  5 +++++
 backport/backport-include/linux/dma-buf.h          |  9 ++++++++
 backport/backport-include/linux/firmware.h         |  9 ++++++++
 backport/backport-include/linux/kernel.h           |  4 ++++
 backport/backport-include/linux/netdevice.h        |  5 +++++
 backport/backport-include/linux/skbuff.h           |  5 ++++-
 backport/backport-include/linux/u64_stats_sync.h   |  4 +++-
 copy-list                                          |  1 +
 dependencies                                       | 24 +++++++++++++++++++---
 .../include_net_cfg80211.patch                     |  2 +-
 .../net_wireless_core.patch                        |  2 +-
 .../0006-ieee802154-6lowpan-namespace.patch        |  2 +-
 .../network/0008-net-user-ns.patch                 |  2 +-
 .../net_wireless_core.patch                        |  4 ++--
 .../net_mac80211_tx.patch                          |  4 ++--
 .../0014-netlink_seq/net_wireless_nl80211.patch    |  2 +-
 .../network/0024-led-blink-api/mac80211.patch      |  2 +-
 .../network/0027-genl-const/hwsim.patch            |  2 +-
 .../network/0027-genl-const/nl80211.patch          |  6 +++---
 .../network/0028-select_queue/mac80211.patch       | 10 +++++----
 .../network/0028-select_queue/mwifiex.patch        |  5 +++--
 .../0030-qdisc_tx_busylock/ieee802154.patch        |  4 ++--
 .../0032-sriov_configure/igb_sriov_configure.patch |  8 ++++----
 .../0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch |  8 ++++----
 .../igb_ndo_set_vf_spoofchk.patch                  |  8 ++++----
 .../network/0035-skb_no_fcs/igb_skb_no_fcs.patch   |  2 +-
 .../network/0042-pci_error_handlers/atl1e.patch    |  2 +-
 .../network/0043-ndo_set_vf_rate/igb.patch         | 10 ++++-----
 .../0044-no_user_ns_in_net/ieee802154.patch        |  4 ++--
 30 files changed, 124 insertions(+), 48 deletions(-)
 create mode 100644 backport/backport-include/asm-generic/pci-dma-compat.h
 create mode 100644 backport/backport-include/generated/utsrelease.h
 create mode 100644 backport/backport-include/linux/firmware.h

-- 
1.9.1

