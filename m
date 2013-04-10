Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:47937 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936533Ab3DJLfe (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 10 Apr 2013 07:35:34 -0400
Received: by mail-pa0-f44.google.com with SMTP id bi5so266816pad.31
        for <backports@vger.kernel.org>; Wed, 10 Apr 2013 04:35:34 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 00/18] backports: pending patches for Luis
Date: Wed, 10 Apr 2013 04:35:10 -0700
Message-Id: <1365593728-5720-1-git-send-email-mcgrof@do-not-panic.com> (sfid-20130410_133540_934334_20793266)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

Here's my dump as I worked towards the merge of our trees.

Tested with ckmake alone. I'll test ckmake --allyesconfig
in a bit with some two other new subsystem. We just might
make it in time to use this for the next release :)
I'm running i915 right now through this new tree.

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

Luis R. Rodriguez (18):
  backports: enable DRM_NOUVEAU for 3.2
  compat: backport dev_level_ratelimited()
  compat: backport __i2c_transfer()
  compat: backport devm_regmap_init()
  compat: backport GPIOF_OPEN_DRAIN definition
  compat: backport ASYNC_DOMAIN_EXCLUSIVE()
  compat: backport devres_release()
  compat: backport dev_get_regmap()
  compat: backport devm_ioremap_resource()
  compat: backport module_platform_driver_probe()
  compat: add helpers to aid backport of generic DMA changes for v4l
  compat: backport dma_get_sgtable()
  backports: add blacklist module support
  backports: add support for module compression
  backports: add check_depmod to look for module search path
  backports: add udev rules if required for backported firmware_class
  backports: use depmod -a
  backports: add update-initramfs support

 backport/.blacklist.map                    |   10 ++
 backport/Makefile.real                     |   20 +--
 backport/compat/compat-3.4.c               |  232 ++++++++++++++++++++++++++++
 backport/compat/compat-3.5.c               |   34 ++++
 backport/compat/compat-3.6.c               |   52 +++++++
 backport/compat/compat-3.9.c               |   55 +++++++
 backport/include/linux/compat-3.4.h        |   42 +++++
 backport/include/linux/compat-3.5.h        |   51 ++++++
 backport/include/linux/compat-3.6.h        |   28 ++++
 backport/include/linux/compat-3.9.h        |   31 ++++
 backport/scripts/are_mods_compressed       |    8 +
 backport/scripts/backport_firmware_install |   21 +++
 backport/scripts/blacklist.sh              |   35 +++++
 backport/scripts/check_depmod              |   78 ++++++++++
 backport/scripts/mod_path                  |    8 +
 backport/scripts/update-initramfs          |   62 ++++++++
 backport/udev/50-compat_firmware.rules     |    4 +
 backport/udev/compat_firmware.sh           |   35 +++++
 backport/udev/ubuntu/compat_firmware.sh    |   29 ++++
 dependencies                               |    1 -
 gentree.py                                 |    1 +
 21 files changed, 827 insertions(+), 10 deletions(-)
 create mode 100644 backport/.blacklist.map
 create mode 100755 backport/scripts/are_mods_compressed
 create mode 100755 backport/scripts/backport_firmware_install
 create mode 100755 backport/scripts/blacklist.sh
 create mode 100755 backport/scripts/check_depmod
 create mode 100755 backport/scripts/mod_path
 create mode 100755 backport/scripts/update-initramfs
 create mode 100644 backport/udev/50-compat_firmware.rules
 create mode 100755 backport/udev/compat_firmware.sh
 create mode 100755 backport/udev/ubuntu/compat_firmware.sh

-- 
1.7.10.4

