Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:47152 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752765AbaBJWrn (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 10 Feb 2014 17:47:43 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 0/6] backports: copy stuff from kernel
Date: Mon, 10 Feb 2014 23:47:28 +0100
Message-Id: <1392072454-18538-1-git-send-email-hauke@hauke-m.de> (sfid-20140210_234745_784077_24623790)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

All the patches expect the first one are removeing some code from backports 
and copy that code from the kernel instead. This should make sure we 
use a recent version of that code.
This is based on top of Johannes last patches.

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
18  3.2.54              [  OK  ]
19  3.3.8               [  OK  ]
20  3.4.79              [  OK  ]
21  3.5.7               [  OK  ]
22  3.6.11              [  OK  ]
23  3.7.10              [  OK  ]
24  3.8.13              [  OK  ]
25  3.9.11              [  OK  ]
26  3.10.29             [  OK  ]
27  3.11.10             [  OK  ]
28  3.12.10             [  OK  ]
29  3.13.2              [  OK  ]
30  3.14-rc1            [  OK  ]


Hauke Mehrtens (6):
  backports: REGULATOR_S5M8767 depends on kernel 3.15
  backports: add ipv6_addr_hash()
  backports: add ETH_P_TEB and ETH_P_8021AD
  backports: copy cordic from kernel
  backports: copy sch_codel.c from kernel
  backports: copy sch_fq_codel.c from kernel

 backport/backport-include/linux/if_ether.h        |    8 +
 backport/backport-include/net/ipv6.h              |   23 +
 backport/compat/Kconfig                           |   11 +-
 backport/compat/Makefile                          |    7 -
 backport/compat/cordic.c                          |  101 ----
 backport/compat/flow_dissector.c                  |  143 -----
 backport/compat/sch_codel.c                       |  306 ----------
 backport/compat/sch_fq_codel_core.c               |  659 ---------------------
 dependencies                                      |    2 +-
 patches/backport-adjustments/flow_dissector.patch |  246 ++++++++
 patches/backport-adjustments/sch_codel.patch      |   98 +++
 patches/backport-adjustments/sch_fq_codel.patch   |  106 ++++
 12 files changed, 491 insertions(+), 1219 deletions(-)
 create mode 100644 backport/backport-include/net/ipv6.h
 delete mode 100644 backport/compat/cordic.c
 delete mode 100644 backport/compat/flow_dissector.c
 delete mode 100644 backport/compat/sch_codel.c
 delete mode 100644 backport/compat/sch_fq_codel_core.c
 create mode 100644 patches/backport-adjustments/flow_dissector.patch
 create mode 100644 patches/backport-adjustments/sch_codel.patch
 create mode 100644 patches/backport-adjustments/sch_fq_codel.patch

-- 
1.7.10.4

