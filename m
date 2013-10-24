Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:41271 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753800Ab3JXTsL (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 24 Oct 2013 15:48:11 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 0/3] backports: update to next-20130920
Date: Thu, 24 Oct 2013 21:47:59 +0200
Message-Id: <1382644082-14032-1-git-send-email-hauke@hauke-m.de> (sfid-20131024_214813_468304_3DF31B3C)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This brings backports to linux-next version next-20130920

Hauke Mehrtens (3):
  backports: add devm_regulator_register()
  backports: fixed regulator driver depends on kernel >= 3.13
  backports: refresh patches on next-20130920

 backport/backport-include/linux/regulator/driver.h |   10 +++
 backport/compat/Makefile                           |    1 +
 backport/compat/backport-3.13.c                    |   83 ++++++++++++++++++++
 dependencies                                       |    2 +-
 .../network/0001-netdev_ops/alx.patch              |    2 +-
 .../drivers_net_ethernet_atheros_alx_main.patch    |    4 +-
 .../16-bluetooth/net_bluetooth_l2cap_sock.patch    |    4 +-
 .../16-bluetooth/net_bluetooth_rfcomm_sock.patch   |    2 +-
 .../drivers_net_ethernet_atheros_alx_main.patch    |    2 +-
 .../drivers_net_usb_cdc_ether.patch                |    2 +-
 10 files changed, 103 insertions(+), 9 deletions(-)
 create mode 100644 backport/compat/backport-3.13.c

-- 
1.7.10.4

