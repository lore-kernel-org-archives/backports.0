Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:35546 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751338AbbKOP5I (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 15 Nov 2015 10:57:08 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 00/15] backport: update to next-20151115
Date: Sun, 15 Nov 2015 16:56:44 +0100
Message-Id: <1447603019-11862-1-git-send-email-hauke@hauke-m.de> (sfid-20151115_165711_122168_03B81F0E)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This contains various patches bringing backport in sync with next-20151115.

Hauke Mehrtens (15):
  copy: add new file include/trace/events/vb2.h
  copy: add drivers/net/wireless/realtek/
  dependencies: make NFC_FDP_I2C depend on kernel >= 3.18
  dependencies: make NFC_FDP depend on kernel >= 3.13
  dependencies: make NFC_MRVL depend on kernel >= 3.3
  haeder: add napi_complete_done()
  header: add upstream version of clamp()
  header: add inet_frags_uninit_net()
  header: make inet_frags_init_net() return something
  header: add empty implementation of irq_of_parse_and_map()
  patches: add forward declaration of struct wpan_dev to cfg802154.h
  patches: remove wpan_dev_hard_header() on kernel < 3.18
  defconfigs: update wifi defconfigs
  defconfigs: update media defconfig
  patches: refresh on next-20151115

 backport/backport-include/linux/kernel.h           |   5 +
 backport/backport-include/linux/netdevice.h        |   8 ++
 backport/backport-include/linux/of_irq.h           |  15 +++
 backport/backport-include/net/inet_frag.h          |  18 +++
 backport/defconfigs/b43                            |   1 -
 backport/defconfigs/media                          |  10 --
 backport/defconfigs/rtlwifi                        |   1 +
 backport/defconfigs/wifi                           |   2 +-
 copy-list                                          |   4 +-
 dependencies                                       |   9 ++
 .../media/0001-dma_mmap_coherent-revert.patch      |   4 +-
 .../media/0002-no_dmabuf/v4l2.patch                | 122 +++++++++++++--------
 .../media/0004-missing-include/hackrf.patch        |   4 +-
 .../media/0005-dma-no-sync/v4l2.patch              |   8 +-
 .../0002-disable-dump-adjust-on-old-kernels.patch  |   4 +-
 .../include_net_cfg80211.patch                     |   2 +-
 .../network/0004-disable-wext-kconfig.patch        |   2 +-
 .../net_wireless_core.patch                        |   2 +-
 .../0013-fix-makefile-includes/cfg802154.patch     |  10 ++
 .../0014-netlink_seq/net_wireless_nl80211.patch    |   2 +-
 .../0020-tty-termios/net_bluetooth_hci_ldisc.patch |  10 +-
 .../network/0024-led-blink-api/mac80211.patch      |   2 +-
 .../network/0028-select_queue/mac80211.patch       |   4 +-
 .../net_bluetooth_hidp_core.patch                  |   2 +-
 .../network/0030-qdisc_tx_busylock/bluetooth.patch |   4 +-
 .../0032-sriov_configure/igb_sriov_configure.patch |   4 +-
 .../0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch |   8 +-
 .../0038-ethtool_rxfh_indir/igb_rxfh_indir.patch   |  10 +-
 .../0043-ndo_set_vf_rate/igb_set_vf_rate.patch     |   4 +-
 .../network/0050-iov_iter/bluetooth.patch          |  16 +--
 .../network/0053-possible_net_t.patch              |   2 +-
 .../0053-remove_wait_on_bit_timeout/btusb.patch    |  12 +-
 .../network/0062-acpi-gpio-remove/hci_bcm.patch    |   4 +-
 .../network/0062-acpi-gpio-remove/hci_intel.patch  |   6 +-
 .../cfg802154.patch                                |  18 +++
 35 files changed, 223 insertions(+), 116 deletions(-)
 create mode 100644 backport/backport-include/linux/of_irq.h
 create mode 100644 patches/collateral-evolutions/network/0013-fix-makefile-includes/cfg802154.patch
 create mode 100644 patches/collateral-evolutions/network/0066-remove-netdev_ieee802154_ptr/cfg802154.patch

-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
