Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH for 3.7 0/8] compat: many patches with many fixes
Date: Tue, 26 Feb 2013 22:05:37 +0100
Message-Id: <1361912745-29665-1-git-send-email-hauke@hauke-m.de>
List-ID: <backports@vger.kernel.org>

These are backports of some patches for the compat linux-3.7.y branch.

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

-- 
1.7.10.4
