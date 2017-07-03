Return-path: <backports-owner@vger.kernel.org>
Received: from mail-sn1nam01on0102.outbound.protection.outlook.com ([104.47.32.102]:43150
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752241AbdGCW1u (ORCPT <rfc822;backports@vger.kernel.org>);
        Mon, 3 Jul 2017 18:27:50 -0400
From: Dan Kephart <Dan.Kephart@lairdtech.com>
To: Johannes Berg <johannes@sipsolutions.net>,
        "backports@vger.kernel.org" <backports@vger.kernel.org>
Subject: Re: Kernel specific branches question
Date: Mon, 3 Jul 2017 22:27:48 +0000
Message-ID: <DM5PR02MB3226F1449C47813CBB5BC198E9D60@DM5PR02MB3226.namprd02.prod.outlook.com> (sfid-20170704_002753_664646_4C2F3E8E)
References: <921F8F57-F9B2-431F-828D-C2D86292ED94@lairdtech.com>
         (sfid-20170627_220738_057277_8F491788),<1498636073.12531.5.camel@sipsolutions.net>
In-Reply-To: <1498636073.12531.5.camel@sipsolutions.net>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hi Johannes,
=A0  =20
>Hi Dan,

>> At Laird, we use backports for supporting our wireless modules,
>> specifically using an unmodified brcmfmac, a fairly modified ath6kl,
>> and an out of tree custom version of the non-upstreamed mwlwifi, and
>> also using unmodified Bluetooth.=A0=A0

>:)

>> At the moment, we are backporting our fork of the 4.9 kernel for
>> those drivers.=A0=A0I pulled a copy of the git repo a few months back an=
d
>> we have worked from that.=A0=A0I=92m wondering how we can help resurrect
>> the process of having branches for specific kernel releases and the
>> testing that was done for those as seen in this commit:
>>  https://git.kernel.org/pub/scm/linux/kernel/git/backports/backports.g
>> it/commit/?h=3Dlinux-4.4.y&id=3Dbec4037a54dd0e1a1aeefe7385faf82bac44d6a0

>So the testing thing there is just the output from the "ckmake" script
>that's there in the repository. It needs a bunch of disk space and lots
>of CPU time, but otherwise shouldn't be that hard to do. We still have
>the compat build box, and I still have a plan to put some kind of
>automation in place, but haven't really had time for it yet.


This is great information, we will probably attempt to set this up
internally for our QA testing.

>However, this is pretty different from how most other people seem to
>work?

>Since kernel releases are sort of ephemeral, and drivers are
>continually developed along with the kernel, we typically see usage
>more of "latest backport + latest kernel" to get to "latest driver for
>use on any kernel".

I think only wireless module vendors would have our use case.  Just to=20
elaborate a bit more.  We sell several system on modules
with 802.11 and bluetooth combo modules. We also sell the wireless
combo modules separately in a variety of form factors for integrating=20
into other systems. We jump the kernels on those SOMs to the latest LTS=20
kernel when released.  We do all our wireless module bring up, debugging,=20
baseline, and QA testing of those wireless modules using LTS kernels
using our SOMs.  To support software releases for those wireless only modul=
es
we use backports on those SOMs kernel to release a driver that builds for=20
many different kernels and rely on the QA testing that pertains to=20
the wireless module on the SOM.  This backports tarball is released with
the firmware and the wpa_supplicant that was used during this
QA process.  If a specific major release works well for the customer, they=
=20
may stay on this release and only want a bug fix or two. =20
We continually move forward with new releases but maintain those older
releases for customers if required.

>Additionally, backports for a fixed kernel version like 4.9 really
>should be pretty stable, so once you have it, it shouldn't really need
>to change? So it seems to me like a tag on master would be sufficient.

I agree this really is all we would need.

>Now, we're not actually doing a good job of following any of upstream,
>linux-next or wireless-testing with backports right now - we should
>probably pick one of those, or multiple of those, and create branches
>in the backports.git for each one of those, rather than having a
>"master" branch.

My preference would be linux-next, but it would be interesting to have both=
.

>To do that, I think we should actually set up a build bot to do a daily
>tests of applying backports on those trees, and then compiling the
>result on all (supported) kernels. This can then email the list, and
>somebody can fix the issues.

>Sounds like a plan?

This sounds fantastic and would enable us to help keep the project up
to date :).

>Note that I'm going to go no sabbatical for July/August, so I won't be
>working on this then either though.

Gives us time to see if we can get the cmake script set up ourselves as wel=
l.

Thanks for the reply.  Looking forward to helping out!

Dan

    =
--
To unsubscribe from this list: send the line "unsubscribe backports" in
