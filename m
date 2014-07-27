Return-path: <backports-owner@vger.kernel.org>
Received: from test.hauke-m.de ([5.39.93.123]:33996 "EHLO test.hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752460AbaG0WKx (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 27 Jul 2014 18:10:53 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 0/9] backports: bring it to next-20140725
Date: Mon, 28 Jul 2014 00:10:30 +0200
Message-Id: <1406499039-16212-1-git-send-email-hauke@hauke-m.de> (sfid-20140728_001057_759020_D675A385)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This makes backports compatible with next-20140725.

Hauke Mehrtens (9):
  backports: fix bit_wait() and bit_wait_io()
  backports: do not build da9211 driver for kernel < 3.17
  backports: backport argument change in alloc_netdev_mqs()
  backports: revert commit for mwifiex sido.
  backports: add some more dev_*_ratelimited() functions
  backports: make media driver USB_MSI2500 depend on kernel 3.5
  backports: do not use dma_buf_vmap() on kernel < 3.5
  backports: add missing linux/mm.h to airspy
  backports: refresh on next-20140725

 backport/backport-include/linux/device.h           | 10 ++++
 backport/backport-include/linux/netdevice.h        | 14 +++++
 backport/backport-include/linux/wait.h             | 26 +++++++++
 backport/compat/Makefile                           |  1 +
 backport/compat/backport-3.17.c                    | 27 +++++++++
 dependencies                                       |  4 ++
 .../media/0001-dma_mmap_coherent-revert.patch      |  4 +-
 .../media/0002-no_dmabuf/v4l2.patch                | 67 +++++++++++++---------
 .../media/0004-missing-include/airspy.patch        | 18 ++++++
 .../network/0004-disable-wext-kconfig.patch        |  2 +-
 .../0014-netlink_seq/net_wireless_nl80211.patch    |  2 +-
 .../network/0024-led-blink-api/mac80211.patch      |  2 +-
 .../network/0027-genl-const/hwsim.patch            |  2 +-
 .../network/0027-genl-const/nl80211.patch          |  6 +-
 .../network/0028-select_queue/mwifiex.patch        |  2 +-
 .../0032-sriov_configure/igb_sriov_configure.patch |  8 +--
 .../0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch |  8 +--
 .../igb_ndo_set_vf_spoofchk.patch                  |  6 +-
 .../network/0043-ndo_set_vf_rate/igb.patch         |  8 +--
 .../network/0046-mmc_rescan_entered/mwifiex.patch  | 12 ++++
 20 files changed, 176 insertions(+), 53 deletions(-)
 create mode 100644 backport/backport-include/linux/wait.h
 create mode 100644 backport/compat/backport-3.17.c
 create mode 100644 patches/collateral-evolutions/media/0004-missing-include/airspy.patch
 create mode 100644 patches/collateral-evolutions/network/0046-mmc_rescan_entered/mwifiex.patch

-- 
1.9.1

