Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:38492 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752365AbaDEMlJ (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 5 Apr 2014 08:41:09 -0400
Received: by mail-pa0-f51.google.com with SMTP id kq14so4681647pab.10
        for <backports@vger.kernel.org>; Sat, 05 Apr 2014 05:41:08 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 00/27] backports: synch up to next-20140311
Date: Sat,  5 Apr 2014 05:40:34 -0700
Message-Id: <1396701662-15165-1-git-send-email-mcgrof@do-not-panic.com> (sfid-20140405_144119_636440_A6ADEF8B)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

I'm back from Limbo! Thanks to Hauke for taking on backports while I was
gone and to Johannes for taking on the first seires of SmPL patches. This
series takes what I saw was pending on the backports mailing list and also
puts out what I have been working on in collaboration with the folks at LIP6,
in particular Julia Lawall, on the helping automate backport the Linux kernel
further. I've put together a lenghty write up [0] of the series of changes
that have been ongoing on the Linux backports project [1] which I hope can
serve as both some form of ramp up education on using Coccinelle and writing
grammar rules in Semantic Patch Language (SmPL) but also concerte evidence of
how this technology can help us scale Linux and scale Linux backporting and
extend the way we do automatic backporting.

This also puts us in synch with next-20140311 and I have some small changes
which lets us create a linux-3.14.y branch ready for release provided I don't
hear back with any issues or qualms observed. All this obviously goes compile
tested against the last 30 Linux kernel releases.

At the Linux Collaboration Summit and on elsewhere I've been beeing poked about
backports and if anyone was working on it and will continue to do so. There
were some isues which I needed to get resolved, its all done and I'm back, now
at SUSE. Now at SUSE I have other responsibilities but I'm going going to
continue to extend backports but with a slightly different set of requirements
and considerations, one of them being focusing on kernels >= 3.0. I understand
there is still huge interest in upkeeping support for older kernels, I don't
plan on removing those immediately but with your help I think we should strive
to build consensus on only using kernels listed on kernel.org. The flexibility
provided by Linux backports can hopefully be used to help persuade folks to
abandon unsupported kernels. This won't happen overnight, but that's the goal.

If you want to test all this agains the latest master branch you can wget the
all in one series of patches [2] and git am it.

[0] http://www.do-not-panic.com//2014/04/automatic-linux-kernel-backporting-with-coccinelle.html
[1] https://backports.wiki.kernel.org
[2] http://drvbp1.linux-foundation.org/~mcgrof/patches/backports/2014/05/synch-up-next-next-20140311.patch

Eliad Peller (1):
  backports: ifdef some pci functions

Johannes Berg (2):
  backports: fix compilation with CONFIG_OF
  backports: add crypto/ccm backport

Luis R. Rodriguez (24):
  backports: backport MPLS support
  backports: make WL1251_SPI depend on >= 3.5
  backports: bump kernel reqs for WL1251_SDIO and WLCORE_SDIO
  backports: bump drivers dependency that require I2C bus classes
  backports: define ETH_P_80221
  backports: backport definition of struct frag_queue
  backports: backport skb_unclone()
  backports: backport frag helper functions for mem limit tracking
  backports: backport inet_frag_maybe_warn_overflow()
  backports: add threaded Coccinelle spatch support
  backports: use --ignore-removal for git add
  backports: add git diff support to lib/bpgit.py
  backports: add support for testing only a single Coccinelle SmPL patch
  backports: add Coccinelle SmPL profiling support to gentree.py
  backports: add include/net/6lowpan.h to copy-list
  backports: address move of 6lowpan.c to 6lowpan_rtnl.c
  backports: address jump label and static key support
  backports: backport net_get_random_once()
  backports: 6lowpan domain specific backport of inet_frag_lru_move()
  backports: backport ieee802154 6lowpan support down to 3.5
  backports: refresh patches based on next-20140311
  backports: backports: reshufle the threaded IRQ backport series
  backports: convert threaded IRQ suport into an SmPL patch
  backports: enhance 0001-netdev_ops.cocci with data structure specifics

 backport/backport-include/linux/if_ether.h         |   5 +
 backport/backport-include/linux/net.h              |  52 ++++++
 backport/backport-include/linux/of.h               |   3 +
 backport/backport-include/linux/pci.h              |   2 +
 backport/backport-include/linux/skbuff.h           |  11 ++
 backport/backport-include/linux/static_key.h       | 186 +++++++++++++++++++++
 backport/backport-include/linux/tracepoint.h       |   7 +
 backport/backport-include/net/inet_frag.h          |  44 +++++
 backport/backport-include/net/ipv6.h               |  19 +++
 backport/backport-include/net/net_namespace.h      |  22 ++-
 backport/compat/Kconfig                            |   9 +
 backport/compat/Makefile                           |   1 +
 backport/compat/backport-3.10.c                    |  28 ++++
 backport/compat/backport-3.13.c                    |  54 ++++++
 backport/compat/backport-3.15.c                    |  14 ++
 backport/compat/backports.h                        |  10 ++
 backport/compat/compat-3.8.c                       |  28 ----
 backport/compat/compat-3.9.c                       |  14 ++
 backport/compat/main.c                             |   8 +-
 copy-list                                          |   8 +
 dependencies                                       |  20 ++-
 gentree.py                                         |  64 +++++--
 lib/bpcoccinelle.py                                |  92 ++++++++++
 lib/bpgit.py                                       |  16 +-
 .../0001-6lowpan-namespace.patch                   | 143 ++++++++++++++++
 .../0002-include-new-netns-headers.patch           |  12 ++
 patches/backport-adjustments/crypto-ccm.patch      |  76 +++++++++
 .../media/0004-sysfs-api.patch                     |   2 +-
 .../network/0001-netdev_ops.cocci                  |   8 +-
 .../mac80211.patch                                 |   4 +-
 .../0006-disable-dump-adjust-on-old-kernels.patch  |   4 +-
 .../network/0010-disable-usb-net-asix.patch        |   2 +-
 .../0012-ieee802154-6lowpan-namespace.patch        |  63 +++++++
 .../network/0013-lowpan-inet_frag_lru_move.patch   |  59 +++++++
 .../network/0013-net-user-ns.patch                 |  17 ++
 .../network/0014-inet_frag_evictor.patch           |  20 +++
 .../network/0015-threaded-irq.cocci                |  75 +++++++++
 .../{09-threaded-irq => 0015-threaded-irq}/INFO    |   3 +-
 .../drivers_net_wireless_iwlwifi_iwl-trans.patch   |  12 ++
 .../network/0016-threaded-irq-one-shot.patch       |  38 +++++
 .../drivers_net_wireless_ti_wl1251_spi.patch       |   2 +-
 .../include_net_cfg80211.patch                     |   2 +-
 .../drivers_net_wireless_b43_b43.patch             |  12 --
 .../drivers_net_wireless_b43_main.patch            |  45 -----
 ...rivers_net_wireless_iwlwifi_pcie_internal.patch |  12 --
 .../drivers_net_wireless_iwlwifi_pcie_trans.patch  |  41 -----
 .../drivers_net_wireless_ti_wlcore_main.patch      |  55 ------
 .../drivers_net_wireless_ti_wlcore_wlcore.patch    |  13 --
 .../net_wireless_core.patch                        |   2 +-
 .../drivers_net_wireless_iwlegacy_3945-mac.patch   |   2 +-
 .../drivers_net_wireless_iwlegacy_4965-mac.patch   |   2 +-
 .../drivers_net_wireless_iwlegacy_common.patch     |   4 +-
 .../drivers_net_wireless_mwifiex_pcie.patch        |   2 +-
 .../16-bluetooth/drivers_bluetooth_hci_ldisc.patch |   4 +-
 .../17-netdev-queue/net_mac80211_iface.patch       |   4 +-
 .../24-pcmcia/drivers_bluetooth_bluecard_cs.patch  |  20 +--
 .../24-pcmcia/drivers_bluetooth_bt3c_cs.patch      |  14 +-
 .../24-pcmcia/drivers_bluetooth_btuart_cs.patch    |  20 +--
 .../24-pcmcia/drivers_bluetooth_dtl1_cs.patch      |  20 +--
 .../drivers_net_wireless_iwlwifi.patch             |   4 +-
 .../drivers_net_wireless_mwl8k.patch               |  10 +-
 .../drivers_net_wireless_rtl818x_rtl8180_dev.patch |   2 +-
 .../include_net_mac80211.patch                     |   2 +-
 .../net_mac80211_iface.patch                       |   4 +-
 .../drivers_net_wireless_mwifiex_sdio.patch        |  16 +-
 .../30-bridge-port/net_wireless_nl80211.patch      |   2 +-
 .../network/30-bridge-port/net_wireless_util.patch |   2 +-
 .../network/36-workqueue/net_mac80211_main.patch   |   2 +-
 .../42-netlink_seq/net_wireless_nl80211.patch      |   2 +-
 .../drivers_net_wireless_mwifiex_init.patch        |   2 +-
 .../52-tty-dev/drivers_bluetooth_hci_ldisc.patch   |   2 +-
 .../drivers_net_ethernet_broadcom_b44.patch        |   4 +-
 .../69-wowlan-no-socket/net_wireless_nl80211.patch |   2 +-
 .../network/81-genl-const/hwsim.patch              |   2 +-
 .../network/81-genl-const/nl80211.patch            |   6 +-
 .../network/83-select_queue/mac80211.patch         |   4 +-
 .../84-ethernet/0001-igb_net_device_ops.patch      |   8 +-
 .../84-ethernet/0002-igb_pci_sriov_configure.patch |  12 +-
 .../network/84-ethernet/0004-igb_err_handler.patch |   2 +-
 .../network/84-ethernet/0005-igb_mdi.patch         |  10 +-
 .../network/84-ethernet/0006-igb_eee.patch         |   6 +-
 .../network/84-ethernet/0007-igb_ethtool_ops.patch |  10 +-
 .../network/84-ethernet/0008-igb_no_fcs.patch      |   2 +-
 .../network/84-ethernet/0009-igb_vlan_rx_vid.patch |   8 +-
 .../network/84-ethernet/0010-igb_ethtool_ops.patch |  10 +-
 .../network/84-ethernet/0011-igb_ethtool_ops.patch |   6 +-
 .../84-ethernet/0012-igb_ndo_set_vf_spoofchk.patch |  10 +-
 .../network/84-ethernet/0013-igb_hwmon.patch       |   6 +-
 .../network/86-qdisc_tx_busylock/ieee802154.patch  |  10 +-
 89 files changed, 1317 insertions(+), 382 deletions(-)
 create mode 100644 backport/backport-include/linux/static_key.h
 create mode 100644 backport/backport-include/net/inet_frag.h
 create mode 100644 lib/bpcoccinelle.py
 create mode 100644 patches/0000-upstream-backport-changes/0001-6lowpan-namespace.patch
 create mode 100644 patches/0000-upstream-backport-changes/0002-include-new-netns-headers.patch
 create mode 100644 patches/backport-adjustments/crypto-ccm.patch
 create mode 100644 patches/collateral-evolutions/network/0012-ieee802154-6lowpan-namespace.patch
 create mode 100644 patches/collateral-evolutions/network/0013-lowpan-inet_frag_lru_move.patch
 create mode 100644 patches/collateral-evolutions/network/0013-net-user-ns.patch
 create mode 100644 patches/collateral-evolutions/network/0014-inet_frag_evictor.patch
 create mode 100644 patches/collateral-evolutions/network/0015-threaded-irq.cocci
 rename patches/collateral-evolutions/network/{09-threaded-irq => 0015-threaded-irq}/INFO (78%)
 create mode 100644 patches/collateral-evolutions/network/0015-threaded-irq/drivers_net_wireless_iwlwifi_iwl-trans.patch
 create mode 100644 patches/collateral-evolutions/network/0016-threaded-irq-one-shot.patch
 delete mode 100644 patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_b43_b43.patch
 delete mode 100644 patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_b43_main.patch
 delete mode 100644 patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_iwlwifi_pcie_internal.patch
 delete mode 100644 patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_iwlwifi_pcie_trans.patch
 delete mode 100644 patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_ti_wlcore_main.patch
 delete mode 100644 patches/collateral-evolutions/network/09-threaded-irq/drivers_net_wireless_ti_wlcore_wlcore.patch

-- 
1.8.5.3

