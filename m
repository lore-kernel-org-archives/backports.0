Return-path: <backports-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:64961 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753348AbaEHUkO (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 8 May 2014 16:40:14 -0400
Received: by mail-wi0-f170.google.com with SMTP id bs8so1581443wib.1
        for <backports@vger.kernel.org>; Thu, 08 May 2014 13:40:13 -0700 (PDT)
From: Samuel Martin <s.martin49@gmail.com>
To: backports@vger.kernel.org
Cc: Samuel Martin <s.martin49@gmail.com>
Subject: [PATCH 0/10] Cross-compilation support improvement
Date: Thu,  8 May 2014 22:39:23 +0200
Message-Id: <1399581573-12072-1-git-send-email-s.martin49@gmail.com> (sfid-20140508_224017_136182_22B0DC49)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hi all,


This patch series improves cross-compilation support, mostly fixing the
scripts to support target root location.

Now, to cross-compile kernel-backports, KLIB_BUILD should still point to
the linux kernel build tree and, the new KROOT variable, to the target
root location (instead of the target kernel module location, as
mentionned at [1]):
---
make \
  CROSS_COMPILE=<toolchain prefix> \
  ARCH=<target architecture> \
  KROOT=<target root directory> \
  KLIB_BUILD=<kernel build directory>
---

This should not change anything when compiling backports for the build
machine.

If this series breaks anything, please let me know.


The following changes since commit 44554cd57d0016c52aeed2ce4f27081b9d9c915f:

  backports: select_queue patch: fix callback kernel version (2014-05-01 18:48:03 -0700)

are available in the git repository at:

  git://github.com/tSed/backports.git sma/cross-compilation

for you to fetch changes up to 99add35cab73b890dd6810fa303ec0c0fa06218c:

  backports: Makefile: update help text (2014-05-08 19:32:33 +0200)


Yours,
Samuel


[1] https://backports.wiki.kernel.org/index.php/Documentation#Cross_compile_with_Freescale.27s_LTIB


Samuel Martin (10):
  backports: Makefile: introduce KROOT and fix INSTALL_MOD_PATH
    definition
  backports: Makefile: introduce KVERSION and rework KLIB definition
  backports: Makefile: export KROOT and KVERSION variables
  backports: blacklist.sh: support install root not in /
  backports: check_depmod.sh: support install root not in /
  backports: Makefile.real: use depmod.sh instead of the depmod program
  backports: Makefile.real: disable update-initramfs.sh execution when
    cross-compiling
  backports: Makefile.real: silent reboot message when cross-compiling
  backports: compress_module.sh: gzip silently overrides existing
    compressed modules
  backports: Makefile: update help text

 backport/Makefile                    | 33 ++++++++++++++++++++++++---------
 backport/Makefile.real               | 24 ++++++++++++++++--------
 backport/scripts/blacklist.sh        |  7 ++++---
 backport/scripts/check_depmod.sh     |  7 ++++---
 backport/scripts/compress_modules.sh |  2 +-
 5 files changed, 49 insertions(+), 24 deletions(-)

--
1.9.2
