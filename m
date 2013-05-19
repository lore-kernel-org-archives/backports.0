Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:59155 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752517Ab3ESWVH (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 19 May 2013 18:21:07 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 0/3] backport: add support till next-20130517
Date: Mon, 20 May 2013 00:20:48 +0200
Message-Id: <1369002051-4002-1-git-send-email-hauke@hauke-m.de> (sfid-20130520_002110_807038_897800F6)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This was successfully tested with next-20130517.

== ckmake-report.log ==

1   2.6.24              [  OK  ]
2   2.6.25              [  OK  ]
3   2.6.26              [  OK  ]
4   2.6.27              [  OK  ]
5   2.6.28              [  OK  ]
6   2.6.29              [  OK  ]
7   2.6.30              [  OK  ]
8   2.6.31              [  OK  ]
9   2.6.32              [  OK  ]
10  2.6.33              [  OK  ]
11  2.6.34              [  OK  ]
12  2.6.35              [  OK  ]
13  2.6.36              [  OK  ]
14  2.6.37              [  OK  ]
15  2.6.38              [  OK  ]
16  2.6.39              [  OK  ]
17  3.0.76              [  OK  ]
18  3.1.10              [  OK  ]
19  3.2.44              [  OK  ]
20  3.3.8               [  OK  ]
21  3.4.43              [  OK  ]
22  3.5.7               [  OK  ]
23  3.6.11              [  OK  ]
24  3.7.10              [  OK  ]
25  3.8.11              [  OK  ]
26  3.9.0               [  OK  ]


Hauke Mehrtens (3):
  backport: do not add the vlan backports for kernel 3.10
  backport: make patch apply again
  backport: refresh patches on next-20130513

 backport/backport-include/linux/if_vlan.h                        |    2 ++
 .../drivers_gpu_drm_i915_intel_opregion.patch                    |    2 +-
 .../drm/07-intel-gtt/drivers_gpu_drm_i915_i915_gem.patch         |    2 +-
 .../collateral-evolutions/network/0001-netdev_ops/mwifiex.patch  |    2 +-
 .../collateral-evolutions/network/0001-netdev_ops/usbnet.patch   |    2 +-
 .../network/0010-disable-usb-net-asix.patch                      |    4 ++--
 .../network/09-threaded-irq/drivers_net_wireless_b43_main.patch  |    6 +++---
 .../11-dev-pm-ops/drivers_net_wireless_iwlegacy_4965-mac.patch   |    2 +-
 .../11-dev-pm-ops/drivers_net_wireless_iwlwifi_pcie_drv.patch    |    4 ++--
 .../network/46-use_other_workqueue/net_bluetooth_hci_core.patch  |    2 +-
 .../drivers_net_wireless_b43_main.patch                          |    2 +-
 .../network/54-get_ts_info/drivers_net_usb_usbnet.patch          |    2 +-
 .../network/62-usb_driver_lpm/drivers_net_usb_cdc_ether.patch    |    2 +-
 13 files changed, 18 insertions(+), 16 deletions(-)

-- 
1.7.10.4

