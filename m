Return-path: <backports-owner@vger.kernel.org>
Received: from mail-la0-f49.google.com ([209.85.215.49]:60069 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752464Ab3G0RYs (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 27 Jul 2013 13:24:48 -0400
Received: by mail-la0-f49.google.com with SMTP id ea20so3054352lab.22
        for <backports@vger.kernel.org>; Sat, 27 Jul 2013 10:24:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1369770120.8548.19.camel@jlt4.sipsolutions.net>
References: <1369278956-17550-1-git-send-email-mcgrof@do-not-panic.com>
 <1369278956-17550-9-git-send-email-mcgrof@do-not-panic.com>
 <1369325176.12002.31.camel@jlt4.sipsolutions.net> <CAB=NE6WG7mYYgWb=Xsx8qc14BwAEdfR6s7bspCegTWg8moi6WQ@mail.gmail.com>
 <1369770120.8548.19.camel@jlt4.sipsolutions.net>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Sat, 27 Jul 2013 10:24:26 -0700
Message-ID: <CAB=NE6URjQzvMCJ2bMDe8xhSD=BtfbBTD8w1pJo9NC4-BYtxKQ@mail.gmail.com> (sfid-20130727_192450_651711_657F25E1)
Subject: Re: [PATCH v3 8/8] gentree.py: add kernel upload support
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Tue, May 28, 2013 at 12:42 PM, Johannes Berg
<johannes@sipsolutions.net> wrote:
> That makes me think that maybe this all should be a wrapper script kinda
> like git-tracker? A separate tool that just calls into this after doing
> all the paranoia stuff?
>
> Although then I'd still recommend using (the equivalent of)
> --git-revision to avoid all the paranoia stuff and potential races with
> it.

So far --git-revision proves to be much slower than a git reset --hard
variant, but both are reasonable options. I'll try to actually instead
add a --git-revision-reset which would just be an alternative to
--git-revision but that requires the tree to be non-bare, and does a
tree reset, and git-paranoia.

  Luis
