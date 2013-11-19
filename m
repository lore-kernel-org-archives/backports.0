Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:40444 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751699Ab3KSInh (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 19 Nov 2013 03:43:37 -0500
Message-ID: <1384850612.15364.1.camel@jlt4.sipsolutions.net> (sfid-20131119_094339_585487_042FD2B9)
Subject: Re: How to detect when module dependencies have changed?
From: Johannes Berg <johannes@sipsolutions.net>
To: Jason Mobarak <jam@cozybit.com>
Cc: backports@vger.kernel.org
Date: Tue, 19 Nov 2013 09:43:32 +0100
In-Reply-To: <CANkDkvwBGyonC3JPvEh59bvfYxEix0N_21=5avX8RiCvyLpiOA@mail.gmail.com> (sfid-20131119_002909_500477_424F846A)
References: <CANkDkvwBGyonC3JPvEh59bvfYxEix0N_21=5avX8RiCvyLpiOA@mail.gmail.com>
	 (sfid-20131119_002909_500477_424F846A)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Mon, 2013-11-18 at 15:28 -0800, Jason Mobarak wrote:

> The problem, I think, was that CRYPTO_CCM was added as a dependency of
> of MAC80211 in the meantime.  I discovered this by using menuconfig to
> figure out what config flags where causing MAC80211 to be disabled...

Yeah, I guess that's really the best way. I don't see a good way to
print out "You can't do this in your defconfig because of CONFIG_XXX".

> At first, to address this, I tried adding "crypto/" and
> "drivers/crypto/" to "copy-list" and regenerating (which also
> requiring some sed manipulation of the CONFIG_ flags)...

That wouldn't really work.

> However, the more "correct" solution (which didn't require any changes
> to backports) was to just enable CYPTO_CCM as a module in the kernel
> backports was being compiled against.

Right. FWIW, I have a backport of crypto-ccm, but it's kinda ugly:
http://p.sipsolutions.net/f70f203dd2bfbd67.txt
(Note the patch is diffed in a subdirectory and a bit messy, but you'll
get the point)

I don't think we should merge this into backports though since all
distro kernels will have CRYPTO_CCM enabled, and everybody else will
just have to know I guess.

> So... my question is, is this a bug?  And/or is there a better way to
> detect this situation in the future?

Well, it's not really a bug - the dependencies changed but what they
need is in every kernel since 2.6.25 or something like that.

johannes

