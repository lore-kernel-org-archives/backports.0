Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:56140 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757207AbcGJVO4 (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 10 Jul 2016 17:14:56 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 00/19] backports: bring to next-20160324
Date: Sun, 10 Jul 2016 23:14:26 +0200
Message-Id: <1468185285-28265-1-git-send-email-hauke@hauke-m.de> (sfid-20160710_231458_920505_0266340E)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This add various stuff needed for next-20160324.

Hauke Mehrtens (19):
  copy-list: rename brcmfmac.h
  copy-list: add media/tvp5150.h header file
  dependencies: deactivate igb on kernel < 3.11
  header: adapt get_user_pages_{locked,unlocked} signature
  header: remove vid parameter from ndo_dflt_fdb_add()
  header: add ipv6_addr_prefix_copy()
  header: add missing S16_MIN and S16_MAX
  header: add empty for_each_child_of_node()
  header: adapt thermal_zone_device_register() signature changes
  header: add thermal_notify_framework()
  patches: do not call of_irq_* functions on kernel < 3.13 in bcma
  patches: make iwlwifi use the old thermal APIs
  patches: remove usage of the head_frag member of skb
  patch: add include for net/ipv6.h to igb_main.c
  backports: add rhashtable_walk_init()
  patches: refresh on next-20160324
  gentree.py: print some more error messages when spatch fails.
  devel: update test kernel versions
  defconfig: update defconfigs, some options changed in the kernel.

 backport/backport-include/linux/kernel.h           |  8 +++
 backport/backport-include/linux/mm.h               | 45 ++++++++++++----
 backport/backport-include/linux/of.h               |  5 ++
 backport/backport-include/linux/rhashtable.h       | 12 +++++
 backport/backport-include/linux/rtnetlink.h        |  6 +++
 backport/backport-include/linux/thermal.h          | 27 ++++++++++
 backport/backport-include/net/ipv6.h               | 18 +++++++
 backport/compat/Makefile                           |  1 +
 backport/compat/backport-4.0.c                     | 18 +++----
 backport/compat/backport-4.7.c                     | 62 ++++++++++++++++++++++
 backport/defconfigs/ar5523                         |  2 +-
 backport/defconfigs/ath10k                         |  2 +-
 backport/defconfigs/ath5k                          |  2 +-
 backport/defconfigs/ath6kl                         |  2 +-
 backport/defconfigs/ath9k                          |  2 +-
 backport/defconfigs/ath9k-debug                    |  2 +-
 backport/defconfigs/carl9170                       |  2 +-
 backport/defconfigs/media                          |  5 --
 backport/defconfigs/wcn36xx                        |  2 +-
 backport/defconfigs/wifi                           | 18 +++++--
 backport/defconfigs/wil6210                        |  2 +-
 copy-list                                          |  4 +-
 dependencies                                       |  3 +-
 devel/backports-update-manager                     | 21 ++++----
 gentree.py                                         |  2 +-
 .../media/0004-missing-include/media-device.patch  |  2 +-
 .../0002-disable-dump-adjust-on-old-kernels.patch  |  4 +-
 .../include_net_cfg80211.patch                     |  2 +-
 .../net_wireless_core.patch                        |  2 +-
 .../network/0013-fix-makefile-includes/igb.patch   | 12 +++++
 .../0014-netlink_seq/net_wireless_nl80211.patch    |  2 +-
 .../network/0024-led-blink-api/mac80211.patch      |  2 +-
 .../network/0025-usb-sg/usbnet.patch               |  2 +-
 .../0032-sriov_configure/igb_sriov_configure.patch |  4 +-
 .../0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch | 23 +++++---
 .../0043-ndo_set_vf_rate/igb_set_vf_rate.patch     |  4 +-
 .../network/0052-deactivate-ptp-pin/igb.patch      | 16 +++---
 .../network/0053-possible_net_t.patch              |  2 +-
 .../0053-remove_wait_on_bit_timeout/btusb.patch    | 12 ++---
 .../network/0055-name_assign_type/brcmfmac.patch   |  2 +-
 .../network/0062-acpi-gpio-remove/hci_bcm.patch    |  2 +-
 .../network/0069-remove-of_irq/bcma.patch          | 26 +++++++++
 .../network/0070-thermal/iwlwifi.patch             | 58 ++++++++++++++++++++
 .../network/0071-skb-head_frag/wireless.patch      | 16 ++++++
 .../network/0072-netdevice-ndo_fdb_add/igb.patch   | 16 ++++++
 45 files changed, 394 insertions(+), 88 deletions(-)
 create mode 100644 backport/backport-include/linux/rhashtable.h
 create mode 100644 backport/backport-include/linux/thermal.h
 create mode 100644 backport/compat/backport-4.7.c
 create mode 100644 patches/collateral-evolutions/network/0013-fix-makefile-includes/igb.patch
 create mode 100644 patches/collateral-evolutions/network/0069-remove-of_irq/bcma.patch
 create mode 100644 patches/collateral-evolutions/network/0070-thermal/iwlwifi.patch
 create mode 100644 patches/collateral-evolutions/network/0071-skb-head_frag/wireless.patch
 create mode 100644 patches/collateral-evolutions/network/0072-netdevice-ndo_fdb_add/igb.patch

-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
