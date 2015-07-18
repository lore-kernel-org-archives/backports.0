Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:34528 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750733AbbGRFFR (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 18 Jul 2015 01:05:17 -0400
Received: by pdbbh15 with SMTP id bh15so26012862pdb.1
        for <backports@vger.kernel.org>; Fri, 17 Jul 2015 22:05:17 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: cocci@systeme.lip6.fr
Cc: backports@vger.kernel.org, johannes@sipsolutions.net,
	"Luis R. Rodriguez" <mcgrof@suse.com>
Subject: [PATCH v2 0/4] pycocci: index opts, SmPL patch proof support
Date: Fri, 17 Jul 2015 22:05:07 -0700
Message-Id: <1437195911-28821-1-git-send-email-mcgrof@do-not-panic.com> (sfid-20150718_070521_494335_66B930FA)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@suse.com>

This v2 changes the way we do git tree inference by using
git rev-parse. While at it, I decided to mesh in SmPL  <--> patch
equivalence proof support. This is a generalized solution, I
originally had written for the backports project, we now give
this instead a proper home and purpose under pycocci.

If there are no issues I'll merge this soon, in hopes it will
make it for the coccinelle 1.0.2 release.

Luis R. Rodriguez (4):
  pycocci: add requirements class
  pycocci: add git class
  pycocci: figure out if to enable --jobs, --use-gitgrep or
    --use-glimpse
  pycocci: add Coccinelle SmPL patch proof support

 tools/pycocci | 475 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 462 insertions(+), 13 deletions(-)

-- 
2.3.2.209.gd67f9d5.dirty

--
To unsubscribe from this list: send the line "unsubscribe backports" in
