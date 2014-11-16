Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:37679 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750823AbaKPUti (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 16 Nov 2014 15:49:38 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 00/20] backports: bring it to next-20141114
Date: Sun, 16 Nov 2014 21:49:00 +0100
Message-Id: <1416170960-12868-1-git-send-email-hauke@hauke-m.de> (sfid-20141116_214941_551196_A8C99370)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This mainly adds some new functions and so on needed by the code from 
next-20141114. I am currently unable to backport ieee802.15.4 so this 
depends on kernel 3.19.

I accidentally pushed the patches in the middle thats the reason I 
haven't integrated the last two patches.

Hauke Mehrtens (20):
  headers: cleanup linux/skbuff.h
  headers: add dev_alloc_page()
  headers: add skb_copy_datagram_msg()
  headers: snd_pcm_stop_xrun()
  headers: delete the list in unregister_netdevice_many()
  headers: add list_last_entry
  headers: add list_first_or_null_rcu()
  headers: add rt6_nexthop()
  copy-list: some header files for ieee802154 were moved
  dependencies: fix media dependencies
  dependencies: make IEEE802154 depend on 3.19
  backports: add woken_wake_function()
  backports: add genl_notify()
  backports: add net/6lowpan/
  patches: igb: remove usage of pfmemalloc in struct page
  patches: disable qdisc_tx_busylock in bluetooth
  backports: refresh patches on next-20141114
  headers: remove pci_regs.h
  headers: fix problem when unloading mac80211 on Ubuntu 14.04
  backports: do not use in kernel version of rt6_nexthop()

 backport/Kconfig.sources                           |   1 +
 backport/Makefile.kernel                           |   1 +
 backport/backport-include/linux/list.h             |  13 +
 backport/backport-include/linux/netdevice.h        |  24 ++
 backport/backport-include/linux/pci_regs.h         | 136 -----------
 backport/backport-include/linux/rculist.h          |  20 ++
 backport/backport-include/linux/skbuff.h           | 263 ++++++---------------
 backport/backport-include/linux/wait.h             |   9 +
 backport/backport-include/net/genetlink.h          |   5 +
 backport/backport-include/net/ip6_fib.h            |  15 ++
 backport/backport-include/sound/pcm.h              |  29 +++
 backport/compat/Makefile                           |   1 +
 backport/compat/backport-3.19.c                    |  79 +++++++
 backport/compat/compat-3.3.c                       |  13 +
 copy-list                                          |   4 +-
 dependencies                                       |   6 +-
 .../0002-disable-dump-adjust-on-old-kernels.patch  |   4 +-
 .../include_net_cfg80211.patch                     |   2 +-
 .../net_wireless_core.patch                        |   2 +-
 .../net_wireless_core.patch                        |   4 +-
 .../net_mac80211_tx.patch                          |   4 +-
 .../0013-fix-makefile-includes/bluetooth.patch     |  10 +
 .../0014-netlink_seq/net_wireless_nl80211.patch    |   2 +-
 .../network/0021-umode_t-api-change/ath10k.patch   |   2 +-
 .../network/0024-led-blink-api/mac80211.patch      |   2 +-
 .../network/0025-usb-sg/usbnet.patch               |  12 +-
 .../network/0027-genl-const/ieee802154.patch       |   4 +-
 .../network/0027-genl-const/nl80211.patch          |   6 +-
 .../network/0028-select_queue/mac80211.patch       |   4 +-
 .../network/0028-select_queue/mwifiex.patch        |   2 +-
 .../network/0030-qdisc_tx_busylock/bluetooth.patch |  12 +
 .../0030-qdisc_tx_busylock/ieee802154.patch        |   4 +-
 .../0032-sriov_configure/igb_sriov_configure.patch |   8 +-
 .../0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch |   8 +-
 .../igb_ndo_set_vf_spoofchk.patch                  |   6 +-
 .../network/0043-ndo_set_vf_rate/igb.patch         |   8 +-
 .../0044-no_user_ns_in_net/ieee802154.patch        |   4 +-
 .../network/0049-no-pfmemalloc/igb.patch           |  28 +++
 38 files changed, 378 insertions(+), 379 deletions(-)
 delete mode 100644 backport/backport-include/linux/pci_regs.h
 create mode 100644 backport/backport-include/net/ip6_fib.h
 create mode 100644 backport/backport-include/sound/pcm.h
 create mode 100644 backport/compat/backport-3.19.c
 create mode 100644 patches/collateral-evolutions/network/0013-fix-makefile-includes/bluetooth.patch
 create mode 100644 patches/collateral-evolutions/network/0030-qdisc_tx_busylock/bluetooth.patch
 create mode 100644 patches/collateral-evolutions/network/0049-no-pfmemalloc/igb.patch

-- 
1.9.1

