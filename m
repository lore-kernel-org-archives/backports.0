Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:49265 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754116Ab3J0NkY (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 27 Oct 2013 09:40:24 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 0/5] backports: update to next-20131018
Date: Sun, 27 Oct 2013 14:39:57 +0100
Message-Id: <1382881202-16709-1-git-send-email-hauke@hauke-m.de> (sfid-20131027_144027_285502_A4682D32)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This brings backports to linux-next version next-20131018.

Hauke Mehrtens (5):
  backports: add REGULATOR_LINEAR_RANGE
  backports: use sysfs api backport independent from kernel version
  backports: backport new sysfs API for bcma and ssb
  backports: refresh on next-20131018
  backports: add some new options to defconfigs/wifi

 backport/backport-include/linux/device.h           |    6 ++--
 backport/backport-include/linux/regulator/driver.h |   11 ++++++
 backport/defconfigs/wifi                           |    4 +++
 .../media/0004-sysfs-api.patch                     |   15 +++++----
 .../drivers_net_ethernet_atheros_alx_main.patch    |    4 +--
 .../16-bluetooth/drivers_bluetooth_hci_ldisc.patch |    4 +--
 .../16-bluetooth/net_bluetooth_af_bluetooth.patch  |    2 +-
 .../16-bluetooth/net_bluetooth_l2cap_sock.patch    |    6 ++--
 .../16-bluetooth/net_bluetooth_rfcomm_sock.patch   |    4 +--
 .../network/16-bluetooth/net_bluetooth_sco.patch   |    4 +--
 .../24-pcmcia/drivers_bluetooth_bluecard_cs.patch  |   12 +++----
 .../24-pcmcia/drivers_bluetooth_bt3c_cs.patch      |   12 +++----
 .../24-pcmcia/drivers_bluetooth_btuart_cs.patch    |   14 ++++----
 .../24-pcmcia/drivers_bluetooth_dtl1_cs.patch      |   16 ++++-----
 .../network/24-pcmcia/drivers_ssb_main.patch       |    2 +-
 .../net_mac80211_ieee80211_i.patch                 |    2 +-
 .../52-tty-dev/drivers_bluetooth_hci_ldisc.patch   |    2 +-
 .../drivers_bluetooth_bfusb.patch                  |    2 +-
 .../drivers_bluetooth_bpa10x.patch                 |    2 +-
 .../drivers_bluetooth_btusb.patch                  |    2 +-
 .../drivers_net_usb_qmi_wwan.patch                 |    2 +-
 .../network/76-sysfs-api/drivers_bcma.patch        |   35 ++++++++++++++++++++
 .../network/76-sysfs-api/drivers_ssb.patch         |   35 ++++++++++++++++++++
 .../76-sysfs-api/net_ieee802154_wpan-class.patch   |   13 +++++---
 .../network/76-sysfs-api/net_wireless_sysfs.patch  |   13 +++++---
 .../network/77-led-blink-api/mac80211.patch        |    2 +-
 .../network/78-usb-sg/usbnet.patch                 |    2 +-
 27 files changed, 164 insertions(+), 64 deletions(-)
 create mode 100644 patches/collateral-evolutions/network/76-sysfs-api/drivers_bcma.patch
 create mode 100644 patches/collateral-evolutions/network/76-sysfs-api/drivers_ssb.patch

-- 
1.7.10.4

