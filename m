Return-path: <backports-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35499 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751789AbdBGEsL (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 6 Feb 2017 23:48:11 -0500
Received: by mail-wr0-f194.google.com with SMTP id o16so4592509wra.2
        for <backports@vger.kernel.org>; Mon, 06 Feb 2017 20:48:10 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1486441223.3070.2.camel@coelho.fi>
References: <1486399064.5430.7.camel@sipsolutions.net> <04ef169d-49b1-98e0-1db6-7c4e7e9b5c9f@broadcom.com>
 <1486441223.3070.2.camel@coelho.fi>
From: Steve deRosier <derosier@gmail.com>
Date: Mon, 6 Feb 2017 20:48:09 -0800
Message-ID: <CALLGbRJ8SG=u3JoShHAZ_p1d=mRRNiBJhXdzCddRYK1Hf_bBjQ@mail.gmail.com> (sfid-20170207_054814_447368_9F7E5000)
Subject: Re: deprecating more kernel versions
To: Luca Coelho <luca@coelho.fi>
Cc: Arend Van Spriel <arend.vanspriel@broadcom.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        backports@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Mon, Feb 6, 2017 at 8:20 PM, Luca Coelho <luca@coelho.fi> wrote:
>
> On Mon, 2017-02-06 at 23:45 +0100, Arend Van Spriel wrote:
> > On 6-2-2017 17:37, Johannes Berg wrote:
> > > What kernel versions do you still need?
> > >
> > > For example, 3.0 is getting really quite old, the oldest long-term
> > > stable is 3.2.x now.
> >
> > We currently backport internal tree and wireless-testing nightly to 3.10
> > and 3.11 kernels.
>
> I think capping at 3.10 is reasonable.  Internally, we have been
> supporting 3.8+, but we got permission to support only 3.12 and above.
>
> Last time we nuked support for older kernels [1], we were supporting
> only 15 kernel versions (3.0 through 3.14).  Now we are at 30 (3.0
> through 4.10 -- sort of).  If we make the cut at 3.10 we are at 20,
> which is still a lot more conservative than our last "nuke".
>
> [1] https://git.kernel.org/cgit/linux/kernel/git/backports/backports.git/commit/?id=be4a0f9ad7e17670d7a30c9e94d5dd918425f90a
>


Maybe this comes from ignorance or inexperience, but I'll throw out a
few questions/thoughts.

* Do we have a policy on how far back or when/how we deprecate versions?
* What is the implication of doing so?  For example, is it a "we don't
bother testing with versions less than 3.10"? or "it's going to stop
working for < 3.10?"
* Is a deprecation in this case a warning we're not going to be
supporting a version soon, or are we immediately dropping support?
* And finally the big one - what's the implication of _keeping_ a
particular older version alive.

I think an "official" position on the above would be appropriate and
perhaps we should decide something and publish that.  And then the
question won't come up anymore... we'll just deprecate at the correct
time.

All that said, here's my issue - we still have customers doing
integrations with our radios, supported via backports, as far back as
2.6.33!  Yes, that's NEW integrations. Usually has to do with BSPs
that haven't been updated. Right now, to support that we're
maintaining two backport "releases" one based on the 3.13 kernel for
<3.0and one based on our 4.4.x kernel for the more modern ones (3.0+).

We can continue to do things like that, but I don't want to keep
adding and maintaining older forks.

But, that's _my_ problem, and it's a commercial problem, and doesn't
need to be the community's problem.

I would say that Luca's suggestion of 3.10 is perfectly reasonable.
However, wouldn't it make sense to always support back to the current
oldest LTS (3.2)? It seems odd that we'd cap higher than a valid LTS.

I'll throw out another thought: what would be the implications of
supporting all current non-eol LTS + all versions say the past 6 (pick
a number). So that'd be 3.2, 3.6, 3.10, 3.12, 3.16, 4.1, 4.4..4.10.
Does that reduce the work, or does going all the way back to 3.2, even
if we don't test and be sure say 3.3 works, still means we're doing
all those version from 3.2 on?

Just throwing out ideas for thought and discussion.

And, I'm fine with 3.10 being the oldest we support.

- Steve
--
To unsubscribe from this list: send the line "unsubscribe backports" in
