Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:39110 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751816AbbHBWh4 (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 2 Aug 2015 18:37:56 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@kernel.org
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 0/8] backports: bring backports to next-20150731
Date: Mon,  3 Aug 2015 00:37:39 +0200
Message-Id: <1438555067-15301-1-git-send-email-hauke@hauke-m.de> (sfid-20150803_003802_691571_02B08574)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This makes backports compatible with next-20150731.

Hauke Mehrtens (8):
  backports: do not add debugfs_create_devm_seqfile() on recent kernel
    versions
  backports: add hex_dump_to_buffer() with int return value
  backports: add seq_hex_dump()
  header: adapt change of parameter in {add,sub}_frag_mem_limit()
  header: add of_platform_populate()
  dependencies: make NFC_NXP_NCI_I2C depend on >=3.17
  dependencies: make the WL1251_SDIO driver depend on platform provider
  patches: refresh on next-20150731

 backport/backport-include/linux/debugfs.h          |   3 +
 backport/backport-include/linux/of_platform.h      |  23 ++++
 backport/backport-include/linux/printk.h           |   8 ++
 backport/backport-include/linux/seq_file.h         |  25 ++++
 backport/backport-include/net/inet_frag.h          |  38 ++++--
 backport/compat/Makefile                           |   1 +
 backport/compat/backport-4.0.c                     | 132 +++++++++++++++++++++
 backport/compat/backport-4.3.c                     |  59 +++++++++
 dependencies                                       |   5 +-
 patches/backport-adjustments/crypto-ccm.patch      |   4 +-
 .../0014-netlink_seq/net_wireless_nl80211.patch    |   2 +-
 .../network/0028-select_queue/mwifiex.patch        |   2 +-
 .../0032-sriov_configure/igb_sriov_configure.patch |   4 +-
 .../0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch |   8 +-
 .../0038-ethtool_rxfh_indir/igb_rxfh_indir.patch   |  10 +-
 .../0043-ndo_set_vf_rate/igb_set_vf_rate.patch     |   4 +-
 .../network/0050-iov_iter/bluetooth.patch          |  14 +--
 .../0053-remove_wait_on_bit_timeout/btusb.patch    |  12 +-
 18 files changed, 311 insertions(+), 43 deletions(-)
 create mode 100644 backport/backport-include/linux/of_platform.h
 create mode 100644 backport/compat/backport-4.3.c

-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe backports" in
