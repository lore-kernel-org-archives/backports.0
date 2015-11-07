Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:52902 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753711AbbKGQzR (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 7 Nov 2015 11:55:17 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 00/10] backport: update to next-20151013
Date: Sat,  7 Nov 2015 17:55:00 +0100
Message-Id: <1446915310-8278-1-git-send-email-hauke@hauke-m.de> (sfid-20151107_175520_266250_24BF550B)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This brings backports in sync with next-20151013.
In addition it fixes some problem on RHEL 7.

Hauke Mehrtens (10):
  patches: argument removed from struct ipv6_stub->ndisc_send_na()
  patches: add missing header in 6lowpan/core.h
  header: adapt renaming of mei_cl_ to mei_cldev_
  header: add ktime_get_ns()
  header: add __GFP_KSWAPD_RECLAIM
  header: add nla_get_le32() and nla_get_le64()
  header: change check for ACPI_COMPANION
  backport: add of_property_read_u64_array()
  dependencies: VIDEO_MT9P031 uses gpio consumer
  patches: refresh on next-20151013

 backport/backport-include/linux/acpi.h             |  4 +--
 backport/backport-include/linux/gfp.h              | 13 ++++++++
 backport/backport-include/linux/mei_cl_bus.h       | 18 +++++++++--
 backport/backport-include/linux/of.h               | 17 ++++++++++
 backport/backport-include/linux/timekeeping.h      | 10 ++++++
 backport/backport-include/net/netlink.h            | 22 +++++++++++++
 backport/compat/backport-3.18.c                    | 37 ++++++++++++++++++++++
 dependencies                                       |  2 +-
 .../0002-disable-dump-adjust-on-old-kernels.patch  |  4 +--
 .../include_net_cfg80211.patch                     |  2 +-
 .../net_wireless_core.patch                        |  2 +-
 .../0013-fix-makefile-includes/6lowpan.patch       | 10 ++++++
 .../0013-fix-makefile-includes/brcmfmac.patch      | 10 ------
 .../0014-netlink_seq/net_wireless_nl80211.patch    |  2 +-
 .../0020-tty-termios/net_bluetooth_hci_ldisc.patch | 10 +++---
 .../network/0024-led-blink-api/mac80211.patch      |  2 +-
 .../network/0025-usb-sg/usbnet.patch               |  2 +-
 .../network/0028-select_queue/mwifiex.patch        |  2 +-
 .../network/0030-qdisc_tx_busylock/bluetooth.patch |  4 +--
 .../0032-sriov_configure/igb_sriov_configure.patch |  4 +--
 .../0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch |  8 ++---
 .../0043-ndo_set_vf_rate/igb_set_vf_rate.patch     |  4 +--
 .../network/0047-write_iter/bluetooth.patch        | 10 +++---
 .../network/0050-iov_iter/bluetooth.patch          |  8 ++---
 .../network/0052-deactivate-ptp-pin/igb.patch      |  4 +--
 .../network/0053-possible_net_t.patch              |  2 +-
 .../0053-remove_wait_on_bit_timeout/btusb.patch    | 12 +++----
 .../hci_intel.patch                                | 10 +++---
 .../network/0055-name_assign_type/brcmfmac.patch   |  2 +-
 .../network/0059-uuid-in-mei/nfc.patch             | 16 ++++++----
 .../network/0062-acpi-gpio-remove/hci_bcm.patch    | 24 +++++++-------
 .../network/0062-acpi-gpio-remove/hci_intel.patch  | 10 +++---
 .../network/0065-ndisc_send_na-argument.cocci      |  9 ++++++
 33 files changed, 211 insertions(+), 85 deletions(-)
 create mode 100644 backport/backport-include/linux/gfp.h
 create mode 100644 patches/collateral-evolutions/network/0013-fix-makefile-includes/6lowpan.patch
 delete mode 100644 patches/collateral-evolutions/network/0013-fix-makefile-includes/brcmfmac.patch
 create mode 100644 patches/collateral-evolutions/network/0065-ndisc_send_na-argument.cocci

-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
