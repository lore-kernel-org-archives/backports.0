Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:51824 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750863AbbLUAGJ (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 20 Dec 2015 19:06:09 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 0/6] backports: sync with next-20151218
Date: Mon, 21 Dec 2015 01:05:55 +0100
Message-Id: <1450656361-21259-1-git-send-email-hauke@hauke-m.de> (sfid-20151221_010618_918225_26A7C784)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This adds some changes needed to work with next-20151218. 

Hauke Mehrtens (6):
  backport: add no_seek_end_llseek()
  dependencies: make ti wlcore depend on kernel >= 3.2
  dependencies: make ATH9K_HWRNG depend on kernel >= 3.17
  header: add NETIF_F_SCTP_CRC
  patches: convert gpio: change member .dev to .parent
  patches: refresh patches on next-20151218

 backport/backport-include/linux/fs.h               |  6 +++++
 backport/backport-include/linux/netdev_features.h  |  5 ++++
 backport/compat/backport-4.5.c                     | 27 ++++++++++++++++++++++
 dependencies                                       |  8 +++++++
 .../generic/0002-gpio-parent.cocci                 | 25 ++++++++++++++++++++
 .../media/0003-devnode_param_type/dvb-core.patch   |  2 +-
 .../network/0004-disable-wext-kconfig.patch        |  2 +-
 .../0013-fix-makefile-includes/6lowpan.patch       |  4 ++--
 .../network/0025-usb-sg/usbnet.patch               | 12 +++++-----
 .../0032-sriov_configure/igb_sriov_configure.patch |  4 ++--
 .../0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch |  8 +++----
 .../0038-ethtool_rxfh_indir/igb_rxfh_indir.patch   | 10 ++++----
 .../0043-ndo_set_vf_rate/igb_set_vf_rate.patch     |  4 ++--
 .../network/0050-iov_iter/bluetooth.patch          |  6 ++---
 .../network/0052-deactivate-ptp-pin/igb.patch      |  2 +-
 .../0053-remove_wait_on_bit_timeout/btusb.patch    | 12 +++++-----
 .../hci_intel.patch                                | 10 ++++----
 .../network/0062-acpi-gpio-remove/hci_intel.patch  |  6 ++---
 18 files changed, 112 insertions(+), 41 deletions(-)
 create mode 100644 patches/collateral-evolutions/generic/0002-gpio-parent.cocci

-- 
2.6.4

--
To unsubscribe from this list: send the line "unsubscribe backports" in
