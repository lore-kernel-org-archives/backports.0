Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:56780 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752870Ab3G1BQh (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 27 Jul 2013 21:16:37 -0400
Received: by mail-pd0-f182.google.com with SMTP id r10so4202003pdi.13
        for <backports@vger.kernel.org>; Sat, 27 Jul 2013 18:16:36 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [RFC 0/9] backports: take us to next-20130703
Date: Sat, 27 Jul 2013 18:16:21 -0700
Message-Id: <1374974190-31561-1-git-send-email-mcgrof@do-not-panic.com> (sfid-20130728_031642_725499_9DCD69B7)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

We're again a bit behind linux-next but time to push things forward.
The delta between next-20130627 and next-20130703 had a very special
feature introduced which was hard to backport: ww_mutex. I have
just compile tested this stuff. I'd appreciate some tests and
review on this.

Johannes Berg (1):
  backport: disable unused automatic backports

Luis R. Rodriguez (8):
  backports: simplify space regexp for src_line
  backports: fix wq_name_list initialization
  backports: fix DMI_EXACT_MATCH() backport
  backports: copy over mfd/max8998.h mfd/max8998-private.h
  backports: backport of_get_child_by_name() support
  backports: backport ww_mutex support
  backports: backport cross-device reservation support
  backports: refresh patches for next-20130703

 backport/backport-include/linux/mod_devicetable.h  |    2 +-
 backport/backport-include/linux/of.h               |   23 +-
 backport/backport-include/linux/reservation.h      |   70 ++
 backport/backport-include/linux/ww_mutex.h         |  333 ++++++++++
 backport/compat/Kconfig                            |   18 +
 backport/compat/Makefile                           |    2 +
 backport/compat/compat-3.3.c                       |    4 +-
 backport/compat/compat-3.7.c                       |   29 +
 backport/compat/drivers-base-reservation.c         |   39 ++
 backport/compat/kernel/ww_mutex.c                  |  667 ++++++++++++++++++++
 copy-list                                          |    2 +
 gentree.py                                         |    8 +-
 lib/kconfig.py                                     |    2 +-
 .../drivers_gpu_drm_i915_i915_gem.patch            |    2 +-
 .../drivers_gpu_drm_i915_i915_gem.patch            |    2 +-
 .../drivers_gpu_drm_i915_i915_gem.patch            |    2 +-
 .../14-shrinkers-api/drivers_gpu_drm_i915.patch    |   12 +-
 .../network/0001-netdev_ops/alx.patch              |    2 +-
 .../network/0007-pci_dev_dev_flags/alx.patch       |    2 +-
 .../drivers_net_wireless_b43_main.patch            |    6 +-
 .../11-dev-pm-ops/drivers_bcma_host_pci.patch      |    2 +-
 .../drivers_net_ethernet_atheros_alx_main.patch    |    4 +-
 .../drivers_net_ethernet_atheros_alx_main.patch    |   10 +-
 .../drivers_net_wireless_b43_main.patch            |    2 +-
 .../drivers_net_usb_cdc_ether.patch                |    2 +-
 25 files changed, 1215 insertions(+), 32 deletions(-)
 create mode 100644 backport/backport-include/linux/reservation.h
 create mode 100644 backport/backport-include/linux/ww_mutex.h
 create mode 100644 backport/compat/drivers-base-reservation.c
 create mode 100644 backport/compat/kernel/ww_mutex.c

-- 
1.7.10.4

