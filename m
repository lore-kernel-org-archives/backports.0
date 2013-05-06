Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pb0-f49.google.com ([209.85.160.49]:34906 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757178Ab3EFVwS (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 6 May 2013 17:52:18 -0400
Received: by mail-pb0-f49.google.com with SMTP id rp8so2225402pbb.36
        for <backports@vger.kernel.org>; Mon, 06 May 2013 14:52:17 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH v2 0/4] backports: fix final link errors
Date: Mon,  6 May 2013 14:52:04 -0700
Message-Id: <1367877128-10812-1-git-send-email-mcgrof@do-not-panic.com> (sfid-20130506_235220_904912_3D9067E1)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

OK this took a while but finally figured it out. This addresses
the link errors introduced by adding the media and voltage
regulator subsystems. We can now move on with life and hopefully
cook a release right in time for v3.10. Now we just have to
step slowly forward on linux-next tags up to where we are
today (which hopefully will remain this way for another week).

Luis R. Rodriguez (4):
  compat: fix dma_common_get_sgtable() backport placements
  compat: backport soc_camera_power_[on|off] for 3.3
  backports: disable some regulator drivers on 3.4 and 3.5
  ckmake: make --check-exports default

 backport/Makefile.kernel                           |    1 +
 backport/backport-include/asm/dma-mapping.h        |    8 ++-
 backport/backport-include/linux/dma-attrs.h        |    6 ++
 .../backport-include/uapi/linux/v4l2-mediabus.h    |   39 +++++++++++
 backport/compat/Kconfig                            |   11 +++
 backport/compat/Makefile                           |    1 +
 backport/compat/compat-3.4.c                       |   73 ++++++++++++++++++++
 backport/compat/compat-3.6.c                       |   19 -----
 backport/compat/dma-shared-helpers.c               |   38 ++++++++++
 dependencies                                       |   27 ++++++++
 devel/ckmake                                       |    4 +-
 11 files changed, 202 insertions(+), 25 deletions(-)
 create mode 100644 backport/backport-include/linux/dma-attrs.h
 create mode 100644 backport/backport-include/uapi/linux/v4l2-mediabus.h
 create mode 100644 backport/compat/dma-shared-helpers.c

-- 
1.7.10.4

