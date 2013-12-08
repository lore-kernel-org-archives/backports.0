Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:38184 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753747Ab3LHPIY (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 8 Dec 2013 10:08:24 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 0/8] backports: fixes for distribution kernels
Date: Sun,  8 Dec 2013 16:08:06 +0100
Message-Id: <1386515294-26231-1-git-send-email-hauke@hauke-m.de> (sfid-20131208_160826_564343_C502BC00)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

These patches are mostly containing fixes for the RHEL 6.5 and for the 
SLES 11 SP3 kernel. With these changes I was able to compile it on both 
distribution. The first patch fixes a problem with mainline kernel 
3.10.21 and upwards and the second something when device tree support 
is activated as it was reported in the bugzilla bugreport.

If we want to support SLES 11 SP3 and RHEL 6.5 with backports 3.13.X 
the last 6 patches should go into that branch, but I haven't tested 
that, this was only tested with linux-next.

These patches are based on the backports patches already posted on the 
mailing list.

1   2.6.25              [  OK  ]
2   2.6.26              [  OK  ]
3   2.6.27              [  OK  ]
4   2.6.28              [  OK  ]
5   2.6.29              [  OK  ]
6   2.6.30              [  OK  ]
7   2.6.31              [  OK  ]
8   2.6.32              [  OK  ]
9   2.6.33              [  OK  ]
10  2.6.34              [  OK  ]
11  2.6.35              [  OK  ]
12  2.6.36              [  OK  ]
13  2.6.37              [  OK  ]
14  2.6.38              [  OK  ]
15  2.6.39              [  OK  ]
16  3.0.101             [  OK  ]
17  3.1.10              [  OK  ]
18  3.2.52              [  OK  ]
19  3.3.8               [  OK  ]
20  3.4.70              [  OK  ]
21  3.5.7               [  OK  ]
22  3.6.11              [  OK  ]
23  3.7.10              [  OK  ]
24  3.8.13              [  OK  ]
25  3.9.11              [  OK  ]
26  3.10.20             [  OK  ]
27  3.11.9              [  OK  ]
28  3.12.1              [  OK  ]
29  3.13-rc1            [  OK  ]


Hauke Mehrtens (8):
  backports: remove DMI_EXACT_MATCH
  backports: add missing include for linux/of.h
  backports: add LINUX_BACKPORT infront of functions
  backports: remove unused workqueue backports
  backports: so not add netdev_features_t on RHEL 6.5
  backports: add missing LINUX_BACKPORT() on various places
  backports: fix skb_add_rx_fragi() for SLES 11 SP3
  backports: do not call dev_hw_addr_random()

 backport/backport-include/linux/device.h          |    3 ++
 backport/backport-include/linux/err.h             |    1 +
 backport/backport-include/linux/etherdevice.h     |    6 ++-
 backport/backport-include/linux/mod_devicetable.h |    4 --
 backport/backport-include/linux/netdev_features.h |    2 +
 backport/backport-include/linux/pci.h             |    4 ++
 backport/backport-include/linux/proc_fs.h         |    2 +
 backport/backport-include/linux/skbuff.h          |    5 ++-
 backport/backport-include/linux/usb.h             |    1 +
 backport/backport-include/linux/usb/ch9.h         |    1 +
 backport/backport-include/linux/watchdog.h        |    1 +
 backport/backport-include/linux/workqueue.h       |   15 --------
 backport/backport-include/net/netlink.h           |   11 ++++++
 backport/compat/compat-2.6.36.c                   |   42 ---------------------
 backport/compat/compat-3.7.c                      |   10 ++---
 backport/compat/compat-3.8.c                      |    1 +
 16 files changed, 40 insertions(+), 69 deletions(-)

-- 
1.7.10.4

