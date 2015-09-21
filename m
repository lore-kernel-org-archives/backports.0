Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:51936 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756697AbbIUWHb (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 21 Sep 2015 18:07:31 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 00/10] backports: bring backports to next-20150903
Date: Tue, 22 Sep 2015 00:07:13 +0200
Message-Id: <1442873243-15490-1-git-send-email-hauke@hauke-m.de> (sfid-20150922_000735_223045_607B79D2)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This makes backports compatible with next-20150903.

1   3.0.101             [  OK  ]
2   3.1.10              [  OK  ]
3   3.2.71              [  OK  ]
4   3.3.8               [  OK  ]
5   3.4.108             [  OK  ]
6   3.5.7               [  OK  ]
7   3.6.11              [  OK  ]
8   3.7.10              [  OK  ]
9   3.8.13              [  OK  ]
10  3.9.11              [  OK  ]
11  3.10.88             [  OK  ]
12  3.11.10             [  OK  ]
13  3.12.47             [  OK  ]
14  3.13.11             [  OK  ]
15  3.14.52             [  OK  ]
16  3.15.10             [  OK  ]
17  3.16.7              [  OK  ]
18  3.17.8              [  OK  ]
19  3.18.21             [  OK  ]
20  3.19.8              [  OK  ]
21  4.0.9               [  OK  ]
22  4.1.7               [  OK  ]
23  4.2.0               [  OK  ]

Hauke Mehrtens (10):
  headers: add linux/bcm47xx_nvram.h
  header: add spi_sync_transfer()
  patches: fix patch for wait_on_bit_timeout()
  patches: remove usage of gpio/consumer.h from hci_intel.c
  patches: add linux/of.h include to st-nci/spi.c
  dependencies: make BCMA_DRIVER_GPIO depend on kernel 3.13
  dependencies: make VIDEO_TC358743 depend on kernel 3.13
  dependencies: make DVB_TDA10071 depend on kernel 3.4
  defconfig: fix ieee802154 defconfig
  patches: refresh patches on next-20150903

 backport/backport-include/linux/bcm47xx_nvram.h    |  27 ++++
 backport/backport-include/linux/spi/spi.h          |  49 +++++++
 backport/defconfigs/ieee802154                     |   4 +-
 dependencies                                       |   5 +
 .../media/0002-no_dmabuf/v4l2.patch                |   8 +-
 .../0013-fix-makefile-includes/st-nci-spi.patch    |  10 ++
 .../network/0021-umode_t-api-change/ath10k.patch   |   2 +-
 .../network/0025-usb-sg/usbnet.patch               |  12 +-
 .../0032-sriov_configure/igb_sriov_configure.patch |   4 +-
 .../0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch |   8 +-
 .../0038-ethtool_rxfh_indir/igb_rxfh_indir.patch   |   2 +-
 .../0043-ndo_set_vf_rate/igb_set_vf_rate.patch     |   4 +-
 .../network/0052-deactivate-ptp-pin/igb.patch      |  14 +-
 .../0053-remove_wait_on_bit_timeout/btusb.patch    |  12 +-
 .../hci_intel.patch                                | 154 ++++++++++++++++-----
 .../network/0062-acpi-gpio-remove/hci_bcm.patch    |  18 +--
 .../network/0062-acpi-gpio-remove/hci_intel.patch  |  67 +++++++++
 17 files changed, 326 insertions(+), 74 deletions(-)
 create mode 100644 backport/backport-include/linux/bcm47xx_nvram.h
 create mode 100644 patches/collateral-evolutions/network/0013-fix-makefile-includes/st-nci-spi.patch
 create mode 100644 patches/collateral-evolutions/network/0062-acpi-gpio-remove/hci_intel.patch

-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe backports" in
