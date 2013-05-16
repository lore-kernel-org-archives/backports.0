Return-path: <backports-owner@vger.kernel.org>
Received: from mail-da0-f42.google.com ([209.85.210.42]:34640 "EHLO
	mail-da0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751144Ab3EPFsc (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 16 May 2013 01:48:32 -0400
Received: by mail-da0-f42.google.com with SMTP id r6so159311dad.15
        for <backports@vger.kernel.org>; Wed, 15 May 2013 22:48:31 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 0/3] backports: updates for next-20130429
Date: Wed, 15 May 2013 22:48:23 -0700
Message-Id: <1368683306-21463-1-git-send-email-mcgrof@do-not-panic.com> (sfid-20130516_074834_403845_4FB50400)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

Here are 3 updates for next-20130429. I believe the last
fix we need is for nouveau drivers due to driver changes
that throw files around to subdirectories and these not
being read for some reason through backports.

Luis R. Rodriguez (3):
  backports: revert remove_proc_subtree() for backport
  backports: add PDE_DATA() case when CONFIG_PROC_FS is disabled
  backports: add proc_set_size() and proc_set_user()

 backport/backport-include/linux/proc_fs.h          |   12 +++-
 backport/compat/backport-3.10.c                    |   23 ++++++-
 .../drm/12-revert-remove_proc_subtree/INFO         |   25 ++++++++
 .../drivers_gpu_drm_drm_proc.patch                 |   64 ++++++++++++++++++++
 4 files changed, 120 insertions(+), 4 deletions(-)
 create mode 100644 patches/collateral-evolutions/drm/12-revert-remove_proc_subtree/INFO
 create mode 100644 patches/collateral-evolutions/drm/12-revert-remove_proc_subtree/drivers_gpu_drm_drm_proc.patch

-- 
1.7.10.4

