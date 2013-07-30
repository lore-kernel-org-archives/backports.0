Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:37109 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754936Ab3G3J0F (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 30 Jul 2013 05:26:05 -0400
Received: by mail-pa0-f47.google.com with SMTP id kl13so6961835pab.34
        for <backports@vger.kernel.org>; Tue, 30 Jul 2013 02:26:04 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 00/14] backports: move us up to next-20130712
Date: Tue, 30 Jul 2013 02:25:45 -0700
Message-Id: <1375176359-1331-1-git-send-email-mcgrof@do-not-panic.com> (sfid-20130730_112608_702803_65FAA4D8)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

This series takes things further up to next-20130712 and also
has one more additional patch since last iterations, the one
that extends the dependencies file with kconfig language
support.

Johannes Berg (1):
  backport: disable unused automatic backports

Luis R. Rodriguez (13):
  backports: simplify space regexp for src_line
  backports: fix wq_name_list initialization
  backports: fix DMI_EXACT_MATCH() backport
  backports: copy over mfd/max8998.h mfd/max8998-private.h
  backports: backport of_get_child_by_name() support
  backports: enable kconfig language on dependencies file
  backports: backport ww_mutex support
  backports: backport cross-device reservation support
  backports: refresh patches for next-20130703
  backports: fix patches for next-20130709
  backports: copy over s2mps11.h
  backports: refresh patches for next-20130709
  backports: refresh patches for next-20130712

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
 copy-list                                          |    3 +
 dependencies                                       |    6 +
 gentree.py                                         |   40 +-
 lib/kconfig.py                                     |    2 +-
 .../drivers_gpu_drm_i915_i915_gem.patch            |    2 +-
 .../drivers_gpu_drm_i915_i915_gem.patch            |    2 +-
 .../drivers_gpu_drm_i915_i915_gem.patch            |    2 +-
 .../14-shrinkers-api/drivers_gpu_drm_i915.patch    |   12 +-
 .../network/0001-netdev_ops/alx.patch              |    2 +-
 .../network/0007-pci_dev_dev_flags/alx.patch       |    2 +-
 .../network/05-usb/ath9k_htc.patch                 |    2 +-
 .../drivers_net_wireless_b43_main.patch            |    6 +-
 .../11-dev-pm-ops/drivers_bcma_host_pci.patch      |    2 +-
 .../drivers_net_ethernet_atheros_alx_main.patch    |   11 +-
 .../drivers_net_ethernet_atheros_alx_main.patch    |    6 +-
 .../drivers_net_wireless_b43_main.patch            |    2 +-
 .../drivers_net_usb_cdc_ether.patch                |    2 +-
 .../drivers_net_wireless_ath_ath9k_hif_usb.patch   |    2 +-
 .../drivers_gpu_drm_drm_sysfs.patch                |    6 +-
 29 files changed, 1254 insertions(+), 45 deletions(-)
 create mode 100644 backport/backport-include/linux/reservation.h
 create mode 100644 backport/backport-include/linux/ww_mutex.h
 create mode 100644 backport/compat/drivers-base-reservation.c
 create mode 100644 backport/compat/kernel/ww_mutex.c

-- 
1.7.10.4

