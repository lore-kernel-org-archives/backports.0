Return-path: <backports-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:51782 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932338AbcHIV2u (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 9 Aug 2016 17:28:50 -0400
Date: Tue, 9 Aug 2016 23:28:48 +0200
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Peter Huewe <PeterHuewe@gmx.de>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Subject: Re: Re: gentree fails at no such file compat/crypto-skcipher.c
Message-ID: <20160809212848.GF3296@wotan.suse.de> (sfid-20160809_232853_776547_BAC00C3B)
References: <trinity-50e3397a-cfd4-4f35-ab8b-51700c2a6cf6-1470642723593@3capp-gmx-bs12>
 <CAB=NE6W=-sOfJCTHZSzk1pFC20Zh9R-rELOe2zcoCDhY_hw33Q@mail.gmail.com>
 <01C20278-FFC0-4346-848F-C3B92F031B4E@gmx.de>
 <20160808201407.GV3296@wotan.suse.de>
 <trinity-cbde6023-9aad-4338-a14e-0adb12480dfb-1470718971775@3capp-gmx-bs04>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <trinity-cbde6023-9aad-4338-a14e-0adb12480dfb-1470718971775@3capp-gmx-bs04>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Tue, Aug 09, 2016 at 07:02:51AM +0200, Peter Huewe wrote:
> Hi Luis,
> > > Thanks, this was not clear to me.
> > > Should we add that to the wiki maybe?
> > 
> > Yes please do.
> Will do once my account is approved.
> Also will add the other stuff/questions that I learn on the way.

Thanks, its been approved.

> > > >But if you are trying to add new drivers, best is to just try the
> > > >master branch of backports against the latest respective linux-next
> > > >tag that backports works against, so in this case backports is at
> > > >backports-20160324, so you can set you linux-next tree to
> > > >next-20160324:
> > > >
> > > >git reset --hard next-20160324
> > > >
> > > >This is because contributions would go to the master branch of
> > > >backports.
> 
> Okay - the gentree works (after adding linux-next-history because the tag is not included anymore in linux-next),

You don't need to add it manually, you typically need to do:

git fetch --tags

> but 'make' in the generated folder fails with some compile errors.
> (implicit declaration of function ‘__kernel_param_unlock’).

Did you run:

make menuconfig

I forget if by default we give you a defconfig in lack of running
the above.

> This probably because I'm already running a kernel newer than the next-20160324 (v4.7), correct?.
> So I would have to run also the next-20160324 or earlier to do work on backports (and test it)?

Right, or build with references to an older kernel target. How to do this is documented in
the wiki.

> How do you test that the backport worked correctly?

We typically just compile time test each release against all kernels down to 3.0.
We run ./devel/ckmake on the directoy where your release is made. This tries to
compile that against all stable kernels you downloaded through the download
manager.

We don't run time test but have considered recently introducing some minimal tests.

> Is it possible to tell the backport package the target-kernel source?

By default it targets all older kernels we support. Another option is
to use backports with direct integration, but I did support for that
a while ago and haven't followed up to keep testing it, so chances are
it needs some love. Kernel integration with backposts is documented on
the wiki as well. Note that even if you use kernel integration, you
still end up with the full delta to support all kernels still. The
added benefit is just that you can then built-in, and you get a serial
git log series of patches on top of a vanilla kernel tree as an option.

> Is this assumption correct:
> The gentree.py script takes the drivers listed in the "patches: refresh on " part of the commit message,
> and creates a backport package for all the listed kernel in that commit?

You can use --git-debug so you can see the atomic step by step process that
gentree.py takes. This is possible for both packages and also integration.
A list of steps using that is available here when used with integration
a while ago:

https://backports.wiki.kernel.org/index.php/Documentation/integration

> So if I were running a 3.16.7 kernel, I could create a suitable package with the gentree.py script,
> using --git-revision next-20160324.

Correct.

> I would then have the backported drivers of next-20160324 available for 3.16.7.
> The gentree.py itself does not care about the "target" kernel.

Correct, its intended to support all kernels older than itself. In theory it
can run against itself but that's a bit odd. If you want to take 4.0 kernel
code you would use the branch linux-4.0.y branch of backports. Likewise if you
want to take 4.1 kernel code, you would use the linux-4.1.y branch of backports.

Development-wise you should work on the master branch, and then perhaps backport
if you wish what you need for your own modification.

In so far as when we'd take tpm drivers if you add support for this -- lets
think about it. Upstream-wise we know adding drivers cannot regress, this is
why we can add new drivers during the RC cycle of the kernel. However, adding
a new drivers to backports is diferent given that you *might* then implicate
collateral for older drivers. This is specially true if you use SmPL (this is
encouraged), but note that logically if you used some SmPL it means you
generalized a backport, and if the changes modify other drivers then it should
mean other drivers needed that backport -- but since it did not have it then
surely it didn't need it. Following this logic, it seems hard, although not
impossible, for new drivers added to backports to regress others. So I leave
it up to a community decision to take or not new drivers on older stable
releases -- at least for me the only requirement I'd have is for the code
to be merged first on origin/master, and then a respective commit backported
to stable branch referring to the upstream origin/master commit. Just as we
do on Linux upstream.

> > > About adding new drivers,
> > > if I make only a patch against the master branch,
> > > how do you then get support for older versions? E.g. 4.0.9?
> > 
> > Just as we do for Linux upstream. First you commit on master, then
> > you take that and you backport it. Same rules apply for upstream though
> > so only fixes / security fixes for older stable releases.
> 
> So by adding my current driver, that is in e.g. next-20160323,
> would this then be made available for all the currently listed kernels or not?

Yes for all supported kernels. You can in fact be lazy as well and say only
support kernels >= 3.16. We do this quite often, check the dependencies file.
This lets you take backporting one step at a time. I'd recommend for instance
targetting 4.5 first, given that if you do on linux-next:

git blame Makefile next-20160323

You will see that the kernel then is 4.5.0. This means that during that time
linux-next represented code that would ultimately go towards 4.6-rc1 and eventually
4.6. So backporting linux-next next-20160323 code means you are backporting
approximately ~v4.6 breed of code. If you use a symbol reference in dependencies
for TPM drivers and list 4.5 as a requirement then compilation may even work
without any changes unless you need to backport something. Once you iron that
out you can add the drivers upstream and peg it as requiring 4.5. Or you can
keep doing work and keep taking the drivers down to 4.4... etc until you get
to 3.16.

Experience shows that given we have a lot of backport work already generalized
through SmPL -- less work is required. So you may only need a few changes. It
ultimately varies what you need to do, but typically the pattern of effort
required is tied down to the core data structures used, and the changes for
them. If we already backport drivers similar to tpm in terms of core
data structures then less work is required.

For tpm I suspect there may be a higher requirement for crypo, but we also
use crypto in 802.11 drivers, and those requirements are met. So perhaps
unless some special crypto is needed I can't expect much work to be needed.

> I didn't quite get your sentence (although I'm familiar with the linux-stable
> backporting rules).

Hopefully all the above helps.

> Currently, since backports is at next-20160324, there is no way to
> "auto"-backport drivers from 4.7 to e.g. 3.16.7?  (until the backports
> project has been updated again)?

Right, ideally backports would move up one linux-next tag per day, but
we are only a few folks. So we move at a slower pace these days, more
at the interest of those who care.

> > > How does the maintenance work? (As I then would also sign up to do the
> > > maintenance of the tpm drivers in the backports)
> > 
> > Everyone lends a hand, as backports moves to a new linux-next target, so that
> > typically means developers involved often help out other subsystem they are not
> > typically interested, but because this is a bit unfair we ask at least one
> > person interested in one subsystem to help vet / review changes and help with
> > general stuff.
> 
> When is the next updated planned?

You can help. Try bumping your linux-next to next-20160325 and then run
gentree.py again, if after that ckmake works, we're set. Keep doing this
and so on. You can typically bisect in the reverse order naturally as well.

There's a series of automation techniques used in backports to help
alleviate some of the work needed.

> > If you manage to address your backports through SmPL that means less work
> > for everyone as these typically then allow the backport to not have to
> > require major changes unless a major functionality that disrupts old
> > data structures is introduced, but if this is not something common on
> > tpm drivers it should be mostly smooth sailing (mostly automation) after
> > the more complex driver is backported.
> 
> Fortunately the TPM subsystem, due to its limited use/usage and only a few
> developers has not seen too many changes, (which now changes a bit) and also
> has not so many external dependencies, I would not be too suprised if simply
> copying drivers/char/tpm and include/linux/tpm*.h from a current kernel to
> e.g, 4.0

Given what you describe I also then don't expect this to be much work.
Additionally if the changes are all tpm subsystem specific you may even
be able to generalize your changes in SmPL instead of old patch, that
in turn would help do less work as the code changes later or new drivers
are added.

> What is the recommendation when the backport would break the interface to
> other drivers (e.g. keys subsystem).  Does the backport then need to provide
> the old interface or would it be better to backport the other subsystem as
> well?

It depends on the stakeholders involved. Up to now we mostly carry networking
and media drivers. I suspect most folks would prefer better underlying
core drivers, however then issue doesn't then become an issue of new drivers
using these but instead ensuring at times that old drivers keep using old
API drivers and perhaps only new ones use the new driver APIs. So for instance
its been given as an example one vendor wanting one version of mac80211 
(say the stock kernel one from the distro) while another using a later
version. This sounds stupid, but I've heard such desires.

To address this today though we take two approaches for this:

o prefix each new backported exported symbol with a backports_ prefix
  this is implcity done when you use EXPORT_SYMBOL*() on backports.

o just replace full swing an entire subsystem. This avoids
  that problem. So if you backport 802.11 we provide all known
  drivers folks use.

Anyway, to help address this, if this is desirable, there are technical long
term solutions for it, for instance module namespaces. But work is needed
on that front.

Then you have to consider userspace APIs as well and the headers they use.
On 802.11 we have taken a technique which simply enables into userspace all
features possible up to the point the code is released, and it then detects
your device capabilities for functionality.

Refer to the iw source code, or wpa_supplicant code for how that is done.

> If I need certain apis from a different subsystem (e.g. the non-locking
> __i2c_transfer routines from 3.10? for a 3.0.101 backport) I would have to
> include a patch for the i2c subsystem (to backport this feature) too,

It depends. That sounds like a welcomed feature to a generic distribution,
as such it may be a patch worth picking up by the distribution. Given
Linux distributions do cherry pick things like these we understand this
and often these days try to advocate upstream #define foo strategies to
annotate a feature is implemented, then the backport code can just
#ifdef foo to check for the feature, regardless of the base kernel
the user is on. This for instance helps generalize backporting for
not only SLE but also RHEL kernels. We can take SLE / RHEL special
macros for backporting too though.

So -- if the feature upstream for I2C you describe falls into the type
that can be #ifdef checked, a solution can be used to detect this and
implicitly work around both. In so far as providing the I2C fix into
backports is concerned -- it also depends. Is this a built-in feature
or is it modular ? What non-tpm drivers could use it ? If you can
export the functionality as modular then you are set, as you can then
just carry it as a new generic module helper. We have some of these,
refer to tons of functionality in the directory backport/compat/
in that take note of the Makefile

compat-$(CPTCFG_BPAUTO_BUILD_CRYPTO_CCM) += crypto-ccm.o                        
compat-$(CPTCFG_BPAUTO_CRYPTO_SKCIPHER) += crypto-skcipher.o 

We copy over from upstream crypto-ccm and throw it in here to
provide our own copy. Additionally there is also patch for
it, see patches/backport-adjustments/crypto-ccm.patch

So the BPAUTO stuff is one of the auto-things we have. Using
SmPL is another strategy.

If you need built-in solutions you can use integration. So it
really depends on what your goals are.

> or
> would I have to re-write the tpm driver to work without this feature.  What
> if this is not possible since some internals of the other subsystem have to
> change?

It depends. But again since, we have a backports_ prefix to carried
backported symbols the solution in backports is self contained.

> Sorry to bug you with all these questions - unfortunately the documentation is a bit sparse at the moment :)
> I hope I can improve this :P

No worries, glad to help, if this helps and if you find the documentation sucks
I'd appreciate any updates you can think of based on this.

  Luis
--
To unsubscribe from this list: send the line "unsubscribe backports" in
