Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:39351 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751048Ab3FOPiU (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 15 Jun 2013 11:38:20 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 0/8] backports: build Ethernet driver on < 3.2 and add ieee802154
Date: Sat, 15 Jun 2013 17:37:50 +0200
Message-Id: <1371310678-26491-1-git-send-email-hauke@hauke-m.de> (sfid-20130615_173823_555411_EBD86C1D)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The first 4 patches are making the Ethernet driver compile on kernel 
versions < 3.2. The last 4 patches are adding support for ieee802154.

Hauke Mehrtens (8):
  backports: move netif_set_real_num_rx_queues() to compat-2.6.37.c
  backports: alx driver needs at least kernel 2.6.31
  backports: build ATL1E only on kernel > 2.6.26
  backports: add NET_CORE config option
  backports: use the given parameter in NETLINK_CB_PORTID()
  backports: add module_spi_driver
  backports: add cast in class_find_device()
  backports: add ieee802154

 backport/Kconfig                                   |    6 +++
 backport/Makefile.kernel                           |    4 ++
 backport/backport-include/linux/device.h           |    2 +-
 backport/backport-include/linux/if_arp.h           |   10 +++++
 backport/backport-include/linux/netlink.h          |    4 +-
 backport/backport-include/linux/spi/spi.h          |   20 ++++++++++
 backport/compat/compat-2.6.35.c                    |   15 --------
 backport/compat/compat-2.6.37.c                    |   27 +++++++++++++
 backport/defconfigs/ieee802154                     |    8 ++++
 copy-list                                          |   11 ++++++
 dependencies                                       |    6 ++-
 .../0001-netlink-portid/ieee802154.patch           |   40 ++++++++++++++++++++
 12 files changed, 134 insertions(+), 19 deletions(-)
 create mode 100644 backport/backport-include/linux/if_arp.h
 create mode 100644 backport/backport-include/linux/spi/spi.h
 create mode 100644 backport/defconfigs/ieee802154
 create mode 100644 patches/collateral-evolutions/ieee802154/0001-netlink-portid/ieee802154.patch

-- 
1.7.10.4

