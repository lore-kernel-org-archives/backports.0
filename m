Return-path: <backports-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:34611 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753230AbbGTRKj (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 20 Jul 2015 13:10:39 -0400
Received: by obre1 with SMTP id e1so105845528obr.1
        for <backports@vger.kernel.org>; Mon, 20 Jul 2015 10:10:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.10.1507201826320.2475@hadrien>
References: <1437195911-28821-1-git-send-email-mcgrof@do-not-panic.com>
 <alpine.DEB.2.02.1507181901020.2059@localhost6.localdomain6>
 <CAB=NE6VEpGSU2tY4H+QjuL82ku-Lz80sXN509q9_DgpbLnPEUQ@mail.gmail.com> <alpine.DEB.2.10.1507201826320.2475@hadrien>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Mon, 20 Jul 2015 10:10:18 -0700
Message-ID: <CAB=NE6X2oHaW3VCR5F2o3j6RmEVeEdtwZenarM1U5qPeAB=F4Q@mail.gmail.com> (sfid-20150720_191040_839019_2BCF61D1)
Subject: Re: [Cocci] [PATCH v2 0/4] pycocci: index opts, SmPL patch proof support
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: "cocci@systeme.lip6.fr" <cocci@systeme.lip6.fr>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>,
	Johannes Berg <johannes@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Mon, Jul 20, 2015 at 9:27 AM, Julia Lawall <julia.lawall@lip6.fr> wrote:
>> > Do you need patches 2 and 3?
>>
>> Do you mean I should squash them together, or something else ?
>
> I meant that since --use-git is able to cope with receiving a subtree of a
> git repository, because git itself is able to cope with that, perhaps you
> don't need them at all.  It seems like you are redoing all the work that
> git already does.

Ah, well so although --use-gitgrep has its own heuristics for
determining if gitgrep can correctly be used or not we still need
something to figure out if it toggle --use-gitgrep or not as I do not
think Coccinelle automatically tries to make use of --use-gitgrep
unless otherwise specified, please correct me if I'm wrong. That is,
if no indexing arguments are passed does Coccinelle figure out on its
own whether or not to use --use-glimpse, --use-gitgrep and as a last
resort --use-coccigrep ? This is what pycocci is doing here. Other
than this another reason for the git class in this series is for
Coccinelle SmPL patch equivalence proof support, that uses git to
create branches for the patch version of changes, then the smpl
version of changes, and finally 'git diff --stat between these two'.

 Luis
--
To unsubscribe from this list: send the line "unsubscribe backports" in
