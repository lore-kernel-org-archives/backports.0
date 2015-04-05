Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:40003 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752559AbbDEWNa (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 5 Apr 2015 18:13:30 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 0/7] backports: bring backports to next-20150313
Date: Mon,  6 Apr 2015 00:13:13 +0200
Message-Id: <1428272000-19929-1-git-send-email-hauke@hauke-m.de> (sfid-20150406_001335_592602_3C062A6A)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

These patches are adding some more stuff needed for using next-20150313.

Hauke Mehrtens (7):
  headers: add sock_skb_cb_check_size()
  patches: adapt function signature of recvmsg sendmsg
  patches: add missing import to rhashtable
  backports: add Cisco/Aironet (AIRO) driver
  backports: add Atmel at76c50x PCI and PCMCIA driver
  backports: add USB ZD1201 driver
  patches: refresh on next-20150313

 backport/backport-include/net/sock.h               |   5 +
 backport/defconfigs/wifi                           |   6 +
 copy-list                                          |   9 +
 dependencies                                       |   4 +
 patches/backport-adjustments/rhashtable.patch      |  10 +
 .../network/0025-usb-sg/usbnet.patch               |  12 +-
 .../network/0027-genl-const/hwsim.patch            |   2 +-
 .../network/0028-select_queue/mwifiex.patch        |   2 +-
 .../network/0046-mmc_rescan_entered/mwifiex.patch  |   2 +-
 .../network/0050-iov_iter/bluetooth.patch          |   4 +-
 .../0053-remove_wait_on_bit_timeout/btusb.patch    |  12 +-
 .../0054-struct-proto_ops-sig/bluetooth.patch      | 212 +++++++++++++++++++++
 .../0054-struct-proto_ops-sig/ieee802154.patch     |  79 ++++++++
 .../network/0054-struct-proto_ops-sig/nfc.patch    |  59 ++++++
 14 files changed, 401 insertions(+), 17 deletions(-)
 create mode 100644 patches/backport-adjustments/rhashtable.patch
 create mode 100644 patches/collateral-evolutions/network/0054-struct-proto_ops-sig/bluetooth.patch
 create mode 100644 patches/collateral-evolutions/network/0054-struct-proto_ops-sig/ieee802154.patch
 create mode 100644 patches/collateral-evolutions/network/0054-struct-proto_ops-sig/nfc.patch

-- 
1.9.1

