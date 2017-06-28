Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:55836 "EHLO sipsolutions.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751084AbdF1Hrz (ORCPT <rfc822;backports@vger.kernel.org>);
        Wed, 28 Jun 2017 03:47:55 -0400
Message-ID: <1498636073.12531.5.camel@sipsolutions.net> (sfid-20170628_094757_434343_3FBACDD5)
Subject: Re: Kernel specific branches question
From: Johannes Berg <johannes@sipsolutions.net>
To: Dan Kephart <Dan.Kephart@lairdtech.com>,
        "backports@vger.kernel.org" <backports@vger.kernel.org>
Date: Wed, 28 Jun 2017 09:47:53 +0200
In-Reply-To: <921F8F57-F9B2-431F-828D-C2D86292ED94@lairdtech.com> (sfid-20170627_220738_057277_8F491788)
References: <921F8F57-F9B2-431F-828D-C2D86292ED94@lairdtech.com>
         (sfid-20170627_220738_057277_8F491788)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hi Dan,

> At Laird, we use backports for supporting our wireless modules,
> specifically using an unmodified brcmfmac, a fairly modified ath6kl,
> and an out of tree custom version of the non-upstreamed mwlwifi, and
> also using unmodified Bluetooth.  

:)

> At the moment, we are backporting our fork of the 4.9 kernel for
> those drivers.  I pulled a copy of the git repo a few months back and
> we have worked from that.  I’m wondering how we can help resurrect
> the process of having branches for specific kernel releases and the
> testing that was done for those as seen in this commit:
> https://git.kernel.org/pub/scm/linux/kernel/git/backports/backports.g
> it/commit/?h=linux-4.4.y&id=bec4037a54dd0e1a1aeefe7385faf82bac44d6a0

So the testing thing there is just the output from the "ckmake" script
that's there in the repository. It needs a bunch of disk space and lots
of CPU time, but otherwise shouldn't be that hard to do. We still have
the compat build box, and I still have a plan to put some kind of
automation in place, but haven't really had time for it yet.

However, this is pretty different from how most other people seem to
work?

Since kernel releases are sort of ephemeral, and drivers are
continually developed along with the kernel, we typically see usage
more of "latest backport + latest kernel" to get to "latest driver for
use on any kernel".

Additionally, backports for a fixed kernel version like 4.9 really
should be pretty stable, so once you have it, it shouldn't really need
to change? So it seems to me like a tag on master would be sufficient.

Now, we're not actually doing a good job of following any of upstream,
linux-next or wireless-testing with backports right now - we should
probably pick one of those, or multiple of those, and create branches
in the backports.git for each one of those, rather than having a
"master" branch.

To do that, I think we should actually set up a build bot to do a daily
tests of applying backports on those trees, and then compiling the
result on all (supported) kernels. This can then email the list, and
somebody can fix the issues.

Sounds like a plan?

Note that I'm going to go no sabbatical for July/August, so I won't be
working on this then either though.

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
