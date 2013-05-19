Return-path: <backports-owner@vger.kernel.org>
Received: from mail.nanl.de ([217.115.11.12]:40315 "EHLO mail.nanl.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753217Ab3ESSsS (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 19 May 2013 14:48:18 -0400
From: Jonas Gorski <jogo@openwrt.org>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: backports@vger.kernel.org
Subject: [PATCH 0/2] compat: fix compilation for 3.10-rc1 and older
Date: Sun, 19 May 2013 20:47:43 +0200
Message-Id: <1368989265-15164-1-git-send-email-jogo@openwrt.org> (sfid-20130519_204831_170445_C3A2BF8E)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

These two patches fix two issues that I encountered/found while
compiling (a slightly older) compat-drivers against 3.10-rc1:

a) compat-3.10.h was missing an include in the #else branch, causing
   build failure.

b) random32() was renamed to prandom_u32(), so older kernels were
   missing an appropriate alias.

Jonas Gorski (2):
  compat: add missing include in #else for compat-3.10.h
  compat: handle renaming of random32() to prandom_u32()

 include/linux/compat-3.10.h |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

-- 
1.7.10.4

