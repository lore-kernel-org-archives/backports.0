Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.mailbox.org ([80.241.60.212]:58408 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751602AbdIJWKq (ORCPT <rfc822;backports@vger.kernel.org>);
        Sun, 10 Sep 2017 18:10:46 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 0/8] backports: misc fixes
Date: Mon, 11 Sep 2017 00:10:12 +0200
Message-Id: <20170910221020.13067-1-hauke@hauke-m.de> (sfid-20170911_001049_494762_F43D7DB2)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This fixes two problems introduced in my previous patches and also adds 
some other small functions needed to build against kernel >= 3.13.

Hauke Mehrtens (8):
  patches: export bp_usbnet_get_stats64() only if function is added
  patches: brcmfmac: Fix netdev_set_priv_destructor
  backport: add ethtool_convert_legacy_u32_to_link_mode()
  header: add IOMEM_ERR_PTR()
  header: add __get_dynamic_array_len
  header: add pm_system_wakeup()
  dependencies: make NFC_TRF7970A depend on kernel > 3.17
  dependencies: make MWIFIEX_PCIE depend on kernel > 3.16

 backport/backport-include/linux/io.h          |  9 +++++++++
 backport/backport-include/linux/netdevice.h   |  3 +--
 backport/backport-include/linux/suspend.h     | 12 ++++++++++++
 backport/backport-include/trace/ftrace.h      |  4 ++++
 backport/compat/backport-4.10.c               |  7 +++++++
 dependencies                                  |  4 ++++
 patches/0075-ndo-stats-64/usbnet.patch        | 10 ++++------
 patches/0079-netdev-destructor/brcmfmac.patch | 13 ++++++++-----
 8 files changed, 49 insertions(+), 13 deletions(-)
 create mode 100644 backport/backport-include/linux/io.h
 create mode 100644 backport/backport-include/linux/suspend.h

-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
