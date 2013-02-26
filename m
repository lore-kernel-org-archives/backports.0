Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <hauke@hauke-m.de>
Message-ID: <512D288A.10102@hauke-m.de>
Date: Tue, 26 Feb 2013 22:26:34 +0100
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: mcgrof@do-not-panic.com
CC: backports@vger.kernel.org
Subject: compat: pull request for linux-3.8.y branch
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <backports@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Luis,

please pull these changes and also pull the tags I made into your
repository so it is easy to find the code base matching the releases.

The following changes since commit
fbe17013eb3dd71332dd948bacd05d6fc876f8a4:

  compat: remove trailing erroneous semicolon from compat-3.8.c
(2013-01-21 16:02:29 -0800)

are available in the git repository at:

  git://github.com/hauke/compat.git tags/compat-v3.8-1

for you to fetch changes up to 0dbce027eb398843ed590f3f79bfab1ddfe70fd5:

  compat: deactivate netdev_set_default_ethtool_ops() for some 3.7
kernels (2013-02-20 13:06:27 +0100)

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
25  3.8.0               [  OK  ]

- ----------------------------------------------------------------
Felix Fietkau (1):
      compat: fix compile errors when assembly is built into modules

Hauke Mehrtens (8):
      compat: do not access default_ethtool_ops
      compat: ckmake: make return code 2 is error
      compat: ckmake: remove lots of warning spam for the log
      compat: ckmake: do not start all build at the same time
      compat: add efi_enabled()
      compat: netdev_set_default_ethtool_ops() is not in kernel 3.7.5
      compat: check if efi_enabled() was already backported
      compat: deactivate netdev_set_default_ethtool_ops() for some 3.7
kernels

 bin/ckmake                 |   12 ++++-----
 compat/compat-3.8.c        |   15 ++---------
 include/linux/compat-2.6.h |    4 +++
 include/linux/compat-3.8.h |   60
+++++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 71 insertions(+), 20 deletions(-)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJRLSiKAAoJEIZ0px9YPRMyvk0QAKh/USiI2GxKMZss/JUQVpgw
DvpVJ4iCpUGYZNUQ7KBw//kRLaVr65TYcYMAjp2tCQdtVcVDNwEhzCQ5pS4aFKi8
/efE5bK0hcPM+5Gj7MXXEy8WPRAq+YMkBe2itW3a+V9lGkkJJ/VyClRaMoaq9ECo
TzJVYX3kGQomEjSaH9ev1bSZ9JkTeoufTbQnKyZtAzMWqBQfARGPR89kNm2pEjSx
b1Q6KEvsOXuu1FFUZwFyRdeE6oUGskAWnGdSMBGSXIoel/nCGVXMUQwMAvZ1Xdu/
c2pCOrTezpzIh1RuS1nSrgf93b4tRhU+qNtuchwsnzBzJqXOfQ37COFva+rvqJCi
lV7GmK3TYbtNfV4fQrntH8+U7Rxf9yqYviN7T/Ld2r7A5YCgaH+diDEiD7Qtl0NL
3kXlohWzRf8Oks6W1nGwdSri03lRcizjrMNaH9BvTPjd0x18damVJZnD7Fz2kQKX
AF1jQ6Ab5L/TfWEOKP3p7ZG6R5bRVJHdL/vgScp0yhh5H1qKwvN7fRJ3jgW8evft
N8QOMSa/ZIwSnWZgUuf62YJOioPkaWWRRX2ITr+h8r6AWIzoAy0vv1sVD/VAh8JK
48k+HBtia43ecV+U95YPLkYJGZJeUck8LMU2x3fhAAaCfhFxTY398bphMDC5+KdL
7j9Lw84z0ZJg/1JcpzZR
=lYoc
-----END PGP SIGNATURE-----
