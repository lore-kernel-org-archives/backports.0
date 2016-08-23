Return-path: <backports-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:55642 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751568AbcHWTNt (ORCPT <rfc822;backports@vger.kernel.org>);
        Tue, 23 Aug 2016 15:13:49 -0400
Date: Tue, 23 Aug 2016 21:00:18 +0200
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Cristina-Gabriela Moraru <cristina.moraru09@gmail.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        linux-kernel@vger.kernel.org, Tom Gundersen <teg@jklm.no>,
        Kay Sievers <kay@vrfy.org>,
        Rusty Russell <rusty@rustcorp.com.au>,
        akpm@linux-foundation.org, backports@vger.kernel.org,
        "vegard.nossum@gmail.com" <vegard.nossum@gmail.com>
Subject: Re: [RFC PATCH 1/5] Add generation of Module.symb in
 streamline_config
Message-ID: <20160823190018.GD3296@wotan.suse.de> (sfid-20160823_211352_463163_6EA7065C)
References: <1471462023-119645-1-git-send-email-cristina.moraru09@gmail.com>
 <1471462023-119645-2-git-send-email-cristina.moraru09@gmail.com>
 <20160818182236.GO3296@wotan.suse.de>
 <CAGZ2q2xi9Uy-ye387=mWhy_fOEJBC593Nos7fH027m-_ZdoOXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CAGZ2q2xi9Uy-ye387=mWhy_fOEJBC593Nos7fH027m-_ZdoOXA@mail.gmail.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Sat, Aug 20, 2016 at 03:59:17PM +0200, Cristina-Gabriela Moraru wrote:
> 2016-08-18 20:22 GMT+02:00 Luis R. Rodriguez <mcgrof@kernel.org>:
> 
> > On Wed, Aug 17, 2016 at 09:26:59PM +0200, Cristina Moraru wrote:
> > > Add generation of ./scripts/Module.ksymb file containing
> > > associations of driver file names and corresponding CONFIG_*
> > > symbol:
> > >
> > > foo_KCONF=CONFIG_FOO
> > >
> > > This file will be further loaded by the Makefile as a
> > > configuration file: all foo_KCONF will be considered variables
> > > and all CONFIG_FOO will be their associate values.
> >
> > Will the file generated always work? What are the current
> > restrictions on kconfig variable names?
> >
> >
> The file generated will always work. It's loaded with makefile's "include"
> directive which is quite straightforward.
> 
> If you're referring to  CONFIG_* variables, I can't find any restriction
> regarding size or anything else.
> If you're referring to the newly created makefile variable foo_KCONF I only
> found this in the documentation:
> "A variable name may be any sequence of characters not containing ‘:’, ‘#’,
> ‘=’, or whitespace."

Both since we'd up with a file with tons of entries like:

bar_KCONF=CONFIG_BAR
foo_KCONF=CONFIG_FOO

I was asking really what checks do we have to ensure either side in these lines
will not make a Makefile barf. For instance using "\" will surely barf. Does
Kconfig check for sanity ? If so then what are the rules for Kconfig variables?
Makefiles then have the above description you mentioned, and I was curious how
and if we want to vet for correctness for both.

> "It is traditional to use upper case letters in variable names, but we
> recommend using lower case letters for variable names that serve internal
> purposes in the makefile, and reserving upper case for parameters that
> control implicit rules or for parameters that the user should override with
> command options"
> 
> Since the module name is lowercase I put the suffix uppercase in order to
> be more visible.

OK thanks.

> > This is nice for experimentation, however as you note we want
> > to evaluate a better way to do this. While at it, can you describe
> > what algorithm currently is used by scripts/kconfig/streamline_config.pl
> > to collect %objects and the associated CONFIG symbol ? Can you think
> > of possible flaws to it ?
> >
> >
> Shortly, all makefiles are parsed searching for patterns such as:
> 
> obj-$(CONFIG_FOO) := obj-foo1.o obj-foo2.o ... etc.
> 
> Each obj-foo is added in the hashmap as key with the value
> array(CONFIG_FOO).
> If obj-foo already exists in the hashmap CONFIG_FOO is appended to the
> array value.

So this fails to then capture lib-$(CONFIG_BAR) then. These can be modules
too. So we'd need something to loop over all possible valid targets to be
able to easily extend this with future targets, in case we get something
other than obj- and lib-. For instance I am looking to add a force-obj-y
and force-lib-y, later this may mean supporting force-obj-m and foce-lib-m,
the actual name however is still up in the air [0], however my point is
we want to be easily able to extend the series of targets used for modules.

This may prove useful to the build something for other things.

Also, does the scripts/kconfig/streamline_config.pl algorithm support
where you have more than one line on a target, for instance:

obj-$(CONFIG_FOO) := foo1.o \
		     foo2.o \
		     foo3.o

If not we'd need to figure out a way to capture these then?

[0] https://lkml.kernel.org/r/20160822235910.GW3296@wotan.suse.de

> I noted that there are situations where an object obj-foo has as associates
> more identical CONFIG_FOOs.
> Since I select only the names which have exaclty one CONFIG_* associated
> this is a bit confusing. I am missing one category of drivers which can be
> found:
> 
> driver-foo ---- CONFIG_FOO CONFIG_FOO

What do these 3 columns represent here ?

> For example: nfit CONFIG_ACPI_NFIT CONFIG_ACPI_NFIT -- this actually
> results in  a module in /sys which does not have a content into
> kconfig_ksymb although it has exactly one match.
> 
> Another thing I can think of is that sometimes we find lines such as:
> 
> foo-name-$(CONFIG_FOO) = obj-foo1.o obj-foo2.o obj-foo3.o
> 
> This can be a clue that the final kernel module is named foo-name and could
> solve some ambiguous cases.
> This are just a few situations I can think of to be kept in mind for the
> next Module.ksymb generator

Indeed thanks, I think it'd be nice if we can iron all of them out. If we cannot
then we should annotate why we can't and see if we are willing to compromise
to help address this.

  Luis
--
To unsubscribe from this list: send the line "unsubscribe backports" in
