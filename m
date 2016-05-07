Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:32866 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751745AbcEGLNn (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 7 May 2016 07:13:43 -0400
Subject: Re: Linux backports CII badge and run time testing
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
References: <CAB=NE6VJF4kk4EoqA3Lqqp9e2bJqrXvoPmGSHaHs6qr3bX43OA@mail.gmail.com>
Cc: Michal Marek <mmarek@suse.cz>, Takashi Iwai <tiwai@suse.de>,
	Johannes Berg <johannes@sipsolutions.net>,
	Fengguang Wu <fengguang.wu@intel.com>
From: Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <572DCDE0.5040605@hauke-m.de> (sfid-20160507_131429_300723_D1AE5EAB)
Date: Sat, 7 May 2016 13:13:36 +0200
MIME-Version: 1.0
In-Reply-To: <CAB=NE6VJF4kk4EoqA3Lqqp9e2bJqrXvoPmGSHaHs6qr3bX43OA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hi Luis,

Did you apply for this? What are the benefits of this?

On 05/05/2016 12:34 AM, Luis R. Rodriguez wrote:
> As per the Core Infrastructure Initiative guidelines we now meet the
> requirements for a badge, the details of the submission is here:
> 
> https://bestpractices.coreinfrastructure.org/projects/111
> 
> A lot of it just required updating our documentation to enable folks
> to report security issues. If there are things that need to be
> adjusted please let me know. A lot of this follows the Linux kernel
> submission for a lot of things:
> 
> https://bestpractices.coreinfrastructure.org/projects/34
> 
> Things we need to improve on though are automated tests specific to
> backports against a series of kernels, and also providing a bit of a
> description when we make new releases. I realize that is hard, but its
> also hard for Linux, we have no reasons no to be able to do that as
> well.

Doing predictable releases cost some constant effort. I do not know if
we have the resources to do predictable releases.

Security support could also be a problem because then we have to react
pretty fast when someone sees a problem in one of the drivers we ship.
Otherwise fixing the security problems should not be a big deal as I
assume that most security problems will be already fixed in upstream
Linux kernel.

> As for run time testing, we know folks out there in the industry
> already use backports and do their own run time tests against drivers,
> and this may be automated, we however need something more, at the very
> least a boot.

Build testing and testing with simulated drivers like mac80211_hwsim
should be doable, but testing all the device drivers which serve real
hardware is nearly impossible.

> Looking for something minimal to start off, how about this:
> 
> https://github.com/michal42/qemu-boot-test

yes that should be doable to have a qemu boot test which also checks if
loading the modules and unloading works.

> This doesn't yet load modules but it should be possible to add support
> for it. I suppose we'd need to backport some qemu related drivers, and
> call it a day to start off with? Anyone oppose to that? Any other
> ideas? I know we discussed the possibility of using 0-day somehow, but
> 0-day builds full kernels, not packages that provide modules, and our
> issues also is we would need coverage of testing over a series of
> kernels.
> 
> If you have further information about how you use backports to do any
> regular run time testing, information on that would be appreciated.

Hauke
--
To unsubscribe from this list: send the line "unsubscribe backports" in
