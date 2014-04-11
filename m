Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:53031 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750842AbaDKUIE (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 11 Apr 2014 16:08:04 -0400
Message-ID: <1397246868.4643.5.camel@jlt4.sipsolutions.net> (sfid-20140411_220806_952795_C2CF4E09)
Subject: Re: Bumping required kernels to 3.0 for Linux backports ?
From: Johannes Berg <johannes@sipsolutions.net>
To: "Luis R. Rodriguez" <mcgrof@frijolero.org>
Cc: Harrison Lee <harrisonl@tme-inc.com>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Date: Fri, 11 Apr 2014 22:07:48 +0200
In-Reply-To: <CAB=NE6VzUomkkVXBtwKD0vbGwdHwoNivMrwipv=d-0Qw7Y__JQ@mail.gmail.com> (sfid-20140411_211822_722817_D6D393F3)
References: <CAB=NE6VvyBKzEg=ErZzQMktY8eLytQ21JCPrOQbxvZ9m-nqHkw@mail.gmail.com>
	 <53451077.2030102@openwrt.org>
	 <CAB=NE6UUN4vQd3SpsvO5tcgaYq3YXQeE0KtZGki7p7OnR=J4RA@mail.gmail.com>
	 <20140409191225.GA10560@kroah.com>
	 <CAB=NE6VqY8yXoYuE0o01vq86imY8EtqLdkPa4bGMvR3bTaj5KQ@mail.gmail.com>
	 <20140409202224.GA12953@kroah.com>
	 <CAB=NE6XY5++p7hJQpQdwrFNUcGbUsKpC+oJiZQciXNduo+8j8A@mail.gmail.com>
	 <20140409210613.GA14392@kroah.com> <s5heh15pr18.wl%tiwai@suse.de>
	 <CAB=NE6VeNTFeGxKXpYunkU-W=JPLMpOnrehttvsqB+yXkdz5fg@mail.gmail.com>
	 <006d01cf5591$694ee230$3beca690$@com>
	 <CAB=NE6WpApJ7dn7GNYM0K7B6dyLeQVM+PRn1Ly=KXfy_96GSVA@mail.gmail.com>
	 <1397241908.4643.1.camel@jlt4.sipsolutions.net>
	 <CAB=NE6VzUomkkVXBtwKD0vbGwdHwoNivMrwipv=d-0Qw7Y__JQ@mail.gmail.com>
	 (sfid-20140411_211822_722817_D6D393F3)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Fri, 2014-04-11 at 12:18 -0700, Luis R. Rodriguez wrote:

> On my current not published commit in which I've axed out all older
> kernels its allowed me to rip out all the patches which were not split
> up atomically and reshuffle and order every single series we have into
> the new 4-digit form which implies they are atomically well split.
> This can enable us to push for clean architecture on patches moving
> forward.

I don't think the 4-digit vs. 2/3 digit thing was ever really an
indicator, but I do see that there are a whole bunch of patches,
particularly for Atheros ethernet drivers (!!) for old kernels.

Maybe a better compromise would be to bump those up with the
dependencies file and keep the compat/compat-*.c code around for others,
i.e. selectively reduce just the patches by bumping single driver
dependencies?

> I think this makes sense if we had an easy way to break things out as
> optional right now but we don't, and given that some older patches
> weren't really atomic (consider bluetooth for pre 3.0) 

I haven't looked at Bluetooth, but I wasn't really suggesting that we
make the patches optional - that's never going to work.

Again, like I said above, what we could potentially do is look through
the pain areas (aka big patches) and reduce those by bumping single
drivers/subsystems up in kernel version, instead of a wholesale bump.

As far as 802.11 wireless is concerned, for example, I think the patches
are actually relatively small for the older kernels.

> Let's also consider now the
> gains of being able to help persuade folks to upgrade if we also
> embrace a sensible policy for what kernels we support. One of my goals
> is to grow backports with more drivers and new options (in-kernel
> support) but if backports can also be used as a carrot to help with
> moving the ecosystem forward, I think its a strong element to
> consider. So there are two gains here: helping us clean up things, and
> setting up a sensible policy that aligns with kernel.org releases /
> maintenance cycles.

I'm not a big fan of politicising technical projects. We're mostly all
here to get problems solved, and most of us push for better solutions,
but usually what happens when we try to enforce better solutions
technically is that we just get to maintain the workarounds outside the
community, which makes it more effort for everybody...

johannes

