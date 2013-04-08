Return-path: <backports-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:24554 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932198Ab3DHK0c (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 8 Apr 2013 06:26:32 -0400
From: Thierry Escande <thierry.escande@linux.intel.com>
To: backports@vger.kernel.org
Subject: [PATCH v3 0/8] backports: add NFC subsystem
Date: Mon,  8 Apr 2013 12:26:05 +0200
Message-Id: <1365416773-12836-1-git-send-email-thierry.escande@linux.intel.com> (sfid-20130408_122639_576760_4DC9503D)
Content-Type: text/plain; charset = "utf-8"
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This adds support for NFC core and drivers backport down to v3.1. Prior kernel
versions won't support it as is since PF_NFC net proto as been introduced in
v3.1 and sock_register kernel api in prior kernels will fail for PF_NFC.


$ckmake --defconfig nfc

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
26  3.9-rc1             [  OK  ]

Thierry Escande (8):
  backport sk_for_each_safe
  backport a define for SOL_NFC
  backport MODULE_ALIAS_GENL_FAMILY macro
  backport module_i2c_driver helper macro
  backports: add NFC core and drivers
  backports: add NFC patches
  build: enable NFC build
  build: add NFC defconfig file

 backport/Kconfig                                   |    2 +
 backport/Makefile.kernel                           |    2 +
 backport/defconfigs/nfc                            |   11 ++
 backport/include/linux/compat-3.10.h               |    6 +
 backport/include/linux/compat-3.3.h                |   21 +++
 backport/include/linux/compat-3.5.h                |   25 +++
 backport/include/linux/compat-3.9.h                |    4 +
 copy-list                                          |   14 ++
 dependencies                                       |    4 +
 .../nfc/01-netlink-portid/INFO                     |   42 +++++
 .../nfc/01-netlink-portid/net_nfc_netlink.patch    |   71 ++++++++
 patches/collateral-evolutions/nfc/02-pr_fmt/INFO   |    6 +
 .../nfc/02-pr_fmt/net_nfc.patch                    |  181 ++++++++++++++++++++
 .../nfc/03-driver-core-constify-data/INFO          |    7 +
 .../net_nfc_core.patch                             |   14 ++
 15 files changed, 410 insertions(+)
 create mode 100644 backport/defconfigs/nfc
 create mode 100644 patches/collateral-evolutions/nfc/01-netlink-portid/INFO
 create mode 100644 patches/collateral-evolutions/nfc/01-netlink-portid/net_nfc_netlink.patch
 create mode 100644 patches/collateral-evolutions/nfc/02-pr_fmt/INFO
 create mode 100644 patches/collateral-evolutions/nfc/02-pr_fmt/net_nfc.patch
 create mode 100644 patches/collateral-evolutions/nfc/03-driver-core-constify-data/INFO
 create mode 100644 patches/collateral-evolutions/nfc/03-driver-core-constify-data/net_nfc_core.patch

-- 
1.7.10.4

