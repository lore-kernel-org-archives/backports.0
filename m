Return-path: <backports-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.21]:64787 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750789AbcHIFC6 convert rfc822-to-8bit (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 9 Aug 2016 01:02:58 -0400
MIME-Version: 1.0
Message-ID: <trinity-cbde6023-9aad-4338-a14e-0adb12480dfb-1470718971775@3capp-gmx-bs04> (sfid-20160809_070301_379441_37502863)
From: "Peter Huewe" <PeterHuewe@gmx.de>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Subject: Aw: Re: gentree fails at no such file compat/crypto-skcipher.c
Content-Type: text/plain; charset=UTF-8
Date: Tue, 9 Aug 2016 07:02:51 +0200
In-Reply-To: <20160808201407.GV3296@wotan.suse.de>
References: <trinity-50e3397a-cfd4-4f35-ab8b-51700c2a6cf6-1470642723593@3capp-gmx-bs12>
 <CAB=NE6W=-sOfJCTHZSzk1pFC20Zh9R-rELOe2zcoCDhY_hw33Q@mail.gmail.com>
 <01C20278-FFC0-4346-848F-C3B92F031B4E@gmx.de>,
 <20160808201407.GV3296@wotan.suse.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hi Luis,
> > Thanks, this was not clear to me.
> > Should we add that to the wiki maybe?
> 
> Yes please do.
Will do once my account is approved.
Also will add the other stuff/questions that I learn on the way.

> > >But if you are trying to add new drivers, best is to just try the
> > >master branch of backports against the latest respective linux-next
> > >tag that backports works against, so in this case backports is at
> > >backports-20160324, so you can set you linux-next tree to
> > >next-20160324:
> > >
> > >git reset --hard next-20160324
> > >
> > >This is because contributions would go to the master branch of
> > >backports.

Okay - the gentree works (after adding linux-next-history because the tag is not included anymore in linux-next),
but 'make' in the generated folder fails with some compile errors.
(implicit declaration of function ‘__kernel_param_unlock’).
This probably because I'm already running a kernel newer than the next-20160324 (v4.7), correct?.
So I would have to run also the next-20160324 or earlier to do work on backports (and test it)?

How do you test that the backport worked correctly?
Is it possible to tell the backport package the target-kernel source?




Is this assumption correct:
The gentree.py script takes the drivers listed in the "patches: refresh on " part of the commit message,
and creates a backport package for all the listed kernel in that commit?

So if I were running a 3.16.7 kernel, I could create a suitable package with the gentree.py script,
using --git-revision next-20160324.
I would then have the backported drivers of next-20160324 available for 3.16.7.
The gentree.py itself does not care about the "target" kernel.

> > About adding new drivers,
> > if I make only a patch against the master branch,
> > how do you then get support for older versions? E.g. 4.0.9?
> 
> Just as we do for Linux upstream. First you commit on master, then
> you take that and you backport it. Same rules apply for upstream though
> so only fixes / security fixes for older stable releases.

So by adding my current driver, that is in e.g. next-20160323,
would this then be made available for all the currently listed kernels or not?
I didn't quite get your sentence (although I'm familiar with the linux-stable backporting rules).


Currently, since backports is at next-20160324, there is no way to "auto"-backport drivers from 4.7 to e.g. 3.16.7?
(until the backports project has been updated again)?

> > How does the maintenance work? (As I then would also sign up to do the
> > maintenance of the tpm drivers in the backports)
> 
> Everyone lends a hand, as backports moves to a new linux-next target, so that
> typically means developers involved often help out other subsystem they are not
> typically interested, but because this is a bit unfair we ask at least one
> person interested in one subsystem to help vet / review changes and help with
> general stuff.

When is the next updated planned?
 
> If you manage to address your backports through SmPL that means less work
> for everyone as these typically then allow the backport to not have to
> require major changes unless a major functionality that disrupts old
> data structures is introduced, but if this is not something common on
> tpm drivers it should be mostly smooth sailing (mostly automation) after
> the more complex driver is backported.

Fortunately the TPM subsystem, due to its limited use/usage and only a few developers has not seen too many changes,
(which now changes a bit) and also has not so many external dependencies,
I would not be too suprised if simply copying drivers/char/tpm and include/linux/tpm*.h from a current kernel to e.g, 4.0

What is the recommendation when the backport would break the interface to other drivers (e.g. keys subsystem).
Does the backport then need to provide the old interface or would it be better to backport the other subsystem as well?

If I need certain apis from a different subsystem (e.g. the non-locking __i2c_transfer routines from 3.10? for a 3.0.101 backport) I would have to include
a patch for the i2c subsystem (to backport this feature) too, or would I have to re-write the tpm driver to work without this feature.
What if this is not possible since some internals of the other subsystem have to change?



Sorry to bug you with all these questions - unfortunately the documentation is a bit sparse at the moment :)
I hope I can improve this :P

Thanks,
Peter
--
To unsubscribe from this list: send the line "unsubscribe backports" in
