Return-path: <backports-owner@vger.kernel.org>
Received: from tmemail.tme-inc.com ([64.40.243.198]:3226 "EHLO tme-inc.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754484AbaDKTv4 convert rfc822-to-8bit (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 11 Apr 2014 15:51:56 -0400
From: "Harrison Lee" <harrisonl@tme-inc.com>
To: <backports@vger.kernel.org>
References: <CAB=NE6VvyBKzEg=ErZzQMktY8eLytQ21JCPrOQbxvZ9m-nqHkw@mail.gmail.com> <53451077.2030102@openwrt.org> <CAB=NE6UUN4vQd3SpsvO5tcgaYq3YXQeE0KtZGki7p7OnR=J4RA@mail.gmail.com> <20140409191225.GA10560@kroah.com> <CAB=NE6VqY8yXoYuE0o01vq86imY8EtqLdkPa4bGMvR3bTaj5KQ@mail.gmail.com> <20140409202224.GA12953@kroah.com> <CAB=NE6XY5++p7hJQpQdwrFNUcGbUsKpC+oJiZQciXNduo+8j8A@mail.gmail.com> <20140409210613.GA14392@kroah.com> <s5heh15pr18.wl%tiwai@suse.de> <CAB=NE6VeNTFeGxKXpYunkU-W=JPLMpOnrehttvsqB+yXkdz5fg@mail.gmail.com> <006d01cf5591$694ee230$3beca690$@com> <CAB=NE6WpApJ7dn7GNYM0K7B6dyLeQVM+PRn1Ly=KXfy_96GSVA@mail.gmail.com> <1397241908.4643.1.camel@jlt4.sipsolutions.net> <CAB=NE6VzUomkkVXBtwKD0vbGwdHwoNivMrwipv=d-0Qw7Y__JQ@mail.gmail.com>
In-Reply-To: <CAB=NE6VzUomkkVXBtwKD0vbGwdHwoNivMrwipv=d-0Qw7Y__JQ@mail.gmail.com>
Subject: RE: Bumping required kernels to 3.0 for Linux backports ?
Date: Fri, 11 Apr 2014 15:51:35 -0400
Message-ID: <00ac01cf55bf$71c84ae0$5558e0a0$@com> (sfid-20140411_215158_442158_15B1F8FD)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

I do understand that dumping "ancient" kernel support would make things a lot easier.
But, in the embedded system world, upgrading kernel isn't that easy like in PC world.
Most of those systems put to market today has 2.6 kernels, and backports project is a great job and it will revive so many systems if it keeps the tradition to support down 2.6.24 as its predecessor.

Best regards,

Harrison

> On Fri, Apr 11, 2014 at 11:45 AM, Johannes Berg
> <johannes@sipsolutions.net> wrote:
> > On Fri, 2014-04-11 at 11:23 -0700, Luis R. Rodriguez wrote:
> >
> >> compat-drivers is ancient as well, the new project is backports and
> we
> >> will be deprecating older kernels to help us scale better.
> >
> > I know I pushed for the 2.6.24 deprecation, but do you see any
> > particular issue with other kernels < 3.0? The 2.6.24 was big and
> ugly,
> > but none of the other ones seem particularly big/ugly, and there
> aren't
> > a ton of patches either ...
> 
> On my current not published commit in which I've axed out all older
> kernels its allowed me to rip out all the patches which were not split
> up atomically and reshuffle and order every single series we have into
> the new 4-digit form which implies they are atomically well split.
> This can enable us to push for clean architecture on patches moving
> forward.
> 
> > Now, I'm all for dropping support if it really makes a difference,
> and
> > we might want to drop them from the ckmake tests to reduce the pain,
> but
> > I'm not entirely sure we should wholesale remove things if there are
> > still users for them out there.
> 
> I think this makes sense if we had an easy way to break things out as
> optional right now but we don't, and given that some older patches
> weren't really atomic (consider bluetooth for pre 3.0) it would mean
> carrying around a pile of mess as optional but to what end if we're
> never applying it? What type of review can we expect from these
> patches if they are really not maintained? Let's also consider now the
> gains of being able to help persuade folks to upgrade if we also
> embrace a sensible policy for what kernels we support. One of my goals
> is to grow backports with more drivers and new options (in-kernel
> support) but if backports can also be used as a carrot to help with
> moving the ecosystem forward, I think its a strong element to
> consider. So there are two gains here: helping us clean up things, and
> setting up a sensible policy that aligns with kernel.org releases /
> maintenance cycles.
> 
>   Luis
> 
 

__________ Information from ESET NOD32 Antivirus, version of virus signature database 9667 (20140411) __________

The message was checked by ESET NOD32 Antivirus.

http://www.eset.com
 


