Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:35743 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751425AbbINHs6 (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 14 Sep 2015 03:48:58 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 00/10] backports: bring backports to next-20150818
Date: Mon, 14 Sep 2015 09:48:32 +0200
Message-Id: <1442216922-3318-1-git-send-email-hauke@hauke-m.de> (sfid-20150914_094859_773013_8C49699C)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This makes backports compatible with next-20150818.
In addition it adds support for GCC 5.

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
  header: add acpi_dev_remove_driver_gpios()
  header: add page_is_pfmemalloc()
  header: remove parameter from mei_cl_register_event_cb()
  header: add compiler-gcc5.h
  patches: make ACPI gpio configuration depend on kernel >= 3.19
  patches: add additional include to brcmfmac
  dependencies: deactivate mwifiex SDIO part in kernel < 3.2
  dependencies: make netup-unidvb driver depend on >= 3.4
  devel: update test kernel versions
  backports: refresh on next-20150818

 backport/backport-include/linux/acpi.h             |  6 ++
 backport/backport-include/linux/compiler-gcc5.h    | 73 ++++++++++++++++++++
 backport/backport-include/linux/mei_cl_bus.h       | 11 +++
 backport/backport-include/linux/mm.h               |  9 +++
 dependencies                                       |  4 ++
 devel/backports-update-manager                     | 14 ++--
 patches/backport-adjustments/crypto-ccm.patch      |  4 +-
 .../media/0001-dma_mmap_coherent-revert.patch      |  4 +-
 .../media/0002-no_dmabuf/v4l2.patch                | 60 ++++++++---------
 .../media/0003-devnode_param_type/rc.patch         |  2 +-
 .../media/0005-dma-no-sync/v4l2.patch              | 14 ++--
 .../include_net_cfg80211.patch                     |  2 +-
 .../network/0005-disable-usb-net-asix.patch        |  4 +-
 .../net_wireless_core.patch                        |  6 +-
 .../0013-fix-makefile-includes/brcmfmac.patch      | 10 +++
 .../0014-netlink_seq/net_wireless_nl80211.patch    |  2 +-
 .../network/0046-mmc_rescan_entered/mwifiex.patch  | 12 ----
 .../network/0049-no-pfmemalloc/no-pfmemalloc.cocci |  2 +-
 .../network/0050-iov_iter/bluetooth.patch          |  2 +-
 .../network/0053-possible_net_t.patch              |  2 +-
 .../0053-remove_wait_on_bit_timeout/btusb.patch    | 12 ++--
 .../network/0062-acpi-gpio-remove/hci_bcm.patch    | 78 ++++++++++++++++++++++
 22 files changed, 256 insertions(+), 77 deletions(-)
 create mode 100644 backport/backport-include/linux/compiler-gcc5.h
 create mode 100644 backport/backport-include/linux/mei_cl_bus.h
 create mode 100644 patches/collateral-evolutions/network/0013-fix-makefile-includes/brcmfmac.patch
 delete mode 100644 patches/collateral-evolutions/network/0046-mmc_rescan_entered/mwifiex.patch
 create mode 100644 patches/collateral-evolutions/network/0062-acpi-gpio-remove/hci_bcm.patch

-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe backports" in
