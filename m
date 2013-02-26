Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 00/23] compat: many patches with many fixes
Date: Tue, 26 Feb 2013 21:58:51 +0100
Message-Id: <1361912354-29498-1-git-send-email-hauke@hauke-m.de>
List-ID: <backports@vger.kernel.org>

These are the patches that I applied to compat master branch in the last month.

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
 include/linux/compat-3.9.h    |  126 +++++++++++++++++++++++++++++++++++++++++
 12 files changed, 334 insertions(+), 26 deletions(-)
 create mode 100644 include/linux/compat-3.9.h

-- 
1.7.10.4
