Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:34841 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755850Ab3EPIXg (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 16 May 2013 04:23:36 -0400
Received: by mail-pa0-f52.google.com with SMTP id bg2so2272080pad.25
        for <backports@vger.kernel.org>; Thu, 16 May 2013 01:23:36 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH v2 0/4] Few updates for next-20130429
Date: Thu, 16 May 2013 01:23:26 -0700
Message-Id: <1368692610-24662-1-git-send-email-mcgrof@do-not-panic.com> (sfid-20130516_102339_450338_320015C9)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

Here are a few updates for next-20130429. The nouveau stuff
still needs to be figured out.

Luis R. Rodriguez (4):
  backports: revert remove_proc_subtree() for backport
  backports: add PDE_DATA() case when CONFIG_PROC_FS is disabled
  backports: add proc_set_size() and proc_set_user()
  gentree.py: do not skip /dev/null patches

 backport/backport-include/linux/proc_fs.h          |   12 +++-
 backport/compat/backport-3.10.c                    |   23 +++++++-
 gentree.py                                         |    2 +-
 .../drm/12-revert-remove_proc_subtree/INFO         |   25 ++++++++
 .../drivers_gpu_drm_drm_proc.patch                 |   62 ++++++++++++++++++++
 5 files changed, 119 insertions(+), 5 deletions(-)
 create mode 100644 patches/collateral-evolutions/drm/12-revert-remove_proc_subtree/INFO
 create mode 100644 patches/collateral-evolutions/drm/12-revert-remove_proc_subtree/drivers_gpu_drm_drm_proc.patch

-- 
1.7.10.4

