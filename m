Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:39197 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752112AbbDCRY2 (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 3 Apr 2015 13:24:28 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 00/11] backports: bring backports to next-20150222
Date: Fri,  3 Apr 2015 19:15:31 +0200
Message-Id: <1428081342-5933-1-git-send-email-hauke@hauke-m.de> (sfid-20150403_192436_355881_EE2DF1C8)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

These patches are adding some more stuff needed for using next-20150222.

Hauke Mehrtens (11):
  copy: remove include/linux/platform_data/vsp1.h
  header: adapt new dma_buf_export() signature
  compat: wait_on_bit_timeout() function
  patches: remove usage of wait_on_bit_timeout() in btusb.c
  dependencies: deactivate NFC_PN544_I2C
  dependencies: deactivate DVB_RTL2830, DVB_RTL2832
  patches: add missing include in ath10k
  patches: do not use memcpy_fromiovec() in bluetooth
  patches: remove usage of vb2_ioctl_expbuf()
  patches: refresh patches on next-20150222
  devel: update the test kernels

 backport/backport-include/linux/dma-buf.h          |  48 +++++++--
 backport/backport-include/linux/wait.h             |  44 ++++++++
 backport/compat/backport-3.18.c                    |  27 +++++
 copy-list                                          |   1 -
 dependencies                                       |   8 ++
 devel/backports-update-manager                     |  13 +--
 .../media/0002-no_dmabuf/v4l2.patch                | 120 ++++++++++++++++++---
 .../media/0005-dma-no-sync/v4l2.patch              |   4 +-
 .../0002-disable-dump-adjust-on-old-kernels.patch  |   4 +-
 .../include_net_cfg80211.patch                     |   2 +-
 .../0013-fix-makefile-includes/ath10k.patch        |  10 ++
 .../0014-netlink_seq/net_wireless_nl80211.patch    |   2 +-
 .../drivers_bluetooth_hci_ath.patch                |  14 ---
 .../network/0027-genl-const/nfc.patch              |   2 +-
 .../network/0027-genl-const/nl80211.patch          |   6 +-
 .../network/0028-select_queue/mac80211.patch       |   4 +-
 .../network/0050-iov_iter/bluetooth.patch          |  38 +++++--
 .../0053-remove_wait_on_bit_timeout/btusb.patch    | 110 +++++++++++++++++++
 18 files changed, 389 insertions(+), 68 deletions(-)
 create mode 100644 patches/collateral-evolutions/network/0013-fix-makefile-includes/ath10k.patch
 delete mode 100644 patches/collateral-evolutions/network/0020-tty-termios/drivers_bluetooth_hci_ath.patch
 create mode 100644 patches/collateral-evolutions/network/0053-remove_wait_on_bit_timeout/btusb.patch

-- 
1.9.1

