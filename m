Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:49586 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751403AbcD3VBE (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 30 Apr 2016 17:01:04 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 00/16] backports: bring to next-20160216
Date: Sat, 30 Apr 2016 23:00:32 +0200
Message-Id: <1462050048-8953-1-git-send-email-hauke@hauke-m.de> (sfid-20160430_230105_940065_C0020806)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This add various stuff needed for next-20160216. In addition this also
deactivates the media driver for kernel < 3.8.

Hauke Mehrtens (16):
  backport: make media depend on kernel 3.8
  header: add pci_enable_msix_exact()
  header: add barrier_data()
  backport: add memzero_explicit()
  header: add shash_desc_zero() and ahash_request_zero()
  header: add AHASH_REQUEST_ON_STACK()
  backport: add crypto skcipher interface
  header: add SHASH_DESC_ON_STACK()
  header: add asm/barrier.h on mips and alpha
  backports: add kstrtobool() and kstrtobool_from_user()
  backports: add devm_led_trigger_register()
  patches: use old signature for struct proto hash function
  dependencies: make DVB_CXD2820R depend on kernel 4.5
  dependencies: make VIDEO_TVP5150 depend on kernel 3.17
  devel: update test kernel versions
  patches: refresh on next-20160216

 backport/backport-include/asm/barrier.h            |   3 +-
 backport/backport-include/asm/dma-mapping.h        |  27 --
 backport/backport-include/crypto/hash.h            |  38 ++
 backport/backport-include/crypto/skcipher.h        | 454 +++++++++++++++++++++
 backport/backport-include/linux/compiler.h         |   8 +
 backport/backport-include/linux/i2c.h              |   9 -
 backport/backport-include/linux/kernel.h           |   7 +
 backport/backport-include/linux/leds.h             |   6 +
 backport/backport-include/linux/mm.h               |   5 -
 backport/backport-include/linux/pci.h              |  20 +
 backport/backport-include/linux/scatterlist.h      |  15 -
 backport/backport-include/linux/string.h           |  22 +-
 backport/compat/Kconfig                            |  21 +-
 backport/compat/Makefile                           |   3 +-
 backport/compat/backport-3.18.c                    |  34 ++
 backport/compat/backport-4.5.c                     |  29 ++
 backport/compat/backport-4.6.c                     |  77 ++++
 backport/compat/compat-3.6.c                       | 136 ------
 backport/compat/compat-3.8.c                       |  55 ---
 backport/compat/dma-shared-helpers.c               |  41 --
 dependencies                                       |  83 +---
 devel/backports-update-manager                     |  21 +-
 patches/backport-adjustments/crypto-skcipher.patch |  32 ++
 .../media/0001-dma_mmap_coherent-revert.patch      |   4 +-
 .../media/0002-no_dmabuf.cocci                     |  75 ----
 .../media/0002-no_dmabuf/v4l2.patch                | 385 -----------------
 .../media/0003-devnode_param_type/INFO             |   8 -
 .../media/0003-devnode_param_type/ddbridge.patch   |  14 -
 .../media/0003-devnode_param_type/dvb-core.patch   |  14 -
 .../media/0003-devnode_param_type/rc.patch         |  14 -
 .../media/0004-missing-include/airspy.patch        |  18 -
 .../media/0004-missing-include/hackrf.patch        |  10 -
 .../media/0004-missing-include/ir-hix5hd2.patch    |  10 -
 .../media/0005-dma-no-sync/v4l2.patch              |  64 ---
 .../media/0006-no-eprobe_defer/v4l2-clk.patch      |  13 -
 .../0002-disable-dump-adjust-on-old-kernels.patch  |   4 +-
 .../include_net_cfg80211.patch                     |   2 +-
 .../0014-netlink_seq/net_wireless_nl80211.patch    |   2 +-
 .../drivers_net_wireless_libertas_if_usb.patch     |   4 +-
 .../network/0024-led-blink-api/mac80211.patch      |   2 +-
 .../network/0028-select_queue/mac80211.patch       |   4 +-
 .../network/0028-select_queue/mwifiex.patch        |   2 +-
 .../network/0030-qdisc_tx_busylock/bluetooth.patch |   4 +-
 .../network/0050-iov_iter/bluetooth.patch          |  18 +-
 .../network/0053-possible_net_t.patch              |   2 +-
 .../network/0061-termios_rwsem/nfc.patch           |   2 +-
 .../network/0068-proto-hash/ieee802154.patch       |  62 +++
 47 files changed, 840 insertions(+), 1043 deletions(-)
 delete mode 100644 backport/backport-include/asm/dma-mapping.h
 create mode 100644 backport/backport-include/crypto/hash.h
 create mode 100644 backport/backport-include/crypto/skcipher.h
 delete mode 100644 backport/backport-include/linux/scatterlist.h
 create mode 100644 backport/compat/backport-4.6.c
 delete mode 100644 backport/compat/dma-shared-helpers.c
 create mode 100644 patches/backport-adjustments/crypto-skcipher.patch
 delete mode 100644 patches/collateral-evolutions/media/0002-no_dmabuf.cocci
 delete mode 100644 patches/collateral-evolutions/media/0002-no_dmabuf/v4l2.patch
 delete mode 100644 patches/collateral-evolutions/media/0003-devnode_param_type/INFO
 delete mode 100644 patches/collateral-evolutions/media/0003-devnode_param_type/ddbridge.patch
 delete mode 100644 patches/collateral-evolutions/media/0003-devnode_param_type/dvb-core.patch
 delete mode 100644 patches/collateral-evolutions/media/0003-devnode_param_type/rc.patch
 delete mode 100644 patches/collateral-evolutions/media/0004-missing-include/airspy.patch
 delete mode 100644 patches/collateral-evolutions/media/0004-missing-include/hackrf.patch
 delete mode 100644 patches/collateral-evolutions/media/0004-missing-include/ir-hix5hd2.patch
 delete mode 100644 patches/collateral-evolutions/media/0005-dma-no-sync/v4l2.patch
 delete mode 100644 patches/collateral-evolutions/media/0006-no-eprobe_defer/v4l2-clk.patch
 create mode 100644 patches/collateral-evolutions/network/0068-proto-hash/ieee802154.patch

-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
