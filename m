Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:33220 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751291Ab3FAQAe (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 1 Jun 2013 12:00:34 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 00/11] backports: add support for RHEL 6.4
Date: Sat,  1 Jun 2013 18:00:06 +0200
Message-Id: <1370102417-6711-1-git-send-email-hauke@hauke-m.de> (sfid-20130601_181037_518553_A2119D48)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This patch series adds support for RHEL 6.4 This was tested with a 
fully patched CentOS 6.4. I just did compile tests and load tests of 
some modules, no actual wifi card was used.

Later I verified that it still compiles on all supported mainline 
kernel versions.

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
17  3.0.79              [  OK  ]
18  3.1.10              [  OK  ]
19  3.10-rc1            [  OK  ]
20  3.2.45              [  OK  ]
21  3.3.8               [  OK  ]
22  3.4.46              [  OK  ]
23  3.5.7               [  OK  ]
24  3.6.11              [  OK  ]
25  3.7.10              [  OK  ]
26  3.8.13              [  OK  ]
27  3.9.3               [  OK  ]

Hauke Mehrtens (11):
  backports: add RedHat version
  backports: add missing LINUX_BACKPORT
  backports: fix DEFINE_DYNAMIC_DEBUG_METADATA for RHEL 6.4
  backports: no kfifo.h when !CPTCFG_BACKPORT_BUILD_KFIFO
  backports: do not backport netif_set_real_num_rx_queues() on RHEL 6.4
  backports: do not backport shmem_read_mapping_page_gfp() on RHEL 6.4
  backports: do not backport skb_tx_timestamp() on RHEL 6.4
  backports: to not backport skb_add_rx_fragi() on RHEL 6.4
  backports: protect irq_set_irq_type()
  backports: protect pcmcia_enable_device
  backports: do not backport struct watchdog_device in RHEL 6.4

 backport/backport-include/linux/dma-mapping.h   |    1 +
 backport/backport-include/linux/dynamic_debug.h |   13 ++++++++++
 backport/backport-include/linux/etherdevice.h   |    2 ++
 backport/backport-include/linux/ethtool.h       |    1 +
 backport/backport-include/linux/irq.h           |    2 ++
 backport/backport-include/linux/kernel.h        |   30 +++++++++++++++++++++++
 backport/backport-include/linux/kfifo.h         |    6 ++++-
 backport/backport-include/linux/netdevice.h     |    2 ++
 backport/backport-include/linux/pagemap.h       |    2 ++
 backport/backport-include/linux/shmem_fs.h      |    2 ++
 backport/backport-include/linux/skbuff.h        |    6 ++++-
 backport/backport-include/linux/version.h       |    9 +++++++
 backport/backport-include/linux/watchdog.h      |    2 ++
 backport/backport-include/pcmcia/ds.h           |    6 ++++-
 backport/compat/compat-2.6.35.c                 |    2 ++
 backport/compat/compat-3.0.c                    |    3 +++
 backport/compat/kstrtox.c                       |    1 +
 17 files changed, 87 insertions(+), 3 deletions(-)
 create mode 100644 backport/backport-include/linux/version.h

-- 
1.7.10.4

