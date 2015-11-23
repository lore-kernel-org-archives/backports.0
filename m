Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:41636 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753317AbbKWXLK (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 23 Nov 2015 18:11:10 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 00/14] backport: update to next-20151120
Date: Tue, 24 Nov 2015 00:10:50 +0100
Message-Id: <1448320264-15070-1-git-send-email-hauke@hauke-m.de> (sfid-20151124_001112_792356_1DE21359)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This contains various patches bringing backport in sync with next-20151120.

Hauke Mehrtens (13):
  header: make asm/atomic.h include asm/barrier.h
  header: remove asm-generic/barrier.h
  copy: remove camera-rcar.h
  copy: add new header files for media devices
  header: include old media header files from new positions
  header: add of_node_full_name()
  backports: add led_set_brightness_sync()
  backports: add nsecs_to_jiffies()
  header: add netif_tx_napi_add()
  patches: remove access to fwnode member in struct device
  patches: remove call to is_platform_device member of struct
    soc_camera_device
  dependencies: make SOC_CAMERA_PLATFORM depend on kernel >= 3.9
  patches: refresh on next-20151120

Luca Coelho (1):
  header: move smp_mb__after_atomic definition to the correct file

 backport/backport-include/asm-generic/barrier.h    |  9 ----
 backport/backport-include/asm/atomic.h             |  5 +--
 backport/backport-include/asm/barrier.h            |  8 ++++
 backport/backport-include/linux/jiffies.h          |  9 ++++
 backport/backport-include/linux/leds.h             | 18 ++++++++
 backport/backport-include/linux/netdevice.h        | 22 ++++++++++
 backport/backport-include/linux/of.h               | 15 +++++++
 .../linux/platform_data/media/si4713.h             | 10 +++++
 .../platform_data/media/soc_camera_platform.h      | 10 +++++
 .../linux/platform_data/media/timb_radio.h         | 10 +++++
 .../linux/platform_data/media/timb_video.h         | 10 +++++
 backport/compat/Makefile                           |  1 +
 backport/compat/backport-3.17.c                    | 51 ++++++++++++++++++++++
 backport/compat/backport-4.5.c                     | 33 ++++++++++++++
 copy-list                                          |  4 +-
 dependencies                                       |  2 +
 .../media/0004-missing-include/hackrf.patch        |  4 +-
 .../media/0006-no-eprobe_defer/v4l2-clk.patch      |  4 +-
 .../media/0007-no-fwnode/v4l2.patch                | 26 +++++++++++
 .../media/0008-no-is_platform_device/si4713.patch  | 14 ++++++
 20 files changed, 247 insertions(+), 18 deletions(-)
 delete mode 100644 backport/backport-include/asm-generic/barrier.h
 create mode 100644 backport/backport-include/linux/platform_data/media/si4713.h
 create mode 100644 backport/backport-include/linux/platform_data/media/soc_camera_platform.h
 create mode 100644 backport/backport-include/linux/platform_data/media/timb_radio.h
 create mode 100644 backport/backport-include/linux/platform_data/media/timb_video.h
 create mode 100644 backport/compat/backport-4.5.c
 create mode 100644 patches/collateral-evolutions/media/0007-no-fwnode/v4l2.patch
 create mode 100644 patches/collateral-evolutions/media/0008-no-is_platform_device/si4713.patch

-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
