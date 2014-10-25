Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:40659 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752088AbaJYSpy (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 25 Oct 2014 14:45:54 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 00/11] backports: bring it to next-20141003
Date: Sat, 25 Oct 2014 11:19:19 +0200
Message-Id: <1414228770-20047-1-git-send-email-hauke@hauke-m.de> (sfid-20141025_211320_531033_1D77EDC5)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This mainly adds changes needed for next-20141003 and updates some of 
the default configs.

1   3.0.101             [  OK  ]
2   3.1.10              [  OK  ]
3   3.2.62              [  OK  ]
4   3.3.8               [  OK  ]
5   3.4.103             [  OK  ]
6   3.5.7               [  OK  ]
7   3.6.11              [  OK  ]
8   3.7.10              [  OK  ]
9   3.8.13              [  OK  ]
10  3.9.11              [  OK  ]
11  3.10.54             [  OK  ]
12  3.11.10             [  OK  ]
13  3.12.27             [  OK  ]
14  3.13.11             [  OK  ]
15  3.14.18             [  OK  ]
16  3.15.10             [  OK  ]
17  3.16.2              [  OK  ]
18  3.17-rc3            [  OK  ]

Hauke Mehrtens (11):
  backports: add wil6210_uapi.h
  backports: add some missing header files
  backports: add freezable_schedule_hrtimeout_range()
  dependencies: deactivate tracing in ath10k and ath with < 3.4
  dependencies: deactivate some media drivers on < 3.4
  dependencies: deactivate pt3 on kernel < 3.3
  dependencies: deactivate SOC_CAMERA on < 3.5
  dependencies: deactivate IR_HIX5HD2 on < 3.7
  backports: refresh patches on next-20141003
  defconfig: update media defconfig
  defconfig: add some new wifi drivers

 backport/backport-include/linux/freezer.h          | 32 +++++++++++
 backport/defconfigs/media                          | 64 +++++++++++-----------
 backport/defconfigs/rtlwifi                        |  2 +
 backport/defconfigs/wifi                           |  9 ++-
 copy-list                                          |  1 +
 dependencies                                       | 22 +++++++-
 .../media/0002-no_dmabuf/v4l2.patch                | 30 +++++-----
 .../media/0004-missing-include/hackrf.patch        | 10 ++++
 .../media/0004-missing-include/ir-hix5hd2.patch    | 10 ++++
 .../0017-get_ts_info/drivers_net_usb_usbnet.patch  |  2 +-
 .../network/0025-usb-sg/usbnet.patch               | 12 ++--
 .../network/0028-select_queue/mwifiex.patch        |  2 +-
 .../0030-qdisc_tx_busylock/ieee802154.patch        |  4 +-
 .../network/0046-mmc_rescan_entered/mwifiex.patch  |  2 +-
 14 files changed, 140 insertions(+), 62 deletions(-)
 create mode 100644 backport/backport-include/linux/freezer.h
 create mode 100644 patches/collateral-evolutions/media/0004-missing-include/hackrf.patch
 create mode 100644 patches/collateral-evolutions/media/0004-missing-include/ir-hix5hd2.patch

-- 
1.9.1

