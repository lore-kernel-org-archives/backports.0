Return-path: <backports-owner@vger.kernel.org>
Received: from mail-la0-f49.google.com ([209.85.215.49]:55998 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752424Ab3C1WPe (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 28 Mar 2013 18:15:34 -0400
Received: by mail-la0-f49.google.com with SMTP id fs13so27970lab.22
        for <backports@vger.kernel.org>; Thu, 28 Mar 2013 15:15:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1364507345.10397.42.camel@jlt4.sipsolutions.net>
References: <1364507345.10397.42.camel@jlt4.sipsolutions.net>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Thu, 28 Mar 2013 15:15:12 -0700
Message-ID: <CAB=NE6X9X0apA0tR-f2_f24W-sWXhUVky2OGEQhAO3=ta1Q2pA@mail.gmail.com> (sfid-20130328_231602_638862_02D2B887)
Subject: Re: compat-drivers wishlist
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Thu, Mar 28, 2013 at 2:49 PM, Johannes Berg
<johannes@sipsolutions.net> wrote:
> Hi,
>
> I've long been fed up with the state of compat's build system, so I
> figured I'd start by soliciting wishlist items.
>
> FWIW, I think that the whole compat-drivers/scripts/ dir needs to be
> rewritten for this ... :-)
>
> My personal wishlist is below. I realize that some of these wishes cause
> contradictions/problems in their implementation, but nonetheless I have
> them :-)
>
> 1) Ability to copy only some drivers.
>    We're interested in using compat-drivers to ship our driver to
> customers for
>    older kernels. We're not at all interested in shipping DRM, Atheros
> drivers,
>    etc.

Seems reasonable. Maybe admin-update can read your own .config

> 2) To make that easier: split all patches per *file* in addition to per
> change.
>    That way, it would be possible to apply only patches for those files
> that are
>    actually in the tree. Right now, I heavily patch out those patches
> that aren't
>    really need.
>    I suppose the best way would be to have directories for each change
> and change
>    the script that applies them to parse the patch header first. Or just
> ignore
>    patches that fail with "no file", but I don't know if that's easy to
> determine
>    from the patch exit status code.

GNU patch could use some love. See commit 4a1a94f93 on compat-drivers.
Perhaps this is an area we'd be interested in extending functionality
as well. Having collateral evolutions split up each into their own
directory is a fine approach as well, but lets think long term here,
given that we're seeing what short term script/hack solutions can cost
us.

Maybe we need a context patch parser that given a .config will only
apply patches for the desired files. For this to work we'd need a
mapping of CONFIG_FOO symbols to respective driver path files regexps.
The Linux kernel MAINTAINERS file comes to mind as something close to
get us there, but that does not yet use CONFIG_ symbols, the title is
a bit loose.

Kconfig however gives us the config to let us build a target, and the
Makefile should let us extract its target dependencies, so I wonder if
we can use this to dynamically build kconfig to target maps.

> 3) Separate the output from the compat-drivers tree.
>    There's no reason to ship patches/, most of scripts/ etc. in the
> resulting
>    tarball, in fact it's just confusing. Having the output in a separate
>    directory, copying there only the few things that are needed, would
> be very
>    helpful.

Sure, makes sense.

> 4) Kconfig.
>    This is a bit conflicting with 1) because a valid Kconfig structure
> requires
>    all the sub-Kconfig files exist. Maybe ship all Kconfig files, or
> automate a
>    way to remove "source" statements for files that don't exist
> (probably easy)

I think its possible to remove not desired source code based on
reading .config. This can be done as a pass if the Kconfig to Makefile
thing is figured out. Then as a secondary step I think we can remove
directories that have just a Kconfig / Makefile, but that's
theoretical, in practice this may be harder, the biggest issue I think
would be to ensure removal of the calling 'source foo/Kconfig' entry,
or we extend Kconfig to support Kconfig imports that don't exist, sort
of with Makefile and the -include foo.mk trick.

> I'll leave it at that for now, and follow up with some concrete
> implementation ideas :-)
>
> Any other thoughts?

There, some feedback, thanks for taking the time to dumping your ideas.

  Luis
