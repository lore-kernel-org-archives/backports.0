Return-path: <backports-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:57428 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754109Ab3EKA1K (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 10 May 2013 20:27:10 -0400
Received: by mail-ie0-f172.google.com with SMTP id 16so9283663iea.31
        for <backports@vger.kernel.org>; Fri, 10 May 2013 17:27:09 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 00/12] backports: move us up to next-20130419
Date: Fri, 10 May 2013 17:26:51 -0700
Message-Id: <1368232023-23817-1-git-send-email-mcgrof@do-not-panic.com> (sfid-20130511_022713_449938_1B9BB9DF)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

As far as compilation for all of the drivers is concerned
we're currently at next-20130409, this series bumps us up to
next-20130419.

I do have patches that takes us up to next-20130423 as well but those
are currently being tested. I'll post them as a separate series in
case anyone wants to help. I'll be out for a bit now.

Note these are the next tags we've tested or are testing:

next-20130402 OK
next-20130403 OK
next-20130404
next-20130405 OK
next-20130408 OK
next-20130409 OK
next-20130410 OK
next-20130411
next-20130412
next-20130415 OK
next-20130416
next-20130417
next-20130418
next-20130419 OK
next-20130422
next-20130423 testing -- I'll post patches as RFTs
next-20130424
next-20130426
 ~~ around here Linus blessed v3.9 ~~
next-20130429
next-20130430

We want to be sure to atomically test next-20130424,
next-20130426, next-20130429 and next-20130430 given
that one of those will serve as a branch point for
our linux-3.10.y stable branch once Linus releases
v3.10.

Luis R. Rodriguez (12):
  backports: make compat module use subsys_initcall()
  backports: backport dma-buf debugfs support
  compat: backport radix-tree bit optimized iterator
  backports: copy brcmfmac-sdio.h
  backports: remove brcmsmac / brcmutil Makefile patches
  backports: remove ath5k trace fix patch
  backports: enable the CONFIG_DRM_QXL driver on >= v3.3
  backports: enable REGULATOR_WM8994 only on >= 3.8
  backports: refresh patches for next-20130415
  backports: fix atl1.c dev-pm-ops patch
  backports: backport new bluetooth hidp session-management
  backports: refresh patches for next-20130419

 backport/backport-include/linux/radix-tree.h       |  218 ++++++++++++++++
 backport/compat/Kconfig                            |    7 +
 backport/compat/Makefile                           |    1 +
 backport/compat/backports.h                        |   14 ++
 backport/compat/lib-radix-tree-helpers.c           |  266 ++++++++++++++++++++
 backport/compat/main.c                             |    7 +-
 copy-list                                          |    1 +
 dependencies                                       |    8 +-
 patches/backport-adjustments/dma-buf.patch         |   30 ++-
 .../network/0001-netdev_ops/atlx.patch             |    2 +-
 .../network/0001-netdev_ops/ipw2100.patch          |    2 +-
 .../network/0001-netdev_ops/mac80211.patch         |    6 +-
 .../network/0001-netdev_ops/mac80211_hwsim.patch   |    2 +-
 .../network/0001-netdev_ops/usbnet.patch           |    2 +-
 .../mac80211.patch                                 |    4 +-
 .../0005-netlink-portid/mac80211_hwsim.patch       |    4 +-
 .../include_net_cfg80211.patch                     |    2 +-
 .../drivers_net_ethernet_atheros_atlx_atl1.patch   |   10 +-
 .../drivers_net_wireless_iwlwifi_pcie_drv.patch    |    4 +-
 .../drivers_net_wireless_ipw2x00_ipw2100.patch     |    2 +-
 .../16-bluetooth/net_bluetooth_hci_sysfs.patch     |    2 +-
 .../16-bluetooth/net_bluetooth_hidp_core.patch     |  109 ++++----
 .../16-bluetooth/net_bluetooth_hidp_sock.patch     |    2 +-
 .../network/16-bluetooth/net_bluetooth_sco.patch   |    2 +-
 .../17-netdev-queue/net_mac80211_iface.patch       |    4 +-
 .../drivers_net_wireless_adm8211.patch             |    2 +-
 .../drivers_net_wireless_ath_carl9170_main.patch   |    2 +-
 .../drivers_net_wireless_mwl8k.patch               |    6 +-
 .../include_net_mac80211.patch                     |    2 +-
 .../net_mac80211_ieee80211_i.patch                 |    2 +-
 .../net_mac80211_iface.patch                       |    6 +-
 .../25-multicast-list_head/net_mac80211_main.patch |    2 +-
 ..._wireless_brcm80211_brcmfmac_bcmsdh_sdmmc.patch |   10 +-
 .../network/36-workqueue/net_mac80211_main.patch   |    2 +-
 .../drivers_net_ethernet_atheros_atlx_atl1.patch   |    8 +-
 .../net_bluetooth_hci_core.patch                   |    2 +-
 .../drivers_net_ethernet_atheros_atlx_atl1.patch   |    2 +-
 .../drivers_bluetooth_btusb.patch                  |    2 +-
 .../drivers_net_usb_cdc_ether.patch                |    2 +-
 .../network/72-brcm80211-makefiles/brcmsmac.patch  |   25 --
 .../network/72-brcm80211-makefiles/brcmutil.patch  |   15 --
 .../network/73-ath5k-tracing/ath5k.patch           |   21 --
 42 files changed, 644 insertions(+), 178 deletions(-)
 create mode 100644 backport/backport-include/linux/radix-tree.h
 create mode 100644 backport/compat/backports.h
 create mode 100644 backport/compat/lib-radix-tree-helpers.c
 delete mode 100644 patches/collateral-evolutions/network/72-brcm80211-makefiles/brcmsmac.patch
 delete mode 100644 patches/collateral-evolutions/network/72-brcm80211-makefiles/brcmutil.patch
 delete mode 100644 patches/collateral-evolutions/network/73-ath5k-tracing/ath5k.patch

-- 
1.7.10.4

