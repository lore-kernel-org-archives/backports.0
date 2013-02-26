Return-Path: <mcgrof+caf_=mcgrof=gmail.com@frijolero.org>
Return-Path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:34986 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759874Ab3BZVSe (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 26 Feb 2013 16:18:34 -0500
Message-ID: <512D26A3.5010802@hauke-m.de>
Date: Tue, 26 Feb 2013 22:18:27 +0100
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: mcgrof@do-not-panic.com
CC: backports@vger.kernel.org
Subject: compat-drivers: pull request for linux-3.7.y branch
Content-Type: text/plain; charset=ISO-8859-1
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Luis,

please pull these changes and also pull the tags I made into your
repository so it is easy to find the code base matching the releases.

The following changes since commit
47e0a13cfb01a71bce3f6b8cc1d02240744c0729:

  compat-drivers: remove 'v' prefix from version on ChangeLog
(2013-01-10 13:00:21 -0800)

are available in the git repository at:

  git://github.com/hauke/compat-drivers.git tags/compat-drivers-v3.7.9-1

for you to fetch changes up to e5919e1156eba3014a02bb928a6aee422885b075:

  compat-drivers: move disable_drm (2013-02-18 22:56:48 +0100)

- ----------------------------------------------------------------
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
17  3.0.62              [  OK  ]
18  3.1.10              [  OK  ]
19  3.2.38              [  OK  ]
20  3.3.8               [  OK  ]
21  3.4.29              [  OK  ]
22  3.5.7               [  OK  ]
23  3.6.11              [  OK  ]
24  3.7.6               [  OK  ]

- ----------------------------------------------------------------
Hauke Mehrtens (4):
      compat-drivers: rename drm config symbols
      compat-drivers: refresh patches
      compat-drivers: refresh patches
      compat-drivers: move disable_drm

Luis R. Rodriguez (2):
      compat-drivers: add disable_drm to driver-select
      compat-drivers: disable DRM drivers for 802.11 drivers

 patches/drm/04-revert-prime-support.patch          |   12 +-
 patches/drm/06-rename-config-options.patch         |  138
++++++++++++++++++++
 patches/drm/07-intel-gtt.patch                     |    2 +-
 patches/network/0001-netdev_ops.patch              |    6 +-
 patches/network/0002-net-misc.patch                |    2 +-
 patches/network/04-netns.patch                     |    8 +-
 patches/network/05-usb.patch                       |    2 +-
 patches/network/09-threaded-irq.patch              |    8 +-
 patches/network/11-dev-pm-ops.patch                |    2 +-
 patches/network/16-bluetooth.patch                 |    4 +-
 patches/network/17-netdev-queue.patch              |    4 +-
 patches/network/25-multicast-list_head.patch       |    6 +-
 patches/network/48-use_skb_get_queue_mapping.patch |    4 +-
 patches/network/62-usb_driver_lpm.patch            |    6 +-
 scripts/driver-select                              |    7 +
 15 files changed, 178 insertions(+), 33 deletions(-)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJRLSajAAoJEIZ0px9YPRMytNsP/jz8sxJ5AzO3gcnZ8YiQdwRt
OoUYt8iAI46TvECFJDpC6KCk6Fqd3P/zRnnLpuKwrhd91I4AjjavgbYtWR7fZc7s
k/q3Ag/FEfW3jJcvsD8hs2Gg18tRtUtYGvD6/LJkEhk+5vI1LaP8BwoLtO3yDv4T
YWJTaNxn3+aEyFtcVb29TH1CgS6WYZDLpBoJybYekNAyMY8XLQtf/R1Bk0pqTZDu
cphfewcHab8XAEN8zDZc2k3SDLxFqZCTfO+eLs4Cr6R7FUSpwvwiL5CuaM7h2OIK
PwmbnObcSS5vQLFWgv2Eo9r74TV2hY7ZelmkzWTagebJ4UdvLBHGPzVAYFSWS4Je
F0o9LUKCiTNSlKBP/eam33r91IjGCL8olXLWir7XtAMTiUzMwWwdDMfHLjF/Lo+z
ZC901Adc4L7Lg50ldVwancCxOQkj06MrQjq+XWxWFDUaOQWmcBK+oYhPJXmoGd0d
0l8gRHQwaZpRbc/N/lmBrx9URb82f98uPRIJ9O/jntiZomV/jplUxodlAf0Hr6aq
rjsKu6EA+nudkDr1l3TTEHqfA0Sike/YJhCO3CXuT5PxEYsaro1B8VyGaeNGKurU
LS8NuQ7i7IqHNP48Gf46knkyxUMBjaqt9qMwGvcGI3P5qS/aV4ifjNyPxQOztzeM
hsurhNHl89fAFNS8GEwl
=YsqN
-----END PGP SIGNATURE-----
