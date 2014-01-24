Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:38644 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751939AbaAXUjA (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 24 Jan 2014 15:39:00 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 0/5] backports: bring it to next-20140124
Date: Fri, 24 Jan 2014 21:38:47 +0100
Message-Id: <1390595932-21877-1-git-send-email-hauke@hauke-m.de> (sfid-20140124_213903_637119_F2B8AF79)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>


This brings backports to next-20140124 and fixes uninstalling.

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
20  3.4.77              [  OK  ]
21  3.5.7               [  OK  ]
22  3.6.11              [  OK  ]
23  3.7.10              [  OK  ]
24  3.8.13              [  OK  ]
25  3.9.11              [  OK  ]
26  3.10.27             [  OK  ]
27  3.11.10             [  OK  ]
28  3.12.8              [  OK  ]
29  3.13-rc8            [  OK  ]

Hauke Mehrtens (5):
  backports: add DECLARE_SOCKADDR
  backports: add __sockaddr_check_size()
  backports: always access net/ieee802154/ with make
  backports: refresh on next-20140124
  backports: fix uninstall filename

 backport/Makefile.kernel                           |    2 +-
 backport/backport-include/linux/net.h              |    5 ++++
 backport/backport-include/linux/socket.h           |    5 ++++
 backport/scripts/uninstall.sh                      |    2 +-
 .../24-pcmcia/drivers_bluetooth_bluecard_cs.patch  |   26 ++++++++++----------
 .../24-pcmcia/drivers_bluetooth_bt3c_cs.patch      |   18 +++++++-------
 .../24-pcmcia/drivers_bluetooth_btuart_cs.patch    |   22 ++++++++---------
 .../24-pcmcia/drivers_bluetooth_dtl1_cs.patch      |   22 ++++++++---------
 .../regulator/0001-bt8xx-rename-dst-ops.patch      |   12 ++++-----
 9 files changed, 62 insertions(+), 52 deletions(-)

-- 
1.7.10.4

