Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:41545 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755529Ab3JXVEd (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 24 Oct 2013 17:04:33 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 0/3] backports: update to next-20130927
Date: Thu, 24 Oct 2013 23:04:21 +0200
Message-Id: <1382648664-17110-1-git-send-email-hauke@hauke-m.de> (sfid-20131024_230436_120393_F1B321B4)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This brings backports to linux-next version next-20130927

Hauke Mehrtens (3):
  backports: add dev_get_platdata()
  backports: add backport prefix to devm_regulator_register()
  backports: refresh on next-20130927

 backport/backport-include/linux/device.h                       |    8 ++++++++
 backport/backport-include/linux/regulator/driver.h             |    2 ++
 patches/backport-adjustments/dma-buf.patch                     |    8 ++++----
 patches/collateral-evolutions/network/05-usb/p54usb.patch      |    2 +-
 .../09-threaded-irq/drivers_net_wireless_b43_main.patch        |    6 +++---
 .../11-dev-pm-ops/drivers_net_wireless_ath_ath9k_pci.patch     |    4 ++--
 .../11-dev-pm-ops/drivers_net_wireless_iwlegacy_3945-mac.patch |    2 +-
 .../11-dev-pm-ops/drivers_net_wireless_iwlegacy_4965-mac.patch |    2 +-
 .../11-dev-pm-ops/drivers_net_wireless_p54_p54pci.patch        |    4 ++--
 .../network/16-bluetooth/net_bluetooth_rfcomm_tty.patch        |    6 +++---
 .../25-multicast-list_head/net_mac80211_driver-ops.patch       |    4 ++--
 .../network/25-multicast-list_head/net_mac80211_main.patch     |    4 ++--
 .../network/36-workqueue/net_mac80211_main.patch               |    2 +-
 .../drivers_net_wireless_b43_main.patch                        |    2 +-
 .../network/62-usb_driver_lpm/drivers_bluetooth_ath3k.patch    |    2 +-
 .../network/62-usb_driver_lpm/drivers_bluetooth_btusb.patch    |    2 +-
 .../drivers_net_wireless_ath_carl9170_usb.patch                |    2 +-
 .../62-usb_driver_lpm/drivers_net_wireless_p54_p54usb.patch    |    2 +-
 .../network/63-tty-termios/net_bluetooth_rfcomm_tty.patch      |    2 +-
 .../drivers_net_wireless_ath_ath9k_debug.patch                 |    2 +-
 20 files changed, 39 insertions(+), 29 deletions(-)

-- 
1.7.10.4

