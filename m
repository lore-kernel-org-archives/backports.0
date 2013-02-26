Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH for 3.8 0/9] compat: many patches with many fixes
Date: Tue, 26 Feb 2013 22:03:03 +0100
Message-Id: <1361912592-29591-1-git-send-email-hauke@hauke-m.de>
List-ID: <backports@vger.kernel.org>

These are backports of some patches for the compat linux-3.8.y branch.

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
 include/linux/compat-3.8.h |   60 +++++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 71 insertions(+), 20 deletions(-)

-- 
1.7.10.4
