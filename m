Return-path: <backports-owner@vger.kernel.org>
Received: from mail-lb0-f181.google.com ([209.85.217.181]:39294 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751198AbaDKTSX (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 11 Apr 2014 15:18:23 -0400
Received: by mail-lb0-f181.google.com with SMTP id c11so3793788lbj.40
        for <backports@vger.kernel.org>; Fri, 11 Apr 2014 12:18:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1397241908.4643.1.camel@jlt4.sipsolutions.net>
References: <CAB=NE6VvyBKzEg=ErZzQMktY8eLytQ21JCPrOQbxvZ9m-nqHkw@mail.gmail.com>
 <53451077.2030102@openwrt.org> <CAB=NE6UUN4vQd3SpsvO5tcgaYq3YXQeE0KtZGki7p7OnR=J4RA@mail.gmail.com>
 <20140409191225.GA10560@kroah.com> <CAB=NE6VqY8yXoYuE0o01vq86imY8EtqLdkPa4bGMvR3bTaj5KQ@mail.gmail.com>
 <20140409202224.GA12953@kroah.com> <CAB=NE6XY5++p7hJQpQdwrFNUcGbUsKpC+oJiZQciXNduo+8j8A@mail.gmail.com>
 <20140409210613.GA14392@kroah.com> <s5heh15pr18.wl%tiwai@suse.de>
 <CAB=NE6VeNTFeGxKXpYunkU-W=JPLMpOnrehttvsqB+yXkdz5fg@mail.gmail.com>
 <006d01cf5591$694ee230$3beca690$@com> <CAB=NE6WpApJ7dn7GNYM0K7B6dyLeQVM+PRn1Ly=KXfy_96GSVA@mail.gmail.com>
 <1397241908.4643.1.camel@jlt4.sipsolutions.net>
From: "Luis R. Rodriguez" <mcgrof@frijolero.org>
Date: Fri, 11 Apr 2014 12:18:01 -0700
Message-ID: <CAB=NE6VzUomkkVXBtwKD0vbGwdHwoNivMrwipv=d-0Qw7Y__JQ@mail.gmail.com> (sfid-20140411_211826_351223_7129F82E)
Subject: Re: Bumping required kernels to 3.0 for Linux backports ?
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Harrison Lee <harrisonl@tme-inc.com>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Fri, Apr 11, 2014 at 11:45 AM, Johannes Berg
<johannes@sipsolutions.net> wrote:
> On Fri, 2014-04-11 at 11:23 -0700, Luis R. Rodriguez wrote:
>
>> compat-drivers is ancient as well, the new project is backports and we
>> will be deprecating older kernels to help us scale better.
>
> I know I pushed for the 2.6.24 deprecation, but do you see any
> particular issue with other kernels < 3.0? The 2.6.24 was big and ugly,
> but none of the other ones seem particularly big/ugly, and there aren't
> a ton of patches either ...

On my current not published commit in which I've axed out all older
kernels its allowed me to rip out all the patches which were not split
up atomically and reshuffle and order every single series we have into
the new 4-digit form which implies they are atomically well split.
This can enable us to push for clean architecture on patches moving
forward.

> Now, I'm all for dropping support if it really makes a difference, and
> we might want to drop them from the ckmake tests to reduce the pain, but
> I'm not entirely sure we should wholesale remove things if there are
> still users for them out there.

I think this makes sense if we had an easy way to break things out as
optional right now but we don't, and given that some older patches
weren't really atomic (consider bluetooth for pre 3.0) it would mean
carrying around a pile of mess as optional but to what end if we're
never applying it? What type of review can we expect from these
patches if they are really not maintained? Let's also consider now the
gains of being able to help persuade folks to upgrade if we also
embrace a sensible policy for what kernels we support. One of my goals
is to grow backports with more drivers and new options (in-kernel
support) but if backports can also be used as a carrot to help with
moving the ecosystem forward, I think its a strong element to
consider. So there are two gains here: helping us clean up things, and
setting up a sensible policy that aligns with kernel.org releases /
maintenance cycles.

  Luis
