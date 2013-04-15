Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:49295 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756146Ab3DOLQE (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 15 Apr 2013 07:16:04 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.0:DHE_RSA_CAMELLIA_256_CBC_SHA1:256)
	(Exim 4.80)
	(envelope-from <johannes@sipsolutions.net>)
	id 1URhOE-0006ea-UO
	for backports@vger.kernel.org; Mon, 15 Apr 2013 13:16:03 +0200
Message-ID: <1366024560.8361.15.camel@jlt4.sipsolutions.net> (sfid-20130415_131618_076481_F78C2BB2)
Subject: Re: [RFC/RFT 00/42] explode header files
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Date: Mon, 15 Apr 2013 13:16:00 +0200
In-Reply-To: <1365897243-31214-1-git-send-email-johannes@sipsolutions.net> (sfid-20130414_015412_493914_07CF2B64)
References: <1365897243-31214-1-git-send-email-johannes@sipsolutions.net>
	 (sfid-20130414_015412_493914_07CF2B64)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Sun, 2013-04-14 at 01:53 +0200, Johannes Berg wrote:
> As we discussed recently, it's better to explode our backport
> header files into the names that the kernel uses instead of
> pre-including half the world from the gcc command line. Doing
> so is obviously a lot of work and can't really be done in a
> way that would continue working inbetween the patch series,
> so I'm doing it per kernel version (or rather compat-x.y.z
> header.)
> 
> Before I rebased onto the media drivers this was pretty much
> passing ckmake --allyesconfig, now minor issues could have
> come up that I need to solve, but generally this should be
> fine. I did solve the issues that I saw in ckmake before.

After fixing a few issues, I'm passing ckmake --allyesconfig with just a
few linker issues that also seem to exist without these patches.

I'm pushing this. I expect we'll find some issues with this and the
other stuff still, but there's no way to fix all of them anyway.

johannes

