Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:36123 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751501Ab3JWVhA (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 23 Oct 2013 17:37:00 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 0/8] backports: update to next-20130913
Date: Wed, 23 Oct 2013 23:36:42 +0200
Message-Id: <1382564210-15230-1-git-send-email-hauke@hauke-m.de> (sfid-20131023_233707_379120_EE2EEC4C)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This brings backports to linux-next version next-20130913

This also fixes some build warnings and probably runtime errors with some 
old kernel versions.

Hauke Mehrtens (8):
  backports: add eth_hw_addr_inherit()
  backports: remove addr_assign_type from usbnet
  backports: REGULATOR_TPS65217 needs struct members from kernel 3.12
  backports: struct tty_port was added with kernel 2.6.28
  backports: use correct suspend/resume function for rtl8188ee
  backports: tcf_destroy_chain takes a normal pointer on <= 2.6.25
  backports: refresh patches on next-20130906
  backports: refresh patches on next-20130913

 backport/backport-include/linux/etherdevice.h       |   19 +++++++++++++++++++
 backport/backport-include/linux/tty.h               |    2 +-
 backport/compat/sch_fq_codel_core.c                 |    4 ++++
 dependencies                                        |    2 +-
 patches/backport-adjustments/dma-buf.patch          |    6 +++---
 .../network/0001-netdev_ops/libertas.patch          |    2 +-
 .../drivers_net_wireless_rtlwifi_rtl8188ee_sw.patch |    4 ++--
 .../16-bluetooth/net_bluetooth_hci_sock.patch       |    4 ++--
 .../drivers_net_wireless_rtl818x_rtl8187_dev.patch  |    2 +-
 .../network/61-netdev-addr_assign_type/usbnet.patch |   14 ++++++++++++++
 .../drivers_net_usb_qmi_wwan.patch                  |    2 +-
 .../drivers_net_wireless_rtl818x_rtl8187_dev.patch  |    2 +-
 .../network/78-usb-sg/usbnet.patch                  |    2 +-
 13 files changed, 51 insertions(+), 14 deletions(-)
 create mode 100644 patches/collateral-evolutions/network/61-netdev-addr_assign_type/usbnet.patch

-- 
1.7.10.4

