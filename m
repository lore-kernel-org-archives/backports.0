Return-path: <backports-owner@vger.kernel.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172]:58359 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755018AbaDKUsT (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 11 Apr 2014 16:48:19 -0400
Received: by mail-lb0-f172.google.com with SMTP id c11so3933461lbj.31
        for <backports@vger.kernel.org>; Fri, 11 Apr 2014 13:48:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1397246868.4643.5.camel@jlt4.sipsolutions.net>
References: <CAB=NE6VvyBKzEg=ErZzQMktY8eLytQ21JCPrOQbxvZ9m-nqHkw@mail.gmail.com>
 <53451077.2030102@openwrt.org> <CAB=NE6UUN4vQd3SpsvO5tcgaYq3YXQeE0KtZGki7p7OnR=J4RA@mail.gmail.com>
 <20140409191225.GA10560@kroah.com> <CAB=NE6VqY8yXoYuE0o01vq86imY8EtqLdkPa4bGMvR3bTaj5KQ@mail.gmail.com>
 <20140409202224.GA12953@kroah.com> <CAB=NE6XY5++p7hJQpQdwrFNUcGbUsKpC+oJiZQciXNduo+8j8A@mail.gmail.com>
 <20140409210613.GA14392@kroah.com> <s5heh15pr18.wl%tiwai@suse.de>
 <CAB=NE6VeNTFeGxKXpYunkU-W=JPLMpOnrehttvsqB+yXkdz5fg@mail.gmail.com>
 <006d01cf5591$694ee230$3beca690$@com> <CAB=NE6WpApJ7dn7GNYM0K7B6dyLeQVM+PRn1Ly=KXfy_96GSVA@mail.gmail.com>
 <1397241908.4643.1.camel@jlt4.sipsolutions.net> <CAB=NE6VzUomkkVXBtwKD0vbGwdHwoNivMrwipv=d-0Qw7Y__JQ@mail.gmail.com>
 <1397246868.4643.5.camel@jlt4.sipsolutions.net>
From: "Luis R. Rodriguez" <mcgrof@frijolero.org>
Date: Fri, 11 Apr 2014 13:47:57 -0700
Message-ID: <CAB=NE6UQj2Q5V3odMqTpye40pcXNVwFK21==KWKs6uknAM6Cgg@mail.gmail.com> (sfid-20140411_224829_808542_8CF434D1)
Subject: Re: Bumping required kernels to 3.0 for Linux backports ?
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Harrison Lee <harrisonl@tme-inc.com>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Fri, Apr 11, 2014 at 1:07 PM, Johannes Berg
<johannes@sipsolutions.net> wrote:
> On Fri, 2014-04-11 at 12:18 -0700, Luis R. Rodriguez wrote:
>
>> On my current not published commit in which I've axed out all older
>> kernels its allowed me to rip out all the patches which were not split
>> up atomically and reshuffle and order every single series we have into
>> the new 4-digit form which implies they are atomically well split.
>> This can enable us to push for clean architecture on patches moving
>> forward.
>
> I don't think the 4-digit vs. 2/3 digit thing was ever really an
> indicator, but I do see that there are a whole bunch of patches,
> particularly for Atheros ethernet drivers (!!) for old kernels.

This wasn't ever really well documented, with time I realized that the
more atomic patches were split out the easier it was to review and
understand why a change was made as well as making it easier to learn
how to backport a subsystem driver, but *also* in the end this effort
makes it easier to review if you could end up transformation a series
into SmPL form. In my trimming commits for old kernels I have been
able to split *every* patch into a proper atomic series (with one
exception but I'd document why and ensure we address that one).

> Maybe a better compromise would be to bump those up with the
> dependencies file and keep the compat/compat-*.c code around for others,
> i.e. selectively reduce just the patches by bumping single driver
> dependencies?

That can work too, but that raises the question of what drivers or
subsystems to bump too. Would we just bump everything now to 3.0 ?

>> I think this makes sense if we had an easy way to break things out as
>> optional right now but we don't, and given that some older patches
>> weren't really atomic (consider bluetooth for pre 3.0)
>
> I haven't looked at Bluetooth, but I wasn't really suggesting that we
> make the patches optional - that's never going to work.
>
> Again, like I said above, what we could potentially do is look through
> the pain areas (aka big patches) and reduce those by bumping single
> drivers/subsystems up in kernel version, instead of a wholesale bump.

OK so we'd still be deleting selective patch series? But we'd keep all
the backport module files and header files around, but for what? That
would leave header files lengthy and full of complexity. Would we have
a subsection on documentation that helps folks feel free to use the
framework to go and backport some random driver -if-they-so-wish-
outside of the tree and show how? Is that the idea?

> As far as 802.11 wireless is concerned, for example, I think the patches
> are actually relatively small for the older kernels.

Sure, but again, are we going to bump all 802.11 drivers to say 3.0,
and if so we are going to then just remove all these patches? If not
that implies someone is going to upkeep those patches, and as I
mentioned I think we need to scale better. I want to do less work, not
more.

>> Let's also consider now the
>> gains of being able to help persuade folks to upgrade if we also
>> embrace a sensible policy for what kernels we support. One of my goals
>> is to grow backports with more drivers and new options (in-kernel
>> support) but if backports can also be used as a carrot to help with
>> moving the ecosystem forward, I think its a strong element to
>> consider. So there are two gains here: helping us clean up things, and
>> setting up a sensible policy that aligns with kernel.org releases /
>> maintenance cycles.
>
> I'm not a big fan of politicising technical projects. We're mostly all
> here to get problems solved, and most of us push for better solutions,
> but usually what happens when we try to enforce better solutions
> technically is that we just get to maintain the workarounds outside the
> community, which makes it more effort for everybody...

There's a good-practices gain from bumping kernels to match the
support structure on kernel.org but let me make it clear its not the
primary reason, that'd be a side effect. Ultimately this comes down to
*support* on backports for older kernels, and I just don't want to do
that anymore, we only have so many contributors to backports but many
users, we have to be picky about how we spend our time. I also have
technical reasons to believe that if we want to backports to grow we
need to make it scale and not dropping kernels more often won't scale.
Dropping supported kernels has to become part of our best technical
practices on backports. We can't make everyone happy.

  Luis
