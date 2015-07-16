Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:35081 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754353AbbGPAc5 (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 15 Jul 2015 20:32:57 -0400
Received: by pdrg1 with SMTP id g1so33673860pdr.2
        for <backports@vger.kernel.org>; Wed, 15 Jul 2015 17:32:57 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: julia.lawall@lip6.fr, "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 0/2] backports: few enhancements still based on 20150626
Date: Wed, 15 Jul 2015 17:32:50 -0700
Message-Id: <1437006772-25592-1-git-send-email-mcgrof@do-not-panic.com> (sfid-20150716_023300_387691_5F69189D)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

A few enhancements still based on next-20150626.

Luis R. Rodriguez (2):
  patches: replace most of 0002-no_dmabuf with SmPL
  ckmake: address directory max depth

 devel/ckmake                                       | 132 +++++----
 .../media/0002-no_dmabuf.cocci                     |  75 +++++
 .../media/0002-no_dmabuf/v4l2.patch                | 305 +--------------------
 3 files changed, 163 insertions(+), 349 deletions(-)
 create mode 100644 patches/collateral-evolutions/media/0002-no_dmabuf.cocci

-- 
2.3.2.209.gd67f9d5.dirty

--
To unsubscribe from this list: send the line "unsubscribe backports" in
