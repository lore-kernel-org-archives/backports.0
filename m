Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:59793 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752692AbaEAX1A (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 1 May 2014 19:27:00 -0400
Received: by mail-pa0-f46.google.com with SMTP id kx10so1671113pab.33
        for <backports@vger.kernel.org>; Thu, 01 May 2014 16:26:59 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 0/8] backports: few python enhancements
Date: Thu,  1 May 2014 16:26:43 -0700
Message-Id: <1398986811-25649-1-git-send-email-mcgrof@do-not-panic.com> (sfid-20140502_012702_499251_1E8E7CB9)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This mainly addresses the lack of checks for binaries which are
required to run some of our python tools. This also fixes some
bug I found with some older versions of Python which I encountered
on a fresh install of OpenSUSE 13.1. Two upstream patches were
also merged that we were carrying around, so we can nuke 'em.

I haven't addressed compilation onto next-20140501, I don't have time
for that right now, patches welcome to help with that.

Luis R. Rodriguez (8):
  backports: add a Python binary package dependency library
  backports: add backports-update-manager binary requirements
  backports: add gentree.py binary requirements
  backports: run autopep8 on ckmake
  backports: add ckmake binary requirements
  backports: remove two upstream patches
  backports: devel/backports-update-manager: fix for older shutil.move
  backports: fix igb patch for next-20140501

 devel/backports-update-manager                     |   29 +-
 devel/ckmake                                       | 1010 +++++++++++---------
 gentree.py                                         |   12 +
 lib/bpreqs.py                                      |  209 ++++
 .../0001-6lowpan-namespace.patch                   |  138 ---
 .../0002-include-new-netns-headers.patch           |   12 -
 .../0001-igb_net_device_ops.patch                  |   14 +-
 7 files changed, 782 insertions(+), 642 deletions(-)
 create mode 100644 lib/bpreqs.py
 delete mode 100644 patches/0000-upstream-backport-changes/0001-6lowpan-namespace.patch
 delete mode 100644 patches/0000-upstream-backport-changes/0002-include-new-netns-headers.patch

-- 
1.9.1

