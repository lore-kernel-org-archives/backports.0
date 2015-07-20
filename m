Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:33704 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752431AbbGTWaz (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 20 Jul 2015 18:30:55 -0400
Received: by pdbnt7 with SMTP id nt7so37208608pdb.0
        for <backports@vger.kernel.org>; Mon, 20 Jul 2015 15:30:54 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: cocci@systeme.lip6.fr,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH v2 0/2] backports: respin on 0002-no_dmabuf SmPL and ckmake changes
Date: Mon, 20 Jul 2015 15:30:44 -0700
Message-Id: <1437431446-32619-1-git-send-email-mcgrof@do-not-panic.com> (sfid-20150721_003057_350825_D924D6DF)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This v2 is a respin with the ckmake format changes fixed. I'll merge
this now as I had not heard feedback on the v1 spin and this is needed
to move on with life.

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
