Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:61546 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755729Ab3DCEcx (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 3 Apr 2013 00:32:53 -0400
Received: by mail-pa0-f43.google.com with SMTP id hz11so678016pad.2
        for <backports@vger.kernel.org>; Tue, 02 Apr 2013 21:32:52 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 0/2] compat: pending compat patches
Date: Tue,  2 Apr 2013 21:32:44 -0700
Message-Id: <1364963566-31377-1-git-send-email-mcgrof@do-not-panic.com> (sfid-20130403_063256_312625_10D09828)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

Johannes,

this brings the compat module in backports up to date with what
we had in compat as an independent project. I'll next work on
testing the DRM drivers and then try adding the media stuff.

This has been test compiled with ckmake on your backports tree.

Luis R. Rodriguez (2):
  compat: backport dma-buf
  compat: add HDMI library support

 backport/compat/Kconfig          |   19 ++
 backport/compat/Makefile         |    2 +
 backport/compat/dma-buf.c        |  575 ++++++++++++++++++++++++++++++++++++++
 backport/compat/hdmi.c           |  308 ++++++++++++++++++++
 backport/include/linux/dma-buf.h |  211 ++++++++++++++
 backport/include/linux/hdmi.h    |  240 ++++++++++++++++
 6 files changed, 1355 insertions(+)
 create mode 100644 backport/compat/dma-buf.c
 create mode 100644 backport/compat/hdmi.c
 create mode 100644 backport/include/linux/dma-buf.h
 create mode 100644 backport/include/linux/hdmi.h

-- 
1.7.10.4

