Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:55816 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753032Ab3KGU2K (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 7 Nov 2013 15:28:10 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 00/11] backports: bring it to next-20131107
Date: Thu,  7 Nov 2013 21:27:47 +0100
Message-Id: <1383856078-19823-1-git-send-email-hauke@hauke-m.de> (sfid-20131107_212811_885802_FA598E04)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The first patch fixes a problem theta some regulator code is referenced 
in backport-3.13.c when the regulator framework is not compiled into 
the kernel. The other patches are mostly needed to bring it to 
next-20131107.

Hauke Mehrtens (11):
  backports: only add regulator code when regulator is activated in
    kernel
  backports: do not build tty backport if it is not in the kernel
  backports: always activate the of.h backports
  backports: add of_property_read_u8_array()
  backports: add ipv6_addr_is_solict_mult()
  backports: fix signature of __vlan_find_dev_deep()
  backports: update kfifo
  backports: fix kfifo_put()
  backports: remove usage of ipv6_stub
  backports: remove soc_camera_power_{on,off}()
  backports: refresh on next-20131107

 backport/backport-include/linux/if_vlan.h          |    2 +
 backport/backport-include/linux/kfifo.h            |   93 +++++++++++++-------
 backport/backport-include/linux/of.h               |   34 ++++---
 backport/backport-include/net/addrconf.h           |   25 ++++++
 .../backport-include/uapi/linux/v4l2-mediabus.h    |   43 ---------
 backport/compat/backport-3.10.c                    |    4 +
 backport/compat/backport-3.13.c                    |    2 +
 backport/compat/compat-2.6.28.c                    |    2 +
 backport/compat/compat-2.6.39.c                    |    2 +
 backport/compat/compat-3.4.c                       |   91 -------------------
 backport/compat/compat-3.7.c                       |    2 -
 backport/compat/compat-3.8.c                       |   63 +++++++++++++
 backport/compat/kfifo.c                            |   13 ++-
 .../network/0001-netdev_ops/mac80211.patch         |    2 +-
 .../network/0001-netdev_ops/mac80211_hwsim.patch   |    2 +-
 .../network/0001-netdev_ops/qmi_wwan.patch         |    2 +-
 .../mac80211.patch                                 |    4 +-
 .../0006-disable-dump-adjust-on-old-kernels.patch  |    4 +-
 .../include_net_cfg80211.patch                     |    2 +-
 .../drivers_net_wireless_ti_wlcore_main.patch      |    6 +-
 .../drivers_net_wireless_ti_wlcore_wlcore.patch    |    2 +-
 .../net_mac80211_tx.patch                          |    4 +-
 .../17-netdev-queue/net_mac80211_iface.patch       |    4 +-
 .../network/22-multiqueue/net_mac80211_tx.patch    |    2 +-
 .../drivers_net_wireless_ti_wlcore_main.patch      |    4 +-
 .../include_net_mac80211.patch                     |    2 +-
 .../net_mac80211_ieee80211_i.patch                 |    2 +-
 .../drivers_bluetooth_btmrvl_sdio.patch            |    6 +-
 .../30-bridge-port/net_wireless_nl80211.patch      |    2 +-
 .../42-netlink_seq/net_wireless_nl80211.patch      |    2 +-
 .../drivers_net_wireless_ti_wl12xx_main.patch      |    2 +-
 .../drivers_bluetooth_ath3k.patch                  |    2 +-
 .../drivers_net_usb_cdc_mbim.patch                 |    2 +-
 .../drivers_net_usb_cdc_ncm.patch                  |    2 +-
 .../drivers_net_usb_qmi_wwan.patch                 |    2 +-
 .../69-wowlan-no-socket/net_wireless_nl80211.patch |    2 +-
 .../network/77-led-blink-api/mac80211.patch        |    2 +-
 .../network/80-ipv6_stub/INFO                      |    9 ++
 .../network/80-ipv6_stub/cdc_mbim.patch            |   29 ++++++
 39 files changed, 257 insertions(+), 223 deletions(-)
 create mode 100644 backport/backport-include/net/addrconf.h
 delete mode 100644 backport/backport-include/uapi/linux/v4l2-mediabus.h
 create mode 100644 patches/collateral-evolutions/network/80-ipv6_stub/INFO
 create mode 100644 patches/collateral-evolutions/network/80-ipv6_stub/cdc_mbim.patch

-- 
1.7.10.4

