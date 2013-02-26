Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <hauke@hauke-m.de>
Message-ID: <512D2778.40606@hauke-m.de>
Date: Tue, 26 Feb 2013 22:22:00 +0100
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: mcgrof@do-not-panic.com
CC: backports@vger.kernel.org
Subject: compat: pull request for master branch
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <backports@vger.kernel.org>

Hi Luis,

please pull these changes and also pull the tags I made into your
repository so it is easy to find the code base matching the releases.

The following changes since commit 5461c0248925836d7d10393ed0296aa82cb46e32:

  compat: remove trailing erroneous semicolon from compat-3.8.c
(2013-01-21 16:01:41 -0800)

are available in the git repository at:

  git://github.com/hauke/compat.git tags/compat-2013-02-20

for you to fetch changes up to fb57da514ae16fc362c2366fce777eb44aa180f0:

  compat: update kernel versions in bin/get-compat-kernels (2013-02-20
12:39:24 +0100)

----------------------------------------------------------------
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
17  3.0.65              [  OK  ]
18  3.1.10              [  OK  ]
19  3.2.38              [  OK  ]
20  3.3.8               [  OK  ]
21  3.4.32              [  OK  ]
22  3.5.7               [  OK  ]
23  3.6.11              [  OK  ]
24  3.7.9               [  OK  ]
25  3.8.0               [  OK  ]

----------------------------------------------------------------
Felix Fietkau (1):
      compat: fix compile errors when assembly is built into modules

Hauke Mehrtens (21):
      compat: do not access default_ethtool_ops
      compat: update kernel versions in bin/get-compat-kernels
      compat: ckmake: make return code 2 is error
      compat: ckmake: remove lots of warning spam for the log
      compat: ckmake: do not start all build at the same time
      compat: add efi_enabled()
      compat: adapt signature change of tty_flip_buffer_push() and
tty_insert_flip_string()
      compat: backport BUILD_BUG_ON from recent kernel
      compat: netdev_set_default_ethtool_ops() is not in kernel 3.7.5
      compat: backport idr_alloc() usage
      compat: backport drop of node parameter from iterators
      compat: check if efi_enabled() was already backported
      compat: add kernel 3.8-rc7 and update others
      compat: move tty_flip_buffer_push() and tty_insert_flip_string()
      compat: add PCI_EXP_LNKCAP_SLS_2_5GB and PCI_EXP_LNKCAP_SLS_5_0GB
      compat: add missing platform devid constants
      compat: add empty struct watchdog_device
      compat: backport of lock_map_acquire_read()
      compat: backport of lock_map_acquire() and lock_map_release()
      compat: deactivate netdev_set_default_ethtool_ops() for some 3.7
kernels
      compat: update kernel versions in bin/get-compat-kernels

Johannes Berg (1):
      compat: backport nla_put_be{16,32,64}()

 bin/ckmake                    |   12 ++--
 bin/get-compat-kernels        |   13 +++--
 compat/compat-3.8.c           |   15 +----
 include/linux/compat-2.6.27.h |   20 +++++++
 include/linux/compat-2.6.37.h |   12 ++++
 include/linux/compat-2.6.38.h |   53 +++++++++++++++++
 include/linux/compat-2.6.h    |    5 ++
 include/linux/compat-3.1.h    |    4 ++
 include/linux/compat-3.5.h    |   26 +++++++++
 include/linux/compat-3.7.h    |    3 +
 include/linux/compat-3.8.h    |   71 ++++++++++++++++++++++-
 include/linux/compat-3.9.h    |  126
+++++++++++++++++++++++++++++++++++++++++
 12 files changed, 334 insertions(+), 26 deletions(-)
 create mode 100644 include/linux/compat-3.9.h
