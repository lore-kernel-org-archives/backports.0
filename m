Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:37817 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755307Ab3EQLAv (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 17 May 2013 07:00:51 -0400
Received: by mail-pd0-f169.google.com with SMTP id y10so2481897pdj.0
        for <backports@vger.kernel.org>; Fri, 17 May 2013 04:00:50 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 0/3] backports: take us up to next-20130501
Date: Fri, 17 May 2013 04:00:42 -0700
Message-Id: <1368788445-1641-1-git-send-email-mcgrof@do-not-panic.com> (sfid-20130517_130053_397833_F9B1DB6F)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

Only 1 change needed.

Luis R. Rodriguez (3):
  backports: address NFC LLCP code shift
  backports: refresh patches for next-20130430
  backports: refresh patches for next-20130501

 copy-list                                                |    1 -
 .../drivers_gpu_drm_i915_intel_opregion.patch            |    2 +-
 .../media/0002-dma_mmap_coherent-revert.patch            |    4 ++--
 .../nfc/01-netlink-portid/net_nfc_netlink.patch          |   14 +++++++-------
 4 files changed, 10 insertions(+), 11 deletions(-)

-- 
1.7.10.4

