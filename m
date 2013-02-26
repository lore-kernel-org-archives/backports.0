Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <hauke@hauke-m.de>
Message-ID: <512D291D.70108@hauke-m.de>
Date: Tue, 26 Feb 2013 22:29:01 +0100
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: mcgrof@do-not-panic.com
CC: backports@vger.kernel.org
Subject: compat: pull request for linux-3.7.y branch
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <backports@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Luis,

please pull these changes and also pull the tags I made into your
repository so it is easy to find the code base matching the releases.

The following changes since commit
5c8ec7e5c1a2164591ee05e331d1cb71f494b9d1:

  compat: backport netdev_set_default_ethtool_ops() (2013-01-21
15:13:40 -0800)

are available in the git repository at:

  git://github.com/hauke/compat.git tags/compat-v3.7.9-1

for you to fetch changes up to 5d46f31ef00cb46462f381e130314abbc9bf4aed:

  compat: add include/export.h in compat-3.8.c (2013-02-19 22:09:29 +0100)

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
17  3.0.65              [  OK  ]
18  3.1.10              [  OK  ]
19  3.2.38              [  OK  ]
20  3.3.8               [  OK  ]
21  3.4.32              [  OK  ]
22  3.5.7               [  OK  ]
23  3.6.11              [  OK  ]
24  3.7.9               [  OK  ]

- ----------------------------------------------------------------
Felix Fietkau (1):
      compat: fix compile errors when assembly is built into modules

Hauke Mehrtens (6):
      compat: do not access default_ethtool_ops
      compat: netdev_set_default_ethtool_ops() is not in kernel 3.7.5
      compat: include linux/compat-3.8.h
      compat: add compat/compat-3.8.c
      compat: deactivate netdev_set_default_ethtool_ops() for some 3.7
kernels
      compat: add include/export.h in compat-3.8.c

Luis R. Rodriguez (1):
      compat: remove trailing erroneous semicolon from compat-3.8.c

 compat/Makefile            |    1 +
 compat/compat-3.8.c        |   16 +++-------------
 include/linux/compat-2.6.h |    5 +++++
 include/linux/compat-3.8.h |    4 +++-
 4 files changed, 12 insertions(+), 14 deletions(-)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJRLSkdAAoJEIZ0px9YPRMyA8cP/0NnOp516uQhLBhET2N8ebZq
RYVYjnacndPiD02+pF7nRh8NwK8TVQoIqwJguFN4EpY8zBvr9iCKTMKSdWoW1UI2
vpQthA+8OkzWWWwvh1x7fm0DamvqXV3ZKVkQNCMqINEs0aBJ6bTMtU+HIAbhjbTj
26dsVCt1V9dPVYhyGUzK5h0fjMDGZmqHHuc0K3/In1f7n7oQmJ3WpNiTElnmmvw9
aA0RBJU/XyiAGnlQEgraIzoMxDp5+a4YpPkldO8xxoi8SJIq30F7XQ7TXV5QTj8+
dEZMem//sAu22ebS5umS3aRUVaZQ3TwGQepS3VeHppCcYS1A5ho1iq6MpBB3ojkW
m1K7tQGP5YUj7RO4TpLLPd8rXPnXoi2P7PgnAKZLKYGKmFV41SQ+0KZjEcHDnrj7
r7PkLSBxSPgtBTerbznkp/Xs7Eqowx4LtwlnJqauMPmAWxhoQsiTKkjpWMKPPp3T
ARF6FXuybeoW3zkhSqp0WVlgjTBBXsM3FnnWclfTd0G32VzsdfroWUsSBRnedIMH
VMYWGCYcWb9AZRS9Fn3yNDHNuZ/4+mWMcCOk2b0/xYtzSpa4K+ZsPivqK0w9fCOy
XdhaPlPk8FYVNJ3uYjZY3mSB/F7v4LsMTsliO5FteKFNB9bOxnIaJsnxn6Or6z/L
h9u9sP6YccbgdXtBezgW
=BhZu
-----END PGP SIGNATURE-----
