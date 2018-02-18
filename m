Return-path: <backports-owner@vger.kernel.org>
Received: from paleale.coelho.fi ([176.9.41.70]:59534 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751478AbeBRNzx (ORCPT
        <rfc822;backports@vger.kernel.org>); Sun, 18 Feb 2018 08:55:53 -0500
From: Luca Coelho <luca@coelho.fi>
To: backports@vger.kernel.org
Cc: Luca Coelho <luciano.coelho@intel.com>
Date: Sun, 18 Feb 2018 15:24:49 +0200
Message-Id: <20180218132459.11011-1-luca@coelho.fi> (sfid-20180218_145555_051016_E58A86DE)
Subject: [PATCH 00/10] backport: updates for v4.16
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Luca Coelho <luciano.coelho@intel.com>

Hi,

Here's a bunch of patches that we had pending in our internal
backports tree.  With this series at least iwlwifi can be fully
backported from v4.16 kernels.

Please review.

Cheers,
Luca.


Luca Coelho (9):
  compat: only define thermal backports if CONFIG_THERMAL is enabled
  backport: add pcie_find_root_port()
  backport: include lib/bucket_locks.c
  backport: update genl_dump_check_consistent() backport
  backport: remove pkcs7_verify.c patch hunk
  backport: add new build_bug.h file
  backports: fix typo "TIMKEEPING" and fix gfp.h
  backport: remove stddef.h inclusions
  backport: increase max stack frame size compiler check to 1280

Sara Sharon (1):
  backport: implement alloc_percpu_gfp() for < 3.18.

 backport-include/linux/percpu.h               | 19 ++++++++++++++++++
 backport/backport-include/linux/build_bug.h   | 10 +++++++++
 backport/backport-include/linux/gfp.h         |  2 +-
 backport/backport-include/linux/pci.h         | 21 +++++++++++++++++++
 backport/backport-include/linux/spinlock.h    | 13 ++++++++++++
 backport/backport-include/linux/thermal.h     |  2 ++
 backport/backport-include/linux/timekeeping.h |  6 +++---
 backport/backport-include/net/genetlink.h     | 23 ++++++++++++++++-----
 backport/compat/Kconfig                       |  7 +++++++
 backport/compat/Makefile                      |  2 +-
 backport/compat/backport-4.3.c                |  2 ++
 backport/compat/verification/mbedtls/asn1.h   |  2 --
 backport/compat/verification/mbedtls/md.h     |  2 --
 backport/compat/verification/mbedtls/oid.h    |  2 --
 patches/lib-bucket_locks.patch                | 29 +++++++++++++++++++++++++++
 patches/lib-rhashtable.patch                  | 27 -------------------------
 patches/verify.patch                          | 11 ----------
 17 files changed, 126 insertions(+), 54 deletions(-)
 create mode 100644 backport-include/linux/percpu.h
 create mode 100644 backport/backport-include/linux/build_bug.h
 create mode 100644 backport/backport-include/linux/spinlock.h
 create mode 100644 patches/lib-bucket_locks.patch

-- 
2.15.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
