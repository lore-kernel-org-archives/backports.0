Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:33463 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752188AbbGTWcc (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 20 Jul 2015 18:32:32 -0400
Received: by padck2 with SMTP id ck2so107349413pad.0
        for <backports@vger.kernel.org>; Mon, 20 Jul 2015 15:32:31 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: cocci@systeme.lip6.fr
Cc: backports@vger.kernel.org, "Luis R. Rodriguez" <mcgrof@suse.com>
Subject: [PATCH v3 0/5] pycocci: few updates and add to install target
Date: Mon, 20 Jul 2015 15:32:19 -0700
Message-Id: <1437431544-32662-1-git-send-email-mcgrof@do-not-panic.com> (sfid-20150721_003233_842659_DF800562)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@suse.com>

This v3 addresses the changes noted by Julia. Since this is extending
features to help with SmPL patch development, in particular --show-proof,
and since we're using quite a bit of heuristics useful to users of Coccinelle
depending on their version installed document all this on a proper man page
for pycocci and also add pycocci into the install target.

In the future we should probably just let pycocci read ini type of file
on say your ~/.pycocci which will let you specify and customize further
defaults we'd inherit depending on your target. Then you can further
customize your options per project. Each upstream project can then also
have their own .pycocci perhaps which promotes a set of options to use.
For instance right now Linux scripts/coccinelle/ lets scripts gather
options to use per SmPL patch. We shoul standardize on a format format
for that and to enable project specific tuned variables.

If there are no issues with this v3 I'll merge soon.

Luis R. Rodriguez (5):
  pycocci: add requirements class
  pycocci: add git class
  pycocci: figure out if to enable --jobs, --use-gitgrep or
    --use-glimpse
  pycocci: add Coccinelle SmPL patch proof support
  pycocci: add man page and promote pycocci to install target

 Makefile       |   3 +
 docs/pycocci.1 | 217 ++++++++++++++++++++++++++
 tools/pycocci  | 486 ++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 687 insertions(+), 19 deletions(-)
 create mode 100644 docs/pycocci.1

-- 
2.3.2.209.gd67f9d5.dirty

--
To unsubscribe from this list: send the line "unsubscribe backports" in
