Return-path: <backports-owner@vger.kernel.org>
Received: from mail-da0-f50.google.com ([209.85.210.50]:64379 "EHLO
	mail-da0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752884Ab3EMKYl (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 13 May 2013 06:24:41 -0400
Received: by mail-da0-f50.google.com with SMTP id i23so3510290dad.9
        for <backports@vger.kernel.org>; Mon, 13 May 2013 03:24:40 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 0/3] backports: take up up to next-20130426
Date: Mon, 13 May 2013 03:24:32 -0700
Message-Id: <1368440675-23190-1-git-send-email-mcgrof@do-not-panic.com> (sfid-20130513_122443_741546_4F94889F)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

This series takes us up to next-20130426. The next tag
is next-20130429 and it seems that Linus took accepted
code reflected there so for instance we'll need to
complete the backport of these next:

  * remove_proc_subtree() 
  * proc_set_size()
  * ttm_bo_reference()
  * ttm_bo_unref()
  * ttm_kmap_obj_virtual()

Luis R. Rodriguez (3):
  backports: add support for regulator_map_voltage_ascend()
  backports: refresh patches for next-20130424
  backports: refresh patches for next-20130426

 backport/backport-include/linux/regulator/driver.h |   26 ++++++++
 backport/compat/Makefile                           |    1 +
 backport/compat/backport-3.10.c                    |   62 ++++++++++++++++++++
 .../drivers_gpu_drm_i915_intel_opregion.patch      |    2 +-
 .../drivers_bluetooth_btmrvl_sdio.patch            |    6 +-
 .../net_bluetooth_hci_core.patch                   |    2 +-
 .../drivers_net_wireless_mwifiex_init.patch        |    2 +-
 .../drivers_bluetooth_btusb.patch                  |    2 +-
 8 files changed, 96 insertions(+), 7 deletions(-)
 create mode 100644 backport/backport-include/linux/regulator/driver.h
 create mode 100644 backport/compat/backport-3.10.c

-- 
1.7.10.4

