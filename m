Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:55962 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750970AbaEaRQY (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 31 May 2014 13:16:24 -0400
Received: from localhost (localhost [127.0.0.1])
	by hauke-m.de (Postfix) with ESMTP id 5BD2E7E58
	for <backports@vger.kernel.org>; Sat, 31 May 2014 19:16:22 +0200 (CEST)
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 00/13] backports: various fixes needed for next-20140501
Date: Sat, 31 May 2014 19:15:57 +0200
Message-Id: <1401556570-3363-1-git-send-email-hauke@hauke-m.de> (sfid-20140531_191627_381733_5A6E0A61)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

These are some patches needed for next-20140501. These patches are 
based on top of most of the patches on the mainline list.

== ckmake-report.log ==

1   3.0.101             [  OK  ]
2   3.1.10              [  OK  ]
3   3.2.59              [  OK  ]
4   3.3.8               [  OK  ]
5   3.4.91              [  OK  ]
6   3.5.7               [  OK  ]
7   3.6.11              [  OK  ]
8   3.7.10              [  OK  ]
9   3.8.13              [  OK  ]
10  3.9.11              [  OK  ]
11  3.10.40             [  OK  ]
12  3.11.10             [  OK  ]
13  3.12.20             [  OK  ]
14  3.13.11             [  OK  ]
15  3.14.4              [  OK  ]
16  3.15-rc7            [  OK  ]


Hauke Mehrtens (13):
  backports: add smp_mb__after_atomic()
  backports: fix build if CPTCFG_IEEE802154_6LOWPAN=m
  backports: select_queue patch: fix callback kernel version
  backports: raise kernel minimal kernel version for some regulator
    drivers
  backports: fix build when CONFIG_PTP_1588_CLOCK=m
  backports: only add net_get_random_once() when not available
  backports: move net_device_priv_flags
  backports: add patch to prevent section mismatch again
  backports: add devm_gpio_request{_one}()
  backports: add irq_get_trigger_type()
  backports: remove unused functions from bluetooth
  backports: refresh patches on next-20140501
  backports: update test kernel versions

 backport/backport-include/asm/atomic.h             |  6 +-
 backport/backport-include/linux/gpio.h             | 29 ++++++++
 backport/backport-include/linux/if.h               | 27 --------
 backport/backport-include/linux/irq.h              | 13 ++++
 backport/backport-include/linux/net.h              |  2 +-
 backport/backport-include/linux/netdevice.h        | 12 ++++
 backport/backport-include/net/net_namespace.h      |  2 +-
 backport/compat/backport-3.15.c                    |  2 +-
 backport/compat/compat-3.5.c                       | 79 +++++++++++++++++++++-
 dependencies                                       |  7 +-
 devel/backports-update-manager                     | 13 ++--
 .../0002-disable-dump-adjust-on-old-kernels.patch  |  4 +-
 .../include_net_cfg80211.patch                     |  2 +-
 .../net_wireless_core.patch                        |  2 +-
 .../network/0004-disable-wext-kconfig.patch        |  2 +-
 .../net_wireless_core.patch                        |  4 +-
 .../0014-netlink_seq/net_wireless_nl80211.patch    |  2 +-
 .../network/0017-get_ts_info/igb_get_ts_info.patch |  8 +--
 .../network/0024-led-blink-api/mac80211.patch      |  2 +-
 .../network/0027-genl-const/hwsim.patch            |  2 +-
 .../network/0027-genl-const/nl80211.patch          |  6 +-
 .../network/0028-select_queue/mac80211.patch       |  4 +-
 .../network/0028-select_queue/mwifiex.patch        |  4 +-
 .../net_bluetooth_hidp_core.patch                  | 20 +-----
 .../0032-sriov_configure/igb_sriov_configure.patch |  8 +--
 .../0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch | 10 +--
 .../igb_ndo_set_vf_spoofchk.patch                  | 10 +--
 .../network/0035-skb_no_fcs/igb_skb_no_fcs.patch   |  2 +-
 .../network/0036-ethtool_eee/igb_ethtool_eee.patch |  8 +--
 .../0037-ethtool_get_module/igb_get_module.patch   |  6 +-
 .../0038-ethtool_rxfh_indir/igb_rxfh_indir.patch   | 10 +--
 .../network/0039-ethtool_rxnfc/igb_rxnfc.patch     |  2 +-
 .../igb_ethtool_cmd_mdix.patch                     | 10 +--
 ...gb-devm_hwmon_device_register_with_groups.patch |  6 +-
 .../igb_pci_error_handlers.patch                   |  2 +-
 .../network/67-fix-section-mismatch/INFO           |  9 +++
 .../drivers_net_wireless_ath_ath5k_led.patch       | 11 +++
 37 files changed, 230 insertions(+), 118 deletions(-)
 create mode 100644 backport/backport-include/linux/gpio.h
 delete mode 100644 backport/backport-include/linux/if.h
 create mode 100644 backport/backport-include/linux/irq.h
 create mode 100644 patches/collateral-evolutions/network/67-fix-section-mismatch/INFO
 create mode 100644 patches/collateral-evolutions/network/67-fix-section-mismatch/drivers_net_wireless_ath_ath5k_led.patch

-- 
1.9.1

