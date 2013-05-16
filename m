Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:37591 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753215Ab3EPWaJ (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 16 May 2013 18:30:09 -0400
Received: by mail-pa0-f53.google.com with SMTP id kq12so2930585pab.26
        for <backports@vger.kernel.org>; Thu, 16 May 2013 15:30:09 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 0/2] backports: take us to next-20130429
Date: Thu, 16 May 2013 15:30:02 -0700
Message-Id: <1368743404-30324-1-git-send-email-mcgrof@do-not-panic.com> (sfid-20130517_003012_097230_AFAE6E02)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

This addresses the rest of the changes required to bring
backports on to next-20130429.

Luis R. Rodriguez (2):
  backports: address nouveau file shuffling
  backports: refresh patches for next-20130429

 .../drivers_gpu_drm_drm_proc.patch                          |   10 +++++-----
 .../collateral-evolutions/drm/13-nouveau-include-fix/INFO   |    2 ++
 .../drivers_gpu_drm_nouveau_Makefile.patch                  |   11 +++++++++++
 3 files changed, 18 insertions(+), 5 deletions(-)
 create mode 100644 patches/collateral-evolutions/drm/13-nouveau-include-fix/INFO
 create mode 100644 patches/collateral-evolutions/drm/13-nouveau-include-fix/drivers_gpu_drm_nouveau_Makefile.patch

-- 
1.7.10.4

