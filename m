Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:56998 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752791Ab3EHG6I (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 8 May 2013 02:58:08 -0400
Message-ID: <1367996285.8279.7.camel@jlt4.sipsolutions.net> (sfid-20130508_085810_643964_EB1B4C4B)
Subject: Re: Backports project release tags for daily snapshots
From: Johannes Berg <johannes@sipsolutions.net>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Date: Wed, 08 May 2013 08:58:05 +0200
In-Reply-To: <CAB=NE6W3mT+fBZcG1x_VL2iQ3dH7dYVFnHJJDFbVBOd1FKJi+g@mail.gmail.com> (sfid-20130508_023714_265635_41BA3735)
References: <CAB=NE6V7drWK18ij8Ue78J+GSDdVpTJWwqTt3+tVNk01EN4q6Q@mail.gmail.com>
	 <CAB=NE6W3mT+fBZcG1x_VL2iQ3dH7dYVFnHJJDFbVBOd1FKJi+g@mail.gmail.com>
	 (sfid-20130508_023714_265635_41BA3735)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Tue, 2013-05-07 at 17:36 -0700, Luis R. Rodriguez wrote:
> On Tue, May 7, 2013 at 5:20 PM, Luis R. Rodriguez
> <mcgrof@do-not-panic.com> wrote:
> > Now'also a good time to consider tagging efforts. I used to tag
> > compat-drivers releases to match the same next tag from linux-next as
> > we moved on with the only difference I used compat-drivers-2013-05-07
> > dates instead  of next-20130507 and I also added a -1 or -2 if I
> > bumped updates by sticking to the same linux-next target.
> >
> > Whatever we decide I'll just note that rel-html currently supports the
> > scheme of dates that are split. I'll still have to update rel-html to
> > support the project name change so perhaps its good for us to consider
> > the tag use / practice. To be clear I only added a signed tag if and
> > only if ckmake yielded good results on all supported kernels. Using
> > git describe you'd be able to easily get the target next release tag.
> >
> > Thoughts, preferences?
> 
> Here's an example:
> 
> linux-next based releases:
>   * backports-20130408 -- first release based on next-20130408
>   * backports-20130408-2 -- update on the backports code still based
> on next-20130408
>   * etc
> 
> linux-stable releases:
> 
>   * backports-v3.10 - based on vanilla Linus-blessed v3.10
>   * backports-v3.10-2 - update on the backports code still based on
> vanilla v3.10
>   * backports-v3.10.1 - based on vanila Greg-bless v3.10.1
>   * backports-v3.10.1-2 - update on the backports code still based on
> vanilla v3.10.1
> 
> Thoughts? I should note I tried to stick to v3.10-1 convention for the
> first release but it just totally slipped at times.

I was kinda hoping you'd just clone my tree and push it somewhere else
as the canonical tree, note that I haven't put it up on kernel.org but
only my own website :-)

And to be honest, I don't really care. Tagging is nice for users, but
doesn't affect me since the backports are another input for our work, we
don't really have any use for backport releases.

johannes

