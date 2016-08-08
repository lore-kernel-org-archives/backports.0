Return-path: <backports-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:41973 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752208AbcHHUOJ (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 8 Aug 2016 16:14:09 -0400
Date: Mon, 8 Aug 2016 22:14:07 +0200
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Peter Huewe <peterhuewe@gmx.de>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Subject: Re: gentree fails at no such file compat/crypto-skcipher.c
Message-ID: <20160808201407.GV3296@wotan.suse.de> (sfid-20160808_221411_479580_4AC46CCD)
References: <trinity-50e3397a-cfd4-4f35-ab8b-51700c2a6cf6-1470642723593@3capp-gmx-bs12>
 <CAB=NE6W=-sOfJCTHZSzk1pFC20Zh9R-rELOe2zcoCDhY_hw33Q@mail.gmail.com>
 <01C20278-FFC0-4346-848F-C3B92F031B4E@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <01C20278-FFC0-4346-848F-C3B92F031B4E@gmx.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Mon, Aug 08, 2016 at 12:05:52PM -0700, Peter Huewe wrote:
> 
> 
> Am 8. August 2016 10:35:47 GMT-07:00, schrieb "Luis R. Rodriguez" <mcgrof@kernel.org>:
> >On Mon, Aug 8, 2016 at 12:52 AM, Peter Huewe <PeterHuewe@gmx.de> wrote:
> >>
> >> I'm currently looking into the backports project to figure out how
> >hard it would be to add the tpm drivers.
> >> However unfortunately the gentree.py script fails, and I cannot
> >really explain why:
> >>
> >> ./gentree.py --clean --git-revision v4.0 /home/peter/linux-next/
> >/home/peter/linux-4.0-backport
> >> Get original source files from git ...
> >> Traceback (most recent call last):
> >>   File "./gentree.py", line 1091, in <module>
> >>     ret = _main()
> >>   File "./gentree.py", line 724, in _main
> >>     logwrite=logwrite)
> >>   File "./gentree.py", line 862, in process
> >>     disable_list = add_automatic_backports(args)
> >>   File "./gentree.py", line 276, in add_automatic_backports
> >>     automatic_backport_mangle_c_file(f)), 'r'):
> >> IOError: [Errno 2] No such file or directory:
> >'/home/peter/linux-4.0-backport/compat/crypto-skcipher.c'
> >
> >If you are trying to use a target v4.0 kernel then you need to
> >checkout the linux-4.0.y branch from the backports tree as well.
> >
> >git checkout -b linux-4.0.y origin/linux-4.0.y
> >
> >And try again.
> 
> Thanks, this was not clear to me.
> Should we add that to the wiki maybe?

Yes please do.

> >But if you are trying to add new drivers, best is to just try the
> >master branch of backports against the latest respective linux-next
> >tag that backports works against, so in this case backports is at
> >backports-20160324, so you can set you linux-next tree to
> >next-20160324:
> >
> >git reset --hard next-20160324
> >
> >This is because contributions would go to the master branch of
> >backports.
> 
> About adding new drivers,
> if I make only a patch against the master branch,
> how do you then get support for older versions? E.g. 4.0.9?

Just as we do for Linux upstream. First you commit on master, then
you take that and you backport it. Same rules apply for upstream though
so only fixes / security fixes for older stable releases.

> How does the maintenance work? (As I then would also sign up to do the
> maintenance of the tpm drivers in the backports)

Everyone lends a hand, as backports moves to a new linux-next target, so that
typically means developers involved often help out other subsystem they are not
typically interested, but because this is a bit unfair we ask at least one
person interested in one subsystem to help vet / review changes and help with
general stuff.

If you manage to address your backports through SmPL that means less work
for everyone as these typically then allow the backport to not have to
require major changes unless a major functionality that disrupts old
data structures is introduced, but if this is not something common on
tpm drivers it should be mostly smooth sailing (mostly automation) after
the more complex driver is backported.

Strive to backport the more complex subsystem driver first, and try to use
SmPL, after that adding new drivers should be trivial.

We don't have strict rules on maintenance yet but perhaps we should start.

 Luis
--
To unsubscribe from this list: send the line "unsubscribe backports" in
