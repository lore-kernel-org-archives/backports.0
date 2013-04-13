Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:55682 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753591Ab3DMONu (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 13 Apr 2013 10:13:50 -0400
Received: by mail-pd0-f178.google.com with SMTP id w11so1818358pde.23
        for <backports@vger.kernel.org>; Sat, 13 Apr 2013 07:13:50 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 0/7] backport: pending backlog
Date: Sat, 13 Apr 2013 07:13:37 -0700
Message-Id: <1365862424-6530-1-git-send-email-mcgrof@do-not-panic.com> (sfid-20130413_161353_666535_B647F076)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

Here's my backlog of patches. With this I would have finally have
cought up. After this we would then need the release script and I
think we're ready to start making releases. This adds two new
subsystems. I've been run time testing the media subsystem drivers
for a while now.

As for intel_ips graphics turbo is still disabled with:

ips 0000:00:1f.6: CPU TDP doesn't match expected value (found 25, expected 29)
ips 0000:00:1f.6: failed to get i915 symbols, graphics turbo disabled until i915 loads

Luis R. Rodriguez (7):
  backports: add support for backport_srctree
  compat: add missing header includes for DMA backports
  compat: backport IORESOURCE_REG definition
  gentree.py: add support to explicitly disable a config
  backports: add support for voltage / current regulator drivers
  backports: add media subsystem drivers
  backports: add intel_ips support

 backport/.blacklist.map                            |    1 +
 backport/Kconfig                                   |    5 +
 backport/Makefile.kernel                           |    5 +
 backport/compat/compat-3.6.c                       |    1 +
 backport/defconfigs/media                          |  506 ++++++++++++++++++++
 backport/defconfigs/regulator                      |   63 +++
 backport/include/linux/compat-3.6.h                |    1 +
 backport/include/linux/compat-3.7.h                |    2 +
 copy-list                                          |   57 +++
 dependencies                                       |   73 +++
 gentree.py                                         |    9 +-
 .../collateral-evolutions/media/0001-pr_fmt.patch  |  493 +++++++++++++++++++
 .../media/0002-dma_mmap_coherent-revert.patch      |   58 +++
 .../media/0003-technisat-usb2-led-rename.patch     |   83 ++++
 .../regulator/0001-bt8xx-rename-dst-ops.patch      |   67 +++
 15 files changed, 1422 insertions(+), 2 deletions(-)
 create mode 100644 backport/defconfigs/media
 create mode 100644 backport/defconfigs/regulator
 create mode 100644 patches/collateral-evolutions/media/0001-pr_fmt.patch
 create mode 100644 patches/collateral-evolutions/media/0002-dma_mmap_coherent-revert.patch
 create mode 100644 patches/collateral-evolutions/media/0003-technisat-usb2-led-rename.patch
 create mode 100644 patches/collateral-evolutions/regulator/0001-bt8xx-rename-dst-ops.patch

-- 
1.7.10.4

