Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:48698 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752644AbbF1V7a (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 28 Jun 2015 17:59:30 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 00/14] backports: bring it to next-20150626
Date: Sun, 28 Jun 2015 23:59:06 +0200
Message-Id: <1435528760-19913-1-git-send-email-hauke@hauke-m.de> (sfid-20150628_235933_601747_705A3473)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This brings backports to next-20150626. There is nothing special in there.

Hauke Mehrtens (14):
  header: rename duplicate include guard
  copy: rename st21nfcb.h to st_nci.h
  copy: add include/linux/platform_data/nfcmrvl.h
  header: add kernel_param_{lock,unlock}() functions
  header: remove kparam_{block,unblock}_sysfs_write()
  header: add N_NCI
  header: add led_trigger_remove() prototpye
  patches: use old locking for struct tty_struct
  backport: add get_user_pages_{locked,unlocked}()
  backport: add frame vector code
  dependencies: build VIDEO_FB_IVTV only on kernel >= 4.2
  dependencies: build NFC_NXP_NCI_I2C only on kernel >= 3.13
  dependencies: make NFC_PN544_I2C depend on kernel >= 3.17
  patches: refresh on next-20150626

 backport/backport-include/asm/barrier.h            |   6 +-
 backport/backport-include/linux/leds.h             |  12 ++
 backport/backport-include/linux/mm.h               |  68 ++++++--
 backport/backport-include/linux/moduleparam.h      |  16 +-
 backport/backport-include/linux/tty.h              |   4 +
 backport/compat/Kconfig                            |   9 +
 backport/compat/Makefile                           |   1 +
 backport/compat/backport-4.0.c                     | 193 +++++++++++++++++++++
 copy-list                                          |   3 +-
 dependencies                                       |   5 +
 .../0005-uapi-compromise/mwifiex.patch             |   2 +-
 .../media/0001-dma_mmap_coherent-revert.patch      |   4 +-
 .../media/0002-no_dmabuf/v4l2.patch                |  60 +++----
 .../media/0005-dma-no-sync/v4l2.patch              |  12 +-
 .../0013-fix-makefile-includes/frame_vector.patch  |  10 ++
 .../network/0050-iov_iter/bluetooth.patch          |   8 +-
 .../0053-remove_wait_on_bit_timeout/btusb.patch    |  12 +-
 .../network/0055-name_assign_type/brcmfmac.patch   |   2 +-
 .../network/0061-termios_rwsem/INFO                |  11 ++
 .../network/0061-termios_rwsem/nfc.patch           |  20 +++
 20 files changed, 389 insertions(+), 69 deletions(-)
 create mode 100644 backport/compat/backport-4.0.c
 create mode 100644 patches/collateral-evolutions/network/0013-fix-makefile-includes/frame_vector.patch
 create mode 100644 patches/collateral-evolutions/network/0061-termios_rwsem/INFO
 create mode 100644 patches/collateral-evolutions/network/0061-termios_rwsem/nfc.patch

-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe backports" in
