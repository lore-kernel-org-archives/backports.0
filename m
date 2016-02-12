Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:49895 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752490AbcBLN7v (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 12 Feb 2016 08:59:51 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 0/5] backports: update to version next-20160104
Date: Fri, 12 Feb 2016 14:58:34 +0100
Message-Id: <1455285519-16163-1-git-send-email-hauke@hauke-m.de> (sfid-20160212_145953_694341_34374193)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Nothing special here, just some small changes needed to make it
compatible with next-20160104.

Hauke Mehrtens (5):
  backports: add memdup_user_nul()
  backports: add div64_u64_rem()
  patches: add missing include
  patches: refresh on next-20160104
  devel: update test kernel versions

 backport/backport-include/linux/math64.h           | 27 ++++++++++++
 backport/backport-include/linux/string.h           |  5 +++
 backport/compat/backport-3.12.c                    | 43 +++++++++++++++++++
 backport/compat/backport-4.5.c                     | 34 +++++++++++++++
 devel/backports-update-manager                     | 19 +++++----
 .../media/0002-no_dmabuf/v4l2.patch                | 48 +++++++++++-----------
 .../media/0003-devnode_param_type/dvb-core.patch   |  2 +-
 .../media/0004-missing-include/media-device.patch  | 12 ++++++
 .../network/0062-acpi-gpio-remove/hci_bcm.patch    |  4 +-
 9 files changed, 158 insertions(+), 36 deletions(-)
 create mode 100644 backport/backport-include/linux/math64.h
 create mode 100644 patches/collateral-evolutions/media/0004-missing-include/media-device.patch

-- 
2.7.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
